# Plano de Campanha Ativa — Check-up | Total Quality Medicina Diagnóstica

Campanha de prospecção ativa via WhatsApp (Evolution API), construída sobre a metodologia do curso **Vende-C** e sobre a infraestrutura já existente no Supabase (projeto "Claude - Automaitizador").

---

## 1. Diagnóstico da infraestrutura (15/07/2026)

| Componente | Estado | Observação |
|---|---|---|
| Base de contatos | ✅ 29.659 contatos de Caraguatatuba/SP | Dados demográficos completos (idade, sexo, bairro, WhatsApp) |
| Motor de disparo | ✅ Ativo | `pg_cron` roda `tick_campaigns()` a cada minuto; jitter 45–90s, limite diário, circuit breaker, retry e idempotência |
| Webhook de respostas | ✅ Ativo | Edge function `evolution-webhook` registra entregas, respostas e opt-outs |
| Instância `totalquality` | ⚠️ **Desconectada** (`state: close`) | Precisa reescanear QR Code — passo obrigatório antes de qualquer envio |
| Instância `Adriano` | ❌ Não existe mais no servidor Evolution | Não usar; recriar apenas se quiser um 2º número no pool |
| Peça publicitária | ⚠️ Não está no storage | Candidata identificada no Drive: `check.mp4` (abr/2026). Subir para o bucket `campaign-media` |
| Campanha anterior (Cardio) | 140 enviados / 124 erros | ~90% dos erros = número sem WhatsApp (`exists: false`) → **validar números antes de enviar** |

## 2. ICP e segmentação (Vende-C: "a habilidade zero")

"Produto para todo mundo não é para ninguém." O check-up tem ICP claro: adultos 40+ que sentem a dor de "faz tempo que não faço exames" e o desejo de tranquilidade sobre a própria saúde.

Distribuição da base contactável:

| Faixa etária | Contatos |
|---|---|
| 40–49 | 4.390 |
| 50–59 | 10.720 |
| 60+ | 11.889 |
| **Total ICP (40+)** | **26.999** |

Recomendação: iniciar pelo núcleo do ICP (**50+, 22.609 contatos**) no piloto, expandindo para 40+ na escala. Motivo: maior aderência à oferta de check-up e melhor taxa de resposta esperada, o que também protege a reputação do número no início.

## 3. Níveis de consciência (Vende-C, Módulo 2 — Aula 2)

A maioria da base está nos níveis 1–2 (não sabe que precisa / sabe mas não age). A mensagem não deve ser só oferta ("tirador de pedido"): ela precisa **elevar a consciência** — nomear a dor (tempo sem check-up, filas, demora) antes do CTA.

## 4. Copy proposta (legenda da peça)

Variável `{primeiro_nome}` já é suportada pelo motor (`usar_primeiro_nome = true`).

**Versão A (dor + prova social):**

> Oi {primeiro_nome}! 👋 Aqui é da *Total Quality Medicina Diagnóstica*, em Caraguatatuba.
>
> Quando foi seu último check-up? Se você precisou pensar para responder, essa mensagem é pra você. 🙂
>
> 🩺 Check-up completo com consultas e exames essenciais
> ⚡ Resultados rápidos, sem filas — há mais de 21 anos no Litoral Norte
> 💳 Valores acessíveis e parcelamento no cartão
>
> Quer saber o que está incluso? Responda *SIM* que te explico em 1 minuto.
>
> _Não quer receber mensagens? Responda SAIR._

**Versão B (benefício direto):** mesma estrutura, abrindo com "Cuidar da saúde não precisa ser complicado nem demorado" — usar no teste A/B do piloto (100 contatos cada).

Princípios aplicados (Vende-C): abordagem ≠ pedido de casamento (o CTA pede uma *resposta*, não a compra); "as pessoas compram por emoção e justificam pelos fatos"; venda é vínculo — tom pessoal, nome próprio, sem parecer spam massificado.

## 5. Cadência e proteção anti-bloqueio (re-warmup)

A instância `totalquality` está parada desde 26/04 (~3 meses). Tratar como re-aquecimento:

