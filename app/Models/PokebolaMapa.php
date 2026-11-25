<?php

declare(strict_types=1);

namespace App\Models;

use App\Http\ApiException;
use App\Services\CalculadoraAtributos;
use PDO;
use Throwable;

/**
 * Ofertas de Pokémon em nós POKEBOLA do mapa.
 * A oferta é registrada em perfil_log: não exige alterações no esquema SQL.
 */
final class PokebolaMapa
{
    public function __construct(private PDO $conn) {}

    public function oferecer(int $perfil, int $no): array
    {
        $this->semBatalhaPendente($perfil);
        $this->conn->beginTransaction();
        try {
            $this->bloquearPerfil($perfil);
            $this->localDisponivel($perfil, $no);
            $oferta = $this->ofertaExistente($perfil, $no);
            if ($oferta === null) {
                // Exclui destinos de evolução. Algumas espécies evoluídas
                // do dump ainda não têm cadeia de evolução cadastrada;
                // elas são explicitamente excluídas como salvaguarda.
                $especie = $this->conn->query(
                    'SELECT pe.id_pokemon_especie FROM pokemon_especie pe '
                    . 'WHERE NOT EXISTS ('
                    . ' SELECT 1 FROM evolucao e WHERE e.id_pokemon_destino = pe.id_pokemon_especie'
                    . ") AND pe.nome NOT IN ('lilligant-hisui', 'krokorok', 'krookodile', "
                    . "'darmanitan-standard', 'darmanitan-galar-standard', 'zoroark-hisui', "
                    . "'jellicent-male', 'braviary-hisui') AND EXISTS ("
                    . ' SELECT 1 FROM pokemon_especie_golpe peg '
                    . ' WHERE peg.id_pokemon_especie = pe.id_pokemon_especie'
                    . ') ORDER BY RAND() LIMIT 1'
                )->fetchColumn();
                if ($especie === false) {
                    throw new ApiException('Nenhum Pokémon inicial está cadastrado para a Pokébola.', 422);
                }
                // O Pokémon oferecido acompanha o nível atual do time.
                $nivel = (int) $this->consultar(
                    'SELECT MAX(nivel) FROM pokemon_time WHERE id_perfil = ?', [$perfil]
                )->fetchColumn();
                $nivel = max(5, min(100, $nivel));
                $oferta = ['id_pokemon_especie' => (int) $especie, 'nivel' => $nivel];
                $this->registrar($perfil, 'POKEBOLA_OFERTA', $no, $oferta);
            }
            $pokemon = $this->pokemonDaOferta($oferta);
            $time = $this->consultar(
                'SELECT pt.id_pokemon_time, pt.posicao, pt.nivel, pe.nome, pe.imagem_url '
                . 'FROM pokemon_time pt '
                . 'INNER JOIN pokemon_especie pe ON pe.id_pokemon_especie = pt.id_pokemon_especie '
                . 'WHERE pt.id_perfil = ? ORDER BY pt.posicao',
                [$perfil]
            )->fetchAll(PDO::FETCH_ASSOC);
            $quantidade = count($time);
            $this->conn->commit();
            return [
                'pokemon' => $pokemon,
                'quantidade_time' => $quantidade,
                'time_cheio' => $quantidade >= 6,
                'time' => $time,
            ];
        } catch (Throwable $e) {
            if ($this->conn->inTransaction()) $this->conn->rollBack();
            throw $e;
        }
    }

