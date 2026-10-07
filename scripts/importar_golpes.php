<?php

$pdo = new PDO(
    'mysql:host=localhost;dbname=monstrobouso;charset=utf8mb4',
    'root',
    ''
);

$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

$golpes = [
    'body-slam',
    'shock-wave',
    'fire-fang',
    'water-pulse',
    'mega-drain',
    'drain-punch',
    'sucker-punch',
    'bullet-punch',
    'shadow-sneak',
    'bug-bite',
    'earth-power',
    'rock-tomb',
    'dragon-claw',
    'dazzling-gleam',
    'acrobatics',
    'psychic',
    'sludge-bomb',
    'ice-beam'
];

$sqlTipo = "
    SELECT id_tipo
    FROM tipo
    WHERE api_nome = ?
";

$sqlInsert = "
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
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
";

$buscarTipo = $pdo->prepare($sqlTipo);
$inserirGolpe = $pdo->prepare($sqlInsert);

foreach ($golpes as $nomeApi) {

    $url = 'https://pokeapi.co/api/v2/move/' . $nomeApi;

    $resposta = file_get_contents($url);

    if ($resposta === false) {
        echo "Erro ao consultar: $nomeApi<br>";
        continue;
    }

    $golpe = json_decode($resposta, true);

    if (!isset($golpe['id'])) {
        echo "Resposta inválida para: $nomeApi<br>";
        continue;
    }

    $apiId = $golpe['id'];
    $nome = $golpe['name'];

    $tipoApi = $golpe['type']['name'];

    $buscarTipo->execute([$tipoApi]);

    $tipo = $buscarTipo->fetch(PDO::FETCH_ASSOC);

    if (!$tipo) {
        echo "Tipo não encontrado no banco: $tipoApi<br>";
        continue;
    }

    $idTipo = $tipo['id_tipo'];

    /*
     * Todos os 18 golpes definidos pelo MONSTROBOLSO
     * são golpes de dano.
     */
    $categoria = 'DANO';

    $poder = 65;
    $precisao = $golpe['accuracy'];
    $pp = $golpe['pp'];
    $prioridade = $golpe['priority'];

    $classeDano = $golpe['damage_class']['name'];

    /*
     * Procura a descrição em inglês.
     */
    $descricao = null;

    foreach ($golpe['effect_entries'] as $efeito) {

        if ($efeito['language']['name'] === 'en') {
            $descricao = $efeito['short_effect'];
            break;
        }
    }

    $inserirGolpe->execute([
        $apiId,
        $nome,
        $idTipo,
        $categoria,
        $poder,
        $precisao,
        $pp,
        $prioridade,
        strtoupper($classeDano),
        $descricao
    ]);

    echo "Inserido: $nome<br>";
}

echo '<br>Importação concluída!';
?>