<?php

$pdo = null;

try {

    /*
     * ==========================================
     * CONEXÃO COM O BANCO
     * ==========================================
     */

    $pdo = new PDO(
        'mysql:host=localhost;dbname=monstrobouso;charset=utf8mb4',
        'root',
        ''
    );

    $pdo->setAttribute(
        PDO::ATTR_ERRMODE,
        PDO::ERRMODE_EXCEPTION
    );

    /*
     * ==========================================
     * POKÉMON QUE SERÁ IMPORTADO
     * ==========================================
     *
     * Este arquivo importa UM Pokémon por vez.
     *
     * Para importar outro Pokémon, basta alterar:
     *
     * $nomePokemon = 'emolga';
     *
     * para:
     *
     * $nomePokemon = 'snivy';
     */

    $nomePokemon = 'gurdurr';


    /*
     * ==========================================
     * CONSULTA À POKÉAPI
     * ==========================================
     */

    $url = 'https://pokeapi.co/api/v2/pokemon/' . $nomePokemon;

    $resposta = file_get_contents($url);

    if ($resposta === false) {

        throw new Exception(
            'Não foi possível consultar a PokéAPI.'
        );
    }

    /*
     * Transformar JSON em array PHP.
     */
    $dados = json_decode($resposta, true);

    if ($dados === null) {

        throw new Exception(
            'A resposta da PokéAPI não pôde ser convertida em JSON.'
        );
    }


    /*
     * ==========================================
     * EXTRAIR STATS
     * ==========================================
     */

    $stats = [];

    foreach ($dados['stats'] as $stat) {

        $nomeStat = $stat['stat']['name'];
        $valor = $stat['base_stat'];

        $stats[$nomeStat] = $valor;
    }


    /*
     * ==========================================
     * IMAGEM
     * ==========================================
     */

    $imagem = $dados['sprites']['front_default'];


    /*
     * ==========================================
     * INICIAR TRANSAÇÃO
     * ==========================================
     */

    $pdo->beginTransaction();


    /*
     * ==========================================
     * VERIFICAR SE O POKÉMON JÁ EXISTE
     * ==========================================
     */

    $sqlPokemonExistente = "
        SELECT id_pokemon_especie
        FROM pokemon_especie
        WHERE api_id = ?
    ";

    $stmtPokemonExistente = $pdo->prepare(
        $sqlPokemonExistente
    );

    $stmtPokemonExistente->execute([
        $dados['id']
    ]);

    $pokemonExistente = $stmtPokemonExistente->fetch(
        PDO::FETCH_ASSOC
    );


    /*
     * ==========================================
     * INSERIR OU REUTILIZAR POKÉMON
     * ==========================================
     */

    if ($pokemonExistente) {

        /*
         * O Pokémon já existe.
         * Vamos reutilizar o ID.
         */
        $idPokemonEspecie =
            $pokemonExistente['id_pokemon_especie'];

        echo
            "O Pokémon {$dados['name']} já existe no banco.<br>";

        /*
         * Atualizamos os dados vindos da API.
         *
         * Assim, uma nova importação também pode
         * atualizar os valores do Pokémon.
         */
        $sqlAtualizarPokemon = "
            UPDATE pokemon_especie
            SET
                nome = ?,
                hp_base = ?,
                ataque_base = ?,
                defesa_base = ?,
                ataque_especial_base = ?,
                defesa_especial_base = ?,
                velocidade_base = ?,
                imagem_url = ?
            WHERE id_pokemon_especie = ?
        ";

        $stmtAtualizarPokemon = $pdo->prepare(
            $sqlAtualizarPokemon
        );

        $stmtAtualizarPokemon->execute([

            $dados['name'],

            $stats['hp'],

            $stats['attack'],

            $stats['defense'],

            $stats['special-attack'],

            $stats['special-defense'],

            $stats['speed'],

            $imagem,

            $idPokemonEspecie
        ]);

    } else {

        /*
         * ==========================================
         * INSERIR NOVO POKÉMON
         * ==========================================
         */

        $sqlPokemon = "
            INSERT INTO pokemon_especie (
                api_id,
                nome,
                hp_base,
                ataque_base,
                defesa_base,
                ataque_especial_base,
                defesa_especial_base,
                velocidade_base,
                imagem_url
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        ";

        $stmtPokemon = $pdo->prepare(
            $sqlPokemon
        );

        $stmtPokemon->execute([

            $dados['id'],

            $dados['name'],

            $stats['hp'],

            $stats['attack'],

            $stats['defense'],

            $stats['special-attack'],

            $stats['special-defense'],

            $stats['speed'],

            $imagem
        ]);

        $idPokemonEspecie =
            $pdo->lastInsertId();

        echo
            "Pokémon inserido: {$dados['name']}<br>";
    }


    /*
     * ==========================================
     * LIMPAR RELAÇÕES ANTIGAS
     * ==========================================
     *
     * Isso é importante se executarmos novamente
     * o importador para o mesmo Pokémon.
     *
     * O Pokémon continua existindo,
     * mas suas relações com tipos, golpes
     * e opções de status serão reconstruídas.
     */

    /*
     * Primeiro removemos as opções de status.
     */
    $sqlDeleteStatus = "
        DELETE FROM pokemon_especie_status_opcao
        WHERE id_pokemon_especie = ?
    ";

    $stmtDeleteStatus = $pdo->prepare(
        $sqlDeleteStatus
    );

    $stmtDeleteStatus->execute([
        $idPokemonEspecie
    ]);


    /*
     * Depois removemos os golpes de dano.
     */
    $sqlDeleteGolpes = "
        DELETE FROM pokemon_especie_golpe
        WHERE id_pokemon_especie = ?
    ";

    $stmtDeleteGolpes = $pdo->prepare(
        $sqlDeleteGolpes
    );

    $stmtDeleteGolpes->execute([
        $idPokemonEspecie
    ]);


    /*
     * Depois removemos os tipos.
     */
    $sqlDeleteTipos = "
        DELETE FROM pokemon_especie_tipo
        WHERE id_pokemon_especie = ?
    ";

    $stmtDeleteTipos = $pdo->prepare(
        $sqlDeleteTipos
    );

    $stmtDeleteTipos->execute([
        $idPokemonEspecie
    ]);


    /*
     * ==========================================
     * PREPARAR BUSCA DO TIPO
     * ==========================================
     */

    $sqlTipo = "
        SELECT id_tipo
        FROM tipo
        WHERE api_nome = ?
    ";

    $stmtTipo = $pdo->prepare(
        $sqlTipo
    );


    /*
     * ==========================================
     * PREPARAR RELAÇÃO POKÉMON ↔ TIPO
     * ==========================================
     */

    $sqlPokemonTipo = "
        INSERT INTO pokemon_especie_tipo (
            id_pokemon_especie,
            id_tipo
        )
        VALUES (?, ?)
    ";

    $stmtPokemonTipo = $pdo->prepare(
        $sqlPokemonTipo
    );


    /*
     * ==========================================
     * PREPARAR BUSCA DOS GOLPES DE DANO
     * ==========================================
     *
     * Agora também buscamos classe_dano.
     *
     * Exemplos:
     *
     * Shock Wave → special
     * Acrobatics → physical
     */

    $sqlGolpeTipo = "
        SELECT
            g.id_golpe,
            g.nome,
            g.classe_dano
        FROM golpe g
        INNER JOIN tipo t
            ON t.id_tipo = g.id_tipo
        WHERE t.api_nome = ?
          AND g.categoria = 'DANO'
        LIMIT 1
    ";

    $stmtGolpeTipo = $pdo->prepare(
        $sqlGolpeTipo
    );


    /*
     * ==========================================
     * PREPARAR RELAÇÃO POKÉMON ↔ GOLPE
     * ==========================================
     */

    $sqlPokemonGolpe = "
        INSERT INTO pokemon_especie_golpe (
            id_pokemon_especie,
            id_golpe,
            slot
        )
        VALUES (?, ?, ?)
    ";

    $stmtPokemonGolpe = $pdo->prepare(
        $sqlPokemonGolpe
    );


    /*
     * ==========================================
     * VARIÁVEIS PARA REGRAS DE STATUS
     * ==========================================
     */

    $slot = 1;

    $temFisico = false;

    $temEspecial = false;

    /*
     * Classe do primeiro golpe.
     *
     * Será importante em caso de empate:
     *
     * Ataque = Ataque Especial
     */

    /*
     * Guardar os tipos da API.
     */
    $tiposApi = [];


    /*
     * ==========================================
     * PROCESSAR TIPOS DO POKÉMON
     * ==========================================
     *
     * Para cada tipo:
     *
     * 1. relaciona o Pokémon ao tipo;
     * 2. procura o golpe de dano daquele tipo;
     * 3. coloca o golpe no slot correspondente;
     * 4. identifica se o golpe é físico ou especial.
     */

    foreach ($dados['types'] as $tipo) {

        $nomeTipoApi =
            $tipo['type']['name'];

        /*
         * Guardar tipo para as regras de status.
         */
        $tiposApi[] = $nomeTipoApi;


        /*
         * ------------------------------
         * Encontrar o tipo no banco
         * ------------------------------
         */

        $stmtTipo->execute([
            $nomeTipoApi
        ]);

        $tipoBanco = $stmtTipo->fetch(
            PDO::FETCH_ASSOC
        );

        if (!$tipoBanco) {

            throw new Exception(
                "Tipo não encontrado no banco: "
                . $nomeTipoApi
            );
        }

        $idTipo = $tipoBanco['id_tipo'];


        /*
         * ------------------------------
         * Relacionar Pokémon e tipo
         * ------------------------------
         */

        $stmtPokemonTipo->execute([

            $idPokemonEspecie,

            $idTipo
        ]);


        /*
         * ------------------------------
         * Procurar golpe de dano
         * ------------------------------
         */

        $stmtGolpeTipo->execute([
            $nomeTipoApi
        ]);

        $golpe = $stmtGolpeTipo->fetch(
            PDO::FETCH_ASSOC
        );

        if (!$golpe) {

            throw new Exception(
                "Não existe golpe de dano cadastrado "
                . "para o tipo: "
                . $nomeTipoApi
            );
        }


        /*
         * ------------------------------
         * Identificar classe do golpe
         * ------------------------------
         */

        $classeDano = strtolower(
            $golpe['classe_dano']
        );

        if ($classeDano === 'physical') {

            $temFisico = true;
        }

        if ($classeDano === 'special') {

            $temEspecial = true;
        }


        /*
         * ------------------------------
         * Relacionar Pokémon e golpe
         * ------------------------------
         */

        $stmtPokemonGolpe->execute([

            $idPokemonEspecie,

            $golpe['id_golpe'],

            $slot
        ]);


        echo
            "Golpe de dano associado: "
            . $golpe['nome']
            . " (slot "
            . $slot
            . ") - "
            . $golpe['classe_dano']
            . "<br>";


        /*
         * Passar para o próximo slot.
         */
        $slot++;
    }


    /*
     * ==========================================
     * CALCULAR OPÇÕES DE GOLPES DE STATUS
     * ==========================================
     */

    $opcoesStatus = [];


    /*
    * SWORDS DANCE
    *
    * Disponível se o Pokémon possui golpe físico.
    *
    * Porém, Pokémon do tipo Fighting usarão
    * Bulk Up no lugar de Swords Dance.
    */
    if (
        $temFisico &&
        !in_array('fighting', $tiposApi, true)
    ) {

        $opcoesStatus['Dança das Espadas'] = [
            'criterio' => 'TEM_FISICO'
        ];
    }


/*
    * NASTY PLOT
    *
    * Disponível se possui golpe especial.
    *
    * Porém, Pokémon do tipo Psychic usarão
    * Calm Mind no lugar de Nasty Plot.
    */
    if (
        $temEspecial &&
        !in_array('psychic', $tiposApi, true)
    ) {

        $opcoesStatus['Maquinação Maliciosa'] = [
            'criterio' => 'TEM_ESPECIAL'
        ];
    }


    /*
     * ==========================================
     * THUNDER WAVE
     * ==========================================
     *
     * Tipo elétrico.
     */

    if (
        in_array(
            'electric',
            $tiposApi,
            true
        )
    ) {

        $opcoesStatus['Onda Trovão'] = [

            'prioridade' => 1,

            'criterio' => 'TIPO_ELETRICO'
        ];
    }


    /*
     * ==========================================
     * TOXIC
     * ==========================================
     *
     * Tipo venenoso.
     */

    if (
        in_array(
            'poison',
            $tiposApi,
            true
        )
    ) {

        $opcoesStatus['Tóxico'] = [

            'prioridade' => 1,

            'criterio' => 'TIPO_POISON'
        ];
    }


    /*
    * CALM MIND
    *
    * Pokémon do tipo Psychic.
    */
    if (
        in_array('psychic', $tiposApi, true)
    ) {

        $opcoesStatus['Paz Mental'] = [
            'criterio' => 'TIPO_PSYCHIC'
        ];
    }


    /*
    * BULK UP
    *
    * Pokémon do tipo Fighting.
    */
    if (
        in_array('fighting', $tiposApi, true)
    ) {

        $opcoesStatus['Corpulência'] = [
            'criterio' => 'TIPO_FIGHTING'
        ];
    }


    /*
     * ==========================================
     * SPORE
     * ==========================================
     *
     * Tipo grama.
     */

    if (
        in_array(
            'grass',
            $tiposApi,
            true
        )
    ) {

        $opcoesStatus['Esporo'] = [

            'prioridade' => 1,

            'criterio' => 'TIPO_GRASS'
        ];
    }


    /*
     * ==========================================
     * WILL-O-WISP
     * ==========================================
     *
     * Tipo fogo OU fantasma.
     */

    if (
        in_array(
            'fire',
            $tiposApi,
            true
        )
        ||
        in_array(
            'ghost',
            $tiposApi,
            true
        )
    ) {

        $opcoesStatus['Fogo Fátuo'] = [

            'prioridade' => 1,

            'criterio' => 'TIPO_FIRE_GHOST'
        ];
    }
    /*
     * ==========================================
     * INSERIR OPÇÕES DE STATUS NO BANCO
     * ==========================================
     */

    $sqlStatusGolpe = "
        SELECT
            id_golpe
        FROM golpe
        WHERE nome = ?
          AND categoria = 'STATUS'
        LIMIT 1
    ";

    $stmtStatusGolpe = $pdo->prepare(
        $sqlStatusGolpe
    );


    $sqlInserirStatus = "
        INSERT INTO pokemon_especie_status_opcao (
            id_pokemon_especie,
            id_golpe,
            criterio
        )
        VALUES (?, ?, ?)
    ";

    $stmtInserirStatus = $pdo->prepare(
        $sqlInserirStatus
    );


    /*
     * Percorrer todas as opções encontradas.
     */

    foreach (
        $opcoesStatus
        as $nomeGolpe => $dadosStatus
    ) {

        /*
         * Encontrar o golpe de status no banco.
         */
        $stmtStatusGolpe->execute([
            $nomeGolpe
        ]);

        $golpeStatus =
            $stmtStatusGolpe->fetch(
                PDO::FETCH_ASSOC
            );

        if (!$golpeStatus) {

            throw new Exception(
                "Golpe de status não encontrado "
                . "na tabela golpe: "
                . $nomeGolpe
            );
        }


        /*
         * Inserir opção.
         */

        $stmtInserirStatus->execute([

            $idPokemonEspecie,

            $golpeStatus['id_golpe'],

            $dadosStatus['criterio']
        ]);


        echo
            "Opção de status associada: "
            . $nomeGolpe
            . "<br>";
    }


    /*
     * ==========================================
     * FINALIZAR TRANSAÇÃO
     * ==========================================
     */

    $pdo->commit();

    echo "<br>";

    echo
        "<strong>"
        . "Importação concluída!"
        . "</strong>";

} catch (Throwable $e) {

    /*
     * ==========================================
     * DESFAZER EM CASO DE ERRO
     * ==========================================
     */

    if (
        $pdo !== null
        &&
        $pdo->inTransaction()
    ) {

        $pdo->rollBack();
    }

    echo "<strong>Erro:</strong> ";

    echo htmlspecialchars(
        $e->getMessage()
    );
}
?>