    /**
     * Um Pokémon aceito vai para a equipe se houver vaga; caso contrário, para o PC.
     * Nenhum integrante existente é apagado ou substituído.
     */
    public function resolver(int $perfil, int $no, bool $aceitar): array
    {
        $this->semBatalhaPendente($perfil);
        $this->conn->beginTransaction();
        try {
            $this->bloquearPerfil($perfil);
            $etapa = $this->localDisponivel($perfil, $no);
            $oferta = $this->ofertaExistente($perfil, $no);
            if ($oferta === null) {
                throw new ApiException('Abra a Pokébola antes de escolher.', 409);
            }
            $pokemon = $this->pokemonDaOferta($oferta);
            $guardadoNoPc = false;
            if ($aceitar) {
                $posicoes = array_map('intval', $this->consultar(
                    'SELECT posicao FROM pokemon_time WHERE id_perfil = ? ORDER BY posicao FOR UPDATE',
                    [$perfil]
                )->fetchAll(PDO::FETCH_COLUMN));
                $guardadoNoPc = count($posicoes) >= 6;
                $idEspecie = (int) $oferta['id_pokemon_especie'];
                $atributos = $pokemon['atributos'];
                $opcoes = (new Encontro($this->conn))->encontrarOpcoesDeGolpeStatus([$idEspecie]);
                $idStatus = $opcoes[$idEspecie][0] ?? null;
                if ($guardadoNoPc) {
                    $this->consultar(
                        "INSERT INTO pokemon_pc (
                            id_perfil, id_pokemon_especie, id_golpe_status, nivel,
                            hp_max, hp_atual, ataque, defesa, ataque_especial,
                            defesa_especial, velocidade, status
                        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'normal')",
                        [
                            $perfil, $idEspecie, $idStatus, (int) $oferta['nivel'],
                            $atributos['hp_max'], $atributos['hp_max'],
                            $atributos['ataque'], $atributos['defesa'],
                            $atributos['ataque_especial'], $atributos['defesa_especial'],
                            $atributos['velocidade'],
                        ]
                    );
                } else {
                    $posicaoLivre = null;
                    for ($posicao = 1; $posicao <= 6; $posicao++) {
                        if (!in_array($posicao, $posicoes, true)) {
                            $posicaoLivre = $posicao;
                            break;
                        }
                    }
                    if ($posicaoLivre === null) {
                        throw new ApiException('Não foi possível encontrar espaço na equipe.', 409);
                    }
                    $this->consultar(
                        "INSERT INTO pokemon_time (
                            id_perfil, id_pokemon_especie, id_golpe_status, nivel,
                            hp_max, hp_atual, ataque, defesa, ataque_especial,
                            defesa_especial, velocidade, status, posicao
                        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'normal', ?)",
                        [
                            $perfil, $idEspecie, $idStatus, (int) $oferta['nivel'],
                            $atributos['hp_max'], $atributos['hp_max'],
                            $atributos['ataque'], $atributos['defesa'],
                            $atributos['ataque_especial'], $atributos['defesa_especial'],
                            $atributos['velocidade'], $posicaoLivre,
                        ]
                    );
                }
            }
            $this->registrar(
                $perfil,
                !$aceitar ? 'POKEBOLA_RECUSADA' : ($guardadoNoPc ? 'POKEBOLA_PC' : 'POKEBOLA_CAPTURADA'),
                $no,
                $oferta
            );
            $this->consultar(
                "UPDATE mapa_no SET status = 'CONCLUIDO', concluido_em = CURRENT_TIMESTAMP() "
                . "WHERE id_perfil = ? AND id_mapa_no = ? AND status = 'DISPONIVEL'",
                [$perfil, $no]
            );
            $this->consultar(
                "UPDATE mapa_no SET status = 'IGNORADO' "
                . "WHERE id_perfil = ? AND etapa = ? AND status = 'DISPONIVEL'",
                [$perfil, $etapa]
            );
            $this->consultar(
                "UPDATE mapa_no destino "
                . "INNER JOIN mapa_conexao ligacao ON ligacao.id_mapa_no_destino = destino.id_mapa_no "
                . "SET destino.status = 'DISPONIVEL' "
                . "WHERE ligacao.id_mapa_no_origem = ? AND destino.id_perfil = ? "
                . "AND destino.status = 'BLOQUEADO'",
                [$no, $perfil]
            );
            $this->conn->commit();
            $nome = ucfirst(str_replace('-', ' ', (string) $pokemon['nome']));
            $mensagem = !$aceitar
                ? "Você deixou $nome para trás e avançou na rota."
                : ($guardadoNoPc
                    ? "$nome foi enviado ao PC, pois sua equipe está cheia!"
                    : "$nome entrou para a sua equipe!");
            return ['message' => $mensagem, 'armazenado_pc' => $guardadoNoPc];
        } catch (Throwable $e) {
            if ($this->conn->inTransaction()) $this->conn->rollBack();
            throw $e;
        }
    }

    public function trocarPosicoes(int $perfil, int $primeiro, int $segundo): array
    {
        $this->semBatalhaPendente($perfil);
        if ($primeiro === $segundo) {
            throw new ApiException('Escolha dois Pokémon diferentes para trocar.', 422);
        }
        $this->conn->beginTransaction();
        $checksDesativados = false;
        try {
            $this->bloquearPerfil($perfil);
            $jogadores = $this->consultar(
                'SELECT id_pokemon_time, posicao FROM pokemon_time '
                . 'WHERE id_perfil = ? AND id_pokemon_time IN (?, ?) FOR UPDATE',
                [$perfil, $primeiro, $segundo]
            )->fetchAll(PDO::FETCH_ASSOC);
            if (count($jogadores) !== 2) {
                throw new ApiException('Selecione dois Pokémon da sua jornada.', 404);
            }
            $posicoes = [];
            foreach ($jogadores as $pokemon) {
                $posicoes[(int) $pokemon['id_pokemon_time']] = (int) $pokemon['posicao'];
            }
            // UNIQUE(perfil,posicao) não permite trocar posições em um UPDATE.
            // Com menos de seis Pokémon, usa um slot livre entre 1 e 6;
            // com seis, usa temporariamente o slot 7 na transação e restaura
            // a verificação de CHECK antes do commit (MariaDB 10.4).
            $ocupadas = array_map('intval', $this->consultar(
                'SELECT posicao FROM pokemon_time WHERE id_perfil = ? FOR UPDATE', [$perfil]
            )->fetchAll(PDO::FETCH_COLUMN));
            $temporaria = null;
            for ($candidata = 1; $candidata <= 6; $candidata++) {
                if (!in_array($candidata, $ocupadas, true)) {
                    $temporaria = $candidata;
                    break;
                }
            }
            if ($temporaria === null) {
                $temporaria = 7;
                $this->conn->exec('SET SESSION check_constraint_checks = OFF');
                $checksDesativados = true;
            }
            $this->consultar(
                'UPDATE pokemon_time SET posicao = ? WHERE id_perfil = ? AND id_pokemon_time = ?',
                [$temporaria, $perfil, $primeiro]
            );
            $this->consultar(
                'UPDATE pokemon_time SET posicao = ? WHERE id_perfil = ? AND id_pokemon_time = ?',
                [$posicoes[$primeiro], $perfil, $segundo]
            );
            $this->consultar(
                'UPDATE pokemon_time SET posicao = ? WHERE id_perfil = ? AND id_pokemon_time = ?',
                [$posicoes[$segundo], $perfil, $primeiro]
            );
            if ($checksDesativados) {
                $this->conn->exec('SET SESSION check_constraint_checks = ON');
                $checksDesativados = false;
            }
            $this->conn->commit();
            return ['message' => 'Posições da equipe atualizadas.'];
        } catch (Throwable $e) {
            if ($this->conn->inTransaction()) $this->conn->rollBack();
            throw $e;
        } finally {
            if ($checksDesativados) {
                $this->conn->exec('SET SESSION check_constraint_checks = ON');
            }
        }
    }

    private function semBatalhaPendente(int $perfil): void
    {
        $batalha = $_SESSION['batalha'] ?? null;
        if (is_array($batalha)
            && (int) ($batalha['id_perfil'] ?? 0) === $perfil
            && (!(bool) ($batalha['finalizada'] ?? false)
                || (bool) ($batalha['persistencia_pendente'] ?? false))) {
            throw new ApiException('Finalize a batalha em andamento antes de alterar a equipe ou visitar a Pokébola.', 409);
        }
    }

    private function bloquearPerfil(int $perfil): void
    {
        if (!$this->consultar('SELECT id_perfil FROM perfil WHERE id_perfil = ? FOR UPDATE', [$perfil])->fetchColumn()) {
            throw new ApiException('Jornada não encontrada.', 404);
        }
    }

    private function localDisponivel(int $perfil, int $no): int
    {
        $linha = $this->consultar(
            "SELECT etapa, status FROM mapa_no WHERE id_perfil = ? AND id_mapa_no = ? "
            . "AND tipo_local = 'POKEBOLA' FOR UPDATE",
            [$perfil, $no]
        )->fetch(PDO::FETCH_ASSOC);
        if (!$linha) throw new ApiException('Esta Pokébola não pertence à sua jornada.', 404);
        if ($linha['status'] !== 'DISPONIVEL') {
            throw new ApiException('Essa Pokébola não está disponível.', 409);
        }
        return (int) $linha['etapa'];
    }

    private function ofertaExistente(int $perfil, int $no): ?array
    {
        $linha = $this->consultar(
            "SELECT detalhes FROM perfil_log WHERE id_perfil = ? AND acao = 'POKEBOLA_OFERTA' "
            . "AND CAST(JSON_UNQUOTE(JSON_EXTRACT(detalhes, '$.id_mapa_no')) AS UNSIGNED) = ? "
            . 'ORDER BY id_perfil_log DESC LIMIT 1',
            [$perfil, $no]
        )->fetchColumn();
        if ($linha === false) return null;
        $dados = json_decode((string) $linha, true, 512, JSON_THROW_ON_ERROR);
        if (!is_array($dados) || !isset($dados['id_pokemon_especie'], $dados['nivel'])) {
            throw new ApiException('A oferta registrada está incompleta.', 409);
        }
        return [
            'id_pokemon_especie' => (int) $dados['id_pokemon_especie'],
            'nivel' => (int) $dados['nivel'],
        ];
    }

    private function pokemonDaOferta(array $oferta): array
    {
        $pokemon = $this->consultar(
            'SELECT pe.*, GROUP_CONCAT(t.nome ORDER BY t.id_tipo SEPARATOR ", ") AS tipos '
            . 'FROM pokemon_especie pe '
            . 'LEFT JOIN pokemon_especie_tipo pet ON pet.id_pokemon_especie = pe.id_pokemon_especie '
            . 'LEFT JOIN tipo t ON t.id_tipo = pet.id_tipo '
            . 'WHERE pe.id_pokemon_especie = ? GROUP BY pe.id_pokemon_especie',
            [(int) $oferta['id_pokemon_especie']]
        )->fetch(PDO::FETCH_ASSOC);
        if (!$pokemon) throw new ApiException('O Pokémon oferecido não foi encontrado.', 404);
        $pokemon['nivel'] = (int) $oferta['nivel'];
        $pokemon['atributos'] = (new CalculadoraAtributos())->calcular(
            (int) $pokemon['hp_base'],
            (int) $pokemon['ataque_base'],
            (int) $pokemon['defesa_base'],
            (int) $pokemon['ataque_especial_base'],
            (int) $pokemon['defesa_especial_base'],
            (int) $pokemon['velocidade_base'],
            $pokemon['nivel']
        );
        return $pokemon;
    }

    private function registrar(int $perfil, string $acao, int $no, array $oferta): void
    {
        $this->consultar(
            'INSERT INTO perfil_log (id_perfil, acao, descricao, detalhes) VALUES (?, ?, ?, ?)',
            [
                $perfil, $acao, 'Encontro com uma Pokébola do mapa.',
                json_encode(['id_mapa_no' => $no] + $oferta, JSON_THROW_ON_ERROR | JSON_UNESCAPED_UNICODE),
            ]
        );
    }

    private function consultar(string $sql, array $parametros): \PDOStatement
    {
        $stmt = $this->conn->prepare($sql);
        $stmt->execute($parametros);
        return $stmt;
    }
}
