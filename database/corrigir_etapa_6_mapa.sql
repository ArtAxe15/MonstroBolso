-- MONSTROBOLSO: correção da etapa 6 do mapa roguelike.
-- Execute no banco monstrobouso pelo DBeaver.
-- Não apaga nós, conexões, perfis, time, dinheiro ou registros de batalha.

SET @tem_chk_etapa := (
  SELECT COUNT(*) FROM information_schema.TABLE_CONSTRAINTS
  WHERE CONSTRAINT_SCHEMA = DATABASE()
    AND TABLE_NAME = 'mapa_no'
    AND CONSTRAINT_NAME = 'chk_mapa_no_etapa'
    AND CONSTRAINT_TYPE = 'CHECK'
);

SET @sql_drop_chk_etapa := IF(
  @tem_chk_etapa > 0,
  'ALTER TABLE `mapa_no` DROP CONSTRAINT `chk_mapa_no_etapa`',
  'SELECT 1'
);

PREPARE stmt_drop_chk_etapa FROM @sql_drop_chk_etapa;
EXECUTE stmt_drop_chk_etapa;
DEALLOCATE PREPARE stmt_drop_chk_etapa;

ALTER TABLE `mapa_no`
  ADD CONSTRAINT `chk_mapa_no_etapa` CHECK (`etapa` BETWEEN 1 AND 6);

-- Verificação: o resultado esperado é 1 <= etapa <= 6.
SELECT CONSTRAINT_NAME, CHECK_CLAUSE
FROM information_schema.CHECK_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = DATABASE()
  AND CONSTRAINT_NAME = 'chk_mapa_no_etapa';
