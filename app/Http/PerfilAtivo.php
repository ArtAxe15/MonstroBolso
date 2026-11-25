<?php

declare(strict_types=1);

namespace App\Http;

use App\Models\Perfil;
use PDO;

final class PerfilAtivo
{
    public static function validar(PDO $conn): int
    {
        $idUsuario = (int) ($_SESSION['usuario']['id_usuario'] ?? 0);
        $idPerfil = (int) ($_SESSION['perfil']['id_perfil'] ?? 0);

        if ($idUsuario <= 0 || $idPerfil <= 0) {
            JsonResponse::send([
                'ok' => false,
                'message' => 'Selecione uma jornada antes de continuar.',
            ], 401);
        }

        if (!(new Perfil($conn))->pertenceAoUsuario($idPerfil, $idUsuario)) {
            unset($_SESSION['perfil']);
            JsonResponse::send([
                'ok' => false,
                'message' => 'A jornada ativa não pertence à sua conta.',
            ], 403);
        }

        return $idPerfil;
    }
}
