-- Execute no banco do jogo com as batalhas em andamento encerradas.
-- Conserva a quantidade de HP perdida e mantém Pokémon desmaiados com 0 HP.
UPDATE pokemon_time AS pt
INNER JOIN pokemon_especie AS pe
    ON pe.id_pokemon_especie = pt.id_pokemon_especie
INNER JOIN (
    SELECT
        time_atual.id_pokemon_time,
        time_atual.hp_max AS hp_max_anterior,
        (2 * especie.hp_base * time_atual.nivel) DIV 100 + time_atual.nivel + 10 AS hp_max_novo
    FROM pokemon_time AS time_atual
    INNER JOIN pokemon_especie AS especie
        ON especie.id_pokemon_especie = time_atual.id_pokemon_especie
    GROUP BY time_atual.id_pokemon_time, time_atual.hp_max, especie.hp_base, time_atual.nivel
) AS hp ON hp.id_pokemon_time = pt.id_pokemon_time
SET
    pt.hp_atual = CASE
        WHEN pt.hp_atual = 0 THEN 0
        ELSE GREATEST(1, LEAST(hp.hp_max_novo, pt.hp_atual + hp.hp_max_novo - hp.hp_max_anterior))
    END,
    pt.hp_max = hp.hp_max_novo,
    pt.ataque = (2 * pe.ataque_base * pt.nivel) DIV 100 + 5,
    pt.defesa = (2 * pe.defesa_base * pt.nivel) DIV 100 + 5,
    pt.ataque_especial = (2 * pe.ataque_especial_base * pt.nivel) DIV 100 + 5,
    pt.defesa_especial = (2 * pe.defesa_especial_base * pt.nivel) DIV 100 + 5,
    pt.velocidade = (2 * pe.velocidade_base * pt.nivel) DIV 100 + 5;
