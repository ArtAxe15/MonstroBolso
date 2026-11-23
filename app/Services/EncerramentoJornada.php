<?php

declare(strict_types=1);

namespace App\Services;

use PDO;
use RuntimeException;

/**
 * Exclui a jornada sem apagar seus registros históricos de batalha.
 * As chamadas devem acontecer dentro de uma transação existente.
 * Requer a migração database/preservar_batalha_log.sql.
 */
final class EncerramentoJornada
{
    public function __construct(private PDO $conn) {}

    /** Usado após a derrota; não executa COMMIT. */
    public function encerrarPorDerrota(int $idPerfil): string
    {
        return $this->excluirPerfilPreservandoHistorico($idPerfil);
    }

    /** Também usado ao excluir uma jornada pela tela de perfis. */
    public function excluirPerfilPreservandoHistorico(int $idPerfil): string
    {
        if (!$this->conn->inTransaction()) {
            throw new RuntimeException('A exclusão da jornada requer uma transação ativa.');
        }

        $consulta = $this->conn->prepare(
            'SELECT nome FROM perfil WHERE id_perfil = :perfil FOR UPDATE'
        );
        $consulta->execute(['perfil' => $idPerfil]);
        $nome = $consulta->fetchColumn();
        if ($nome === false) {
            throw new RuntimeException('A jornada não foi encontrada.');
        }

        // Mantém a identidade da jornada no próprio batalha_log, mesmo
        // depois que a chave estrangeira id_perfil passar a ser NULL.
        $preservar = $this->conn->prepare(
            'UPDATE batalha_log
             SET id_perfil_original = COALESCE(id_perfil_original, id_perfil),
                 nome_jornada = COALESCE(nome_jornada, :nome)
             WHERE id_perfil = :perfil'
        );
        $preservar->execute(['nome' => (string) $nome, 'perfil' => $idPerfil]);

        // Compra continua vinculada ao perfil e precisa ser removida.
        $this->conn->prepare('DELETE FROM compra WHERE id_perfil = :perfil')
            ->execute(['perfil' => $idPerfil]);

        // A FK de batalha_log possui ON DELETE SET NULL. Não excluímos
        // batalha_log nem batalha_pokemon: ambos permanecem como histórico.
        $apagar = $this->conn->prepare('DELETE FROM perfil WHERE id_perfil = :perfil');
        $apagar->execute(['perfil' => $idPerfil]);
        if ($apagar->rowCount() !== 1) {
            throw new RuntimeException('Não foi possível excluir a jornada.');
        }

        return (string) $nome;
    }
}
