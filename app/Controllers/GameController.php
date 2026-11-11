<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Http\JsonResponse;
use PDO;
use Throwable;

final class GameController
{
    private const POSICOES_MAPA = [
        [270, 180], [730, 180], [500, 300],
        [160, 410], [390, 450], [650, 450], [840, 410],
        [270, 620], [730, 620], [500, 770]
    ];

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
        $dados = json_decode(file_get_contents('php://input') ?: '', true);
        if (!is_array($dados)) JsonResponse::send(['ok' => false, 'message' => 'JSON inválido.'], 400);
        return $dados;
    }

    public function starters(): void
    {
        $this->perfilAtivo();
        $stmt = $this->conn->query("SELECT pe.id_pokemon_especie, pe.nome, pe.imagem_url, pe.hp_base, pe.ataque_base, pe.defesa_base, pe.ataque_especial_base, pe.defesa_especial_base, pe.velocidade_base, GROUP_CONCAT(t.nome ORDER BY t.id_tipo SEPARATOR ', ') AS tipos FROM pokemon_especie pe LEFT JOIN pokemon_especie_tipo pet ON pet.id_pokemon_especie = pe.id_pokemon_especie LEFT JOIN tipo t ON t.id_tipo = pet.id_tipo WHERE pe.nome IN ('snivy','tepig','oshawott') GROUP BY pe.id_pokemon_especie ORDER BY FIELD(pe.nome,'snivy','tepig','oshawott')");
        JsonResponse::send(['ok' => true, 'iniciais' => $stmt->fetchAll()]);
    }

    public function chooseStarter(): void
    {
        $idPerfil = $this->perfilAtivo();
        $dados = $this->dados();
        $nome = strtolower(trim((string) ($dados['nome'] ?? '')));
        if (!in_array($nome, ['snivy', 'tepig', 'oshawott'], true)) {
            JsonResponse::send(['ok' => false, 'message' => 'Escolha Snivy, Tepig ou Oshawott.'], 422);
        }

        $check = $this->conn->prepare('SELECT COUNT(*) FROM pokemon_time WHERE id_perfil = :perfil');
        $check->execute(['perfil' => $idPerfil]);
        if ((int) $check->fetchColumn() > 0) {
            JsonResponse::send(['ok' => false, 'message' => 'Esta jornada já possui um Pokémon inicial.'], 409);
        }

        $stmt = $this->conn->prepare('SELECT * FROM pokemon_especie WHERE nome = :nome LIMIT 1');
        $stmt->execute(['nome' => $nome]);
        $pokemon = $stmt->fetch();
        if (!$pokemon) JsonResponse::send(['ok' => false, 'message' => 'Dados do Pokémon inicial não encontrados.'], 404);

        // Fórmula simplificada para gerar os atributos iniciais no nível 5.
        $nivel = 5;
        $hp = (int) floor((2 * (int) $pokemon['hp_base'] * $nivel) / 100) + $nivel + 10;
        $ataque = (int) floor((2 * (int) $pokemon['ataque_base'] * $nivel) / 100) + 5;
        $defesa = (int) floor((2 * (int) $pokemon['defesa_base'] * $nivel) / 100) + 5;
        $ataqueEsp = (int) floor((2 * (int) $pokemon['ataque_especial_base'] * $nivel) / 100) + 5;
        $defesaEsp = (int) floor((2 * (int) $pokemon['defesa_especial_base'] * $nivel) / 100) + 5;
        $velocidade = (int) floor((2 * (int) $pokemon['velocidade_base'] * $nivel) / 100) + 5;

        try {
            $this->conn->beginTransaction();
            $insert = $this->conn->prepare("
                INSERT INTO pokemon_time (
                    id_perfil,
                    id_pokemon_especie,
                    nivel,
                    hp_max,
                    hp_atual,
                    ataque,
                    defesa,
                    ataque_especial,
                    defesa_especial,
                    velocidade,
                    status,
                    posicao
                ) VALUES (
                    :perfil,
                    :especie,
                    5,
                    :hp_max,
                    :hp_atual,
                    :ataque,
                    :defesa,
                    :ataque_esp,
                    :defesa_esp,
                    :velocidade,
                    'normal',
                    1
                )
            ");

            $insert->execute([
                'perfil' => $idPerfil,
                'especie' => $pokemon['id_pokemon_especie'],
                'hp_max' => $hp,
                'hp_atual' => $hp,
                'ataque' => $ataque,
                'defesa' => $defesa,
                'ataque_esp' => $ataqueEsp,
                'defesa_esp' => $defesaEsp,
                'velocidade' => $velocidade
            ]);
            $this->conn->prepare("INSERT INTO perfil_log (id_perfil, acao, descricao, detalhes) VALUES (:perfil, 'INICIAL_ESCOLHIDO', 'Pokémon inicial escolhido.', :detalhes)")
                ->execute(['perfil' => $idPerfil, 'detalhes' => json_encode(['pokemon' => $nome], JSON_UNESCAPED_UNICODE)]);
            $this->gerarMapaSeNecessario($idPerfil);
            $this->conn->commit();
        } catch (Throwable $e) {
            if ($this->conn->inTransaction()) $this->conn->rollBack();
            throw $e;
        }

        JsonResponse::send(['ok' => true, 'message' => 'Inicial escolhido! Sua jornada começou.', 'proxima_etapa' => 'map']);
    }

    private function gerarMapaSeNecessario(int $idPerfil): void
    {
        $check = $this->conn->prepare('SELECT COUNT(*) FROM npc_mapa WHERE id_perfil = :perfil');
        $check->execute(['perfil' => $idPerfil]);
        if ((int) $check->fetchColumn() > 0) return;

        $tipos = $this->conn->query('SELECT id_npc_tipo FROM npc_tipo ORDER BY id_npc_tipo')->fetchAll(PDO::FETCH_COLUMN);
        if (!$tipos) throw new \RuntimeException('Nenhum tipo de treinador NPC foi cadastrado.');
        $posicoes = self::POSICOES_MAPA;
        shuffle($tipos);
        shuffle($posicoes);

        $insert = $this->conn->prepare('INSERT INTO npc_mapa (id_perfil, id_npc_tipo, posicao_x, posicao_y, ordem) VALUES (:perfil, :tipo, :x, :y, :ordem)');
        for ($i = 0; $i < count(self::POSICOES_MAPA); $i++) {
            $tipo = $tipos[$i % count($tipos)];
            $insert->execute([
                'perfil' => $idPerfil, 'tipo' => $tipo,
                'x' => $posicoes[$i][0], 'y' => $posicoes[$i][1], 'ordem' => $i + 1
            ]);
        }
    }

    public function map(): void
    {
        $idPerfil = $this->perfilAtivo();
        $teamCheck = $this->conn->prepare('SELECT COUNT(*) FROM pokemon_time WHERE id_perfil = :perfil');
        $teamCheck->execute(['perfil' => $idPerfil]);
        if ((int) $teamCheck->fetchColumn() === 0) {
            JsonResponse::send(['ok' => true, 'proxima_etapa' => 'starter']);
        }

        try {
            $this->conn->beginTransaction();
            $this->gerarMapaSeNecessario($idPerfil);
            $this->conn->commit();
        } catch (Throwable $e) {
            if ($this->conn->inTransaction()) $this->conn->rollBack();
            throw $e;
        }

        $perfilStmt = $this->conn->prepare('SELECT nome, dinheiro FROM perfil WHERE id_perfil = :perfil');
        $perfilStmt->execute(['perfil' => $idPerfil]);
        $perfil = $perfilStmt->fetch();

        $teamStmt = $this->conn->prepare('SELECT id_pokemon_time, nome_especie, nome_exibicao, imagem_url, nivel, hp_atual, hp_max, hp_percentual, status FROM vw_time_pokemon WHERE id_perfil = :perfil ORDER BY posicao');
        $teamStmt->execute(['perfil' => $idPerfil]);

        $npcStmt = $this->conn->prepare('SELECT nm.id_npc_mapa, nm.posicao_x, nm.posicao_y, nm.ordem, nm.derrotado, nt.id_npc_tipo, t.nome AS tipo_nome, nt.descricao FROM npc_mapa nm JOIN npc_tipo nt ON nt.id_npc_tipo = nm.id_npc_tipo JOIN tipo t ON t.id_tipo = nt.id_tipo WHERE nm.id_perfil = :perfil ORDER BY nm.ordem');
        $npcStmt->execute(['perfil' => $idPerfil]);

        JsonResponse::send([
            'ok' => true,
            'perfil' => ['id_perfil' => $idPerfil, 'nome' => $perfil['nome'], 'dinheiro' => (int) $perfil['dinheiro']],
            'time' => $teamStmt->fetchAll(),
            'npc' => $npcStmt->fetchAll()
        ]);
    }
}
