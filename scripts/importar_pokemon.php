<?php
declare(strict_types=1);

/**
 * Importa ou atualiza uma espécie e reconstrói suas relações com tipos,
 * um golpe de dano por tipo e opções de golpe de status.
 *
 * Regra de categoria escolhida:
 * - Ataque >= Ataque Especial: usar golpes físicos (empate favorece físico);
 * - Ataque Especial > Ataque: usar golpes especiais.
 */

function h(string $valor): string
{
    return htmlspecialchars($valor, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}

function buscarPokemonNaApi(string $nome): array
{
    $nome = strtolower(str_replace(' ', '-', trim($nome)));
    $url = 'https://pokeapi.co/api/v2/pokemon/' . rawurlencode($nome);
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
        throw new RuntimeException("Não foi possível consultar a PokéAPI para '{$nome}'. Confira a conexão com a internet e o nome digitado.");
    }
    if ($codigoHttp !== 200) {
        throw new RuntimeException("A PokéAPI respondeu HTTP {$codigoHttp} para '{$nome}'. Confira o nome do Pokémon.");
    }

    $dados = json_decode($resposta, true);
    if (!is_array($dados) || !isset($dados['id'], $dados['name'], $dados['stats'], $dados['types'])) {
        throw new RuntimeException('A PokéAPI retornou dados incompletos para o Pokémon.');
    }

    return $dados;
}

/** Consulta um endpoint/URL da PokéAPI e valida a resposta HTTP e JSON. */
function buscarJsonApi(string $url, string $recurso): array
{
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
        throw new RuntimeException("Não foi possível consultar a PokéAPI para obter {$recurso}.");
    }
    if ($codigoHttp !== 200) {
        throw new RuntimeException("A PokéAPI respondeu HTTP {$codigoHttp} ao consultar {$recurso}.");
    }

    $dados = json_decode($resposta, true);
    if (!is_array($dados)) {
        throw new RuntimeException("A PokéAPI retornou JSON inválido ao consultar {$recurso}.");
    }

    return $dados;
}

/** Percorre a árvore de evolução e reúne todos os pares origem -> destino. */
function coletarTransicoesEvolutivas(array $elo, array &$transicoes): void
{
    $nomeOrigem = (string) ($elo['species']['name'] ?? '');
    if ($nomeOrigem === '') {
        return;
    }

    foreach (($elo['evolves_to'] ?? []) as $filho) {
        $nomeDestino = (string) ($filho['species']['name'] ?? '');
        if ($nomeDestino !== '') {
            $chave = $nomeOrigem . '>' . $nomeDestino;
            if (!isset($transicoes[$chave])) {
                $transicoes[$chave] = [
                    'origem' => $nomeOrigem,
                    'destino' => $nomeDestino,
                    'detalhes' => [],
                ];
            }
            foreach (($filho['evolution_details'] ?? []) as $detalhe) {
                $transicoes[$chave]['detalhes'][] = $detalhe;
            }
        }
        coletarTransicoesEvolutivas($filho, $transicoes);
    }
}

/**
 * Converte os requisitos da PokéAPI para as regras simplificadas do projeto.
 * A regra customizada Seadra -> Kingdra é nível 40, em vez de troca.
 * Qualquer espécie com uma evolução registrada também poderá usar Moon Stone
 * em qualquer nível; essa alternativa universal será aplicada pelo serviço PHP
 * de evolução, não pela condição de nível desta linha.
 */
