<?php

declare(strict_types=1);

namespace App\Models;

use App\Http\ApiException;
use PDO;
use PDOStatement;
use Throwable;

final class ServicosMapa
{
    public function __construct(private PDO $conn)
    {
    }

    public function catalogo(int $perfil, int $no): array
    {
        $this->localDisponivel($perfil, $no, 'POKEMART');
        return [
            'dinheiro' => $this->saldo($perfil),
            'itens' => $this->consulta(
                'SELECT i.id_item, i.nome, i.preco, i.descricao, COALESCE(inv.quantidade, 0) AS quantidade
                 FROM item i LEFT JOIN inventario inv ON inv.id_item = i.id_item AND inv.id_perfil = ?
                 ORDER BY i.categoria, i.nome',
                [$perfil]
            )->fetchAll(),
        ];
    }

    public function visitar(int $perfil, int $no, string $acao, ?int $item = null): array
    {
        $this->conn->beginTransaction();
        try {
            $saldo = $this->saldo($perfil, true);
            $etapa = $this->localDisponivel($perfil, $no, $acao === 'curar' ? 'CENTRO_POKEMON' : 'POKEMART', true);
            if ($acao === 'comprar') {
                $preco = $this->consulta('SELECT preco FROM item WHERE id_item = ?', [$item])->fetchColumn();
                if ($preco === false) {
                    throw new ApiException('Item não encontrado.', 404);
                }
                $preco = (int) $preco;
                if ($saldo < $preco) {
                    throw new ApiException('Saldo insuficiente.', 422);
                }
                $saldo -= $preco;
                $this->consulta('UPDATE perfil SET dinheiro = ? WHERE id_perfil = ?', [$saldo, $perfil]);
                $this->consulta(
                    'INSERT INTO inventario (id_perfil, id_item, quantidade) VALUES (?, ?, 1)
                     ON DUPLICATE KEY UPDATE quantidade = quantidade + 1',
                    [$perfil, $item]
                );
            } else {
                if ($acao === 'curar') {
                    $this->consulta(
                        "UPDATE pokemon_time SET hp_atual = hp_max, status = 'normal' WHERE id_perfil = ?",
                        [$perfil]
                    );
                }
                $this->concluir($perfil, $no, $etapa);
            }
            $this->conn->commit();
        } catch (Throwable $e) {
            if ($this->conn->inTransaction()) {
                $this->conn->rollBack();
            }
            throw $e;
        }

        return ['dinheiro' => $saldo];
    }

    private function concluir(int $perfil, int $no, int $etapa): void
    {
        $this->consulta(
            "UPDATE mapa_no SET status = 'CONCLUIDO', concluido_em = CURRENT_TIMESTAMP()
             WHERE id_mapa_no = ? AND id_perfil = ?",
            [$no, $perfil]
        );
        $this->consulta(
            "UPDATE mapa_no SET status = 'IGNORADO'
             WHERE id_perfil = ? AND etapa = ? AND status = 'DISPONIVEL'",
            [$perfil, $etapa]
        );
        $this->consulta(
            "UPDATE mapa_no destino
             JOIN mapa_conexao conexao ON conexao.id_mapa_no_destino = destino.id_mapa_no
             SET destino.status = 'DISPONIVEL'
             WHERE conexao.id_mapa_no_origem = ? AND destino.id_perfil = ? AND destino.status = 'BLOQUEADO'",
            [$no, $perfil]
        );
    }

    private function saldo(int $perfil, bool $bloquear = false): int
    {
        $saldo = $this->consulta(
            'SELECT dinheiro FROM perfil WHERE id_perfil = ?' . ($bloquear ? ' FOR UPDATE' : ''),
            [$perfil]
        )->fetchColumn();
        if ($saldo === false) {
            throw new ApiException('Jornada não encontrada.', 404);
        }
        return (int) $saldo;
    }

    private function localDisponivel(int $perfil, int $no, string $tipo, bool $bloquear = false): int
    {
        $local = $this->consulta(
            'SELECT etapa, status FROM mapa_no WHERE id_mapa_no = ? AND id_perfil = ? AND tipo_local = ?'
                . ($bloquear ? ' FOR UPDATE' : ''),
            [$no, $perfil, $tipo]
        )->fetch();
        if ($local === false) {
            throw new ApiException('Local não encontrado nesta jornada.', 404);
        }
        if ($local['status'] !== 'DISPONIVEL') {
            throw new ApiException('Este local não está disponível.', 409);
        }
        return (int) $local['etapa'];
    }

    private function consulta(string $sql, array $parametros): PDOStatement
    {
        $stmt = $this->conn->prepare($sql);
        $stmt->execute($parametros);
        return $stmt;
    }
}
