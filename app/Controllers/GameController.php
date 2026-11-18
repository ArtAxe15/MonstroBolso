<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Http\JsonResponse;
use App\Http\ApiException;
use App\Http\PerfilAtivo;
use App\Models\Encontro;
use App\Models\ServicosMapa;
use PDO;
use App\Services\BattleService;
use App\Services\CalculadoraAtributos;
use App\Services\MontadorTimeAdversario;
use Throwable;

final class GameController
{

    public function __construct(private PDO $conn) {}

    private function perfilAtivo(): int
    {
        return PerfilAtivo::validar($this->conn);
    }

    private function dados(): array
    {
        $dados = json_decode(file_get_contents('php://input') ?: '', true);
        if (!is_array($dados)) JsonResponse::send(['ok' => false, 'message' => 'JSON inválido.'], 400);
        return $dados;
    }

    public function starters(): void
    {
        $this->perfilAtivo();
        $stmt = $this->conn->query("SELECT pe.id_pokemon_especie, pe.nome, pe.imagem_url, pe.hp_base, pe.ataque_base, pe.defesa_base, pe.ataque_especial_base, pe.defesa_especial_base, pe.velocidade_base, GROUP_CONCAT(t.nome ORDER BY t.id_tipo SEPARATOR ', ') AS tipos FROM pokemon_especie pe LEFT JOIN pokemon_especie_tipo pet ON pet.id_pokemon_especie = pe.id_pokemon_especie LEFT JOIN tipo t ON t.id_tipo = pet.id_tipo WHERE pe.nome IN ('snivy','tepig','oshawott') GROUP BY pe.id_pokemon_especie ORDER BY FIELD(pe.nome,'snivy','tepig','oshawott')");
        JsonResponse::send(['ok' => true, 'iniciais' => $stmt->fetchAll()]);
    }

