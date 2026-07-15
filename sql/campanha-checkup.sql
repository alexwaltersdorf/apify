-- ============================================================
-- Campanha Check-up — Total Quality (WhatsApp via Evolution)
-- Projeto Supabase: "Claude - Automaitizador" (ajwhrmjzvfdjwsqynbzt)
--
-- Pré-requisitos (Fase 0):
--   1. Instância 'totalquality' CONECTADA na Evolution (QR escaneado)
--   2. Peça de check-up publicada no bucket 'campaign-media'
--      (ajustar :media_url abaixo)
--   3. Copy aprovada
--
-- Segurança do fluxo: criar a campanha NÃO dispara nada.
-- O envio só começa quando contatos são inscritos (passo 4).
-- ============================================================

-- ------------------------------------------------------------
-- 0) Conferências rápidas
-- ------------------------------------------------------------
-- Status permitidos (conferir antes de usar valores diferentes de 'ativa'):
SELECT conrelid::regclass AS tabela, pg_get_constraintdef(oid) AS regra
FROM pg_constraint
WHERE contype = 'c'
  AND conrelid IN ('public.campaigns'::regclass, 'public.whatsapp_instances'::regclass);

-- Instância conectada? (state deve ser "open")
SELECT i.nome, h.status, left(h.content, 200) AS body
FROM public.whatsapp_instances i,
LATERAL extensions.http((
  'GET', i.evolution_url || 'instance/connectionState/' || i.nome,
  ARRAY[extensions.http_header('apikey', i.api_key)], NULL, NULL
)::extensions.http_request) h
WHERE i.nome = 'totalquality';

-- ------------------------------------------------------------
-- 1) Validação prévia de números (evita ~90% dos erros do piloto Cardio)
--    Valida um lote de 300 contatos 50+ ainda não validados.
--    Rodar quantas vezes for preciso antes de inscrever lotes novos.
-- ------------------------------------------------------------
WITH lote AS (
  SELECT id, whatsapp
  FROM public.contacts
  WHERE idade >= 50
    AND whatsapp IS NOT NULL
    AND opt_out = false
    AND whatsapp_exists IS NULL
  ORDER BY random()
  LIMIT 300
),
consulta AS (
  SELECT h.content::jsonb AS resultado
  FROM public.whatsapp_instances i,
  LATERAL extensions.http((
    'POST', i.evolution_url || 'chat/whatsappNumbers/' || i.nome,
    ARRAY[extensions.http_header('apikey', i.api_key),
          extensions.http_header('Content-Type', 'application/json')],
    'application/json',
    jsonb_build_object('numbers', (SELECT jsonb_agg(whatsapp) FROM lote))::text
  )::extensions.http_request) h
  WHERE i.nome = 'totalquality'
)
UPDATE public.contacts c
SET whatsapp_exists = (r.item ->> 'exists')::boolean,
    whatsapp_validated_at = now()
FROM consulta, LATERAL jsonb_array_elements(consulta.resultado) r(item)
WHERE c.whatsapp = r.item ->> 'number';

-- ------------------------------------------------------------
-- 2) Criar a campanha (piloto — versão A da copy)
-- ------------------------------------------------------------
INSERT INTO public.campaigns (
  nome, descricao, status,
  horario_inicio, horario_fim, dias_semana,
  limite_diario, intervalo_min_seg, intervalo_max_seg,
  tipo_conteudo, mensagem_texto, media_url, media_filename,
  usar_primeiro_nome,
  filtro_idade_min,
  tenant_id
) VALUES (
  'Checkup 2026 - Piloto A',
  'Campanha ativa de check-up. Piloto 50+, copy versão A (dor + prova social). Warmup: 30/dia.',
  'ativa',                                   -- sem contatos inscritos, nada é enviado
  '09:00', '18:00', ARRAY[1,2,3,4,5],
  30, 45, 90,
  'video',
  E'Oi {primeiro_nome}! 👋 Aqui é da *Total Quality Medicina Diagnóstica*, em Caraguatatuba.\n\nQuando foi seu último check-up? Se você precisou pensar para responder, essa mensagem é pra você. 🙂\n\n🩺 Check-up completo com consultas e exames essenciais\n⚡ Resultados rápidos, sem filas — há mais de 21 anos no Litoral Norte\n💳 Valores acessíveis e parcelamento no cartão\n\nQuer saber o que está incluso? Responda *SIM* que te explico em 1 minuto.\n\n_Não quer receber mensagens? Responda SAIR._',
  'https://ajwhrmjzvfdjwsqynbzt.supabase.co/storage/v1/object/public/campaign-media/checkup.mp4',  -- << AJUSTAR após upload
  'checkup.mp4',
  true,
  50,                                        -- piloto: 50+; escala: mudar para 40
  '00000000-0000-0000-0000-000000000001'
)
RETURNING id;   -- guardar este UUID para os passos 3 e 4

