<?php
declare(strict_types=1);

set_time_limit(600);

/**
 * Importa/atualiza os 36 golpes de dano definidos pelo MONSTROBOLSO.
 *
 * Regras do projeto:
 * - 18 tipos, cada um com um golpe físico e um especial;
 * - poder personalizado fixo em 65;
 * - a classe e o tipo esperados são definidos pelo projeto e validados contra a PokéAPI;
 * - os golpes com prioridade 1 são configurados explicitamente abaixo;
 * - a importação é feita em transação e pode ser repetida sem duplicar os golpes.
 */

function h(string $valor): string
{
    return htmlspecialchars($valor, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}

function buscarGolpeNaApi(string $slug): array
{
    $url = 'https://pokeapi.co/api/v2/move/' . rawurlencode($slug);
    $contexto = stream_context_create([
        'http' => [
            'method' => 'GET',
            'timeout' => 20,
            'ignore_errors' => true,
            'header' => "Accept: application/json\r\nUser-Agent: MONSTROBOLSO-Importer/1.0\r\n",
        ],
    ]);

    $resposta = @file_get_contents($url, false, $contexto);
    $codigoHttp = 0;
    foreach (($http_response_header ?? []) as $cabecalho) {
        if (preg_match('/^HTTP\/\S+\s+(\d{3})/', $cabecalho, $partes)) {
            $codigoHttp = (int) $partes[1];
        }
    }

    if ($resposta === false) {
        throw new RuntimeException("Não foi possível consultar a PokéAPI para '{$slug}'. Confira a conexão com a internet.");
    }
    if ($codigoHttp !== 200) {
        throw new RuntimeException("A PokéAPI respondeu HTTP {$codigoHttp} para o golpe '{$slug}'. Nenhuma alteração foi gravada.");
    }

    $dados = json_decode($resposta, true);
    if (!is_array($dados) || !isset($dados['id'], $dados['name'], $dados['type']['name'], $dados['damage_class']['name'])) {
        throw new RuntimeException("Resposta inválida da PokéAPI para '{$slug}'. Nenhuma alteração foi gravada.");
    }

    return $dados;
}

$pdo = null;

/* Slug da PokéAPI => tipo esperado e classe definida pelo MONSTROBOLSO. */
$golpes = [
    'body-slam'     => ['tipo' => 'normal',   'classe' => 'PHYSICAL'],
    'round'         => ['tipo' => 'normal',   'classe' => 'SPECIAL'],
    'shock-wave'    => ['tipo' => 'electric', 'classe' => 'SPECIAL'],
    'spark'         => ['tipo' => 'electric', 'classe' => 'PHYSICAL'],
    'fire-fang'     => ['tipo' => 'fire',     'classe' => 'PHYSICAL'],
    'incinerate'    => ['tipo' => 'fire',     'classe' => 'SPECIAL'],
    'water-pulse'   => ['tipo' => 'water',    'classe' => 'SPECIAL'],
    'aqua-jet'      => ['tipo' => 'water',    'classe' => 'PHYSICAL'],
    'mega-drain'    => ['tipo' => 'grass',    'classe' => 'SPECIAL'],
    'leaf-blade'    => ['tipo' => 'grass',    'classe' => 'PHYSICAL'],
    'drain-punch'   => ['tipo' => 'fighting', 'classe' => 'PHYSICAL'],
    'aura-sphere'   => ['tipo' => 'fighting', 'classe' => 'SPECIAL'],
    'sucker-punch'  => ['tipo' => 'dark',     'classe' => 'PHYSICAL'],
    'dark-pulse'    => ['tipo' => 'dark',     'classe' => 'SPECIAL'],
    'bullet-punch'  => ['tipo' => 'steel',    'classe' => 'PHYSICAL'],
    'flash-cannon'  => ['tipo' => 'steel',    'classe' => 'SPECIAL'],
    'shadow-sneak'  => ['tipo' => 'ghost',    'classe' => 'PHYSICAL'],
    'shadow-ball'   => ['tipo' => 'ghost',    'classe' => 'SPECIAL'],
    'bug-bite'      => ['tipo' => 'bug',      'classe' => 'PHYSICAL'],
    'signal-beam'   => ['tipo' => 'bug',      'classe' => 'SPECIAL'],
    'earth-power'   => ['tipo' => 'ground',   'classe' => 'SPECIAL'],
    'bulldoze'      => ['tipo' => 'ground',   'classe' => 'PHYSICAL'],
    'rock-tomb'     => ['tipo' => 'rock',     'classe' => 'PHYSICAL'],
    'power-gem'     => ['tipo' => 'rock',     'classe' => 'SPECIAL'],
    'dragon-claw'   => ['tipo' => 'dragon',   'classe' => 'PHYSICAL'],
    'dragon-breath' => ['tipo' => 'dragon',   'classe' => 'SPECIAL'],
    'dazzling-gleam'=> ['tipo' => 'fairy',    'classe' => 'SPECIAL'],
    'play-rough'    => ['tipo' => 'fairy',    'classe' => 'PHYSICAL'],
    'acrobatics'    => ['tipo' => 'flying',   'classe' => 'PHYSICAL'],
    'air-slash'     => ['tipo' => 'flying',   'classe' => 'SPECIAL'],
    'psychic'       => ['tipo' => 'psychic',  'classe' => 'SPECIAL'],
    'zen-headbutt'  => ['tipo' => 'psychic',  'classe' => 'PHYSICAL'],
    'sludge-bomb'   => ['tipo' => 'poison',   'classe' => 'SPECIAL'],
    'poison-jab'    => ['tipo' => 'poison',   'classe' => 'PHYSICAL'],
    'ice-beam'      => ['tipo' => 'ice',      'classe' => 'SPECIAL'],
    'ice-shard'     => ['tipo' => 'ice',      'classe' => 'PHYSICAL'],
];

/* A prioridade faz parte dos dados usados pela batalha, não da escolha de status. */
$golpesPrioridadeUm = [
    'sucker-punch',
    'bullet-punch',
    'shadow-sneak',
    'aqua-jet',
    'ice-shard',
];

try {
    $pdo = new PDO(
        'mysql:host=localhost;dbname=monstrobouso;charset=utf8mb4',
        'root',
        '',
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ]
    );

    $buscarTipo = $pdo->prepare('SELECT id_tipo FROM tipo WHERE api_nome = ? LIMIT 1');
    $registros = [];

    /* Primeiro consulta e valida todos os golpes. Se a API falhar, nada é alterado no banco. */
    foreach ($golpes as $slug => $esperado) {
        $dados = buscarGolpeNaApi($slug);
        $tipoApi = (string) $dados['type']['name'];
        $classeApi = strtoupper((string) $dados['damage_class']['name']);

        if ($tipoApi !== $esperado['tipo']) {
            throw new RuntimeException("O tipo informado pela PokéAPI para '{$slug}' é '{$tipoApi}', mas o MONSTROBOLSO espera '{$esperado['tipo']}'. Nenhuma alteração foi gravada.");
        }
        if ($classeApi !== $esperado['classe']) {
            throw new RuntimeException("A classe informada pela PokéAPI para '{$slug}' é '{$classeApi}', mas o MONSTROBOLSO espera '{$esperado['classe']}'. Nenhuma alteração foi gravada.");
        }

        $buscarTipo->execute([$tipoApi]);
        $tipoBanco = $buscarTipo->fetch();
        if (!$tipoBanco) {
            throw new RuntimeException("O tipo '{$tipoApi}' não está cadastrado em tipo.api_nome. Nenhuma alteração foi gravada.");
        }

        /*
         * As descrições são do sistema do projeto, não a descrição integral da PokéAPI.
         * Assim não anunciamos efeitos secundários que decidimos adiar (confusão, redução
         * de atributos, flinch, condição especial de Sucker Punch, consumo de Berry etc.).
         */
        $nomesTipos = [
            'normal' => 'Normal', 'electric' => 'Elétrico', 'fire' => 'Fogo',
            'water' => 'Água', 'grass' => 'Grama', 'fighting' => 'Lutador',
            'dark' => 'Sombrio', 'steel' => 'Aço', 'ghost' => 'Fantasma',
            'bug' => 'Inseto', 'ground' => 'Terra', 'rock' => 'Pedra',
            'dragon' => 'Dragão', 'fairy' => 'Fada', 'flying' => 'Voador',
            'psychic' => 'Psíquico', 'poison' => 'Veneno', 'ice' => 'Gelo',
        ];
        $descricao = 'Golpe ' . strtolower($esperado['classe'] === 'PHYSICAL' ? 'físico' : 'especial')
            . ' do tipo ' . ($nomesTipos[$tipoApi] ?? $tipoApi) . ' que causa dano.';

        $descricoesImplementadas = [
            'body-slam' => 'Causa dano e tem 30% de chance de paralisar o oponente.',
            'fire-fang' => 'Causa dano e tem 10% de chance de causar queimadura.',
            'mega-drain' => 'Causa dano e recupera HP equivalente a 50% do dano causado.',
            'drain-punch' => 'Causa dano e recupera HP equivalente a 50% do dano causado.',
            'sucker-punch' => 'Golpe físico do tipo Sombrio com prioridade de execução 1.',
            'bullet-punch' => 'Golpe físico do tipo Aço com prioridade de execução 1.',
            'shadow-sneak' => 'Golpe físico do tipo Fantasma com prioridade de execução 1.',
            'aqua-jet' => 'Golpe físico do tipo Água com prioridade de execução 1.',
            'ice-shard' => 'Golpe físico do tipo Gelo com prioridade de execução 1.',
            'dragon-breath' => 'Causa dano e tem 30% de chance de paralisar o oponente.',
            'poison-jab' => 'Causa dano e tem 30% de chance de envenenar o oponente.',
            'sludge-bomb' => 'Causa dano e tem 30% de chance de envenenar o oponente.',
            'ice-beam' => 'Causa dano e tem 10% de chance de congelar o oponente.',
        ];
        if (isset($descricoesImplementadas[$slug])) {
            $descricao = $descricoesImplementadas[$slug];
        }

        $prioridade = in_array($slug, $golpesPrioridadeUm, true)
            ? 1
            : (int) ($dados['priority'] ?? 0);

        $registros[] = [
            'api_id' => (int) $dados['id'],
            'nome' => (string) $dados['name'],
            'id_tipo' => (int) $tipoBanco['id_tipo'],
            'tipo' => $tipoApi,
            'categoria' => 'DANO',
            'poder' => 65,
            'precisao' => $dados['accuracy'] ?? null,
            'pp' => $dados['pp'] ?? null,
            'prioridade' => $prioridade,
            'classe_dano' => $esperado['classe'],
            'descricao' => $descricao,
            'slug' => $slug,
        ];
    }

    $sqlUpsert = "
        INSERT INTO golpe (
            api_id, nome, id_tipo, categoria, poder,
            precisao, pp, prioridade, classe_dano, descricao
        ) VALUES (
            :api_id, :nome, :id_tipo, :categoria, :poder,
            :precisao, :pp, :prioridade, :classe_dano, :descricao
        )
        ON DUPLICATE KEY UPDATE
            api_id = VALUES(api_id),
            nome = VALUES(nome),
            id_tipo = VALUES(id_tipo),
            categoria = VALUES(categoria),
            poder = VALUES(poder),
            precisao = VALUES(precisao),
            pp = VALUES(pp),
            prioridade = VALUES(prioridade),
            classe_dano = VALUES(classe_dano),
            descricao = VALUES(descricao)
    ";

    $pdo->beginTransaction();
    $gravarGolpe = $pdo->prepare($sqlUpsert);
    foreach ($registros as $registro) {
        $gravarGolpe->execute([
            ':api_id' => $registro['api_id'],
            ':nome' => $registro['nome'],
            ':id_tipo' => $registro['id_tipo'],
            ':categoria' => $registro['categoria'],
            ':poder' => $registro['poder'],
            ':precisao' => $registro['precisao'],
            ':pp' => $registro['pp'],
            ':prioridade' => $registro['prioridade'],
            ':classe_dano' => $registro['classe_dano'],
            ':descricao' => $registro['descricao'],
        ]);
    }
    $pdo->commit();

    echo '<!doctype html><html lang="pt-BR"><meta charset="utf-8"><title>Importação de golpes</title><body>';
    echo '<h1>Importação de golpes concluída</h1>';
    echo '<p>Foram sincronizados ' . count($registros) . ' golpes. Todos possuem poder 65 no MONSTROBOLSO.</p>';
    echo '<ul>';
    foreach ($registros as $registro) {
        echo '<li>' . h($registro['nome']) . ' — ' . h($registro['tipo']) . ' / ' . h($registro['classe_dano']) . ' — prioridade ' . (int) $registro['prioridade'] . '</li>';
    }
    echo '</ul><p>Próximo passo: reimportar as espécies com importar_pokemon.php para recalcular seus golpes e opções de status.</p>';
    echo '</body></html>';
} catch (Throwable $e) {
    if ($pdo instanceof PDO && $pdo->inTransaction()) {
        $pdo->rollBack();
    }
    http_response_code(500);
    echo '<!doctype html><html lang="pt-BR"><meta charset="utf-8"><title>Erro na importação</title><body>';
    echo '<h1>Não foi possível importar os golpes</h1><p>' . h($e->getMessage()) . '</p>';
    echo '<p>Nenhuma alteração parcial foi confirmada. Corrija a causa indicada e tente novamente.</p>';
    echo '</body></html>';
}
