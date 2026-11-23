<?php

declare(strict_types=1);

namespace App\Models;

use App\Http\ApiException;
use App\Domain\Pokemon;
use App\Domain\TipoElemental;
use PDO;
use PDOStatement;
use Throwable;

/**
 * Armazenamento do PC: mantém os Pokémon fora de pokemon_time (time de batalha).
 * Cada transferência é atômica e preserva espécie, nickname, nível, atributos,
 * HP atual, status, item e golpe de status.
 */
final class PokemonPc
{
    private const CAMPOS = 'id_perfil, id_pokemon_especie, id_held_item, apelido, nivel, '
        . 'hp_max, hp_atual, ataque, defesa, ataque_especial, defesa_especial, '
        . 'velocidade, status, id_golpe_status';

    public function __construct(private PDO $conn) {}

    public function listar(int $perfil): array
    {
        $this->validarJornada($perfil);
        $time = $this->sql(
            'SELECT vw.id_pokemon_time, vw.id_pokemon_especie, vw.posicao, vw.nome_exibicao, '
            . 'vw.nome_especie, vw.imagem_url, vw.nivel, vw.hp_atual, vw.hp_max, '
            . 'vw.hp_percentual, vw.status, vw.item_equipado, vw.golpe_status, '
            . 'pt.ataque, pt.defesa, pt.ataque_especial, pt.defesa_especial, pt.velocidade '
            . 'FROM vw_time_pokemon vw '
            . 'JOIN pokemon_time pt ON pt.id_pokemon_time = vw.id_pokemon_time '
            . 'WHERE vw.id_perfil = ? ORDER BY vw.posicao', [$perfil]
        )->fetchAll(PDO::FETCH_ASSOC);
        $pc = $this->sql(
            'SELECT pc.id_pokemon_pc, pc.id_pokemon_especie, pc.apelido, pe.nome AS nome_especie, '
            . 'COALESCE(NULLIF(TRIM(pc.apelido), \'\'), pe.nome) AS nome_exibicao, '
            . 'pe.imagem_url, pc.nivel, pc.hp_atual, pc.hp_max, '
            . 'pc.ataque, pc.defesa, pc.ataque_especial, pc.defesa_especial, pc.velocidade, '
            . 'CASE WHEN pc.hp_max > 0 THEN ROUND(pc.hp_atual * 100 / pc.hp_max) ELSE 0 END AS hp_percentual, '
            . 'pc.status, hi.nome AS item_equipado, gs.nome AS golpe_status '
            . 'FROM pokemon_pc pc '
            . 'JOIN pokemon_especie pe ON pe.id_pokemon_especie = pc.id_pokemon_especie '
            . 'LEFT JOIN held_item hi ON hi.id_held_item = pc.id_held_item '
            . 'LEFT JOIN golpe gs ON gs.id_golpe = pc.id_golpe_status '
            . 'WHERE pc.id_perfil = ? ORDER BY pc.id_pokemon_pc', [$perfil]
        )->fetchAll(PDO::FETCH_ASSOC);
        // Entidades do domínio: cada Pokémon agrega tipos que herdam de TipoPokemon.
        $ids = array_values(array_unique(array_merge(
            array_map('intval', array_column($time, 'id_pokemon_especie')),
            array_map('intval', array_column($pc, 'id_pokemon_especie'))
        )));
        $tiposPorEspecie = [];
        if ($ids) {
            $marcadores = implode(',', array_fill(0, count($ids), '?'));
            $linhas = $this->sql(
                "SELECT pet.id_pokemon_especie, t.nome FROM pokemon_especie_tipo pet "
                . "JOIN tipo t ON t.id_tipo = pet.id_tipo "
                . "WHERE pet.id_pokemon_especie IN ($marcadores) ORDER BY t.id_tipo", $ids
            )->fetchAll(PDO::FETCH_ASSOC);
            foreach ($linhas as $tipo) {
                $tiposPorEspecie[(int) $tipo['id_pokemon_especie']][] = new TipoElemental((string) $tipo['nome']);
            }
        }
        foreach ($time as &$p) {
            $p['tipos'] = $this->descreverTipos($p, $tiposPorEspecie);
        }
        unset($p);
        foreach ($pc as &$p) {
            $p['tipos'] = $this->descreverTipos($p, $tiposPorEspecie);
        }
        unset($p);
        return ['time' => $time, 'pc' => $pc, 'limite_time' => 6];
    }

