<?php

declare(strict_types=1);

namespace App\Models;

use PDO;
use RuntimeException;

final class Batalha
{
    public function __construct(private PDO $conn)
    {
    }

    public function encontrarIdsStatus(): array
    {
        $stmt = $this->conn->prepare('SELECT id_status, nome FROM status_pokemon');
        $stmt->execute();

        $resultado = [];
        foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $status) {
            $resultado[mb_strtolower((string) $status['nome'])] = (int) $status['id_status'];
        }

        return $resultado;
    }

    public function atualizarPokemonTime(int $idPerfil, array $pokemon): void
    {
        $stmt = $this->conn->prepare(
            'UPDATE pokemon_time
             SET hp_atual = :hp_atual,
                 status = :status,
                 nivel = :nivel,
                 hp_max = :hp_max,
                 ataque = :ataque,
                 defesa = :defesa,
                 ataque_especial = :ataque_especial,
                 defesa_especial = :defesa_especial,
                 velocidade = :velocidade
             WHERE id_pokemon_time = :pokemon_time
               AND id_perfil = :perfil'
        );
        $stmt->execute([
            'hp_atual' => (int) $pokemon['atributos']['hp_atual'],
            'status' => (string) $pokemon['status'],
            'nivel' => (int) $pokemon['nivel'],
            'hp_max' => (int) $pokemon['atributos']['hp_max'],
            'ataque' => (int) $pokemon['atributos']['ataque'],
            'defesa' => (int) $pokemon['atributos']['defesa'],
            'ataque_especial' => (int) $pokemon['atributos']['ataque_especial'],
            'defesa_especial' => (int) $pokemon['atributos']['defesa_especial'],
            'velocidade' => (int) $pokemon['atributos']['velocidade'],
            'pokemon_time' => (int) $pokemon['id_pokemon_time'],
            'perfil' => $idPerfil,
        ]);
        if ($stmt->rowCount() === 0) {
            $existente = $this->conn->prepare(
                'SELECT 1 FROM pokemon_time
                 WHERE id_pokemon_time = :pokemon_time AND id_perfil = :perfil'
            );
            $existente->execute([
                'pokemon_time' => (int) $pokemon['id_pokemon_time'],
                'perfil' => $idPerfil,
            ]);
            if ($existente->fetchColumn() === false) {
                throw new RuntimeException('Um Pokémon da equipe não pertence mais a esta jornada.');
            }
        }
    }

    public function marcarTreinadorDerrotado(int $idPerfil, int $idNpcMapa): void
    {
        $stmt = $this->conn->prepare(
            'UPDATE npc_mapa
             SET derrotado = 1, derrotado_em = CURRENT_TIMESTAMP()
             WHERE id_npc_mapa = :npc_mapa
               AND id_perfil = :perfil
               AND derrotado = 0'
        );
        $stmt->execute([
            'npc_mapa' => $idNpcMapa,
            'perfil' => $idPerfil,
        ]);
        if ($stmt->rowCount() !== 1) {
            throw new RuntimeException('O treinador não pôde ser marcado como derrotado.');
        }
    }

    public function marcarDesafioConcluido(int $idPerfil, int $idDesafio): void
    {
        $stmt = $this->conn->prepare(
            'INSERT INTO progresso_desafio
                (id_perfil, id_desafio, concluido, concluido_em)
             VALUES
                (:perfil, :desafio, 1, CURRENT_TIMESTAMP())
             ON DUPLICATE KEY UPDATE
                concluido = 1,
                concluido_em = COALESCE(concluido_em, CURRENT_TIMESTAMP())'
        );
        $stmt->execute([
            'perfil' => $idPerfil,
            'desafio' => $idDesafio,
        ]);
    }

    public function marcarNoSelvagemConcluido(int $idPerfil, int $idMapaNo): void
    {
        $consulta = $this->conn->prepare(
            "SELECT etapa
             FROM mapa_no
             WHERE id_mapa_no = :no
               AND id_perfil = :perfil
               AND tipo_local = 'SELVAGEM'
               AND status = 'DISPONIVEL'
             FOR UPDATE"
        );
        $consulta->execute([
            'no' => $idMapaNo,
            'perfil' => $idPerfil,
        ]);
        $no = $consulta->fetch(PDO::FETCH_ASSOC);
        if ($no === false) {
            throw new RuntimeException('O encontro selvagem não está mais disponível nesta jornada.');
        }

        $concluir = $this->conn->prepare(
            "UPDATE mapa_no
             SET status = 'CONCLUIDO', concluido_em = CURRENT_TIMESTAMP()
             WHERE id_mapa_no = :no
               AND id_perfil = :perfil
               AND tipo_local = 'SELVAGEM'
               AND status = 'DISPONIVEL'"
        );
        $concluir->execute([
            'no' => $idMapaNo,
            'perfil' => $idPerfil,
        ]);
        if ($concluir->rowCount() !== 1) {
            throw new RuntimeException('O encontro selvagem não pôde ser concluído no mapa.');
        }

        $ignorarAlternativas = $this->conn->prepare(
            "UPDATE mapa_no
             SET status = 'IGNORADO'
             WHERE id_perfil = :perfil
               AND etapa = :etapa
               AND status = 'DISPONIVEL'
               AND id_mapa_no <> :no"
        );
        $ignorarAlternativas->execute([
            'perfil' => $idPerfil,
            'etapa' => (int) $no['etapa'],
            'no' => $idMapaNo,
        ]);

        $liberarProximos = $this->conn->prepare(
            "UPDATE mapa_no destino
             INNER JOIN mapa_conexao conexao
                 ON conexao.id_mapa_no_destino = destino.id_mapa_no
             SET destino.status = 'DISPONIVEL'
             WHERE conexao.id_mapa_no_origem = :no
               AND destino.id_perfil = :perfil
               AND destino.status = 'BLOQUEADO'"
        );
        $liberarProximos->execute([
            'no' => $idMapaNo,
            'perfil' => $idPerfil,
        ]);
    }

    public function adicionarDinheiroPerfil(int $idPerfil, int $quantia): void
    {
        if ($quantia <= 0) {
            throw new RuntimeException('A quantia de dinheiro da recompensa é inválida.');
        }

        $stmt = $this->conn->prepare(
            'UPDATE perfil
             SET dinheiro = dinheiro + :quantia
             WHERE id_perfil = :perfil'
        );
        $stmt->execute([
            'quantia' => $quantia,
            'perfil' => $idPerfil,
        ]);
        if ($stmt->rowCount() !== 1) {
            throw new RuntimeException('A recompensa não pôde ser adicionada à jornada.');
        }
    }

    public function inserirHistorico(
        int $idPerfil,
        ?int $idDesafio,
        string $resultado,
        string $detalhesJson,
        string $iniciadaEm,
        int $dinheiroGanho
    ): int {
        $stmt = $this->conn->prepare(
            'INSERT INTO batalha_log
                (id_perfil, id_desafio, resultado, dinheiro_ganho, detalhes, iniciada_em, finalizada_em)
             VALUES
                (:perfil, :desafio, :resultado, :dinheiro, :detalhes, :iniciada_em, CURRENT_TIMESTAMP())'
        );
        $stmt->execute([
            'perfil' => $idPerfil,
            'desafio' => $idDesafio,
            'resultado' => $resultado,
            'dinheiro' => $dinheiroGanho,
            'detalhes' => $detalhesJson,
            'iniciada_em' => $iniciadaEm,
        ]);

        return (int) $this->conn->lastInsertId();
    }

    public function inserirPokemonHistorico(int $idBatalha, array $pokemon): void
    {
        $stmt = $this->conn->prepare(
            'INSERT INTO batalha_pokemon
                (id_batalha, id_pokemon_time, id_pokemon_especie, lado, ordem, nivel,
                 hp_inicial, hp_final, id_status_final, id_held_item)
             VALUES
                (:batalha, :pokemon_time, :especie, :lado, :ordem, :nivel,
                 :hp_inicial, :hp_final, :status, :held_item)'
        );
        $stmt->execute([
            'batalha' => $idBatalha,
            'pokemon_time' => $pokemon['id_pokemon_time'],
            'especie' => (int) $pokemon['id_pokemon_especie'],
            'lado' => (string) $pokemon['lado'],
            'ordem' => (int) $pokemon['ordem'],
            'nivel' => (int) $pokemon['nivel'],
            'hp_inicial' => (int) $pokemon['hp_inicial'],
            'hp_final' => (int) $pokemon['hp_final'],
            'status' => $pokemon['id_status_final'],
            'held_item' => $pokemon['id_held_item'],
        ]);
    }
}
