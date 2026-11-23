<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Http\ApiException;
use App\Http\JsonResponse;
use App\Http\PerfilAtivo;
use PDO;
use Throwable;

final class FinalController
{
    public function __construct(private PDO $conn) {}

    private function usuarioId(): int
    {
        $usuario = (int) ($_SESSION['usuario']['id_usuario'] ?? 0);
        if ($usuario < 1) {
            throw new ApiException('Faça login novamente.', 401);
        }
        return $usuario;
    }

    public function ultimaDerrota(): void
    {
        $this->usuarioId();
        $derrota = $_SESSION['ultima_derrota'] ?? null;
        if (!is_array($derrota)) {
            throw new ApiException('Nenhuma derrota recente nesta sessão.', 404);
        }
        JsonResponse::send(['ok' => true, 'derrota' => $derrota]);
    }

    public function reiniciar(): void
    {
        $usuario = $this->usuarioId();
        $derrota = $_SESSION['ultima_derrota'] ?? null;
        if (!is_array($derrota)) {
            throw new ApiException('Não há jornada derrotada para reiniciar.', 409);
        }
        $nome = trim((string) ($derrota['nome_jornada'] ?? ''));
        if ($nome === '') {
            throw new ApiException('O nome da jornada derrotada não está disponível.', 409);
        }

        try {
            $this->conn->beginTransaction();
            $lock = $this->conn->prepare('SELECT id_usuario FROM usuario WHERE id_usuario = :usuario FOR UPDATE');
            $lock->execute(['usuario' => $usuario]);
            if (!$lock->fetchColumn()) {
                throw new ApiException('Conta não encontrada.', 404);
            }
            $contar = $this->conn->prepare('SELECT COUNT(*) FROM perfil WHERE id_usuario = :usuario');
            $contar->execute(['usuario' => $usuario]);
            if ((int) $contar->fetchColumn() >= 3) {
                throw new ApiException('Limite de três jornadas atingido.', 409);
            }
            $criar = $this->conn->prepare(
                'INSERT INTO perfil (id_usuario, nome, dinheiro) VALUES (:usuario, :nome, 0)'
            );
            $criar->execute(['usuario' => $usuario, 'nome' => $nome]);
            $idPerfil = (int) $this->conn->lastInsertId();
            $this->conn->prepare(
                "INSERT INTO perfil_log (id_perfil, acao, descricao)
                 VALUES (:perfil, 'CRIACAO', 'Nova jornada criada após derrota.')"
            )->execute(['perfil' => $idPerfil]);
            $this->conn->commit();
        } catch (Throwable $e) {
            if ($this->conn->inTransaction()) $this->conn->rollBack();
            throw $e;
        }

        unset($_SESSION['ultima_derrota']);
        $_SESSION['perfil'] = ['id_perfil' => $idPerfil, 'nome' => $nome];
        JsonResponse::send([
            'ok' => true,
            'message' => 'Nova jornada criada. Escolha seu Pokémon inicial!',
            'perfil' => $_SESSION['perfil'],
            'proxima_etapa' => 'starter',
        ], 201);
    }

    public function campeao(): void
    {
        $this->usuarioId();
        $idPerfil = PerfilAtivo::validar($this->conn);
        $conquista = $this->conn->prepare(
            "SELECT 1 FROM progresso_desafio pd
             INNER JOIN desafio d ON d.id_desafio = pd.id_desafio
             WHERE pd.id_perfil = :perfil AND pd.concluido = 1 AND d.tipo = 'rival'
             LIMIT 1"
        );
        $conquista->execute(['perfil' => $idPerfil]);
        if (!$conquista->fetchColumn()) {
            throw new ApiException('Esta jornada ainda não derrotou o Rival.', 409);
        }

        $equipe = $this->conn->prepare(
            "SELECT pe.nome AS nome_especie, pt.apelido, pe.imagem_url,
                    pt.nivel, pt.hp_atual, pt.hp_max, pt.posicao,
                    GROUP_CONCAT(DISTINCT t.nome ORDER BY t.id_tipo SEPARATOR ', ') AS tipos
             FROM pokemon_time pt
             INNER JOIN pokemon_especie pe ON pe.id_pokemon_especie = pt.id_pokemon_especie
             LEFT JOIN pokemon_especie_tipo pet ON pet.id_pokemon_especie = pe.id_pokemon_especie
             LEFT JOIN tipo t ON t.id_tipo = pet.id_tipo
             WHERE pt.id_perfil = :perfil
             GROUP BY pt.id_pokemon_time, pe.nome, pt.apelido, pe.imagem_url,
                      pt.nivel, pt.hp_atual, pt.hp_max, pt.posicao
             ORDER BY pt.posicao"
        );
        $equipe->execute(['perfil' => $idPerfil]);
        $perfil = $this->conn->prepare('SELECT nome FROM perfil WHERE id_perfil = :perfil');
        $perfil->execute(['perfil' => $idPerfil]);
        JsonResponse::send([
            'ok' => true,
            'nome_jornada' => (string) $perfil->fetchColumn(),
            'equipe' => $equipe->fetchAll(PDO::FETCH_ASSOC),
        ]);
    }
}
