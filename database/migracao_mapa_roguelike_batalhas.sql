-- MONSTROBOLSO: mapa roguelike integrado ao cadastro de NPCs usado pelas batalhas.
-- Execute uma vez no banco monstrobouso (MariaDB 10.4+).
-- Não altera BattleController, BattleService, Encontro nem as tabelas de batalha.

CREATE TABLE IF NOT EXISTS `mapa_no` (
  `id_mapa_no` int(11) NOT NULL AUTO_INCREMENT,
  `id_perfil` int(11) NOT NULL,
  `tipo_local` varchar(25) NOT NULL,
  `id_npc_tipo` int(11) DEFAULT NULL,
  `id_npc_mapa` int(11) DEFAULT NULL,
  `posicao_x` tinyint(3) unsigned NOT NULL,
  `posicao_y` tinyint(3) unsigned NOT NULL,
  `etapa` tinyint(3) unsigned NOT NULL,
  `ordem_no` tinyint(3) unsigned NOT NULL,
  `status` varchar(15) NOT NULL DEFAULT 'BLOQUEADO',
  `criado_em` datetime NOT NULL DEFAULT current_timestamp(),
  `concluido_em` datetime DEFAULT NULL,
  PRIMARY KEY (`id_mapa_no`),
  UNIQUE KEY `uq_mapa_no_etapa` (`id_perfil`,`etapa`,`ordem_no`),
  UNIQUE KEY `uq_mapa_no_posicao` (`id_perfil`,`posicao_x`,`posicao_y`),
  UNIQUE KEY `uq_mapa_no_npc_mapa` (`id_npc_mapa`),
  KEY `idx_mapa_no_npc_tipo` (`id_npc_tipo`),
  CONSTRAINT `fk_mapa_no_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id_perfil`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mapa_no_npc_tipo` FOREIGN KEY (`id_npc_tipo`) REFERENCES `npc_tipo` (`id_npc_tipo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_mapa_no_npc_mapa` FOREIGN KEY (`id_npc_mapa`) REFERENCES `npc_mapa` (`id_npc_mapa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_mapa_no_tipo` CHECK (`tipo_local` IN ('TREINADOR','SELVAGEM','POKEBOLA','CENTRO_POKEMON','POKEMART','DESAFIO')),
  CONSTRAINT `chk_mapa_no_status` CHECK (`status` IN ('BLOQUEADO','DISPONIVEL','CONCLUIDO','IGNORADO')),
  CONSTRAINT `chk_mapa_no_coordenadas` CHECK (`posicao_x` <= 100 AND `posicao_y` <= 100),
  CONSTRAINT `chk_mapa_no_etapa` CHECK (`etapa` BETWEEN 1 AND 6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Corrige também bancos que já possuíam mapa_no da migração anterior (etapas 1 a 5).
-- O layout atual possui uma sexta etapa para o desafio final.
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

-- Compatibilidade com a tabela mapa_no criada pela migração anterior, que não
-- possuía id_npc_mapa. A coluna liga cada ponto de treinador ao ID esperado
-- pelo código de batalha que já existe no projeto.
SET @coluna_id_npc_mapa := (
  SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mapa_no' AND COLUMN_NAME = 'id_npc_mapa'
);
SET @sql_coluna := IF(
  @coluna_id_npc_mapa = 0,
  'ALTER TABLE `mapa_no` ADD COLUMN `id_npc_mapa` int(11) DEFAULT NULL AFTER `id_npc_tipo`',
  'SELECT 1'
);
PREPARE stmt_coluna FROM @sql_coluna;
EXECUTE stmt_coluna;
DEALLOCATE PREPARE stmt_coluna;

SET @indice_id_npc_mapa := (
  SELECT COUNT(*) FROM information_schema.STATISTICS
  WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mapa_no' AND INDEX_NAME = 'uq_mapa_no_npc_mapa'
);
SET @sql_indice := IF(
  @indice_id_npc_mapa = 0,
  'ALTER TABLE `mapa_no` ADD UNIQUE KEY `uq_mapa_no_npc_mapa` (`id_npc_mapa`)',
  'SELECT 1'
);
PREPARE stmt_indice FROM @sql_indice;
EXECUTE stmt_indice;
DEALLOCATE PREPARE stmt_indice;

SET @fk_id_npc_mapa := (
  SELECT COUNT(*) FROM information_schema.TABLE_CONSTRAINTS
  WHERE CONSTRAINT_SCHEMA = DATABASE() AND TABLE_NAME = 'mapa_no'
    AND CONSTRAINT_NAME = 'fk_mapa_no_npc_mapa' AND CONSTRAINT_TYPE = 'FOREIGN KEY'
);
SET @sql_fk := IF(
  @fk_id_npc_mapa = 0,
  'ALTER TABLE `mapa_no` ADD CONSTRAINT `fk_mapa_no_npc_mapa` FOREIGN KEY (`id_npc_mapa`) REFERENCES `npc_mapa` (`id_npc_mapa`) ON DELETE CASCADE ON UPDATE CASCADE',
  'SELECT 1'
);
PREPARE stmt_fk FROM @sql_fk;
EXECUTE stmt_fk;
DEALLOCATE PREPARE stmt_fk;

CREATE TABLE IF NOT EXISTS `mapa_conexao` (
  `id_mapa_conexao` int(11) NOT NULL AUTO_INCREMENT,
  `id_mapa_no_origem` int(11) NOT NULL,
  `id_mapa_no_destino` int(11) NOT NULL,
  PRIMARY KEY (`id_mapa_conexao`),
  UNIQUE KEY `uq_mapa_conexao` (`id_mapa_no_origem`,`id_mapa_no_destino`),
  KEY `idx_mapa_conexao_destino` (`id_mapa_no_destino`),
  CONSTRAINT `fk_mapa_conexao_origem` FOREIGN KEY (`id_mapa_no_origem`) REFERENCES `mapa_no` (`id_mapa_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mapa_conexao_destino` FOREIGN KEY (`id_mapa_no_destino`) REFERENCES `mapa_no` (`id_mapa_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
