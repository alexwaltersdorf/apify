-- ============================================================
-- Escala da campanha de check-up (22/07/2026)
-- Projeto Supabase: ajwhrmjzvfdjwsqynbzt
--
-- 1º degrau de escala após o piloto, aplicando a escada de re-warmup
-- documentada (30 -> 50 -> 80 -> 110 msgs/dia). Público mantido em 50+
-- (pool de ~22 mil contatos, meses de runway).
-- ============================================================

-- Volume: instância 30 -> 50/dia; cada campanha (A/B) 15 -> 25/dia.
UPDATE public.whatsapp_instances SET limite_diario = 50, atualizado_em = now()
WHERE nome = 'totalquality';

UPDATE public.campaigns SET limite_diario = 25, atualizado_em = now()
WHERE id IN ('aae6844c-65b0-46f2-bb70-524b151f2506','2d4378e2-d2cb-44e0-a9ec-b5881a6fbdc1');

-- A função enroll_checkup_piloto() foi ajustada (migration scale_enroll_checkup_piloto):
--   * lote diário de cada campanha = o próprio campaigns.limite_diario
--   * teto por campanha: 100 -> 2000 (guardrail; piloto era 200 no total)
--   * revalida números na Evolution quando o pool cai abaixo de 3x a demanda do dia
-- => Próximos degraus de volume: basta alterar campaigns.limite_diario
--    (e whatsapp_instances.limite_diario), sem redefinir a função.

-- ------------------------------------------------------------
-- Escada de re-warmup sugerida (subir 1 degrau a cada 3-4 dias sem sinais
-- de bloqueio: erros_consecutivos baixos, circuit_open=false, health_score alto):
--   Semana atual : 50/dia  (25 A + 25 B)   <-- APLICADO
--   +3-4 dias    : 80/dia  (40 A + 40 B)
--   +3-4 dias    : 110/dia (55 A + 55 B)
-- Para aplicar um degrau:
--   UPDATE public.whatsapp_instances SET limite_diario = 80 WHERE nome='totalquality';
--   UPDATE public.campaigns SET limite_diario = 40
--     WHERE id IN ('aae6844c-65b0-46f2-bb70-524b151f2506','2d4378e2-d2cb-44e0-a9ec-b5881a6fbdc1');
-- ------------------------------------------------------------

-- Verificação:
--   SELECT nome, limite_diario, msg_enviadas_hoje FROM public.whatsapp_instances WHERE nome='totalquality';
--   SELECT nome, limite_diario, total_contatos, total_enviados FROM public.campaigns WHERE nome LIKE 'Checkup 2026%';
