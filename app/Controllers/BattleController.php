<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Http\JsonResponse;
use App\Services\BattleService;
use PDO;
use RuntimeException;
use Throwable;

final class BattleController
{
    public function __construct(private PDO $conn) {}

    private function perfilAtivo(): int
    {
        $idUsuario = (int) ($_SESSION['usuario']['id_usuario'] ?? 0);
        $idPerfil = (int) ($_SESSION['perfil']['id_perfil'] ?? 0);

        if ($idUsuario <= 0 || $idPerfil <= 0) {
            JsonResponse::send(['ok' => false, 'message' => 'Selecione uma jornada antes de continuar.'], 401);
        }

        $stmt = $this->conn->prepare('SELECT id_perfil FROM perfil WHERE id_perfil = :perfil AND id_usuario = :usuario');
        $stmt->execute(['perfil' => $idPerfil, 'usuario' => $idUsuario]);

        if (!$stmt->fetch()) {
            unset($_SESSION['perfil']);
            JsonResponse::send(['ok' => false, 'message' => 'A jornada ativa não pertence à sua conta.'], 403);
        }

        return $idPerfil;
    }

    private function dados(): array
    {
        $dados = json_decode((string) (file_get_contents('php://input') ?: ''), true);

        if (!is_array($dados)) {
            JsonResponse::send(['ok' => false, 'message' => 'JSON inválido.'], 400);
        }

        return $dados;
    }

    public function start(): void
    {
        $idPerfil = $this->perfilAtivo();
        $dados = $this->dados();
        $idDesafio = (int) ($dados['id_desafio'] ?? 0);

        try {
            $resultado = BattleService::iniciarBatalha($this->conn, $idPerfil, $idDesafio);
            JsonResponse::send($resultado);
        } catch (Throwable $e) {
            $code = $e instanceof RuntimeException && $e->getCode() > 0 ? (int) $e->getCode() : 500;
            JsonResponse::send(['ok' => false, 'message' => $e->getMessage()], $code);
        }
    }

    public function state(): void
    {
        $this->perfilAtivo();

        try {
            JsonResponse::send(BattleService::obterEstadoAtual());
        } catch (Throwable $e) {
            $code = $e instanceof RuntimeException && $e->getCode() > 0 ? (int) $e->getCode() : 500;
            JsonResponse::send(['ok' => false, 'message' => $e->getMessage()], $code);
        }
    }

    public function turn(): void
    {
        $idPerfil = $this->perfilAtivo();
        $dados = $this->dados();

        try {
            $resultado = BattleService::executarTurno($this->conn, $idPerfil, $dados);
            JsonResponse::send($resultado);
        } catch (Throwable $e) {
            $code = $e instanceof RuntimeException && $e->getCode() > 0 ? (int) $e->getCode() : 500;
            JsonResponse::send(['ok' => false, 'message' => $e->getMessage()], $code);
        }
    }
}