function determinarRegraEvolucao(string $origem, string $destino, array $detalhes, int $idMoonStone): array
{
    $chave = strtolower($origem . '>' . $destino);
    $gatilhosApi = [];
    $niveis = [];

    foreach ($detalhes as $detalhe) {
        $gatilho = (string) ($detalhe['trigger']['name'] ?? '');
        if ($gatilho !== '' && !in_array($gatilho, $gatilhosApi, true)) {
            $gatilhosApi[] = $gatilho;
        }
        if ($gatilho === 'level-up' && isset($detalhe['min_level'])) {
            $nivel = (int) $detalhe['min_level'];
            if ($nivel >= 1 && $nivel <= 100) {
                $niveis[] = $nivel;
            }
        }
    }

    $gatilhoOriginal = $gatilhosApi[0] ?? null;

    $regrasPersonalizadas = [
        'seadra>kingdra' => 40,
        'basculin-white-striped>basculegion-male' => 30,
        'yamask>runerigus' => 35,
        'yamask-galar>runerigus' => 35,
    ];

    if (isset($regrasPersonalizadas[$chave])) {
        return [
            'metodo_evolucao' => 'NIVEL',
            'nivel_requisito' => $regrasPersonalizadas[$chave],
            'id_item' => null,
            'api_trigger' => $gatilhoOriginal,
        ];
    }
    

    if ($niveis !== []) {
        return [
            'metodo_evolucao' => 'NIVEL',
            'nivel_requisito' => min($niveis),
            'id_item' => null,
            'api_trigger' => $gatilhoOriginal,
        ];
    }

    // Trocas, pedras específicas e demais condições complexas viram Moon Stone.
    return [
        'metodo_evolucao' => 'ITEM',
        'nivel_requisito' => null,
        'id_item' => $idMoonStone,
        'api_trigger' => $gatilhoOriginal,
    ];
}

