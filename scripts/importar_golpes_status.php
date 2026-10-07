<?php

$host = 'localhost';
$db   = 'monstrobouso';
$user = 'root';
$pass = '';

$pdo = new PDO(
    "mysql:host=$host;dbname=$db;charset=utf8mb4",
    $user,
    $pass,
    [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
    ]
);

$apiBase = 'https://pokeapi.co/api/v2/';

/*
 * Os nomes usados aqui são os nomes dos recursos da PokéAPI.
 */
$golpesStatus = [
    'swords-dance' => 'Dança das Espadas',
    'nasty-plot'   => 'Maquinação Maliciosa',
    'thunder-wave' => 'Onda Trovão',
    'toxic'        => 'Tóxico',
    'calm-mind'    => 'Paz Mental',
    'bulk-up'      => 'Corpulência',
    'spore'        => 'Esporo',
    'will-o-wisp'  => 'Fogo Fátuo',
];


/**
 * Faz uma requisição GET para a PokéAPI
 * e retorna o JSON convertido para array.
 */
function buscarApi(string $url): array
{
    $ch = curl_init($url);

    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => 15,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTPHEADER => [
            'Accept: application/json'
        ]
    ]);

    $resposta = curl_exec($ch);

    if ($resposta === false) {
        $erro = curl_error($ch);
        curl_close($ch);

        throw new Exception("Erro ao acessar a PokéAPI: $erro");
    }

    $codigoHttp = curl_getinfo($ch, CURLINFO_HTTP_CODE);

    curl_close($ch);

    if ($codigoHttp !== 200) {
        throw new Exception(
            "PokéAPI retornou HTTP $codigoHttp para: $url"
        );
    }

    $dados = json_decode($resposta, true);

    if (!is_array($dados)) {
        throw new Exception("Resposta inválida da PokéAPI.");
    }

    return $dados;
}


/**
 * Obtém o ID do tipo no nosso banco através
 * do nome utilizado pela PokéAPI.
 *
 * Exemplo:
 * electric → id_tipo correspondente no banco
 */
function obterIdTipo(PDO $pdo, string $apiNome): int
{
    $sql = "
        SELECT id_tipo
        FROM tipo
        WHERE api_nome = :api_nome
        LIMIT 1
    ";

    $stmt = $pdo->prepare($sql);
    $stmt->execute([
        ':api_nome' => $apiNome
    ]);

    $idTipo = $stmt->fetchColumn();

    if ($idTipo === false) {
        throw new Exception(
            "Tipo '$apiNome' não encontrado na tabela tipo."
        );
    }

    return (int) $idTipo;
}


/**
 * Pega a descrição em inglês existente
 * em effect_entries.
 */
function obterDescricao(array $dados): ?string
{
    if (!isset($dados['effect_entries'])) {
        return null;
    }

    foreach ($dados['effect_entries'] as $efeito) {

        if (
            isset($efeito['language']['name']) &&
            $efeito['language']['name'] === 'en'
        ) {
            $descricao = $efeito['effect'] ?? null;

            if ($descricao !== null) {
                /*
                 * A API pode utilizar:
                 * $effect_chance
                 *
                 * Retiramos isso porque vamos guardar
                 * apenas uma descrição textual.
                 */
                $descricao = str_replace(
                    '$effect_chance',
                    'a chance do efeito',
                    $descricao
                );

                return mb_substr($descricao, 0, 255);
            }
        }
    }

    return null;
}


try {

    $pdo->beginTransaction();

    $sql = "
        INSERT INTO golpe (
            api_id,
            nome,
            id_tipo,
            categoria,
            poder,
            precisao,
            pp,
            prioridade,
            classe_dano,
            descricao
        )
        VALUES (
            :api_id,
            :nome,
            :id_tipo,
            'STATUS',
            :poder,
            :precisao,
            :pp,
            :prioridade,
            :classe_dano,
            :descricao
        )
        ON DUPLICATE KEY UPDATE
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

    $stmtGolpe = $pdo->prepare($sql);

    foreach ($golpesStatus as $apiNome => $nomeBanco) {

        echo "Importando: $nomeBanco<br>";

        $dados = buscarApi(
            $apiBase . 'move/' . $apiNome
        );

        $idTipo = obterIdTipo(
            $pdo,
            $dados['type']['name']
        );

        /*
         * Para golpes de status:
         * a PokéAPI pode devolver power = 0.
         * No nosso banco preferimos NULL.
         */
        $poder = (
            isset($dados['power']) &&
            $dados['power'] !== 0
        )
            ? $dados['power']
            : null;

        $descricao = obterDescricao($dados);

        $stmtGolpe->execute([
            ':api_id'       => $dados['id'],
            ':nome'         => $nomeBanco,
            ':id_tipo'      => $idTipo,
            ':poder'        => $poder,
            ':precisao'     => $dados['accuracy'],
            ':pp'           => $dados['pp'],
            ':prioridade'   => $dados['priority'],
            ':classe_dano'  => $dados['damage_class']['name'] ?? null,
            ':descricao'    => $descricao
        ]);
    }

    $pdo->commit();

    echo "<br><strong>Importação concluída!</strong>";

} catch (Throwable $e) {

    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }

    echo "<strong>Erro:</strong> "
       . htmlspecialchars($e->getMessage());
}
?>