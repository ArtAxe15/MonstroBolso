<?php
declare(strict_types=1);

namespace App\Models;

use PDO;

final class User
{
    public function __construct(
        private PDO $conn
    ) {
    }

    /**
     * Busca um usuário pelo nome cadastrado.
     */
    public function findByNomeUsuario(string $nomeUsuario): ?array
    {
        $sql = '
            SELECT
                id_usuario,
                nome_usuario,
                senha_hash,
                criado_em
            FROM usuario
            WHERE nome_usuario = :nome_usuario
            LIMIT 1
        ';

        $stmt = $this->conn->prepare($sql);
        $stmt->bindValue(':nome_usuario', $nomeUsuario, PDO::PARAM_STR);
        $stmt->execute();

        $usuario = $stmt->fetch();

        return $usuario === false ? null : $usuario;
    }

    /**
     * Cria um usuário usando o hash de senha já produzido pelo Controller.
     */
    public function create(string $nomeUsuario, string $senhaHash): bool
    {
        $sql = '
            INSERT INTO usuario (nome_usuario, senha_hash)
            VALUES (:nome_usuario, :senha_hash)
        ';

        $stmt = $this->conn->prepare($sql);
        $stmt->bindValue(':nome_usuario', $nomeUsuario, PDO::PARAM_STR);
        $stmt->bindValue(':senha_hash', $senhaHash, PDO::PARAM_STR);

        return $stmt->execute();
    }
}