    private function descreverTipos(array $linha, array $tiposPorEspecie): string
    {
        $tipos = $tiposPorEspecie[(int) $linha['id_pokemon_especie']] ?? [];
        if (!$tipos) return '';
        $pokemon = new Pokemon(
            (string) $linha['nome_especie'], (int) $linha['nivel'],
            (int) $linha['hp_max'], (int) $linha['hp_atual'],
            (int) $linha['ataque'], (int) $linha['defesa'],
            (int) $linha['ataque_especial'], (int) $linha['defesa_especial'],
            (int) $linha['velocidade'], (string) $linha['status'], ...$tipos
        );
        return $pokemon->descreverTipos();
    }

    public function movimentar(int $perfil, string $acao, ?int $idTime, ?int $idPc): array
    {
        if (!in_array($acao, ['guardar', 'retirar', 'trocar'], true)) {
            throw new ApiException('Ação desconhecida do PC.', 422);
        }
        $this->semBatalhaPendente($perfil);
        $this->conn->beginTransaction();
        try {
            // Mesmo bloqueio de perfil usado para controlar capturas e mudanças no time.
            $this->validarJornada($perfil, true);
            $time = $this->sql(
                'SELECT * FROM pokemon_time WHERE id_perfil = ? ORDER BY posicao FOR UPDATE', [$perfil]
            )->fetchAll(PDO::FETCH_ASSOC);
            $quantidade = count($time);
            $selecionado = null;
            if ($acao !== 'retirar') {
                foreach ($time as $pokemon) {
                    if ((int) $pokemon['id_pokemon_time'] === $idTime) {
                        $selecionado = $pokemon;
                        break;
                    }
                }
                if ($selecionado === null) {
                    throw new ApiException('Escolha um Pokémon da sua equipe.', 404);
                }
            }
            $armazenado = null;
            if ($acao !== 'guardar') {
                $armazenado = $this->sql(
                    'SELECT * FROM pokemon_pc WHERE id_perfil = ? AND id_pokemon_pc = ? FOR UPDATE',
                    [$perfil, $idPc]
                )->fetch(PDO::FETCH_ASSOC);
                if (!$armazenado) {
                    throw new ApiException('Escolha um Pokémon que está no seu PC.', 404);
                }
            }

            if ($acao === 'guardar') {
                if ($quantidade <= 1) {
                    throw new ApiException('Você deve manter pelo menos um Pokémon na equipe.', 422);
                }
                $this->guardarPokemon($selecionado);
                $this->excluirDoTime((int) $selecionado['id_pokemon_time'], $perfil);
                $this->fecharEspacoNaEquipe($perfil);
                $mensagem = 'Pokémon enviado ao PC com sucesso.';
            } elseif ($acao === 'retirar') {
                if ($quantidade >= 6) {
                    throw new ApiException('Sua equipe está completa. Escolha um integrante para trocar.', 422);
                }
                $ocupadas = array_map('intval', array_column($time, 'posicao'));
                $posicaoLivre = null;
                for ($i = 1; $i <= 6; $i++) {
                    if (!in_array($i, $ocupadas, true)) { $posicaoLivre = $i; break; }
                }
                if ($posicaoLivre === null) {
                    throw new ApiException('Equipe sem posição livre.', 409);
                }
                $this->retirarDoPc($armazenado, $posicaoLivre);
                $this->excluirDoPc((int) $armazenado['id_pokemon_pc'], $perfil);
                $mensagem = 'Pokémon retirado do PC e adicionado à equipe.';
            } else {
                // Troca simultânea mesmo com seis integrantes. Nenhum Pokémon é perdido.
                $posicao = (int) $selecionado['posicao'];
                $this->guardarPokemon($selecionado);
                $this->excluirDoTime((int) $selecionado['id_pokemon_time'], $perfil);
                $this->retirarDoPc($armazenado, $posicao);
                $this->excluirDoPc((int) $armazenado['id_pokemon_pc'], $perfil);
                $mensagem = 'Pokémon trocados entre a equipe e o PC.';
            }

            $this->sql(
                'INSERT INTO perfil_log (id_perfil, acao, descricao, detalhes) VALUES (?, ?, ?, ?)',
                [$perfil, 'PC_' . strtoupper($acao), $mensagem, json_encode([
                    'id_pokemon_time' => $idTime,
                    'id_pokemon_pc' => $idPc,
                ], JSON_UNESCAPED_UNICODE | JSON_THROW_ON_ERROR)]
            );
            $this->conn->commit();
            return ['message' => $mensagem];
        } catch (Throwable $e) {
            if ($this->conn->inTransaction()) $this->conn->rollBack();
            throw $e;
        }
    }