-- ------------------------------------------------------------
-- 3) (Opcional, recomendado) Restringir inscrição a números validados
--    O enroll padrão não filtra por whatsapp_exists; para o piloto,
--    marcar como opt-out temporário NÃO é adequado — em vez disso,
--    valide o lote (passo 1) e use tags, ou simplesmente aceite os
--    erros 'exists:false' (não consomem limite diário do WhatsApp,
--    apenas do contador interno).
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 4) Inscrever o lote piloto (ISTO INICIA OS ENVIOS na próxima janela)
--    Instância totalquality: 8b0de9a8-4901-4c37-b6ed-f48ab330f72f
--    O enroll usa limite_diario da campanha como tamanho do lote (30).
--    Rodar 1x/dia durante o piloto; automatizar via pg_cron na escala.
-- ------------------------------------------------------------
-- SELECT public.enroll_campaign_targets(
--   '<CAMPAIGN_ID_DO_PASSO_2>'::uuid,
--   '8b0de9a8-4901-4c37-b6ed-f48ab330f72f'::uuid
-- );

-- Automação diária da inscrição (ativar somente na Fase 3 — escala):
-- SELECT cron.schedule(
--   'enroll-checkup-daily', '30 8 * * 1-5',
--   $$SELECT public.enroll_campaign_targets('<CAMPAIGN_ID>'::uuid,
--       '8b0de9a8-4901-4c37-b6ed-f48ab330f72f'::uuid)$$
-- );

-- ------------------------------------------------------------
-- 5) Monitoramento
-- ------------------------------------------------------------
-- Visão geral da campanha:
SELECT nome, status, total_contatos, total_enviados, total_entregues,
       total_respondidos, total_erros,
       round(100.0 * total_respondidos / nullif(total_enviados,0), 1) AS taxa_resposta_pct
FROM public.campaigns
WHERE nome LIKE 'Checkup 2026%';

-- Erros por tipo (diagnóstico):
SELECT left(ultimo_erro, 80) AS erro, count(*)
FROM public.campaign_contacts cc
JOIN public.campaigns c ON c.id = cc.campaign_id
WHERE c.nome LIKE 'Checkup 2026%' AND cc.status = 'erro'
GROUP BY 1 ORDER BY 2 DESC;

-- Saúde da instância:
SELECT nome, status, health_score, msg_enviadas_hoje, limite_diario,
       erros_consecutivos, circuit_open, ultimo_envio_em
FROM public.whatsapp_instances
WHERE nome = 'totalquality';

-- Respostas recebidas (para o comercial fazer follow-up):
SELECT ct.primeiro_nome, ct.whatsapp, ct.ultima_resposta_texto, ct.ultima_resposta_em
FROM public.contacts ct
WHERE ct.ultima_resposta_em > now() - interval '2 days'
ORDER BY ct.ultima_resposta_em DESC;

-- ------------------------------------------------------------
-- 6) Controles operacionais
-- ------------------------------------------------------------
-- Pausar a campanha (para tudo imediatamente):
-- UPDATE public.campaigns SET status = 'pausada' WHERE nome = 'Checkup 2026 - Piloto A';
-- Subir o limite no re-warmup (dias 4-7 → 50; semana 2 → 80; semana 3 → 100):
-- UPDATE public.campaigns SET limite_diario = 50 WHERE nome = 'Checkup 2026 - Piloto A';
-- UPDATE public.whatsapp_instances SET limite_diario = 50 WHERE nome = 'totalquality';
