<?php

declare(strict_types=1);

require __DIR__ . '/../app/Autoload.php';

use App\Services\BattleService;
use App\Services\StatCalculator;

function criarPokemonTeste(string $nome, int $nivel, array $bases): array
{
    $hpMax = StatCalculator::calcularHp((int) $bases['hp_base'], $nivel);

    return [
        'nome' => $nome,
        'id_pokemon_especie' => $bases['id_pokemon_especie'],
        'nivel' => $nivel,
        'hp_atual' => $hpMax,
        'hp_max' => $hpMax,
        'status' => 'normal',
        'posicao' => 1,
        'ataque' => StatCalculator::calcular((int) $bases['ataque_base'], $nivel),
        'defesa' => StatCalculator::calcular((int) $bases['defesa_base'], $nivel),
        'ataque_especial' => StatCalculator::calcular((int) $bases['ataque_especial_base'], $nivel),
        'defesa_especial' => StatCalculator::calcular((int) $bases['defesa_especial_base'], $nivel),
        'velocidade' => StatCalculator::calcular((int) $bases['velocidade_base'], $nivel),
        'tipos' => $bases['tipos'],
        'golpes' => [
            [
                'id_golpe' => 1,
                'nome' => 'Investida',
                'categoria' => 'DANO',
                'classe_dano' => 'physical',
                'poder' => 40,
                'precisao' => 100,
                'prioridade' => 0,
                'id_tipo' => 1,
                'tipo_nome' => 'Normal',
            ],
            [
                'id_golpe' => 2,
                'nome' => 'Chama',
                'categoria' => 'DANO',
                'classe_dano' => 'special',
                'poder' => 40,
                'precisao' => 100,
                'prioridade' => 0,
                'id_tipo' => 2,
                'tipo_nome' => 'Fogo',
            ],
        ],
    ];
}

$player = [
    criarPokemonTeste('Snivy', 10, [
        'id_pokemon_especie' => 16,
        'hp_base' => 45,
        'ataque_base' => 45,
        'defesa_base' => 55,
        'ataque_especial_base' => 45,
        'defesa_especial_base' => 55,
        'velocidade_base' => 63,
        'tipos' => ['Grama'],
    ]),
    criarPokemonTeste('Purrloin', 10, [
        'id_pokemon_especie' => 30,
        'hp_base' => 41,
        'ataque_base' => 50,
        'defesa_base' => 37,
        'ataque_especial_base' => 50,
        'defesa_especial_base' => 37,
        'velocidade_base' => 66,
        'tipos' => ['Preto'],
    ]),
];

$enemy = [
    criarPokemonTeste('Tepig', 10, [
        'id_pokemon_especie' => 19,
        'hp_base' => 65,
        'ataque_base' => 63,
        'defesa_base' => 45,
        'ataque_especial_base' => 45,
        'defesa_especial_base' => 45,
        'velocidade_base' => 45,
        'tipos' => ['Fogo'],
    ]),
    criarPokemonTeste('Pansage', 10, [
        'id_pokemon_especie' => 32,
        'hp_base' => 50,
        'ataque_base' => 53,
        'defesa_base' => 48,
        'ataque_especial_base' => 53,
        'defesa_especial_base' => 48,
        'velocidade_base' => 64,
        'tipos' => ['Grama'],
    ]),
];

$simulacao = BattleService::simularPartida($player, $enemy, ['max_turnos' => 80]);

printf("Resultado: %s\n", strtoupper((string) $simulacao['resultado']['vencedor']));
printf("Turnos: %d\n", (int) $simulacao['turnos']);
printf("Dano médio por golpe: %.2f\n", (float) $simulacao['balance']['dano_medio']);
printf("Total de golpes: %d\n", (int) $simulacao['balance']['total_golpes']);

if ((float) $simulacao['balance']['dano_medio'] > 60.0) {
    echo "Aviso: o dano ficou exagerado para a escala atual do projeto.\n";
} elseif ((float) $simulacao['balance']['dano_medio'] < 15.0) {
    echo "Aviso: o dano ficou irrisório para a escala atual do projeto.\n";
} else {
    echo "Escala de dano aceitável para nível 10 x nível 10.\n";
}

