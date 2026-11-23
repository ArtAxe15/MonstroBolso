<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Http\JsonResponse;
use App\Services\EncerramentoJornada;
use PDO;
use Throwable;

final class ProfileController
{
    public function __construct(private PDO $conn) {}

    private function usuarioId(): int
    {
        $id = (int) ($_SESSION['usuario']['id_usuario'] ?? 0);
        if ($id <= 0) {
            JsonResponse::send(['ok' => false, 'message' => 'Sua sessão expirou. Entre novamente.'], 401);
        }
        return $id;
    }

    private function dados(): array
    {
        $dados = json_decode(file_get_contents('php://input') ?: '', true);
        if (!is_array($dados)) {
            JsonResponse::send(['ok' => false, 'message' => 'JSON inválido.'], 400);
        }
        return $dados;
    }

    public function index(): void
    {
        $idUsuario = $this->usuarioId();
        $sql = 'SELECT p.id_perfil, p.nome, p.dinheiro, p.criado_em,
                       (SELECT COUNT(*) FROM pokemon_time pt WHERE pt.id_perfil = p.id_perfil) AS qtd_pokemon
                FROM perfil p WHERE p.id_usuario = :id_usuario ORDER BY p.criado_em, p.id_perfil';
        $stmt = $this->conn->prepare($sql);
        $stmt->execute(['id_usuario' => $idUsuario]);
        JsonResponse::send([
            'ok' => true,
            'perfis' => $stmt->fetchAll(),
            'limite' => 3,
            'perfil_ativo' => (int) ($_SESSION['perfil']['id_perfil'] ?? 0)
        ]);
    }

    public function create(): void
    {
        $idUsuario = $this->usuarioId();
        $dados = $this->dados();
        $nome = trim((string) ($dados['nome'] ?? ''));

        if ($nome === '' || mb_strlen($nome) < 2 || mb_strlen($nome) > 50) {
            JsonResponse::send(['ok' => false, 'message' => 'O nome da jornada deve ter entre 2 e 50 caracteres.'], 422);
        }

        try {
            $this->conn->beginTransaction();
            // Bloqueia a linha do usuário para impedir que duas criações simultâneas ultrapassem o limite.
            $lock = $this->conn->prepare('SELECT id_usuario FROM usuario WHERE id_usuario = :id FOR UPDATE');
            $lock->execute(['id' => $idUsuario]);
            if (!$lock->fetch()) {
                throw new \RuntimeException('Conta não encontrada.');
            }

            $count = $this->conn->prepare('SELECT COUNT(*) FROM perfil WHERE id_usuario = :id');
            $count->execute(['id' => $idUsuario]);
            if ((int) $count->fetchColumn() >= 3) {
                $this->conn->rollBack();
                JsonResponse::send(['ok' => false, 'message' => 'Você já possui o limite de 3 jornadas.'], 409);
            }

            $insert = $this->conn->prepare('INSERT INTO perfil (id_usuario, nome, dinheiro) VALUES (:usuario, :nome, 0)');
            $insert->execute(['usuario' => $idUsuario, 'nome' => $nome]);
            $idPerfil = (int) $this->conn->lastInsertId();

            $log = $this->conn->prepare("INSERT INTO perfil_log (id_perfil, acao, descricao) VALUES (:perfil, 'CRIACAO', 'Nova jornada criada.')");
            $log->execute(['perfil' => $idPerfil]);
            $this->conn->commit();

            $_SESSION['perfil'] = ['id_perfil' => $idPerfil, 'nome' => $nome];
            JsonResponse::send(['ok' => true, 'message' => 'Jornada criada!', 'id_perfil' => $idPerfil, 'proxima_etapa' => 'starter'], 201);
        } catch (Throwable $e) {
            if ($this->conn->inTransaction()) $this->conn->rollBack();
            throw $e;
        }
    }

    public function select(): void
    {
        $idUsuario = $this->usuarioId();
        $dados = $this->dados();
        $idPerfil = (int) ($dados['id_perfil'] ?? 0);
        if ($idPerfil <= 0) JsonResponse::send(['ok' => false, 'message' => 'Selecione uma jornada válida.'], 422);

        $stmt = $this->conn->prepare('SELECT id_perfil, nome FROM perfil WHERE id_perfil = :perfil AND id_usuario = :usuario');
        $stmt->execute(['perfil' => $idPerfil, 'usuario' => $idUsuario]);
        $perfil = $stmt->fetch();
        if (!$perfil) JsonResponse::send(['ok' => false, 'message' => 'Jornada não encontrada para esta conta.'], 404);

        $_SESSION['perfil'] = ['id_perfil' => (int) $perfil['id_perfil'], 'nome' => $perfil['nome']];
        unset($_SESSION['ultima_derrota']);
        $team = $this->conn->prepare('SELECT COUNT(*) FROM pokemon_time WHERE id_perfil = :perfil');
        $team->execute(['perfil' => $idPerfil]);
        $temInicial = (int) $team->fetchColumn() > 0;

        $campeao = $this->conn->prepare(
            "SELECT 1 FROM progresso_desafio pd JOIN desafio d ON d.id_desafio = pd.id_desafio
             WHERE pd.id_perfil = :perfil AND pd.concluido = 1 AND d.tipo = 'rival' LIMIT 1"
        );
        $campeao->execute(['perfil' => $idPerfil]);
        $concluida = (bool) $campeao->fetchColumn();

        JsonResponse::send([
            'ok' => true,
            'message' => 'Jornada selecionada.',
            'proxima_etapa' => $concluida ? 'champion' : ($temInicial ? 'map' : 'starter'),
            'perfil' => $_SESSION['perfil']
        ]);
    }

    public function delete(): void
    {
        $idUsuario = $this->usuarioId();
        $dados = $this->dados();
        $idPerfil = (int) ($dados['id_perfil'] ?? 0);
        if ($idPerfil <= 0) JsonResponse::send(['ok' => false, 'message' => 'Jornada inválida.'], 422);

        $check = $this->conn->prepare('SELECT id_perfil FROM perfil WHERE id_perfil = :perfil AND id_usuario = :usuario');
        $check->execute(['perfil' => $idPerfil, 'usuario' => $idUsuario]);
        if (!$check->fetch()) JsonResponse::send(['ok' => false, 'message' => 'Jornada não encontrada.'], 404);

        try {
            $this->conn->beginTransaction();
            // Preserva o histórico de batalhas no próprio batalha_log.
            (new EncerramentoJornada($this->conn))
                ->excluirPerfilPreservandoHistorico($idPerfil);
            $this->conn->commit();

            if ((int) ($_SESSION['perfil']['id_perfil'] ?? 0) === $idPerfil) unset($_SESSION['perfil']);
            JsonResponse::send(['ok' => true, 'message' => 'Jornada excluída.']);
        } catch (Throwable $e) {
            if ($this->conn->inTransaction()) $this->conn->rollBack();
            throw $e;
        }
    }
}
