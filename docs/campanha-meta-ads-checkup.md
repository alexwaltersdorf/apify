# Campanha Meta Ads — Check-ups Preventivos | Total Quality Medicina Diagnóstica

Campanha de geração de demanda no Meta (Facebook + Instagram) integrada ao motor de **venda ativa via WhatsApp** já em operação. Estruturada por um funil completo (TOFU → MOFU → BOFU → pós-venda), aplicando a metodologia Vende-C: níveis de consciência, ICP, funil de 7 etapas, follow-up e gestão por taxa de conversão.

---

## 1. Estratégia: o papel de cada canal

O Vende-C ensina que prospecção ativa e passiva não competem — se combinam ("nunca dependa de uma só forma"). A arquitetura:

| Canal | Papel no funil | Tipo |
|---|---|---|
| **Meta Ads** | Gerar demanda: elevar consciência (níveis 1–2) e capturar intenção (níveis 3–4) | Passivo → atrai |
| **WhatsApp (Evolution/Supabase)** | Converter: abordagem, qualificação, apresentação, follow-up, fechamento | Ativo → converte |
| **Bot n8n + recepção** | Atendimento, agendamento e pós-venda | Fechamento + LTV |

O anúncio não vende o check-up — ele **inicia a conversa**. Quem vende é o funil ativo ("o fechamento paga a conta de todas as etapas"). Por isso o objetivo central da campanha é **Click-to-WhatsApp (CTWA)**: cada clique cai direto no WhatsApp da clínica, onde o processo de vendas assume.

## 2. ICP e públicos (a "habilidade zero")

**ICP:** adultos 40+ (núcleo 50+) de Caraguatatuba e Litoral Norte de SP, que sentem a dor "faz tempo que não faço exames" e o desejo de tranquilidade sobre a própria saúde. Decisor frequente: a mulher 40–60 que cuida da saúde da família (agendadora do lar).

**Públicos no Gerenciador:**

| # | Público | Fonte | Etapa |
|---|---|---|---|
| P1 | Frio local — 38+, raio 15 km de Caraguatatuba (+ São Sebastião, Ubatuba, Ilhabela) | Segmentação geográfica + idade | TOFU |
| P2 | Lookalike 1–3% da base de clientes | Custom Audience: lista da base (~29 mil contatos, upload com hash) | TOFU/MOFU |
| P3 | Envolvimento — viu ≥50% dos vídeos ou interagiu com a página/perfil (365d) | Remarketing de engajamento | MOFU |
| P4 | Quase-cliente — clicou no CTWA mas não agendou; visitantes do perfil (30d) | Remarketing quente | BOFU |
| P5 | Base atual (exclusão ou campanha própria de recompra/retorno anual) | Custom Audience | Pós-venda |

Exclusões: quem já agendou (via lista atualizada semanalmente) — "a pior coisa em vendas é gastar tempo (e verba) com quem não tem perfil" ou já converteu.

## 3. Funil da campanha (níveis de consciência → etapas Meta)

A base do mercado está nos níveis 1–2 de consciência (não sabe que precisa / sabe mas não age). Vender só para o nível 4 é ser "tirador de pedido" — e caro, porque todos os concorrentes disputam esse mesmo público. A campanha compra atenção barata no topo e colhe intenção no fundo.

### TOFU — Elevar a consciência (níveis 1–2)
- **Objetivo Meta:** Reconhecimento → Visualizações de vídeo (ThruPlay)
- **Público:** P1 + P2 | **Verba:** 30% do orçamento
- **Criativo:** vídeos educativos de 15–30s. Ângulos: "quando foi seu último check-up?" (gancho de rotina); "alguns marcadores só aparecem no exame — por isso a rotina existe" (gancho de controle); "cuidar da saúde é rotina, não emergência" (nomear a dor SEM prometer resultado nem explorar medo — nunca usar "sinais silenciosos", "antes que seja tarde" ou vocabulário de alarme).
- **Função escondida:** construir o público P3 (quem assiste ≥50% declara interesse — é o "levantar a mão" silencioso).

### MOFU — Consideração (níveis 2–3)
- **Objetivo Meta:** Engajamento / Tráfego
- **Público:** P3 | **Verba:** 20%
- **Criativo:** carrossel "o que é um check-up e o que ele inclui", vídeo institucional (21 anos no Litoral Norte, estrutura, equipe), conteúdo "como se preparar para seus exames". Prova social institucional (tempo de mercado, estrutura) — **sem depoimento de paciente, sem "antes e depois"** (vedado pela publicidade médica).
- **Princípio Vende-C:** "as pessoas compram por emoção e justificam pelos fatos" — aqui entregamos os fatos que justificam a decisão que o TOFU semeou.

