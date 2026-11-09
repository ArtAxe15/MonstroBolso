<?php

declare(strict_types=1);

namespace App\Models;

use PDO;

class User
{
    private PDO $conn;

    public function __construct(PDO $conn)
    {
        $this->conn = $conn;
    }

    public function findByNomeUsuario(string $nomeUsuario): ?array
    {
        $sql = 'SELECT * FROM usuario WHERE nome_usuario = :nome_usuario LIMIT 1';
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([':nome_usuario' => $nomeUsuario]);

        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        return $user ?: null;
    }

    public function create(string $nomeUsuario, string $senhaHash): bool
    {
        $sql = 'INSERT INTO usuario (nome_usuario, senha_hash, criado_em) VALUES (:nome_usuario, :senha_hash, NOW())';
        $stmt = $this->conn->prepare($sql);

        return $stmt->execute([
            ':nome_usuario' => $nomeUsuario,
            ':senha_hash' => $senhaHash,
        ]);
    }
}
