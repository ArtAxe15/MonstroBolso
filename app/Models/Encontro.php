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
             WHERE d.ordem BETWEEN 1 AND 6 AND NOT EXISTS (
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

    public function encontrarRotaGerada(int $idPerfil): ?array
    {
        $detalhes = $this->consultar(
            "SELECT detalhes FROM perfil_log
             WHERE id_perfil = :perfil AND acao = 'ROTA_GERADA'
             ORDER BY id_perfil_log DESC LIMIT 1",
            ['perfil' => $idPerfil]
        )->fetchColumn();

        return $detalhes === false ? null : json_decode($detalhes, true, 512, JSON_THROW_ON_ERROR);
    }

    public function registrarRotaGerada(int $idPerfil, int $idDesafio, int $area): void
    {
        $this->consultar(
            "INSERT INTO perfil_log (id_perfil, acao, detalhes)
             VALUES (:perfil, 'ROTA_GERADA', :detalhes)",
            [
                'perfil' => $idPerfil,
                'detalhes' => json_encode(['id_desafio' => $idDesafio, 'area' => $area], JSON_THROW_ON_ERROR),
            ]
        );
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
                 dp.id_pokemon_especie,
                 dp.id_held_item,
                 dp.id_golpe_status,
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
                 dp.id_pokemon_especie,
                 dp.id_held_item,
                 dp.id_golpe_status,
                 pe.nome,
                 pe.imagem_url,
                 hi.nome,
                 gs.nome
             ORDER BY dp.ordem',
            ['desafio' => $idDesafio]
        )->fetchAll();
    }

    public function encontrarTimeDoJogador(int $idPerfil): array
    {
        return $this->consultar(
            'SELECT
                 pt.id_pokemon_time,
                 pt.id_pokemon_especie,
                 pt.id_held_item,
                 pt.id_golpe_status,
                 pt.apelido,
                 pt.nivel,
                 pt.hp_max,
                 pt.hp_atual,
                 pt.ataque,
                 pt.defesa,
                 pt.ataque_especial,
                 pt.defesa_especial,
                 pt.velocidade,
                 pt.status,
                 pt.posicao,
                 pe.nome AS nome_especie,
                 pe.imagem_url
             FROM pokemon_time pt
             INNER JOIN pokemon_especie pe
                 ON pe.id_pokemon_especie = pt.id_pokemon_especie
             WHERE pt.id_perfil = :perfil
             ORDER BY pt.posicao',
            ['perfil' => $idPerfil]
        )->fetchAll();
    }

    public function encontrarInventario(int $idPerfil): array
    {
        return $this->consultar(
            'SELECT
                 i.id_item,
                 i.nome,
                 i.categoria,
                 i.valor_efeito,
                 i.descricao,
                 i.tipo_efeito,
                 inv.quantidade
             FROM inventario inv
             INNER JOIN item i ON i.id_item = inv.id_item
             WHERE inv.id_perfil = :perfil
               AND inv.quantidade > 0
             ORDER BY i.nome',
            ['perfil' => $idPerfil]
        )->fetchAll();
    }

    public function encontrarCurasDeStatus(): array
    {
        $curas = [];
        foreach ($this->consultar(
            'SELECT cura.id_item, status.nome
             FROM item_status_cura cura
             JOIN status_pokemon status ON status.id_status = cura.id_status'
        )->fetchAll() as $cura) {
            $curas[(int) $cura['id_item']][] = $cura['nome'];
        }
        return $curas;
    }

    public function consumirItem(int $idPerfil, int $idItem): bool
    {
        return $this->consultar(
            'UPDATE inventario SET quantidade = quantidade - 1
             WHERE id_perfil = :perfil AND id_item = :item AND quantidade > 0',
            ['perfil' => $idPerfil, 'item' => $idItem]
        )->rowCount() === 1;
    }

    public function encontrarOpcoesDeGolpeStatus(array $idsEspecie): array
    {
        [$idsEspecie, $marcadores] = $this->prepararListaIds($idsEspecie);
        if ($idsEspecie === []) {
            return [];
        }

        $opcoes = [];
        foreach ($this->consultar(
            "SELECT opcao.id_pokemon_especie, golpe.id_golpe
             FROM pokemon_especie_status_opcao opcao
             JOIN golpe ON golpe.id_golpe = opcao.id_golpe
             WHERE golpe.api_id IN (14, 417) AND golpe.categoria = 'STATUS'
               AND opcao.id_pokemon_especie IN ({$marcadores})
             ORDER BY opcao.id_pokemon_especie, golpe.api_id",
            $idsEspecie
        )->fetchAll() as $opcao) {
            $opcoes[(int) $opcao['id_pokemon_especie']][] = (int) $opcao['id_golpe'];
        }
        return $opcoes;
    }

    /** No MONSTROBOLSO, metodo_evolucao=NIVEL prevalece sobre o gatilho original da API. */
    public function encontrarEvolucaoPorNivel(int $idEspecie, int $nivel): ?array
    {
        $evolucao = $this->consultar(
            "SELECT id_pokemon_destino, nivel_requisito
             FROM evolucao
             WHERE id_pokemon_origem = :especie
               AND metodo_evolucao = 'NIVEL'
               AND nivel_requisito <= :nivel
             ORDER BY nivel_requisito, id_evolucao
             LIMIT 1",
            ['especie' => $idEspecie, 'nivel' => $nivel]
        )->fetch();

        return $evolucao === false ? null : $evolucao;
    }

    public function encontrarDadosDasEspecies(array $idsEspecie): array
    {
        [$idsEspecie, $marcadores] = $this->prepararListaIds($idsEspecie);
        if ($idsEspecie === []) {
            return [];
        }

        $especies = $this->consultar(
            "SELECT
                 id_pokemon_especie,
                 nome,
                 imagem_url,
                 hp_base,
                 ataque_base,
                 defesa_base,
                 ataque_especial_base,
                 defesa_especial_base,
                 velocidade_base
             FROM pokemon_especie
             WHERE id_pokemon_especie IN ({$marcadores})",
            $idsEspecie
        )->fetchAll();

        $resultado = [];
        foreach ($especies as $especie) {
            $resultado[(int) $especie['id_pokemon_especie']] = $especie;
        }

        return $resultado;
    }

    public function encontrarTiposDasEspecies(array $idsEspecie): array
    {
        [$idsEspecie, $marcadores] = $this->prepararListaIds($idsEspecie);
        if ($idsEspecie === []) {
            return [];
        }

        $tipos = $this->consultar(
            "SELECT pet.id_pokemon_especie, t.nome
             FROM pokemon_especie_tipo pet
             INNER JOIN tipo t ON t.id_tipo = pet.id_tipo
             WHERE pet.id_pokemon_especie IN ({$marcadores})
             ORDER BY pet.id_pokemon_especie, t.id_tipo",
            $idsEspecie
        )->fetchAll();

        $resultado = [];
        foreach ($tipos as $tipo) {
            $resultado[(int) $tipo['id_pokemon_especie']][] = $tipo['nome'];
        }

        return $resultado;
    }

    public function encontrarEfetividadesPorNome(): array
    {
        return $this->consultar(
            'SELECT tipo_atacante.nome AS tipo_atacante,
                    tipo_defensor.nome AS tipo_defensor,
                    te.multiplicador
             FROM tipo_efetividade te
             INNER JOIN tipo tipo_atacante
                 ON tipo_atacante.id_tipo = te.id_tipo_atacante
             INNER JOIN tipo tipo_defensor
                 ON tipo_defensor.id_tipo = te.id_tipo_defensor'
        )->fetchAll();
    }

    public function encontrarGolpesDeDanoDasEspecies(array $idsEspecie): array
    {
        [$idsEspecie, $marcadores] = $this->prepararListaIds($idsEspecie);
        if ($idsEspecie === []) {
            return [];
        }

        $golpes = $this->consultar(
            "SELECT
                 peg.id_pokemon_especie,
                 peg.slot,
                 g.id_golpe,
                 g.nome,
                 t.nome AS tipo,
                 g.categoria,
                 g.poder,
                 g.precisao,
                 g.pp,
                 g.prioridade,
                 g.classe_dano,
                 g.descricao
             FROM pokemon_especie_golpe peg
             INNER JOIN golpe g ON g.id_golpe = peg.id_golpe
             INNER JOIN tipo t ON t.id_tipo = g.id_tipo
             WHERE peg.id_pokemon_especie IN ({$marcadores})
               AND g.categoria = 'DANO'
             ORDER BY peg.id_pokemon_especie, peg.slot",
            $idsEspecie
        )->fetchAll();

        $resultado = [];
        foreach ($golpes as $golpe) {
            $resultado[(int) $golpe['id_pokemon_especie']][] = $golpe;
        }

        return $resultado;
    }

    public function encontrarGolpesPorIds(array $idsGolpe): array
    {
        [$idsGolpe, $marcadores] = $this->prepararListaIds($idsGolpe);
        if ($idsGolpe === []) {
            return [];
        }

        $golpes = $this->consultar(
            "SELECT
                 g.id_golpe,
                 g.api_id,
                 g.nome,
                 t.nome AS tipo,
                 g.categoria,
                 g.poder,
                 g.precisao,
                 g.pp,
                 g.prioridade,
                 g.classe_dano,
                 g.descricao
             FROM golpe g
             INNER JOIN tipo t ON t.id_tipo = g.id_tipo
             WHERE g.id_golpe IN ({$marcadores})",
            $idsGolpe
        )->fetchAll();

        $resultado = [];
        foreach ($golpes as $golpe) {
            $resultado[(int) $golpe['id_golpe']] = $golpe;
        }

        return $resultado;
    }

    public function encontrarItensPorIds(array $idsHeldItem): array
    {
        [$idsHeldItem, $marcadores] = $this->prepararListaIds($idsHeldItem);
        if ($idsHeldItem === []) {
            return [];
        }

        $itens = $this->consultar(
            "SELECT
                 id_held_item,
                 nome,
                 tipo_efeito,
                 base_calculo,
                 numerador,
                 denominador,
                 gatilho,
                 limiar_hp,
                 consumivel
             FROM held_item
             WHERE id_held_item IN ({$marcadores})",
            $idsHeldItem
        )->fetchAll();

        $resultado = [];
        foreach ($itens as $item) {
            $resultado[(int) $item['id_held_item']] = $item;
        }

        return $resultado;
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

    public function encontrarEspeciesSelvagensPorArea(int $area): array
    {
        $colunaEspecie = self::COLUNAS_ESPECIE_POR_AREA[$area] ?? null;
        if ($colunaEspecie === null) {
            throw new \InvalidArgumentException('Área de encontro selvagem inválida.');
        }

        return array_map(
            'intval',
            $this->consultar(
                "SELECT DISTINCT {$colunaEspecie}
                 FROM npc_tipo_pokemon
                 ORDER BY {$colunaEspecie}"
            )->fetchAll(PDO::FETCH_COLUMN)
        );
    }

    public function encontrarNoSelvagemDoPerfil(int $idMapaNo, int $idPerfil): ?array
    {
        $no = $this->consultar(
            "SELECT id_mapa_no, posicao_y, status
             FROM mapa_no
             WHERE id_mapa_no = :no
               AND id_perfil = :perfil
               AND tipo_local = 'SELVAGEM'
             LIMIT 1",
            [
                'no' => $idMapaNo,
                'perfil' => $idPerfil,
            ]
        )->fetch();

        return $no === false ? null : $no;
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

    private function prepararListaIds(array $ids): array
    {
        $ids = array_values(array_unique(array_filter(
            array_map('intval', $ids),
            static fn(int $id): bool => $id > 0
        )));

        return [
            $ids,
            implode(',', array_fill(0, count($ids), '?')),
        ];
    }
}
