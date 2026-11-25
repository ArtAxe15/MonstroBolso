-- ROGUEMON - Efeitos secundarios: 25% por condicao (25/11/2026)
-- Execute no banco existente no DBeaver, apos backup.
-- Pode ser executado novamente: nao duplica as associacoes golpe_efeito.
-- NAO importe database/monstrobouso.sql sobre jornadas existentes.
-- Use o banco monstrobouso na conexao antes de executar.
use monstrobouso
begin transaction;

-- Preserva a mudanca anterior: todos os golpes acertam pela precisao.
UPDATE golpe SET precisao = 100 WHERE precisao IS NULL OR precisao <> 100;

-- A porcentagem secundaria e somente para efeitos de golpes de DANO.
-- Golpes STATUS (Spore, Toxic, etc.) e efeitos de dreno/atributos mantem sua regra.
UPDATE golpe_efeito AS ge
JOIN golpe AS g ON g.id_golpe = ge.id_golpe
SET ge.chance = 25
WHERE g.categoria = 'DANO' AND ge.tipo_efeito = 'APLICAR_STATUS';

-- Os oito tipos explicitamente sem efeitos secundarios novos nao devem
-- manter antigos APLICAR_STATUS, caso haja dados legados desses tipos.
DELETE ge FROM golpe_efeito AS ge
JOIN golpe AS g ON g.id_golpe = ge.id_golpe
JOIN tipo AS t ON t.id_tipo = g.id_tipo
WHERE g.categoria = 'DANO'
  AND ge.tipo_efeito = 'APLICAR_STATUS'
  AND t.api_nome IN ('fighting', 'ground', 'flying', 'dark', 'steel', 'fairy', 'rock', 'ghost');

-- Efeitos por tipo (incluindo os que ja existiam):
-- Fogo/Dragao -> Queimadura; Eletrico -> Paralisia;
-- Agua/Gelo -> Congelamento; Grama/Psiquico -> Sono;
-- Inseto/Veneno -> Envenenamento.
INSERT INTO golpe_efeito
    (id_golpe, tipo_efeito, alvo, id_status, atributo, alteracao, percentual, chance)
SELECT g.id_golpe, 'APLICAR_STATUS', 'OPONENTE', sp.id_status, NULL, NULL, NULL, 25
FROM golpe AS g
JOIN tipo AS t ON t.id_tipo = g.id_tipo
JOIN status_pokemon AS sp
  ON sp.nome = CASE t.api_nome
    WHEN 'fire' THEN 'Queimadura'
    WHEN 'dragon' THEN 'Queimadura'
    WHEN 'electric' THEN 'Paralisia'
    WHEN 'water' THEN 'Congelamento'
    WHEN 'ice' THEN 'Congelamento'
    WHEN 'grass' THEN 'Sono'
    WHEN 'psychic' THEN 'Sono'
    WHEN 'bug' THEN 'Envenenamento'
    WHEN 'poison' THEN 'Envenenamento'
  END
WHERE g.categoria = 'DANO'
  AND t.api_nome IN ('fire','dragon','electric','water','ice','grass','psychic','bug','poison')
  AND NOT EXISTS (
    SELECT 1 FROM golpe_efeito AS ge
    WHERE ge.id_golpe = g.id_golpe
      AND ge.tipo_efeito = 'APLICAR_STATUS'
      AND ge.id_status = sp.id_status
  );

-- Efeitos especificos mantidos, alem daqueles do tipo:
-- Body Slam = Paralisia; Dragon Breath = Paralisia + Queimadura.
INSERT INTO golpe_efeito
    (id_golpe, tipo_efeito, alvo, id_status, atributo, alteracao, percentual, chance)
SELECT g.id_golpe, 'APLICAR_STATUS', 'OPONENTE', sp.id_status, NULL, NULL, NULL, 25
FROM golpe AS g
JOIN status_pokemon AS sp ON sp.nome = 'Paralisia'
WHERE g.categoria = 'DANO'
  AND g.api_id IN (34, 225)
  AND NOT EXISTS (
    SELECT 1 FROM golpe_efeito AS ge
    WHERE ge.id_golpe = g.id_golpe
      AND ge.tipo_efeito = 'APLICAR_STATUS'
      AND ge.id_status = sp.id_status
  );

-- Atualiza as descricoes historicas de 15% sem mexer em dreno/status.
UPDATE golpe SET descricao = REPLACE(descricao, '15%', '25%')
WHERE categoria = 'DANO' AND descricao LIKE '%15%';

-- Evita repetir texto se a migracao for executada mais de uma vez.
UPDATE golpe AS g
JOIN tipo AS t ON t.id_tipo = g.id_tipo
SET g.descricao = CONCAT(
  COALESCE(g.descricao, ''),
  ' Efeito de tipo: 25% de chance de ',
  CASE t.api_nome
    WHEN 'fire' THEN 'queimar'
    WHEN 'dragon' THEN 'queimar'
    WHEN 'electric' THEN 'paralisar'
    WHEN 'water' THEN 'congelar'
    WHEN 'ice' THEN 'congelar'
    WHEN 'grass' THEN 'adormecer'
    WHEN 'psychic' THEN 'adormecer'
    WHEN 'bug' THEN 'envenenar'
    WHEN 'poison' THEN 'envenenar'
  END,
  ' o oponente.'
)
WHERE g.categoria = 'DANO'
  AND t.api_nome IN ('fire','dragon','electric','water','ice','grass','psychic','bug','poison')
  AND g.api_id NOT IN (424, 188, 398, 58)
  AND COALESCE(g.descricao, '') NOT LIKE '%Efeito de tipo: 25% de chance de%';

COMMIT;

-- Conferencia: efeitos secundarios de golpes de dano devem mostrar 25;
-- demais efeitos mantem as regras originais.
SELECT g.nome AS golpe, t.nome AS tipo, sp.nome AS condicao, ge.chance
FROM golpe_efeito AS ge
JOIN golpe AS g ON g.id_golpe = ge.id_golpe
JOIN tipo AS t ON t.id_tipo = g.id_tipo
JOIN status_pokemon AS sp ON sp.id_status = ge.id_status
WHERE g.categoria = 'DANO' AND ge.tipo_efeito = 'APLICAR_STATUS'
ORDER BY t.nome, g.nome, sp.nome;
