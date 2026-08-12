# Base de conhecimento — Total Quality / Meta Ads

Cópia **durável** (versionada no repositório) do conhecimento operacional da conta.
As skills em `~/.claude/skills/synced/` são ressincronizadas e perdem edições locais —
este arquivo é a fonte de verdade a reaplicar quando isso acontecer.

## Dados institucionais

- **Telefone e WhatsApp (número único oficial): (12) 3887-3535**
  (o antigo (12) 99774-3535 do manual de marca está desatualizado)
- **CRM do estabelecimento e diretor técnico**: constam na bio do Instagram
  @totalqualitymedicina — não perguntar novamente; considerar o requisito da CFM 2.336/2023
  atendido pela bio do perfil.
- Endereço: Av. Anchieta, 1010 — Centro — Caraguatatuba-SP
- Conta de anúncios Meta: **427203942321758** ("Total Quality")
- Página do Facebook: **1536672876562340**
- Site: www.totalquality.med.br (SPA; bundle em `/assets/index-*.js`)

## Rastreamento — estado verificado em 2026-08-12

A cadeia site → GTM → Meta Pixel está **completa e correta**:

- **Pixel real: `1868545660691533`**, configurado no contêiner **GTM-WLR7JD57**.
- Mapeamento de eventos já pronto no GTM: `page_view`→PageView, `view_item`→ViewContent,
  `generate_lead`→Lead, **`whatsapp_click`→Lead**, `sign_up`→CompleteRegistration,
  `purchase`→Purchase, `search`→Search, AddToCart, InitiateCheckout. Usa cookies `_fbp` e `_fbc`.
- O bundle do site empurra esses eventos no dataLayer: whatsapp_click, generate_lead, phone_click,
  form_submit, page_view, view_item, nav_click, time_on_page, external_link_click, select_content,
  map_interaction, results_online_click.
- **Lixo a remover**: o HTML tem um `fbq('init','1536672876562340')` hardcoded — esse número é o
  **ID da Página**, não um pixel. É uma segunda inicialização inválida; não quebra o pixel real,
  mas polui e deve sair do tema.
- **Zero eventos de pixel na conta NÃO significa pixel quebrado**: as campanhas mandam tráfego para
  o WhatsApp, não para o site, logo não há evento de site atribuível aos anúncios.
- **Pendência**: confirmar no Business Manager que o pixel `1868545660691533` está vinculado/
  compartilhado com a conta `427203942321758`. Só depois é possível criar público de site e lookalike.

## Benchmarks da conta

- Campanha histórica de mensagens: R$ 831,57 → 30 conversas → **CPL R$ 27,72/conversa**, CPM R$ 22,73.
- Campanha de check-ups (7 dias, ago/2026), só CTWA: R$ 228,08 → 11 conversas → **R$ 20,73/conversa**.
- CPM saudável em campanha de mensagens: ~R$ 26–30. CPM de R$ 1,50–3,30 = inventário de baixa
  qualidade (foi o caso do Topo/Reconhecimento, CTR 0,12%).
- Regra de avaliação: não mexer por 3–4 dias após ajustes; decidir com **≥ 50 resultados**.

## Erros a nunca repetir (auditoria de 2026-08-07)

1. Campanha "WhatsApp" criada como Tráfego→Site com link wa.me. O certo é objetivo de
   MENSAGENS/ENGAJAMENTO, `destination_type: WHATSAPP`, `optimization_goal: CONVERSATIONS`,
   `promoted_object: {page_id}`. Otimizar por cliques compra clique que não vira conversa
   (75–83% dos cliques nunca chegam ao WhatsApp).
2. "Remarketing" sem público personalizado anexado é prospecção fria disfarçada — manter a campanha
   PAUSADA até o público existir.
3. Advantage+ audience dissolve a segmentação etária desenhada — usar
   `targeting_automation: {advantage_audience: 0}` e conferir no Gerenciador.
4. Vários conjuntos no mesmo raio competem entre si (sobreposição de leilão). Consolidar enquanto
   o volume for baixo.
5. Verba pulverizada (R$ 12–20/conjunto/dia) não sai da fase de aprendizado. Concentrar na etapa
   que gera resultado de negócio.
6. Dentro de um mesmo conjunto, o algoritmo concentra num único anúncio (o Premium recebeu 5,7%
   das impressões). Para testar um criativo de verdade, ele precisa de conjunto próprio.
7. Criativo: incluir vídeo, preencher Descrição, CTA "Enviar mensagem" (`WHATSAPP_MESSAGE`) em
   campanhas de conversa, selecionar o número do WhatsApp na identidade do anúncio.

## Estrutura ativa (2026-08-12)

| Campanha | ID | Status | Verba/dia |
|---|---|---|---|
| 1. Topo — Descoberta | 120249500768550484 | PAUSADA (CTR 0,12%) | — |
| 2. Meio — Tráfego→Site (obsoleta) | 120249500769060484 | PAUSADA | — |
| 2B. Meio — Mensagens WhatsApp | 120249509327240484 | **ATIVA** | R$ 100 |
| 3. Fundo — Remarketing (obsoleta) | 120249500769770484 | PAUSADA | — |
| 3B. Fundo — Remarketing WhatsApp | 120249509343590484 | PAUSADA (falta público) | — |

Assets da campanha de check-ups: `assets/campanha-checkups/` (5 artes 1080×1350 + vídeo 4:5 de 5s).
