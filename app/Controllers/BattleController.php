<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Http\ApiException;
use App\Http\JsonResponse;
use App\Http\PerfilAtivo;
use App\Services\BattleService;
use PDO;

final class BattleController
{
    private BattleService $battleService;

    public function __construct(private PDO $conn)
    {
        $this->battleService = new BattleService($conn);
    }

    public function start(): void
    {
        $idPerfil = PerfilAtivo::validar($this->conn);
        $dados = json_decode(file_get_contents('php://input') ?: '', true);
        if (!is_array($dados)) {
            JsonResponse::send([
                'ok' => false,
                'message' => 'JSON inválido.',
            ], 400);
        }

        try {
            $batalha = $this->battleService->iniciar($idPerfil, $dados);
        } catch (ApiException $e) {
            JsonResponse::send([
                'ok' => false,
                'message' => $e->getMessage(),
            ], $e->statusCode());
        }

        JsonResponse::send([
            'ok' => true,
            'batalha' => $batalha,
        ]);
    }

    public function state(): void
    {
        $idPerfil = PerfilAtivo::validar($this->conn);
        $batalha = $this->battleService->obterEstado($idPerfil);
        if ($batalha === null) {
            JsonResponse::send([
                'ok' => false,
                'message' => 'Não há uma batalha em andamento nesta jornada.',
            ], 404);
        }

        JsonResponse::send([
            'ok' => true,
            'batalha' => $batalha,
        ]);
    }
}