    private function guardarPokemon(array $pokemon): void
    {
        $this->sql(
            'INSERT INTO pokemon_pc (' . self::CAMPOS . ') '
            . 'SELECT ' . self::CAMPOS . ' FROM pokemon_time WHERE id_pokemon_time = ? AND id_perfil = ?',
            [(int) $pokemon['id_pokemon_time'], (int) $pokemon['id_perfil']]
        );
    }

    private function retirarDoPc(array $pokemon, int $posicao): void
    {
        $this->sql(
            'INSERT INTO pokemon_time (' . self::CAMPOS . ', posicao) '
            . 'SELECT ' . self::CAMPOS . ', ? FROM pokemon_pc WHERE id_pokemon_pc = ? AND id_perfil = ?',
            [$posicao, (int) $pokemon['id_pokemon_pc'], (int) $pokemon['id_perfil']]
        );
    }

    private function excluirDoTime(int $idTime, int $perfil): void
    {
        $this->sql('DELETE FROM pokemon_time WHERE id_pokemon_time = ? AND id_perfil = ?', [$idTime, $perfil]);
    }

    private function excluirDoPc(int $idPc, int $perfil): void
    {
        $this->sql('DELETE FROM pokemon_pc WHERE id_pokemon_pc = ? AND id_perfil = ?', [$idPc, $perfil]);
    }

    private function fecharEspacoNaEquipe(int $perfil): void
    {
        // Compacta as posições de maneira crescente: não colide com UNIQUE(perfil, posicao).
        $restantes = $this->sql(
            'SELECT id_pokemon_time, posicao FROM pokemon_time '
            . 'WHERE id_perfil = ? ORDER BY posicao FOR UPDATE', [$perfil]
        )->fetchAll(PDO::FETCH_ASSOC);
        $novaPosicao = 1;
        foreach ($restantes as $pokemon) {
            if ((int) $pokemon['posicao'] !== $novaPosicao) {
                $this->sql(
                    'UPDATE pokemon_time SET posicao = ? WHERE id_perfil = ? AND id_pokemon_time = ?',
                    [$novaPosicao, $perfil, (int) $pokemon['id_pokemon_time']]
                );
            }
            $novaPosicao++;
        }
    }

    private function validarJornada(int $perfil, bool $bloquear = false): void
    {
        $stmt = $this->sql(
            'SELECT id_perfil FROM perfil WHERE id_perfil = ?' . ($bloquear ? ' FOR UPDATE' : ''), [$perfil]
        );
        if (!$stmt->fetchColumn()) {
            throw new ApiException('Jornada não encontrada.', 404);
        }
    }

    private function semBatalhaPendente(int $perfil): void
    {
        $batalha = $_SESSION['batalha'] ?? null;
        if (is_array($batalha) && (int) ($batalha['id_perfil'] ?? 0) === $perfil
            && (!(bool) ($batalha['finalizada'] ?? false)
                || (bool) ($batalha['persistencia_pendente'] ?? false))) {
            throw new ApiException('Finalize a batalha em andamento antes de usar o PC.', 409);
        }
    }

    private function sql(string $query, array $params): PDOStatement
    {
        $stmt = $this->conn->prepare($query);
        $stmt->execute($params);
        return $stmt;
    }
}