### BOFU — Conversão (níveis 3–4)
- **Objetivo Meta:** Vendas/Conversas → **Click-to-WhatsApp**
- **Público:** P3 + P4 + P2 (1%) | **Verba:** 40%
- **Criativo:** os 2 vídeos de check-up já validados (A "dor + pergunta" / B "benefício direto") + variação estática. CTA: **"Enviar mensagem"**.
- **Mensagem pré-preenchida no WhatsApp:** "Olá! Vi o anúncio do check-up e quero saber mais 😊" → dispara o fluxo de qualificação.
- **Copy da campanha ativa reaproveitada** (mesma linguagem nos dois canais = consistência que gera confiança).

### Remarketing de resgate (P4) — 10% da verba
- Quem clicou e não agendou recebe, após 3–7 dias, criativo com ângulo diferente (Vende-C: "80% das vendas entre a 5ª e a 8ª exposição" — o remarketing é o follow-up pago).
- Ângulo: quebra de objeção prática — "leva menos tempo do que você imagina", "resultados rápidos", "agende pelo WhatsApp em 2 minutos".

## 4. Copies por etapa (A/B) — versão auditada (CFM 2.336/2023)

### TOFU — vídeo (legenda)
> **A:** Quando foi seu último check-up? Se você precisou parar para lembrar, talvez seja hora de cuidar disso. 🩺 A prevenção é um ato de cuidado com a sua saúde. | Total Quality Medicina Diagnóstica — há 21 anos em Caraguatatuba. *Saiba mais.*
>
> **B:** Alguns marcadores de saúde só aparecem em exames — por isso a rotina de check-up existe. 🩺 Conhecer seu corpo por meio de exames periódicos é um ato de cuidado. | Total Quality Medicina Diagnóstica. *Assista.*

### BOFU — CTWA (legenda)
> **A (dor + pergunta):** Quando foi seu último check-up? 🩺 Na Total Quality você realiza seus exames com agilidade e conforto, em Caraguatatuba. Consultas e exames essenciais em um só lugar, com resultados em curto prazo. 💬 *Toque em "Enviar mensagem" e fale com nossa equipe pelo WhatsApp.*
>
> **B (benefício direto):** Cuidar da saúde não precisa ser complicado nem demorado. 🩺 Check-up com consultas e exames essenciais, estrutura moderna e atendimento há 21 anos no Litoral Norte. 💬 *Fale com nossa equipe pelo WhatsApp e saiba o que está incluso.*

**Diretrizes de compliance aplicadas (auditar novamente a peça final antes de publicar):**
- Sem promessa/garantia de resultado ("garanta sua saúde" ❌ → "cuide da sua saúde" ✅)
- Sem superlativos ou autoproclamação ("a melhor clínica" ❌; "21 anos de atuação" ✅ — fato verificável)
- Sem depoimentos de pacientes, sem "antes e depois", sem sensacionalismo/medo ("você pode estar doente e não sabe!" ❌)
- Sem preço-isca em anúncio com finalidade de captação sensacionalista; se divulgar valores, de forma sóbria e completa
- **Identificação obrigatória (art. 5º, CFM 2.336/2023):** toda peça de estabelecimento deve exibir, em local visível, o nome da clínica com o nº de registro no CRM-SP e o nome do diretor técnico-médico com CRM (incluir no rodapé dos criativos e na página principal do perfil — art. 6º). *Preencher: [Registro CRM-SP da clínica] e [Diretor(a) Técnico(a) — CRM].*
- Imagens: banco de imagens/produção própria com cessão — não usar imagens de pacientes reais sem autorização (e mesmo com ela, sem identificação); nunca expor consulta/procedimento em andamento nem laudo/resultado de exame (dado sensível LGPD)

## 5. Estrutura no Gerenciador de Anúncios

```
Campanha 1 — [TOFU] Consciência Check-up (Vídeo/ThruPlay, CBO)
  └── AdSet P1 Frio local 38+  ── 2 vídeos educativos
  └── AdSet P2 Lookalike 1-3%  ── mesmos criativos
Campanha 2 — [MOFU] Consideração (Engajamento)
  └── AdSet P3 Envolvimento    ── carrossel + institucional
Campanha 3 — [BOFU] Conversas WhatsApp (CTWA, Advantage+ desativado p/ controle geo)
  └── AdSet P3+P2(1%)          ── vídeo A vs vídeo B (teste A/B)
  └── AdSet P4 Remarketing     ── ângulo quebra de objeção
```

