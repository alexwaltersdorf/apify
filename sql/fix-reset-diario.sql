-- ============================================================
-- CORREÇÃO (22/07/2026): envios travavam após o 1º dia
-- Projeto Supabase: ajwhrmjzvfdjwsqynbzt
--
-- Causa raiz: o contador public.whatsapp_instances.msg_enviadas_hoje
-- nunca era zerado. Não havia cron de reset diário. Depois que o
-- contador atingia o limite_diario, o gate em send_next_campaign_message
-- (msg_enviadas_hoje >= limite_diario) reagendava todos os pendentes para
-- "amanhã 09h" indefinidamente. A inscrição diária (enroll_checkup_piloto)
-- seguia acumulando contatos, mas nada era enviado a partir do 2º dia.
--
-- Correção: função + cron que zeram o contador uma vez por dia, antes da
-- janela de envio. É idempotente (só reseta se ultimo_reset_em < hoje).
-- ============================================================

CREATE OR REPLACE FUNCTION public.reset_daily_send_counters()
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path TO 'public', 'pg_temp'
AS $$
DECLARE
  v_reset int;
BEGIN
  WITH r AS (
    UPDATE public.whatsapp_instances
    SET msg_enviadas_hoje = 0,
        ultimo_reset_em   = current_date,
        atualizado_em     = now()
    WHERE coalesce(ultimo_reset_em, date '2000-01-01') < current_date
    RETURNING 1
  )
  SELECT count(*) INTO v_reset FROM r;
  RETURN jsonb_build_object('ran_at', now(), 'instancias_resetadas', v_reset);
END;
$$;

-- 11:00 UTC = 08:00 BRT — antes da janela de envio (09h-18h BRT) e da
-- inscrição diária (enroll-checkup-piloto-daily às 11:45 UTC).
SELECT cron.schedule(
  'reset-daily-send-counters',
  '0 11 * * *',
  $$SELECT public.reset_daily_send_counters()$$
);

-- ------------------------------------------------------------
-- Destrava manual (executado uma vez em 22/07 para liberar o lote do dia):
-- ------------------------------------------------------------
-- UPDATE public.whatsapp_instances
-- SET msg_enviadas_hoje = 0, ultimo_reset_em = current_date, atualizado_em = now()
-- WHERE nome = 'totalquality';
--
-- WITH picks AS (
--   SELECT id, row_number() OVER (PARTITION BY campaign_id ORDER BY agendado_para) AS rn
--   FROM public.campaign_contacts
--   WHERE campaign_id IN ('aae6844c-65b0-46f2-bb70-524b151f2506','2d4378e2-d2cb-44e0-a9ec-b5881a6fbdc1')
--     AND status = 'pendente'
-- )
-- UPDATE public.campaign_contacts cc
-- SET agendado_para = now() + make_interval(secs => (p.rn - 1) * 90)
-- FROM picks p WHERE cc.id = p.id AND p.rn <= 15;

-- ------------------------------------------------------------
-- Verificação:
--   SELECT jobname, schedule, active FROM cron.job WHERE jobname='reset-daily-send-counters';
--   SELECT nome, msg_enviadas_hoje, ultimo_reset_em FROM public.whatsapp_instances WHERE nome='totalquality';
-- ------------------------------------------------------------
