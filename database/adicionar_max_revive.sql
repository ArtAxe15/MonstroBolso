INSERT INTO item (nome, categoria, preco, valor_efeito, descricao, tipo_efeito)
SELECT 'Max Revive', 'REVIVE', 4000, 100, 'Revive um Pokémon desmaiado com 100% do HP máximo.', 'PERCENTUAL'
WHERE NOT EXISTS (SELECT 1 FROM item WHERE nome = 'Max Revive');