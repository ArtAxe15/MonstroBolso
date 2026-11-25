<?php

declare(strict_types=1);

namespace App\Models;

use PDO;

final class Perfil
{
    public function __construct(private PDO $conn)
    {
    }

    public function pertenceAoUsuario(int $idPerfil, int $idUsuario): bool
    {
        $stmt = $this->conn->prepare(
            'SELECT 1
             FROM perfil
             WHERE id_perfil = :perfil AND id_usuario = :usuario
             LIMIT 1'
        );
        $stmt->execute([
            'perfil' => $idPerfil,
            'usuario' => $idUsuario,
        ]);

        return $stmt->fetchColumn() !== false;
    }
}