| Período | Limite diário | Observação |
|---|---|---|
| Dias 1–3 | 30/dia | Piloto + re-warmup |
| Dias 4–7 | 50/dia | Se taxa de erro < 5% e sem sinais de bloqueio |
| Semana 2 | 80/dia | — |
| Semana 3+ | 100–110/dia | Teto atual da instância |

Parâmetros fixos: intervalo aleatório **45–90s** entre envios, janela **09h–18h**, **segunda a sexta** (o motor já aplica tudo isso por campanha).

**Validação prévia de números:** antes de inscrever cada lote, validar via endpoint `POST /chat/whatsappNumbers/{instância}` da Evolution e marcar `contacts.whatsapp_exists`. Isso elimina a principal causa de erro da campanha anterior e evita queimar o limite diário com números inexistentes.

## 6. Fases da campanha

1. **Fase 0 — Preparação** (bloqueia tudo): reconectar WhatsApp (QR), subir `check.mp4` ao bucket `campaign-media`, aprovar copy.
2. **Fase 1 — Piloto (dias 1–3):** 200 contatos 50+, A/B de copy (100/100). Meta mínima: entrega > 90%, resposta ≥ 3%.
3. **Fase 2 — Leitura e ajuste:** comparar taxa de resposta A × B ("não existe 'eu acho' — existe teste e validação"). Ajustar copy/segmento.
4. **Fase 3 — Escala progressiva:** lotes diários conforme tabela de warmup, expandindo para 40+. Com 100/dia, a base ICP dura ~9 meses de campanha contínua.
5. **Fase 4 — Follow-up (Vende-C: "a riqueza está no acompanhamento"):** quem respondeu entra em atendimento comercial (agendamento); quem não respondeu recebe 2º toque após 5–7 dias com ângulo diferente (usar `filtro_enviado_ha_mais_dias` + `filtro_sem_resposta_apos_dias`, já suportados). 80% das vendas acontecem entre a 5ª e a 8ª exposição.

## 7. Funil e métricas (Vende-C: "o que não é medido não pode ser melhorado")

Funil da campanha e metas iniciais:

| Etapa | Métrica | Meta piloto |
|---|---|---|
| Prospecção | Enviados/dia | 30 → 110 |
| Entrega | `total_entregues / total_enviados` | > 90% |
| Resposta (exposição) | `total_respondidos / total_enviados` | ≥ 3% |
| Qualificação → Agendamento | agendados / respostas | ≥ 30% |
| Comparecimento | compareceu / agendados | ≥ 70% |

A taxa de conversão global ("número mágico") define a previsibilidade: ex. com 100 envios/dia, 3% resposta e 30% agendamento ⇒ ~1 agendamento/dia ⇒ ~20/mês por número conectado.

Consultas de monitoramento estão no script `sql/campanha-checkup.sql` (seção 5).

## 8. Conformidade (LGPD)

- Opt-out automático já ativo (tabela `optout_keywords` + webhook); toda mensagem informa a saída ("Responda SAIR").
- `audit_log` disponível para trilha de conformidade.
- Não reenviar para `opt_out = true` (o `enroll_campaign_targets` já exclui).
- Horário comercial e volume limitado reduzem incômodo e denúncias — que são também o principal fator de bloqueio do número.

## 9. Próximos passos (checklist)

- [ ] **Reconectar o WhatsApp**: abrir o Evolution Manager (`http://evolution-api-4lwx.srv1554023.hstgr.cloud/manager`), entrar com a API key global, abrir a instância `totalquality` e escanear o QR (WhatsApp → Aparelhos conectados). Alternativa: pedir ao assistente um QR novo na hora.
- [ ] **Subir a peça** `check.mp4` (Drive) para o bucket público `campaign-media` do Supabase (Dashboard → Storage) e anotar a URL pública.
- [ ] **Aprovar a copy** (versões A/B acima) e a segmentação (50+ no piloto).
- [ ] **Rodar o script** `sql/campanha-checkup.sql` (cria a campanha; a inscrição do lote piloto é o gatilho do envio).
- [ ] Acompanhar o piloto por 3 dias e decidir a escala.