$statusBattle = BattleService::simularPartida([
    [
        'nome' => 'Bulbasaur',
        'id_pokemon_especie' => 1,
        'nivel' => 12,
        'hp_atual' => 80,
        'hp_max' => 80,
        'status' => 'normal',
        'posicao' => 1,
        'ataque' => 35,
        'defesa' => 30,
        'ataque_especial' => 40,
        'defesa_especial' => 35,
        'velocidade' => 30,
        'tipos' => ['Grama'],
        'golpes' => [[
            'id_golpe' => 200,
            'nome' => 'Folha',
            'categoria' => 'DANO',
            'classe_dano' => 'special',
            'poder' => 50,
            'precisao' => 100,
            'prioridade' => 0,
            'id_tipo' => 5,
            'tipo_nome' => 'Grama',
            'efeitos' => [[
                'tipo_efeito' => 'APLICAR_STATUS',
                'alvo' => 'OPONENTE',
                'id_status' => 1,
                'chance' => 100,
            ]],
        ]],
    ],
], [
    [
        'nome' => 'Charmander',
        'id_pokemon_especie' => 2,
        'nivel' => 12,
        'hp_atual' => 80,
        'hp_max' => 80,
        'status' => 'normal',
        'posicao' => 1,
        'ataque' => 38,
        'defesa' => 31,
        'ataque_especial' => 38,
        'defesa_especial' => 31,
        'velocidade' => 35,
        'tipos' => ['Fogo'],
        'golpes' => [[
            'id_golpe' => 201,
            'nome' => 'Chama',
            'categoria' => 'DANO',
            'classe_dano' => 'special',
            'poder' => 40,
            'precisao' => 100,
            'prioridade' => 0,
            'id_tipo' => 2,
            'tipo_nome' => 'Fogo',
        ]],
    ],
], ['max_turnos' => 5]);

$statusStatus = false;
foreach ($statusBattle['eventos'] as $evento) {
    if (($evento['tipo'] ?? '') === 'status_aplicado') {
        $statusStatus = true;
        break;
    }
}

echo "Status aplicado: " . ($statusStatus ? 'SIM' : 'NAO') . "\n";

try {
    $db = \App\Config\Database::getConnection();
    $perfil = (int) $db->query('SELECT MIN(id_perfil) FROM perfil')->fetchColumn();
    if ($perfil > 0) {
        $db->prepare('INSERT INTO inventario (id_perfil, id_item, quantidade) VALUES (:perfil, :item, 2) ON DUPLICATE KEY UPDATE quantidade = quantidade + 2')
            ->execute(['perfil' => $perfil, 'item' => 1]);

        $battleTeste = [
            'jogador' => ['time' => [[
                'id' => 999,
                'nome' => 'Teste',
                'hp_atual' => 50,
                'hp_max' => 50,
                'status' => 'normal',
                'posicao' => 1,
                'ataque' => 30,
                'defesa' => 30,
                'ataque_especial' => 30,
                'defesa_especial' => 30,
                'velocidade' => 30,
                'tipos' => ['Normal'],
                'golpes' => [[
                    'id_golpe' => 999,
                    'nome' => 'Investida',
                    'categoria' => 'DANO',
                    'classe_dano' => 'physical',
                    'poder' => 20,
                    'precisao' => 100,
                    'prioridade' => 0,
                    'id_tipo' => 1,
                    'tipo_nome' => 'Normal',
                ]],
            ]], 'ativo' => 0],
            'oponente' => ['time' => [[
                'id' => 998,
                'nome' => 'Alvo',
                'hp_atual' => 50,
                'hp_max' => 50,
                'status' => 'normal',
                'posicao' => 1,
                'ataque' => 30,
                'defesa' => 30,
                'ataque_especial' => 30,
                'defesa_especial' => 30,
                'velocidade' => 30,
                'tipos' => ['Normal'],
                'golpes' => [[
                    'id_golpe' => 998,
                    'nome' => 'Investida',
                    'categoria' => 'DANO',
                    'classe_dano' => 'physical',
                    'poder' => 20,
                    'precisao' => 100,
                    'prioridade' => 0,
                    'id_tipo' => 1,
                    'tipo_nome' => 'Normal',
                ]],
            ]], 'ativo' => 0],
            'aguardando_troca' => false,
            'fim' => null,
            'resultado' => null,
            'eventos' => [],
            'turnos' => 0,
            'persistida' => false,
            'itens' => [],
        ];

        $_SESSION['batalha'] = $battleTeste;
        $resposta = BattleService::executarTurno($db, $perfil, ['acao' => 'item', 'id_item' => 1, 'alvo_posicao' => 1]);
        echo "Item usado: " . (isset($resposta['estado']['itens']) ? 'SIM' : 'NAO') . "\n";
    } else {
        echo "Item usado: NAO\n";
    }
} catch (Throwable $e) {
    echo "Item usado: NAO\n";
    echo 'Erro item: ' . $e->getMessage() . "\n";
}