/** Registra todas as transições cujas duas espécies já existem no banco. */
function sincronizarCadeiaEvolutiva(PDO $pdo, array $dadosCadeia, int $idMoonStone): array
{
    if (!isset($dadosCadeia['chain']) || !is_array($dadosCadeia['chain'])) {
        throw new RuntimeException('A PokéAPI não retornou uma cadeia evolutiva válida.');
    }

    $transicoes = [];
    coletarTransicoesEvolutivas($dadosCadeia['chain'], $transicoes);

    /*
    * Adicionar a evolução personalizada somente quando a espécie
    * importada for o Basculin de listra branca.
    */
    $nomeImportado = strtolower(
        (string) ($_POST['nome'] ?? '')
    );

    $nomeImportado = str_replace(' ', '-', trim($nomeImportado));

    if ($nomeImportado === 'basculin-white-striped') {
        $chavePersonalizada = 'basculin-white-striped>basculegion-male';

        if (!isset($transicoes[$chavePersonalizada])) {
            $transicoes[$chavePersonalizada] = [
                'origem' => 'basculin-white-striped',
                'destino' => 'basculegion-male',
                'detalhes' => [],
            ];
        }
    }

    /*
    * Evolução personalizada do Yamask de Galar.
    */
    if ($nomeImportado === 'yamask-galar') {
        $chavePersonalizada = 'yamask>runerigus';

        if (!isset($transicoes[$chavePersonalizada])) {
            $transicoes[$chavePersonalizada] = [
                'origem' => 'yamask',
                'destino' => 'runerigus',
                'detalhes' => [],
            ];
        }
    }


    $stmtEspecie = $pdo->prepare(
        'SELECT id_pokemon_especie FROM pokemon_especie WHERE nome = ? LIMIT 1'
    );
    $sqlUpsert = "
        INSERT INTO evolucao (
            id_item, metodo_evolucao, nivel_requisito, api_trigger,
            id_pokemon_origem, id_pokemon_destino
        ) VALUES (?, ?, ?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE
            id_item = VALUES(id_item),
            metodo_evolucao = VALUES(metodo_evolucao),
            nivel_requisito = VALUES(nivel_requisito),
            api_trigger = VALUES(api_trigger)
    ";
    $stmtUpsert = $pdo->prepare($sqlUpsert);

    $quantidade = 0;
    $pendentes = [];
    $resumo = [];

    foreach ($transicoes as $transicao) {
        $stmtEspecie->execute([$transicao['origem']]);
        $origem = $stmtEspecie->fetchColumn();
        $stmtEspecie->execute([$transicao['destino']]);
        $destino = $stmtEspecie->fetchColumn();

        if ($origem === false || $destino === false) {
            // Não exibir como pendentes as relações da cadeia
            // que não correspondem à evolução personalizada.
            $chaveTransicao = strtolower(
                $transicao['origem'] . '>' . $transicao['destino']
            );

            if ($chaveTransicao === 'basculin>basculegion') {
                continue;
            }

            if ($origem === false) {
                $pendentes[] = $transicao['origem'];
            }

            if ($destino === false) {
                $pendentes[] = $transicao['destino'];
            }

            continue;
        }

        $regra = determinarRegraEvolucao(
            $transicao['origem'],
            $transicao['destino'],
            $transicao['detalhes'],
            $idMoonStone
        );

        $stmtUpsert->execute([
            $regra['id_item'],
            $regra['metodo_evolucao'],
            $regra['nivel_requisito'],
            $regra['api_trigger'],
            (int) $origem,
            (int) $destino,
        ]);

        $quantidade++;
        $requisito = $regra['metodo_evolucao'] === 'NIVEL'
            ? 'nível ' . $regra['nivel_requisito']
            : 'Moon Stone';
        $resumo[] = $transicao['origem'] . ' → ' . $transicao['destino'] . ' (' . $requisito . ')';
    }

    return [
        'quantidade' => $quantidade,
        'pendentes' => array_values(array_unique($pendentes)),
        'resumo' => $resumo,
    ];
}

function mostrarFormularioPokemon(string $nome = '', string $aviso = ''): void
{
    echo '<!doctype html><html lang="pt-BR"><head><meta charset="utf-8">';
    echo '<meta name="viewport" content="width=device-width, initial-scale=1">';
    echo '<title>Importar Pokémon | MONSTROBOLSO</title>';
    echo '<style>body{font-family:system-ui,sans-serif;max-width:760px;margin:32px auto;padding:0 16px;color:#20242a}form{display:flex;gap:10px;flex-wrap:wrap}input{flex:1;min-width:220px;padding:12px;font:inherit}button{padding:12px 18px;font:inherit;cursor:pointer}.aviso{padding:12px;background:#f1f5f9;border-radius:8px;white-space:pre-wrap}</style>';
    echo '</head><body><h1>Importar Pokémon</h1>';
    echo '<p>Digite o nome usado pela PokéAPI, por exemplo <strong>emolga</strong>, <strong>snivy</strong> ou <strong>Mr Mime</strong>. Ao reimportar uma espécie, seus tipos, golpes de dano e opções de status serão recalculados.</p>';
    if ($aviso !== '') {
        echo '<p class="aviso">' . h($aviso) . '</p>';
    }
    echo '<form method="post" action="">';
    echo '<input type="text" name="nome" value="' . h($nome) . '" placeholder="Nome do Pokémon" required autofocus>';
    echo '<button type="submit">Importar</button></form>';
    echo '<p>Regra de golpe: Ataque maior ou igual a Ataque Especial escolhe golpes físicos; caso contrário, escolhe golpes especiais.</p>';
    echo '</body></html>';
}

$metodo = strtoupper((string) ($_SERVER['REQUEST_METHOD'] ?? 'GET'));
if ($metodo !== 'POST') {
    mostrarFormularioPokemon();
    exit;
}

$nomePokemon = trim((string) ($_POST['nome'] ?? ''));
if ($nomePokemon === '') {
    mostrarFormularioPokemon('', 'Digite o nome de um Pokémon.');
    exit;
}

$pdo = null;

try {
    $dados = buscarPokemonNaApi($nomePokemon);

    $stats = [];
    foreach ($dados['stats'] as $stat) {
        $nomeStat = (string) ($stat['stat']['name'] ?? '');
        if ($nomeStat !== '') {
            $stats[$nomeStat] = (int) $stat['base_stat'];
        }
    }

    foreach (['hp', 'attack', 'defense', 'special-attack', 'special-defense', 'speed'] as $statObrigatorio) {
        if (!isset($stats[$statObrigatorio])) {
            throw new RuntimeException("Faltou o atributo '{$statObrigatorio}' na resposta da PokéAPI.");
        }
    }

    $tiposApi = [];
    foreach ($dados['types'] as $registroTipo) {
        $tipoApi = (string) ($registroTipo['type']['name'] ?? '');
        if ($tipoApi === '') {
            throw new RuntimeException('A PokéAPI retornou um tipo sem nome.');
        }
        $tiposApi[] = $tipoApi;
    }
    $tiposApi = array_values(array_unique($tiposApi));

    if (count($tiposApi) < 1 || count($tiposApi) > 2) {
        throw new RuntimeException('A estrutura atual permite de um a dois tipos por espécie. A espécie retornou ' . count($tiposApi) . ' tipos.');
    }

    /* Empate é resolvido a favor do golpe físico, conforme decisão do projeto. */
    $classeEscolhida = $stats['attack'] >= $stats['special-attack']
        ? 'PHYSICAL'
        : 'SPECIAL';

    $imagem = $dados['sprites']['front_default'] ?? null;

    /* Consultar a espécie e sua cadeia evolutiva antes de iniciar alterações no banco. */
    $urlEspecie = (string) ($dados['species']['url'] ?? '');
    if ($urlEspecie === '') {
        throw new RuntimeException('A resposta da PokéAPI não trouxe a URL da espécie.');
    }
    $dadosEspecie = buscarJsonApi($urlEspecie, 'a espécie do Pokémon');
    $urlCadeia = (string) ($dadosEspecie['evolution_chain']['url'] ?? '');
    if ($urlCadeia === '') {
        throw new RuntimeException('A PokéAPI não informou a cadeia evolutiva desta espécie.');
    }
    $dadosCadeia = buscarJsonApi($urlCadeia, 'a cadeia evolutiva');

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

    $pdo->beginTransaction();

    /* Buscar espécie existente por ID da PokéAPI para não criar duplicatas. */
    $stmtExistente = $pdo->prepare('SELECT id_pokemon_especie FROM pokemon_especie WHERE api_id = ? LIMIT 1');
    $stmtExistente->execute([(int) $dados['id']]);
    $existente = $stmtExistente->fetch();

    if ($existente) {
        $idPokemonEspecie = (int) $existente['id_pokemon_especie'];
        $sqlAtualizar = "
            UPDATE pokemon_especie
            SET nome = ?, hp_base = ?, ataque_base = ?, defesa_base = ?,
                ataque_especial_base = ?, defesa_especial_base = ?,
                velocidade_base = ?, imagem_url = ?
            WHERE id_pokemon_especie = ?
        ";
        $pdo->prepare($sqlAtualizar)->execute([
            $dados['name'],
            $stats['hp'],
            $stats['attack'],
            $stats['defense'],
            $stats['special-attack'],
            $stats['special-defense'],
            $stats['speed'],
            $imagem,
            $idPokemonEspecie,
        ]);
        $acao = 'atualizado';
    } else {
        $sqlInserir = "
            INSERT INTO pokemon_especie (
                api_id, nome, hp_base, ataque_base, defesa_base,
                ataque_especial_base, defesa_especial_base, velocidade_base, imagem_url
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        ";
        $pdo->prepare($sqlInserir)->execute([
            (int) $dados['id'],
            $dados['name'],
            $stats['hp'],
            $stats['attack'],
            $stats['defense'],
            $stats['special-attack'],
            $stats['special-defense'],
            $stats['speed'],
            $imagem,
        ]);
        $idPokemonEspecie = (int) $pdo->lastInsertId();
        $acao = 'inserido';
    }

    /* Remover associações antigas; todas serão recalculadas dentro da mesma transação. */
    foreach (['pokemon_especie_status_opcao', 'pokemon_especie_golpe', 'pokemon_especie_tipo'] as $tabela) {
        $stmtDelete = $pdo->prepare("DELETE FROM {$tabela} WHERE id_pokemon_especie = ?");
        $stmtDelete->execute([$idPokemonEspecie]);
    }

    $stmtTipo = $pdo->prepare('SELECT id_tipo FROM tipo WHERE api_nome = ? LIMIT 1');
    $stmtInserirTipo = $pdo->prepare('INSERT INTO pokemon_especie_tipo (id_pokemon_especie, id_tipo) VALUES (?, ?)');
    $stmtGolpeTipo = $pdo->prepare(" 
        SELECT g.id_golpe, g.nome, g.classe_dano
        FROM golpe AS g
        INNER JOIN tipo AS t ON t.id_tipo = g.id_tipo
        WHERE t.api_nome = ?
          AND g.categoria = 'DANO'
          AND UPPER(g.classe_dano) = ?
        ORDER BY g.id_golpe
        LIMIT 1
    ");
    $stmtInserirGolpe = $pdo->prepare(
        'INSERT INTO pokemon_especie_golpe (id_pokemon_especie, id_golpe, slot) VALUES (?, ?, ?)'
    );

    $golpesAssociados = [];
    $slot = 1;
    foreach ($tiposApi as $tipoApi) {
        $stmtTipo->execute([$tipoApi]);
        $tipoBanco = $stmtTipo->fetch();
        if (!$tipoBanco) {
            throw new RuntimeException("O tipo '{$tipoApi}' não está cadastrado em tipo.api_nome. Importe/corrija os 36 golpes antes de reimportar o Pokémon.");
        }

        $stmtGolpeTipo->execute([$tipoApi, $classeEscolhida]);
        $golpe = $stmtGolpeTipo->fetch();
        if (!$golpe) {
            throw new RuntimeException("Não existe golpe de dano da classe {$classeEscolhida} para o tipo '{$tipoApi}'. Execute primeiro importar_golpes.php. A transação será desfeita.");
        }

        $stmtInserirTipo->execute([$idPokemonEspecie, (int) $tipoBanco['id_tipo']]);
        $stmtInserirGolpe->execute([$idPokemonEspecie, (int) $golpe['id_golpe'], $slot]);
        $golpesAssociados[] = (string) $golpe['nome'];
        $slot++;
    }

    /*
     * Opções genéricas:
     * - físico (incluindo empate): Dança das Espadas, exceto tipo Lutador;
     * - especial: Maquinação Maliciosa, exceto tipo Psíquico.
     * As opções específicas por tipo continuam independentes.
     */
    $opcoesStatus = [];
    if ($classeEscolhida === 'PHYSICAL' && !in_array('fighting', $tiposApi, true)) {
        $opcoesStatus['Dança das Espadas'] = 'TEM_FISICO';
    }
    if ($classeEscolhida === 'SPECIAL' && !in_array('psychic', $tiposApi, true)) {
        $opcoesStatus['Maquinação Maliciosa'] = 'TEM_ESPECIAL';
    }

    if (in_array('electric', $tiposApi, true)) {
        $opcoesStatus['Onda Trovão'] = 'TIPO_ELETRICO';
    }
    if (in_array('poison', $tiposApi, true)) {
        $opcoesStatus['Tóxico'] = 'TIPO_POISON';
    }
    if (in_array('psychic', $tiposApi, true)) {
        $opcoesStatus['Paz Mental'] = 'TIPO_PSYCHIC';
    }
    if (in_array('fighting', $tiposApi, true)) {
        $opcoesStatus['Corpulência'] = 'TIPO_FIGHTING';
    }
    if (in_array('grass', $tiposApi, true)) {
        $opcoesStatus['Esporo'] = 'TIPO_GRASS';
    }
    if (in_array('fire', $tiposApi, true) || in_array('ghost', $tiposApi, true)) {
        $opcoesStatus['Fogo Fátuo'] = 'TIPO_FIRE_GHOST';
    }

    $stmtBuscarGolpeStatus = $pdo->prepare(
        "SELECT id_golpe FROM golpe WHERE nome = ? AND categoria = 'STATUS' LIMIT 1"
    );
    $stmtInserirOpcao = $pdo->prepare(
        'INSERT INTO pokemon_especie_status_opcao (id_pokemon_especie, id_golpe, criterio) VALUES (?, ?, ?)'
    );

    foreach ($opcoesStatus as $nomeGolpeStatus => $criterio) {
        $stmtBuscarGolpeStatus->execute([$nomeGolpeStatus]);
        $golpeStatus = $stmtBuscarGolpeStatus->fetch();
        if (!$golpeStatus) {
            throw new RuntimeException("O golpe de status '{$nomeGolpeStatus}' não existe em golpe. A transação será desfeita.");
        }
        $stmtInserirOpcao->execute([
            $idPokemonEspecie,
            (int) $golpeStatus['id_golpe'],
            $criterio,
        ]);
    }

    /*
     * Se a nova regra tornou inválida uma escolha antiga de status no time/desafio,
     * removemos somente essa escolha. O Pokémon e as demais informações são mantidos.
     */
    $sqlLimparStatusTime = "
        UPDATE pokemon_time AS pt
        LEFT JOIN pokemon_especie_status_opcao AS pso
            ON pso.id_pokemon_especie = pt.id_pokemon_especie
           AND pso.id_golpe = pt.id_golpe_status
        SET pt.id_golpe_status = NULL
        WHERE pt.id_pokemon_especie = ?
          AND pt.id_golpe_status IS NOT NULL
          AND pso.id_golpe IS NULL
    ";
    $pdo->prepare($sqlLimparStatusTime)->execute([$idPokemonEspecie]);

    $sqlLimparStatusDesafio = "
        UPDATE desafio_pokemon AS dp
        LEFT JOIN pokemon_especie_status_opcao AS pso
            ON pso.id_pokemon_especie = dp.id_pokemon_especie
           AND pso.id_golpe = dp.id_golpe_status
        SET dp.id_golpe_status = NULL
        WHERE dp.id_pokemon_especie = ?
          AND dp.id_golpe_status IS NOT NULL
          AND pso.id_golpe IS NULL
    ";
    $pdo->prepare($sqlLimparStatusDesafio)->execute([$idPokemonEspecie]);

    /* Sincronizar evoluções da cadeia apenas entre espécies já cadastradas. */
    $stmtMoonStone = $pdo->prepare("SELECT id_item FROM item WHERE nome = 'Moon Stone' AND categoria = 'EVOLUCAO' LIMIT 1");
    $stmtMoonStone->execute();
    $idMoonStone = $stmtMoonStone->fetchColumn();
    if ($idMoonStone === false) {
        throw new RuntimeException('Moon Stone não encontrada na tabela item. Execute primeiro atualizar_evolucao_monstrobouso.sql.');
    }

    $dadosEvolucao = sincronizarCadeiaEvolutiva($pdo, $dadosCadeia, (int) $idMoonStone);

    $pdo->commit();

    echo '<!doctype html><html lang="pt-BR"><meta charset="utf-8"><title>Importação de Pokémon</title><body>';
    echo '<h1>Pokémon ' . h((string) $dados['name']) . ' ' . h($acao) . ' com sucesso</h1>';
    echo '<p>Atributos base: Ataque ' . $stats['attack'] . '; Ataque Especial ' . $stats['special-attack'] . '.</p>';
    echo '<p>Categoria selecionada: <strong>' . h($classeEscolhida) . '</strong>';
    if ($stats['attack'] === $stats['special-attack']) {
        echo ' (empate: padrão físico)';
    }
    echo '.</p>';
    echo '<p>Tipos: ' . h(implode(', ', $tiposApi)) . '.</p>';
    echo '<p>Golpes associados: ' . h(implode(', ', $golpesAssociados)) . '.</p>';
    echo '<p>Opções de status: ' . h(implode(', ', array_keys($opcoesStatus))) . '.</p>';
    echo '<h2>Evoluções sincronizadas</h2>';
    echo '<p>Transições inseridas/atualizadas: ' . (int) $dadosEvolucao['quantidade'] . '.</p>';
    if ($dadosEvolucao['resumo'] !== []) {
        echo '<ul>';
        foreach ($dadosEvolucao['resumo'] as $linhaEvolucao) {
            echo '<li>' . h($linhaEvolucao) . '</li>';
        }
        echo '</ul>';
    }
    if ($dadosEvolucao['pendentes'] !== []) {
        echo '<p>Relações ainda não registradas porque uma ou ambas as espécies não estão cadastradas: ' . h(implode(', ', $dadosEvolucao['pendentes'])) . '. Elas poderão ser preenchidas ao importar as espécies que faltam.</p>';
    }
    echo '<p>Importação e reconstrução de relações concluídas. As alterações foram confirmadas em uma transação.</p>';
    echo '<hr><h2>Importar outra espécie</h2>';
    echo '<form method="post" action=""><input type="text" name="nome" placeholder="Nome do próximo Pokémon" required><button type="submit">Importar</button></form>';
    echo '</body></html>';
} catch (Throwable $e) {
    if ($pdo instanceof PDO && $pdo->inTransaction()) {
        $pdo->rollBack();
    }
    http_response_code(500);
    echo '<!doctype html><html lang="pt-BR"><meta charset="utf-8"><title>Erro na importação</title><body>';
    echo '<h1>Não foi possível importar o Pokémon</h1><p>' . h($e->getMessage()) . '</p>';
    echo '<p>Se a transação já havia começado, as alterações foram desfeitas.</p>';
    echo '<hr><h2>Tentar novamente</h2>';
    echo '<form method="post" action=""><input type="text" name="nome" value="' . h($nomePokemon) . '" placeholder="Nome do Pokémon" required><button type="submit">Tentar novamente</button></form>';
    echo '</body></html>';
}