- **Orçamento sugerido (piloto de 30 dias):** R$ 70–100/dia total (TOFU 30% · MOFU 20% · BOFU 40% · Resgate 10%). Abaixo de R$ 50/dia o aprendizado do algoritmo fica lento.
- **Teste A/B:** "não existe 'eu acho' — existe teste e validação". Rodar A×B no BOFU por 7 dias ou ~50 conversas antes de matar o perdedor. Criativos "caducam" em 1–2 semanas: manter esteira de variações.
- **Janela de atendimento:** anúncios CTWA 24/7, mas com resposta automática do bot fora do horário ("respondemos a partir das 8h") — velocidade de resposta define conversão ("macarrão se come quente": responder em minutos, não horas).

## 6. Métricas e metas — a cadeia CPC → CPL → CAC → LTV

"O que não é medido não pode ser melhorado." Funil de indicadores e metas iniciais (mercado local de saúde, a calibrar com dados reais):

| Etapa | Métrica | Meta piloto |
|---|---|---|
| Anúncio | CPM / CTR | CTR ≥ 1% (BOFU) |
| Clique → Conversa | Custo por conversa iniciada | R$ 5–15 |
| Conversa → Qualificado | % respondido pelo funil ativo | ≥ 60% |
| Qualificado → Agendamento | taxa de agendamento | ≥ 30% |
| Agendado → Comparecimento | show rate | ≥ 70% |
| **CAC** | verba ÷ comparecimentos | **R$ 50–120** |
| **LTV** | ticket check-up × recorrência anual + exames da família | LTV/CAC ≥ 3 |

**Exemplo do "número mágico":** R$ 90/dia → ~9 conversas/dia (R$ 10/conversa) → 60% qualificadas (5,4) → 30% agendam (1,6/dia) → 70% comparecem ≈ **1,1 check-up/dia ≈ 24/mês**. Com esses ratios validados, a receita vira previsível: para dobrar agendamentos, dobra-se a verba do BOFU (mantendo CPC estável) — é o investimento X no topo produzindo Y no fundo.

## 7. Integração com a venda ativa (onde o Meta encontra o Vende-C)

O lead do CTWA entra no **mesmo funil de 7 etapas** da campanha ativa:

1. **Abordagem** (bot/recepção): resposta em minutos, chamar pelo nome, tom humano — "não existe segunda chance para a primeira impressão".
2. **Qualificação**: 2–3 perguntas poderosas — "é para você ou para alguém da família?", "prefere manhã ou tarde?", "tem alguma data em mente?" (pergunta de escolha dupla conduz ao agendamento).
3. **Apresentação**: o que inclui o check-up, prazo dos resultados, formas de pagamento — benefício antes de característica.
4. **Follow-up**: quem não fecha entra na cadência (toques em 2, 5 e 8 dias; "a riqueza está no acompanhamento") + remarketing P4 rodando em paralelo.
5. **Fechamento**: pedir o agendamento explicitamente — "Posso confirmar seu horário de quinta às 9h?" (fechamento é uma pergunta).
6. **Pós-venda**: 1s após o exame = 1ª janela de indicação; resultado entregue = 2ª janela. Script: "que bom que deu tudo certo! Quem da sua família também está precisando cuidar dos exames?" — **indicação não se pede, se pega**.
7. **Registro**: cada lead marcado com origem `meta-ads` no CRM (Supabase) para medir o funil por canal.

## 8. Cronograma (4 semanas)

| Semana | Ação |
|---|---|
| 1 | Subir estrutura, públicos e pixels/API de conversões; iniciar TOFU + BOFU (A/B); bot preparado para o fluxo CTWA |
| 2 | Primeira leitura (CTR, custo/conversa); ativar MOFU com o público P3 formado; ajustar copies |
| 3 | Matar criativo perdedor do A/B; ativar remarketing P4; primeira leitura de CAC real |
| 4 | Leitura completa da cadeia CPC→CAC→LTV; decisão de escala (subir verba 20–30% por vez, nunca dobrar de uma vez — protege o aprendizado do algoritmo) |

## 9. Checklist pré-publicação (obrigatório)

- [ ] Auditoria de compliance da peça final (CFM 2.336/2023 / CONAR) — copies, criativos e landing
- [ ] Perfil/página com identificação completa da clínica + diretor técnico e CRM
- [ ] Pixel/API de conversões instalada; eventos de conversa configurados
- [ ] Bot n8n com fluxo de boas-vindas para a mensagem pré-preenchida do anúncio
- [ ] Origem `meta-ads` sendo gravada no CRM para atribuição
- [ ] Listas de exclusão (já agendados/clientes) carregadas e com atualização semanal
