# Webhook Divisor — Evolution → Supabase → n8n

**Implantado em 17/07/2026** (aprovado por Alex).

## Contexto

A Evolution API permite apenas **um** webhook por instância. Desde junho/2026, o webhook
da instância `totalquality` apontava direto para o n8n (bot de atendimento da Total Quality),
o que deixava o sistema de campanhas do Supabase cego: sem registro de respostas, entregas
e — crítico — sem processamento automático de opt-out ("SAIR").

## Solução implantada

A edge function `evolution-webhook` (v3) do projeto Supabase "Claude - Automaitizador"
virou um **divisor**:

```
Evolution (totalquality)
   └─► Supabase evolution-webhook  ──► RPC process_evolution_webhook
         │                              (respostas, entregas, opt-out, métricas)
         └─► repassa MESSAGES_UPSERT ──► n8n (bot de atendimento)
                                          payload intacto, mesmo header secreto
```

- Só `MESSAGES_UPSERT` é repassado ao n8n — exatamente o que ele recebia antes;
  `MESSAGES_UPDATE` (entregas/leituras) fica só no Supabase.
- O repasse é *best-effort* com timeout de 10s: se o n8n estiver fora, o processamento
  local não é bloqueado (mas o evento não é re-entregue ao n8n).
- Webhook da Evolution reconfigurado via `POST /webhook/set/totalquality` com
  `base64: true` (formato que o n8n já esperava) e o mesmo `x-webhook-secret`.

## Configuração

- URL do n8n: env `N8N_FORWARD_URL` na função (fallback hard-coded para a URL atual).
- Segredo: env `WEBHOOK_SECRET` (fallback hard-coded, gerado no bootstrap de abril).
- Para reverter (n8n direto de novo): `POST /webhook/set/totalquality` apontando a URL
  do n8n com `events: ["MESSAGES_UPSERT"]`.

## Verificação

- Teste sintético (`TEST_PING`) processado com sucesso em 17/07.
- Conferir eventos chegando: `SELECT event_type, count(*), max(received_at) FROM webhook_events GROUP BY 1;`
