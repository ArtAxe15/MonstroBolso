<?php
declare(strict_types=1);

namespace App\Models;

use PDO;
use PDOStatement;

final class Encontro
{
    private const COLUNAS_ESPECIE_POR_AREA = [
        1 => 'id_pokemon_0_1',
        2 => 'id_pokemon_2_3',
        3 => 'id_pokemon_4_6',
    ];

    public function __construct(private PDO $conn)
    {
    }

    public function contarConcluidos(int $idPerfil): int
    {
        return (int) $this->consultar(
            'SELECT COUNT(*)
             FROM progresso_desafio
             WHERE id_perfil = :perfil AND concluido = 1',
            ['perfil' => $idPerfil]
        )->fetchColumn();
    }

    public function encontrarAtual(int $idPerfil): ?array
    {
        $desafio = $this->consultar(
            'SELECT d.id_desafio, d.ordem, d.nome, d.tipo
             FROM desafio d
             WHERE NOT EXISTS (
                 SELECT 1
                 FROM progresso_desafio pd
                 WHERE pd.id_perfil = :perfil
                   AND pd.id_desafio = d.id_desafio
                   AND pd.concluido = 1
             )
             ORDER BY d.ordem
             LIMIT 1',
            ['perfil' => $idPerfil]
        )->fetch();

        return $desafio === false ? null : $desafio;
    }

    public function encontrarPorId(int $idDesafio): ?array
    {
        $desafio = $this->consultar(
            'SELECT id_desafio, ordem, nome, tipo
             FROM desafio
             WHERE id_desafio = :desafio
             LIMIT 1',
            ['desafio' => $idDesafio]
        )->fetch();

        return $desafio === false ? null : $desafio;
    }

    public function encontrarPokemon(int $idDesafio): array
    {
        return $this->consultar(
            'SELECT
                 dp.ordem,
                 dp.nivel,
                 pe.nome,
                 pe.imagem_url,
                 GROUP_CONCAT(DISTINCT t.nome ORDER BY t.id_tipo SEPARATOR \', \') AS tipos,
                 hi.nome AS item,
                 gs.nome AS golpe_status
             FROM desafio_pokemon dp
             INNER JOIN pokemon_especie pe
                 ON pe.id_pokemon_especie = dp.id_pokemon_especie
             LEFT JOIN pokemon_especie_tipo pet
                 ON pet.id_pokemon_especie = pe.id_pokemon_especie
             LEFT JOIN tipo t ON t.id_tipo = pet.id_tipo
             LEFT JOIN held_item hi ON hi.id_held_item = dp.id_held_item
             LEFT JOIN golpe gs ON gs.id_golpe = dp.id_golpe_status
             WHERE dp.id_desafio = :desafio
             GROUP BY
                 dp.id_desafio_pokemon,
                 dp.ordem,
                 dp.nivel,
                 pe.nome,
                 pe.imagem_url,
                 hi.nome,
                 gs.nome
             ORDER BY dp.ordem',
            ['desafio' => $idDesafio]
        )->fetchAll();
    }

    public function encontrarLimitesDeNivel(int $ordemInicial, int $ordemFinal): ?array
    {
        $limites = $this->consultar(
            'SELECT MIN(dp.nivel) AS nivel_minimo, MAX(dp.nivel) AS nivel_maximo
             FROM desafio_pokemon dp
             INNER JOIN desafio d ON d.id_desafio = dp.id_desafio
             WHERE d.ordem BETWEEN :ordem_inicial AND :ordem_final',
            [
                'ordem_inicial' => $ordemInicial,
                'ordem_final' => $ordemFinal,
            ]
        )->fetch();

        if ($limites === false || $limites['nivel_minimo'] === null) {
            return null;
        }

        return [
            'nivel_minimo' => (int) $limites['nivel_minimo'],
            'nivel_maximo' => (int) $limites['nivel_maximo'],
        ];
    }

    public function encontrarDoPerfil(int $idNpcMapa, int $idPerfil): ?array
    {
        $npc = $this->consultar(
            'SELECT
                 nm.id_npc_mapa,
                 nm.id_npc_tipo,
                 nm.posicao_y,
                 nm.derrotado,
                 nt.descricao,
                 t.nome AS tipo_nome
             FROM npc_mapa nm
             INNER JOIN npc_tipo nt ON nt.id_npc_tipo = nm.id_npc_tipo
             INNER JOIN tipo t ON t.id_tipo = nt.id_tipo
             WHERE nm.id_npc_mapa = :npc_mapa
               AND nm.id_perfil = :perfil
             LIMIT 1',
            [
                'npc_mapa' => $idNpcMapa,
                'perfil' => $idPerfil,
            ]
        )->fetch();

        return $npc === false ? null : $npc;
    }

    public function encontrarLimitesVerticaisDoPerfil(int $idPerfil): ?array
    {
        $limites = $this->consultar(
            'SELECT
                 MIN(posicao_y) AS posicao_superior,
                 MAX(posicao_y) AS posicao_inferior
             FROM npc_mapa
             WHERE id_perfil = :perfil',
            ['perfil' => $idPerfil]
        )->fetch();

        if (
            $limites === false
            || $limites['posicao_superior'] === null
            || $limites['posicao_inferior'] === null
        ) {
            return null;
        }

        return [
            'posicao_superior' => (int) $limites['posicao_superior'],
            'posicao_inferior' => (int) $limites['posicao_inferior'],
        ];
    }

    public function encontrarEspeciesPorArea(int $idNpcTipo, int $area): array
    {
        $colunaEspecie = self::COLUNAS_ESPECIE_POR_AREA[$area] ?? null;
        if ($colunaEspecie === null) {
            throw new \InvalidArgumentException('Área de treinador inválida.');
        }

        return $this->consultar(
            "SELECT posicao, {$colunaEspecie} AS id_pokemon_especie
             FROM npc_tipo_pokemon
             WHERE id_npc_tipo = :tipo
             ORDER BY posicao",
            ['tipo' => $idNpcTipo]
        )->fetchAll();
    }

    public function encontrarComTipos(array $idsEspecie): array
    {
        $idsEspecie = array_values(array_unique(array_map('intval', $idsEspecie)));
        if ($idsEspecie === []) {
            return [];
        }

        $marcadores = implode(',', array_fill(0, count($idsEspecie), '?'));
        $especies = $this->consultar(
            "SELECT
                 pe.id_pokemon_especie,
                 pe.nome,
                 pe.imagem_url,
                 GROUP_CONCAT(DISTINCT t.nome ORDER BY t.id_tipo SEPARATOR ', ') AS tipos
             FROM pokemon_especie pe
             LEFT JOIN pokemon_especie_tipo pet
                 ON pet.id_pokemon_especie = pe.id_pokemon_especie
             LEFT JOIN tipo t ON t.id_tipo = pet.id_tipo
             WHERE pe.id_pokemon_especie IN ({$marcadores})
             GROUP BY pe.id_pokemon_especie, pe.nome, pe.imagem_url",
            $idsEspecie
        )->fetchAll();

        $resultado = [];
        foreach ($especies as $especie) {
            $resultado[(int) $especie['id_pokemon_especie']] = $especie;
        }

        return $resultado;
    }

    private function consultar(string $sql, array $parametros = []): PDOStatement
    {
        $stmt = $this->conn->prepare($sql);
        $stmt->execute($parametros);

        return $stmt;
    }
}