    public function chooseStarter(): void
    {
        $idPerfil = $this->perfilAtivo();
        $dados = $this->dados();
        $nome = strtolower(trim((string) ($dados['nome'] ?? '')));
        if (!in_array($nome, ['snivy', 'tepig', 'oshawott'], true)) {
            JsonResponse::send(['ok' => false, 'message' => 'Escolha Snivy, Tepig ou Oshawott.'], 422);
        }

        $check = $this->conn->prepare('SELECT COUNT(*) FROM pokemon_time WHERE id_perfil = :perfil');
        $check->execute(['perfil' => $idPerfil]);
        if ((int) $check->fetchColumn() > 0) {
            JsonResponse::send(['ok' => false, 'message' => 'Esta jornada já possui um Pokémon inicial.'], 409);
        }

        $stmt = $this->conn->prepare('SELECT * FROM pokemon_especie WHERE nome = :nome LIMIT 1');
        $stmt->execute(['nome' => $nome]);
        $pokemon = $stmt->fetch();
        if (!$pokemon) JsonResponse::send(['ok' => false, 'message' => 'Dados do Pokémon inicial não encontrados.'], 404);

        $nivel = 97;
        $idEspecie = (int) $pokemon['id_pokemon_especie'];
        $opcoesStatus = (new Encontro($this->conn))->encontrarOpcoesDeGolpeStatus([$idEspecie]);
        $idGolpeStatus = $opcoesStatus[$idEspecie][0] ?? null;
        $atributos = (new CalculadoraAtributos())->calcular(
            (int) $pokemon['hp_base'],
            (int) $pokemon['ataque_base'],
            (int) $pokemon['defesa_base'],
            (int) $pokemon['ataque_especial_base'],
            (int) $pokemon['defesa_especial_base'],
            (int) $pokemon['velocidade_base'],
            $nivel
        );

        try {
            $this->conn->beginTransaction();
            $insert = $this->conn->prepare("
                INSERT INTO pokemon_time (
                    id_perfil,
                    id_pokemon_especie,
                    id_golpe_status,
                    nivel,
                    hp_max,
                    hp_atual,
                    ataque,
                    defesa,
                    ataque_especial,
                    defesa_especial,
                    velocidade,
                    status,
                    posicao
                ) VALUES (
                    :perfil,
                    :especie,
                    :golpe_status,
                    :nivel,
                    :hp_max,
                    :hp_atual,
                    :ataque,
                    :defesa,
                    :ataque_esp,
                    :defesa_esp,
                    :velocidade,
                    'normal',
                    1
                )
            ");

            $insert->execute([
                'perfil' => $idPerfil,
                'especie' => $idEspecie,
                'golpe_status' => $idGolpeStatus,
                'nivel' => $nivel,
                'hp_max' => $atributos['hp_max'],
                'hp_atual' => $atributos['hp_max'],
                'ataque' => $atributos['ataque'],
                'defesa' => $atributos['defesa'],
                'ataque_esp' => $atributos['ataque_especial'],
                'defesa_esp' => $atributos['defesa_especial'],
                'velocidade' => $atributos['velocidade']
            ]);
            $this->conn->prepare("INSERT INTO perfil_log (id_perfil, acao, descricao, detalhes) VALUES (:perfil, 'INICIAL_ESCOLHIDO', 'Pokémon inicial escolhido.', :detalhes)")
                ->execute(['perfil' => $idPerfil, 'detalhes' => json_encode(['pokemon' => $nome], JSON_UNESCAPED_UNICODE)]);
            $this->gerarMapaSeNecessario($idPerfil);
            $this->conn->commit();
        } catch (Throwable $e) {
            if ($this->conn->inTransaction()) $this->conn->rollBack();
            throw $e;
        }

        JsonResponse::send(['ok' => true, 'message' => 'Inicial escolhido! Sua jornada começou.', 'proxima_etapa' => 'map']);
    }

    private function gerarMapaSeNecessario(int $idPerfil): void
    {
        $bloqueio = $this->conn->prepare('SELECT id_perfil FROM perfil WHERE id_perfil = :perfil FOR UPDATE');
        $bloqueio->execute(['perfil' => $idPerfil]);
        $bloqueio->closeCursor();

        $encontro = new Encontro($this->conn);
        $desafioAtual = $encontro->encontrarAtual($idPerfil);
        if ($desafioAtual === null) {
            $concluirDesafio = $this->conn->prepare(
                "UPDATE mapa_no SET status = 'CONCLUIDO', concluido_em = CURRENT_TIMESTAMP()
                 WHERE id_perfil = :perfil AND tipo_local = 'DESAFIO' AND status <> 'CONCLUIDO'"
            );
            $concluirDesafio->execute(['perfil' => $idPerfil]);
            $encerrarRota = $this->conn->prepare(
                "UPDATE mapa_no SET status = 'IGNORADO' WHERE id_perfil = :perfil AND status = 'DISPONIVEL'"
            );
            $encerrarRota->execute(['perfil' => $idPerfil]);
            return;
        }

        $idDesafio = (int) $desafioAtual['id_desafio'];
        $rota = $encontro->encontrarRotaGerada($idPerfil);
        $primeiroDesafio = (int) $desafioAtual['ordem'] === 1;
        $mesmoDesafio = $rota !== null && (int) $rota['id_desafio'] === $idDesafio;
        $check = $this->conn->prepare(
            'SELECT COUNT(*) AS total, '
            . "SUM(CASE WHEN etapa = 1 THEN 1 ELSE 0 END) AS etapa_um, "
            . "SUM(CASE WHEN etapa = 2 THEN 1 ELSE 0 END) AS etapa_dois, "
            . "SUM(CASE WHEN etapa = 3 THEN 1 ELSE 0 END) AS etapa_tres, "
            . "SUM(CASE WHEN etapa = 4 THEN 1 ELSE 0 END) AS etapa_quatro, "
            . "SUM(CASE WHEN etapa = 5 THEN 1 ELSE 0 END) AS etapa_cinco, "
            . "SUM(CASE WHEN etapa = 6 AND tipo_local = 'DESAFIO' THEN 1 ELSE 0 END) AS desafio_final "
            . 'FROM mapa_no WHERE id_perfil = :perfil'
        );
        $check->execute(['perfil' => $idPerfil]);
        $mapaExistente = $check->fetch(PDO::FETCH_ASSOC) ?: [];

        $checkConexoes = $this->conn->prepare(
            'SELECT COUNT(*) FROM mapa_conexao mc '
            . 'INNER JOIN mapa_no mn ON mn.id_mapa_no = mc.id_mapa_no_origem '
            . 'WHERE mn.id_perfil = :perfil'
        );
        $checkConexoes->execute(['perfil' => $idPerfil]);

        $checkVinculos = $this->conn->prepare(
            "SELECT COUNT(*) FROM mapa_no WHERE id_perfil = :perfil "
            . "AND tipo_local = 'TREINADOR' AND id_npc_mapa IS NOT NULL"
        );
        $checkVinculos->execute(['perfil' => $idPerfil]);
        $quantidadeTreinadores = $this->conn->prepare(
            "SELECT COUNT(*) FROM mapa_no WHERE id_perfil = :perfil AND tipo_local = 'TREINADOR'"
        );
        $quantidadeTreinadores->execute(['perfil' => $idPerfil]);

        // Confere a distribuição visual alinhada: 3 -> 4 -> 3 -> 2 -> 2 -> desafio.
        // Também valida os vínculos com npc_mapa para manter o combate existente.
        $mapaAtualizado = (int) ($mapaExistente['total'] ?? 0) === 15
            && (int) ($mapaExistente['etapa_um'] ?? 0) === 3
            && (int) ($mapaExistente['etapa_dois'] ?? 0) === 4
            && (int) ($mapaExistente['etapa_tres'] ?? 0) === 3
            && (int) ($mapaExistente['etapa_quatro'] ?? 0) === 2
            && (int) ($mapaExistente['etapa_cinco'] ?? 0) === 2
            && (int) ($mapaExistente['desafio_final'] ?? 0) === 1
            && (int) $checkConexoes->fetchColumn() === 20
            && (int) $checkVinculos->fetchColumn() === (int) $quantidadeTreinadores->fetchColumn();
        if ($mapaAtualizado && ($mesmoDesafio || ($rota === null && $primeiroDesafio))) {
            if ($rota === null) {
                $encontro->registrarRotaGerada($idPerfil, $idDesafio, 1);
            }
            return;
        }

        $area = $rota['area'] ?? 1;
        if (!$mesmoDesafio && !$primeiroDesafio) {
            if ($rota === null) {
                $area = (new MontadorTimeAdversario($this->conn))->obterEstadoDoPerfil($idPerfil)['area_atual'];
            }
            $outrasAreas = array_values(array_diff([1, 2, 3], [$area]));
            $area = $outrasAreas[array_rand($outrasAreas)];
        }

        $apagarMapa = $this->conn->prepare('DELETE FROM mapa_no WHERE id_perfil = :perfil');
        $apagarMapa->execute(['perfil' => $idPerfil]);
        $apagarNpcsAntigos = $this->conn->prepare('DELETE FROM npc_mapa WHERE id_perfil = :perfil');
        $apagarNpcsAntigos->execute(['perfil' => $idPerfil]);

        $tiposTreinador = $this->conn->query(
            'SELECT id_npc_tipo FROM npc_tipo ORDER BY id_npc_tipo'
        )->fetchAll(PDO::FETCH_COLUMN);
        if (!$tiposTreinador) {
            throw new \RuntimeException('Nenhum tipo de treinador NPC foi cadastrado.');
        }

        // Coordenadas percentuais (x, y), iguais às da referência visual.
        $etapas = [
            1 => ['posicoes' => [[14, 79], [50, 79], [86, 79]], 'tipos' => ['TREINADOR', 'SELVAGEM', 'POKEBOLA']],
            2 => ['posicoes' => [[10, 61], [36, 61], [64, 61], [90, 61]], 'tipos' => ['TREINADOR', 'TREINADOR', 'SELVAGEM', 'POKEBOLA']],
            3 => ['posicoes' => [[25, 43], [50, 43], [75, 43]], 'tipos' => ['TREINADOR', 'SELVAGEM', 'POKEBOLA']],
            4 => ['posicoes' => [[36, 30], [64, 30]], 'tipos' => ['TREINADOR', 'SELVAGEM']],
            5 => ['posicoes' => [[36, 17], [64, 17]], 'tipos' => ['CENTRO_POKEMON', 'POKEMART']],
            6 => ['posicoes' => [[50, 7]], 'tipos' => ['DESAFIO']],
        ];

        $insertNpc = $this->conn->prepare(
            'INSERT INTO npc_mapa (id_perfil, id_npc_tipo, posicao_x, posicao_y, ordem) '
            . 'VALUES (:perfil, :tipo, :x, :y, :ordem)'
        );
        $insertNo = $this->conn->prepare(
            'INSERT INTO mapa_no '
            . '(id_perfil, tipo_local, id_npc_tipo, id_npc_mapa, posicao_x, posicao_y, etapa, ordem_no, status) '
            . 'VALUES (:perfil, :tipo, :npc_tipo, :npc_mapa, :x, :y, :etapa, :ordem, :status)'
        );

        $ids = [];
        $ordemNpc = 1;
        foreach ($etapas as $numeroEtapa => $configuracao) {
            $tiposLocais = $configuracao['tipos'];
            shuffle($tiposLocais);
            if ($numeroEtapa === 3) {
                // As extremidades são a única saída de alguns nós da etapa anterior.
                $indicePokebola = array_search('POKEBOLA', $tiposLocais, true);
                [$tiposLocais[1], $tiposLocais[$indicePokebola]] = [$tiposLocais[$indicePokebola], $tiposLocais[1]];
            }

            foreach ($configuracao['posicoes'] as $indice => [$x, $y]) {
                $tipoLocal = $tiposLocais[$indice];
                $idNpcTipo = null;
                $idNpcMapa = null;

                if ($tipoLocal === 'TREINADOR') {
                    $idNpcTipo = (int) $tiposTreinador[array_rand($tiposTreinador)];

                    // O sistema de batalha atual usa npc_mapa.id_npc_mapa.
                    // Cada nó de treinador recebe um NPC ligado por FK, sem
                    // alterar BattleController, BattleService ou seus contratos.
                    $insertNpc->execute([
                        'perfil' => $idPerfil,
                        'tipo' => $idNpcTipo,
                        'x' => $x * 10,
                        'y' => $y * 10,
                        'ordem' => $ordemNpc++,
                    ]);
                    $idNpcMapa = (int) $this->conn->lastInsertId();
                }

                $insertNo->execute([
                    'perfil' => $idPerfil,
                    'tipo' => $tipoLocal,
                    'npc_tipo' => $idNpcTipo,
                    'npc_mapa' => $idNpcMapa,
                    'x' => $x,
                    'y' => $y,
                    'etapa' => $numeroEtapa,
                    'ordem' => $indice + 1,
                    'status' => $numeroEtapa === 1 ? 'DISPONIVEL' : 'BLOQUEADO',
                ]);
                $ids[$numeroEtapa][$indice] = (int) $this->conn->lastInsertId();
            }
        }

        // Ramificações e convergências da rota, sempre seguindo para cima.
        $conexoes = [
            // Início -> primeira fileira (três escolhas).
            [1, 0, 2, 0], [1, 0, 2, 1],
            [1, 1, 2, 1], [1, 1, 2, 2],
            [1, 2, 2, 2], [1, 2, 2, 3],

            // 4 pontos -> 3 pontos.
            [2, 0, 3, 0],
            [2, 1, 3, 0], [2, 1, 3, 1],
            [2, 2, 3, 1], [2, 2, 3, 2],
            [2, 3, 3, 2],

            // 3 pontos -> 2 pontos.
            [3, 0, 4, 0],
            [3, 1, 4, 0], [3, 1, 4, 1],
            [3, 2, 4, 1],

            // Dois caminhos finais de preparação, Centro ou Poké Mart.
            [4, 0, 5, 0], [4, 1, 5, 1],
            [5, 0, 6, 0], [5, 1, 6, 0],
        ];

        $insertConexao = $this->conn->prepare(
            'INSERT INTO mapa_conexao (id_mapa_no_origem, id_mapa_no_destino) '
            . 'VALUES (:origem, :destino)'
        );
        foreach ($conexoes as [$etapaOrigem, $indiceOrigem, $etapaDestino, $indiceDestino]) {
            $insertConexao->execute([
                'origem' => $ids[$etapaOrigem][$indiceOrigem],
                'destino' => $ids[$etapaDestino][$indiceDestino],
            ]);
        }
        $encontro->registrarRotaGerada($idPerfil, $idDesafio, $area);
    }

    /**
     * Sincroniza a rota com o estado de derrota já registrado pelo sistema
     * de encontros. Não inicia nem altera batalhas: apenas reflete npc_mapa.derrotado.
     */
    private function sincronizarProgressoMapa(int $idPerfil): void
    {
        $consulta = $this->conn->prepare(
            "SELECT mn.id_mapa_no, mn.etapa "
            . 'FROM mapa_no mn '
            . 'INNER JOIN npc_mapa nm ON nm.id_npc_mapa = mn.id_npc_mapa '
            . "WHERE mn.id_perfil = :perfil AND mn.tipo_local = 'TREINADOR' "
            . "AND nm.derrotado = 1 AND mn.status = 'DISPONIVEL'"
        );
        $consulta->execute(['perfil' => $idPerfil]);
        $concluidos = $consulta->fetchAll(PDO::FETCH_ASSOC);

        foreach ($concluidos as $no) {
            $concluir = $this->conn->prepare(
                "UPDATE mapa_no SET status = 'CONCLUIDO', concluido_em = CURRENT_TIMESTAMP() "
                . 'WHERE id_mapa_no = :no AND id_perfil = :perfil'
            );
            $concluir->execute(['no' => (int) $no['id_mapa_no'], 'perfil' => $idPerfil]);

            $ignorarAlternativas = $this->conn->prepare(
                "UPDATE mapa_no SET status = 'IGNORADO' "
                . "WHERE id_perfil = :perfil AND etapa = :etapa AND status = 'DISPONIVEL' "
                . 'AND id_mapa_no <> :no'
            );
            $ignorarAlternativas->execute([
                'perfil' => $idPerfil,
                'etapa' => (int) $no['etapa'],
                'no' => (int) $no['id_mapa_no'],
            ]);

            $liberar = $this->conn->prepare(
                "UPDATE mapa_no destino "
                . 'INNER JOIN mapa_conexao conexao ON conexao.id_mapa_no_destino = destino.id_mapa_no '
                . "SET destino.status = 'DISPONIVEL' "
                . 'WHERE conexao.id_mapa_no_origem = :no AND destino.id_perfil = :perfil '
                . "AND destino.status = 'BLOQUEADO'"
            );
            $liberar->execute(['no' => (int) $no['id_mapa_no'], 'perfil' => $idPerfil]);
        }
    }

    public function map(): void
    {
        $idPerfil = $this->perfilAtivo();
        $teamCheck = $this->conn->prepare('SELECT COUNT(*) FROM pokemon_time WHERE id_perfil = :perfil');
        $teamCheck->execute(['perfil' => $idPerfil]);
        if ((int) $teamCheck->fetchColumn() === 0) {
            JsonResponse::send(['ok' => true, 'proxima_etapa' => 'starter']);
        }

        try {
            $this->conn->beginTransaction();
            $this->gerarMapaSeNecessario($idPerfil);
            $this->sincronizarProgressoMapa($idPerfil);
            $estadoDesafios = (new MontadorTimeAdversario($this->conn))->obterEstadoDoPerfil($idPerfil);
            $this->conn->commit();
        } catch (Throwable $e) {
            if ($this->conn->inTransaction()) {
                $this->conn->rollBack();
            }
            throw $e;
        }

        $perfilStmt = $this->conn->prepare('SELECT nome, dinheiro FROM perfil WHERE id_perfil = :perfil');
        $perfilStmt->execute(['perfil' => $idPerfil]);
        $perfil = $perfilStmt->fetch();

        $teamStmt = $this->conn->prepare(
            'SELECT id_pokemon_time, nome_especie, nome_exibicao, imagem_url, nivel, '
            . 'hp_atual, hp_max, hp_percentual, status '
            . 'FROM vw_time_pokemon WHERE id_perfil = :perfil ORDER BY posicao'
        );
        $teamStmt->execute(['perfil' => $idPerfil]);

        $nosStmt = $this->conn->prepare(
            'SELECT mn.id_mapa_no, mn.tipo_local, mn.posicao_x, mn.posicao_y, mn.etapa, '
            . 'mn.ordem_no, mn.status, mn.id_npc_mapa, '
            . 'nm.derrotado, nt.id_npc_tipo, t.nome AS tipo_nome, nt.descricao AS tipo_descricao '
            . 'FROM mapa_no mn '
            . 'LEFT JOIN npc_mapa nm ON nm.id_npc_mapa = mn.id_npc_mapa '
            . 'LEFT JOIN npc_tipo nt ON nt.id_npc_tipo = mn.id_npc_tipo '
            . 'LEFT JOIN tipo t ON t.id_tipo = nt.id_tipo '
            . 'WHERE mn.id_perfil = :perfil ORDER BY mn.etapa, mn.ordem_no'
        );
        $nosStmt->execute(['perfil' => $idPerfil]);
        $nos = $nosStmt->fetchAll(PDO::FETCH_ASSOC);

        $conexoesStmt = $this->conn->prepare(
            'SELECT mc.id_mapa_no_origem AS origem, mc.id_mapa_no_destino AS destino '
            . 'FROM mapa_conexao mc '
            . 'INNER JOIN mapa_no mn ON mn.id_mapa_no = mc.id_mapa_no_origem '
            . 'WHERE mn.id_perfil = :perfil'
        );
        $conexoesStmt->execute(['perfil' => $idPerfil]);
        $conexoes = $conexoesStmt->fetchAll(PDO::FETCH_ASSOC);

        // Mantém o formato npc que a abertura de batalha já utiliza.
        $npc = [];
        foreach ($nos as $no) {
            if ($no['id_npc_mapa'] !== null) {
                $npc[] = [
                    'id_npc_mapa' => (int) $no['id_npc_mapa'],
                    'posicao_x' => (int) $no['posicao_x'] * 10,
                    'posicao_y' => (int) $no['posicao_y'] * 10,
                    'ordem' => (int) $no['ordem_no'],
                    'derrotado' => (int) ($no['derrotado'] ?? 0),
                    'id_npc_tipo' => (int) $no['id_npc_tipo'],
                    'tipo_nome' => $no['tipo_nome'],
                    'descricao' => $no['tipo_descricao'],
                ];
            }
        }

        $etapasDisponiveis = array_values(array_filter(
            array_map(static fn(array $no): int => $no['status'] === 'DISPONIVEL' ? (int) $no['etapa'] : 99, $nos),
            static fn(int $etapa): bool => $etapa !== 99
        ));
        $etapaAtual = $etapasDisponiveis === [] ? 6 : min($etapasDisponiveis);
        $concluidos = count(array_filter($nos, static fn(array $no): bool => $no['status'] === 'CONCLUIDO'));

        JsonResponse::send([
            'ok' => true,
            'perfil' => [
                'id_perfil' => $idPerfil,
                'nome' => $perfil['nome'],
                'dinheiro' => (int) $perfil['dinheiro'],
            ],
            'time' => $teamStmt->fetchAll(),
            'inventario' => (new Encontro($this->conn))->encontrarInventario($idPerfil),
            'npc' => $npc,
            'nos' => $nos,
            'conexoes' => $conexoes,
            'progresso' => ['concluidos' => $concluidos, 'total' => count($nos)],
            'etapa_atual' => $etapaAtual,
            'area_atual' => $estadoDesafios['area_atual'],
            'desafio_atual' => $estadoDesafios['desafio_atual'],
            'jornada_concluida' => $estadoDesafios['desafio_atual'] === null,
        ]);
    }

    public function pokemart(): void
    {
        $idPerfil = $this->perfilAtivo();
        try {
            $no = $this->idServicoMapa($_GET['id_mapa_no'] ?? null);
            $dados = (new ServicosMapa($this->conn))->catalogo($idPerfil, $no);
            JsonResponse::send(['ok' => true] + $dados);
        } catch (ApiException $e) {
            JsonResponse::send(['ok' => false, 'message' => $e->getMessage()], $e->statusCode());
        }
    }

    public function visitarServicoMapa(): void
    {
        $idPerfil = $this->perfilAtivo();
        $dados = $this->dados();
        try {
            $acao = $dados['acao'] ?? null;
            if (!in_array($acao, ['curar', 'comprar', 'concluir_pokemart'], true)) {
                throw new ApiException('Ação inválida.', 422);
            }
            $no = $this->idServicoMapa($dados['id_mapa_no'] ?? null);
            $item = $acao === 'comprar' ? $this->idServicoMapa($dados['id_item'] ?? null) : null;
            $resposta = (new ServicosMapa($this->conn))->visitar($idPerfil, $no, $acao, $item);
            JsonResponse::send(['ok' => true] + $resposta);
        } catch (ApiException $e) {
            JsonResponse::send(['ok' => false, 'message' => $e->getMessage()], $e->statusCode());
        }
    }

    private function idServicoMapa(mixed $valor): int
    {
        $id = is_int($valor) || is_string($valor) ? filter_var($valor, FILTER_VALIDATE_INT) : false;
        if ($id === false || $id <= 0) {
            throw new ApiException('Identificador inválido.', 422);
        }
        return $id;
    }

    public function encounter(): void
    {
        $idPerfil = $this->perfilAtivo();
        $temNpc = array_key_exists('id_npc_mapa', $_GET);
        $temDesafio = array_key_exists('id_desafio', $_GET);
        if ($temNpc === $temDesafio) {
            JsonResponse::send([
                'ok' => false,
                'message' => 'Informe somente um id_npc_mapa ou id_desafio válido.',
            ], 422);
        }

        $chaveId = $temNpc ? 'id_npc_mapa' : 'id_desafio';
        $valorId = $_GET[$chaveId];
        if (!is_string($valorId) || !ctype_digit($valorId) || (int) $valorId <= 0) {
            JsonResponse::send([
                'ok' => false,
                'message' => 'O identificador do encontro é inválido.',
            ], 422);
        }

        $alvo = [
            ($temNpc ? 'id_npc_mapa' : 'id_desafio') => (int) $valorId,
        ];

        try {
            $encontro = (new BattleService($this->conn))->obterEncontro($idPerfil, $alvo);
        } catch (ApiException $e) {
            JsonResponse::send([
                'ok' => false,
                'message' => $e->getMessage(),
            ], $e->statusCode());
        }

        JsonResponse::send(['ok' => true] + $encontro);
    }
}
