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
        $idPerfil = $this->perfilDaSessao();
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

    public function turn(): void
    {
        $idPerfil = $this->perfilDaSessao();
        $dados = json_decode(file_get_contents('php://input') ?: '', true);
        if (!is_array($dados)) {
            JsonResponse::send([
                'ok' => false,
                'message' => 'JSON inválido.',
            ], 400);
        }

        try {
            $resultado = $this->battleService->executarTurno($idPerfil, $dados);
        } catch (ApiException $e) {
            JsonResponse::send([
                'ok' => false,
                'message' => $e->getMessage(),
            ], $e->statusCode());
        }

        JsonResponse::send(['ok' => true] + $resultado);
    }

    private function perfilDaSessao(): int
    {
        $idUsuario = (int) ($_SESSION['usuario']['id_usuario'] ?? 0);
        $idPerfil = (int) ($_SESSION['perfil']['id_perfil'] ?? 0);
        if ($idUsuario <= 0 || $idPerfil <= 0) {
            JsonResponse::send([
                'ok' => false,
                'message' => 'Selecione uma jornada antes de continuar.',
            ], 401);
        }

        return $idPerfil;
    }
}
