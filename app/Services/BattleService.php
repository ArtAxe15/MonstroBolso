<?php

declare(strict_types=1);

namespace App\Services;

use InvalidArgumentException;
use PDO;
use RuntimeException;

final class BattleService
{
    public const RECOMPENSA_MOEDAS = 300;
    public const NIVEIS_POR_VITORIA = 2;
    public const NIVEL_MAXIMO = 100;

    public static function iniciarBatalha(PDO $conn, int $idPerfil, int $idDesafio): array
    {
        self::iniciarSessaoSeNecessario();

        if ($idDesafio <= 0) {
            throw new InvalidArgumentException('Desafio inválido.', 400);
        }

        $timeJogador = self::montarTimeJogador($conn, $idPerfil);
        $timeOponente = self::montarTimeOponente($conn, $idDesafio);

        if ($timeJogador === []) {
            throw new RuntimeException('O jogador não possui Pokémon vivos para batalhar.', 409);
        }

        if ($timeOponente === []) {
            throw new RuntimeException('O desafio informado não possui Pokémon registrados.', 404);
        }

        $battle = [
            'id_batalha' => null,
            'id_desafio' => $idDesafio,
            'id_perfil' => $idPerfil,
            'jogador' => [
                'time' => $timeJogador,
                'ativo' => self::indicePrimeiroVivo($timeJogador),
            ],
            'oponente' => [
                'time' => $timeOponente,
                'ativo' => self::indicePrimeiroVivo($timeOponente),
            ],
            'aguardando_troca' => false,
            'fim' => null,
            'resultado' => null,
            'eventos' => [],
            'turnos' => 0,
            'persistida' => false,
            'itens' => self::listarItensUtilizaveis($conn, $idPerfil),
        ];

        $_SESSION['batalha'] = $battle;

        return self::respostaEstado($battle);
    }

    public static function obterEstadoAtual(): array
    {
        self::iniciarSessaoSeNecessario();

        if (!isset($_SESSION['batalha']) || !is_array($_SESSION['batalha'])) {
            throw new RuntimeException('Batalha inexistente.', 409);
        }

        return self::respostaEstado($_SESSION['batalha']);
    }

    public static function executarTurno(PDO $conn, int $idPerfil, array $dados): array
    {
        self::iniciarSessaoSeNecessario();

        if (!isset($_SESSION['batalha']) || !is_array($_SESSION['batalha'])) {
            throw new RuntimeException('Batalha inexistente.', 409);
        }

        $battle = $_SESSION['batalha'];

        if ($battle['fim'] !== null) {
            throw new RuntimeException('A batalha já foi finalizada.', 409);
        }

        $acao = strtolower(trim((string) ($dados['acao'] ?? '')));

        if ($acao === 'item') {
            $idItem = (int) ($dados['id_item'] ?? 0);
            $alvoPosicao = (int) ($dados['alvo_posicao'] ?? 0);
            $battle = self::processarItem($conn, $battle, $idPerfil, $idItem, $alvoPosicao);
            $_SESSION['batalha'] = $battle;

            if ($battle['fim'] === null && self::ladoTemAtivoVivo($battle, 'INIMIGO')) {
                $acaoBot = self::acaoBotInimigo(self::pokemonAtivo($battle, 'INIMIGO'));
                if ($acaoBot !== null) {
                    self::aplicarGolpeEmBattle($battle, 'INIMIGO', $acaoBot);
                }
            }

            self::processarTurnoStatus($battle);
            $_SESSION['batalha'] = $battle;
            return self::respostaEstado($battle);
        }

        if ($acao === 'trocar') {
            $posicao = (int) ($dados['posicao'] ?? 0);
            $battle = self::processarTroca($battle, $posicao);
            $_SESSION['batalha'] = $battle;
            return self::respostaEstado($battle);
        }

        if ($acao === 'golpe') {
            $slot = (int) ($dados['slot'] ?? -1);
            $battle = self::processarGolpeJogador($battle, $slot);
            $_SESSION['batalha'] = $battle;

            if (!$battle['persistida'] && $battle['fim'] !== null) {
                self::finalizarBatalha($conn, $idPerfil, $battle);
                $_SESSION['batalha'] = $battle;
            }

            return self::respostaEstado($battle);
        }

        throw new InvalidArgumentException('Ação inválida.', 400);
    }

    private static function listarItensUtilizaveis(PDO $conn, int $idPerfil): array
    {
        $stmt = $conn->prepare('
            SELECT i.id_item, i.nome, i.categoria, i.tipo_efeito, i.valor_efeito, inv.quantidade
            FROM inventario inv
            JOIN item i ON i.id_item = inv.id_item
            WHERE inv.id_perfil = :perfil
              AND inv.quantidade > 0
              AND i.categoria IN (\'HP\', \'HP_STATUS\', \'STATUS\')
            ORDER BY i.nome ASC
        ');
        $stmt->execute(['perfil' => $idPerfil]);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    private static function processarItem(PDO $conn, array $battle, int $idPerfil, int $idItem, int $alvoPosicao): array
    {
        if ($idItem <= 0) {
            throw new InvalidArgumentException('Item inválido.', 400);
        }

        $item = self::obterItemInventario($conn, $idPerfil, $idItem);
        if ($item === null) {
            throw new InvalidArgumentException('Você não possui este item.', 400);
        }

        $alvo = self::acharPokemonPorPosicao($battle['jogador']['time'], $alvoPosicao);
        if ($alvo === null) {
            throw new InvalidArgumentException('Posição de alvo inválida.', 400);
        }

        if ((int) ($alvo['hp_atual'] ?? 0) <= 0) {
            throw new InvalidArgumentException('O Pokémon alvo está desmaiado.', 400);
        }

        $conn->beginTransaction();
        try {
            $stmt = $conn->prepare('UPDATE inventario SET quantidade = quantidade - 1 WHERE id_perfil = :perfil AND id_item = :item AND quantidade > 0');
            $stmt->execute(['perfil' => $idPerfil, 'item' => $idItem]);

            if ($stmt->rowCount() !== 1) {
                throw new RuntimeException('Não foi possível consumir o item.', 409);
            }

            $valorEfeito = (int) ($item['valor_efeito'] ?? 0);
            $tipoEfeito = (string) ($item['tipo_efeito'] ?? 'ABSOLUTO');
            $categoria = (string) ($item['categoria'] ?? 'HP');

            if ($categoria === 'HP' || $categoria === 'HP_STATUS') {
                $cura = $tipoEfeito === 'PERCENTUAL'
                    ? (int) ceil(((int) ($alvo['hp_max'] ?? 0) * $valorEfeito) / 100)
                    : $valorEfeito;

                $novoHp = min((int) ($alvo['hp_max'] ?? 0), (int) ($alvo['hp_atual'] ?? 0) + $cura);
                $alvo['hp_atual'] = $novoHp;
                $battle['jogador']['time'][self::indicePokemon($battle['jogador']['time'], $alvo['nome'], $alvo['posicao'])] = $alvo;
            }

            $statusAtual = self::normalizarStatusNome((string) ($alvo['status'] ?? 'normal'));
            $statusCurado = false;
            if ($categoria === 'STATUS' || $categoria === 'HP_STATUS') {
                $statusCurado = self::curarStatusPokemon($conn, $alvo, (int) $idItem);
                $alvo['status'] = $statusCurado === true ? 'normal' : $statusAtual;
                $battle['jogador']['time'][self::indicePokemon($battle['jogador']['time'], $alvo['nome'], $alvo['posicao'])] = $alvo;
            }

            $battle['eventos'][] = [
                'tipo' => 'item_usado',
                'lado' => 'JOGADOR',
                'item' => (string) ($item['nome'] ?? 'Item'),
                'alvo' => $alvo['nome'],
                'categoria' => $categoria,
            ];

            if ($statusCurado === true) {
                $battle['eventos'][] = [
                    'tipo' => 'status_curado',
                    'lado' => 'JOGADOR',
                    'pokemon' => $alvo['nome'],
                    'status' => $statusAtual,
                ];
            }
            $battle['itens'] = self::listarItensUtilizaveis($conn, $idPerfil);

            $conn->commit();
        } catch (\Throwable $e) {
            if ($conn->inTransaction()) {
                $conn->rollBack();
            }
            throw $e;
        }

        return $battle;
    }

    private static function obterItemInventario(PDO $conn, int $idPerfil, int $idItem): ?array
    {
        $stmt = $conn->prepare('
            SELECT i.id_item, i.nome, i.categoria, i.tipo_efeito, i.valor_efeito, inv.quantidade
            FROM inventario inv
            JOIN item i ON i.id_item = inv.id_item
            WHERE inv.id_perfil = :perfil AND inv.id_item = :item AND inv.quantidade > 0
            LIMIT 1
        ');
        $stmt->execute(['perfil' => $idPerfil, 'item' => $idItem]);

        $item = $stmt->fetch(PDO::FETCH_ASSOC);
        return $item ?: null;
    }

    private static function curarStatusPokemon(PDO $conn, array &$pokemon, int $idItem): bool
    {
        $stmt = $conn->prepare('SELECT id_status FROM item_status_cura WHERE id_item = :item');
        $stmt->execute(['item' => $idItem]);
        $statusCura = array_map('intval', array_column($stmt->fetchAll(PDO::FETCH_ASSOC), 'id_status'));

        if ($statusCura === []) {
            return false;
        }

        $statusAtivo = self::normalizarStatusNome((string) ($pokemon['status'] ?? 'normal'));
        $statusAplicavel = self::statusNomePorId($statusCura);

        if (!in_array($statusAtivo, $statusAplicavel, true)) {
            return false;
        }

        $pokemon['status'] = 'normal';
        return true;
    }

    private static function statusNomePorId(array $ids): array
    {
        $mapeado = [];
        foreach ($ids as $id) {
            $nome = self::nomeStatusPorId((int) $id);
            if ($nome !== '') {
                $mapeado[] = $nome;
            }
        }

        return $mapeado;
    }

    public static function simularPartida(array $jogadorTime, array $oponenteTime, array $opcoes = []): array
    {
        $battle = [
            'id_batalha' => null,
            'id_desafio' => null,
            'id_perfil' => 0,
            'jogador' => ['time' => self::normalizarTimeSimulado($jogadorTime), 'ativo' => 0],
            'oponente' => ['time' => self::normalizarTimeSimulado($oponenteTime), 'ativo' => 0],
            'aguardando_troca' => false,
            'fim' => null,
            'resultado' => null,
            'eventos' => [],
            'turnos' => 0,
            'persistida' => false,
            'itens' => [],
        ];

        $battle['jogador']['ativo'] = self::indicePrimeiroVivo($battle['jogador']['time']);
        $battle['oponente']['ativo'] = self::indicePrimeiroVivo($battle['oponente']['time']);

        $maxTurnos = (int) ($opcoes['max_turnos'] ?? 80);

        while ($battle['fim'] === null && $battle['turnos'] < $maxTurnos) {
            $battle['turnos']++;

            $acaoJogador = self::acaoBotJogador($battle['jogador']['time'][$battle['jogador']['ativo']]);
            $acaoBot = self::acaoBotInimigo($battle['oponente']['time'][$battle['oponente']['ativo']]);
            $acoes = [
                ['lado' => 'JOGADOR', 'atacante' => $battle['jogador']['time'][$battle['jogador']['ativo']], 'golpe' => $acaoJogador],
                ['lado' => 'INIMIGO', 'atacante' => $battle['oponente']['time'][$battle['oponente']['ativo']], 'golpe' => $acaoBot],
            ];

            usort($acoes, static fn (array $a, array $b): int => self::compararAtaques($a, $b));

            foreach ($acoes as $acao) {
                if ($battle['fim'] !== null) {
                    break;
                }

                if (!self::ladoTemAtivoVivo($battle, $acao['lado'])) {
                    continue;
                }

                if (!self::pokemonPodeAgir($battle, $acao['lado'])) {
                    continue;
                }

                $quebraram = self::aplicarGolpeEmBattle($battle, $acao['lado'], $acao['golpe']);
                if ($quebraram) {
                    break;
                }
            }

            self::processarTurnoStatus($battle);
        }

        if ($battle['fim'] === null) {
            $battle['fim'] = 'EMPATE';
            $battle['resultado'] = ['vencedor' => 'EMPATE', 'status' => 'EMPATE'];
            $battle['eventos'][] = ['tipo' => 'fim', 'lado' => 'SISTEMA', 'resultado' => 'EMPATE'];
        }

        $totalGolpes = 0;
        $totalDano = 0;
        foreach ($battle['eventos'] as $evento) {
            if (($evento['tipo'] ?? '') !== 'golpe') {
                continue;
            }

            $totalGolpes++;
            $totalDano += (int) ($evento['dano'] ?? 0);
        }

        $danoMedio = $totalGolpes > 0 ? $totalDano / $totalGolpes : 0.0;

        return [
            'turnos' => $battle['turnos'],
            'resultado' => $battle['resultado'],
            'eventos' => $battle['eventos'],
            'balance' => [
                'total_golpes' => $totalGolpes,
                'dano_medio' => round($danoMedio, 2),
            ],
            'estado' => self::serializarEstado($battle),
        ];
    }

    private static function normalizarTimeSimulado(array $time): array
    {
        $lista = [];

        foreach ($time as $index => $pokemon) {
            $hpMax = (int) ($pokemon['hp_max'] ?? 0);
            if ($hpMax <= 0) {
                $hpMax = (int) ($pokemon['hp_atual'] ?? 0);
            }

            $lista[] = [
                'id' => $pokemon['id'] ?? ($index + 1),
                'id_pokemon_especie' => $pokemon['id_pokemon_especie'] ?? ($index + 1),
                'nome' => (string) ($pokemon['nome'] ?? 'Pokemon'),
                'apelido' => $pokemon['apelido'] ?? null,
                'nivel' => (int) ($pokemon['nivel'] ?? 1),
                'hp_atual' => max(0, (int) ($pokemon['hp_atual'] ?? $hpMax)),
                'hp_max' => max(0, $hpMax),
                'status' => (string) ($pokemon['status'] ?? 'normal'),
                'posicao' => (int) ($pokemon['posicao'] ?? ($index + 1)),
                'ataque' => (int) ($pokemon['ataque'] ?? 1),
                'defesa' => (int) ($pokemon['defesa'] ?? 1),
                'ataque_especial' => (int) ($pokemon['ataque_especial'] ?? 1),
                'defesa_especial' => (int) ($pokemon['defesa_especial'] ?? 1),
                'velocidade' => (int) ($pokemon['velocidade'] ?? 1),
                'tipos' => $pokemon['tipos'] ?? [],
                'estagios' => [
                    'ATAQUE' => 0,
                    'DEFESA' => 0,
                    'ATAQUE_ESPECIAL' => 0,
                    'DEFESA_ESPECIAL' => 0,
                    'VELOCIDADE' => 0,
                ],
                'golpes' => self::normalizarGolpes($pokemon['golpes'] ?? []),
            ];
        }

        return $lista;
    }

    private static function normalizarGolpes(array $golpes): array
    {
        $lista = [];

        foreach ($golpes as $golpe) {
            $lista[] = [
                'id_golpe' => (int) ($golpe['id_golpe'] ?? 0),
                'nome' => (string) ($golpe['nome'] ?? 'Golpe'),
                'categoria' => (string) ($golpe['categoria'] ?? 'DANO'),
                'classe_dano' => (string) ($golpe['classe_dano'] ?? 'physical'),
                'poder' => (int) ($golpe['poder'] ?? 0),
                'precisao' => $golpe['precisao'] ?? null,
                'prioridade' => (int) ($golpe['prioridade'] ?? 0),
                'id_tipo' => (int) ($golpe['id_tipo'] ?? 1),
                'tipo_nome' => (string) ($golpe['tipo_nome'] ?? 'Normal'),
                'efeitos' => self::normalizarEfeitos($golpe['efeitos'] ?? []),
            ];
        }

        return $lista;
    }

    private static function normalizarEfeitos(array $efeitos): array
    {
        $lista = [];
        foreach ($efeitos as $efeito) {
            $lista[] = [
                'tipo_efeito' => (string) ($efeito['tipo_efeito'] ?? 'APLICAR_STATUS'),
                'alvo' => (string) ($efeito['alvo'] ?? 'OPONENTE'),
                'id_status' => (int) ($efeito['id_status'] ?? 0),
                'atributo' => (string) ($efeito['atributo'] ?? ''),
                'alteracao' => (int) ($efeito['alteracao'] ?? 0),
                'percentual' => (int) ($efeito['percentual'] ?? 0),
                'chance' => (int) ($efeito['chance'] ?? 100),
            ];
        }

        return $lista;
    }

    private static function processarTroca(array $battle, int $posicao): array
    {
        $jogadorAtivo = self::pokemonAtivo($battle, 'JOGADOR');
        if ($jogadorAtivo === null) {
            throw new RuntimeException('Não há Pokémon ativo para trocar.', 409);
        }

        $alvo = self::acharPokemonPorPosicao($battle['jogador']['time'], $posicao);
        if ($alvo === null) {
            throw new InvalidArgumentException('Posição de troca inválida.', 400);
        }

        if ((int) ($alvo['hp_atual'] ?? 0) <= 0) {
            throw new InvalidArgumentException('O Pokémon escolhido está desmaiado.', 400);
        }

        $indiceAtual = (int) ($battle['jogador']['ativo'] ?? 0);
        $indiceAlvo = (int) ($alvo['posicao'] ?? 1) - 1;
        if ($indiceAtual === $indiceAlvo) {
            throw new InvalidArgumentException('O Pokémon já está ativo.', 400);
        }

        $eventos = $battle['eventos'];
        $eventos[] = [
            'tipo' => 'trocou',
            'lado' => 'JOGADOR',
            'pokemon' => $alvo['nome'],
            'de' => $jogadorAtivo['nome'],
            'para' => $alvo['nome'],
        ];
        $battle['eventos'] = $eventos;
        $battle['jogador']['ativo'] = $indiceAlvo;
        $battle['aguardando_troca'] = false;

        if ($battle['fim'] !== null) {
            return $battle;
        }

        $botAtivo = self::pokemonAtivo($battle, 'INIMIGO');
        if ($botAtivo !== null && self::ladoTemAtivoVivo($battle, 'INIMIGO')) {
            $golpeBot = self::acaoBotInimigo($botAtivo);
            if ($golpeBot !== null) {
                self::aplicarGolpeEmBattle($battle, 'INIMIGO', $golpeBot);
            }
        }

        return $battle;
    }

    private static function processarGolpeJogador(array $battle, int $slot): array
    {
        if ($battle['aguardando_troca']) {
            $battle['aguardando_troca'] = false;
            return $battle;
        }

        if (!self::pokemonPodeAgir($battle, 'JOGADOR')) {
            return $battle;
        }

        $jogadorAtivo = self::pokemonAtivo($battle, 'JOGADOR');
        if ($jogadorAtivo === null) {
            throw new RuntimeException('Seu time não possui mais Pokémon válidos.', 409);
        }

        $golpe = self::obterGolpePorSlot($jogadorAtivo, $slot);
        if ($golpe === null) {
            throw new InvalidArgumentException('Golpe inválido para este Pokémon.', 400);
        }

        $acaoJogador = ['lado' => 'JOGADOR', 'atacante' => $jogadorAtivo, 'golpe' => $golpe];
        $acaoBot = self::acaoBotInimigo(self::pokemonAtivo($battle, 'INIMIGO'));

        $acoes = [$acaoJogador];
        if (self::ladoTemAtivoVivo($battle, 'INIMIGO') && $acaoBot !== null) {
            $acoes[] = ['lado' => 'INIMIGO', 'atacante' => self::pokemonAtivo($battle, 'INIMIGO'), 'golpe' => $acaoBot];
        }

        usort($acoes, static fn (array $a, array $b): int => self::compararAtaques($a, $b));

        foreach ($acoes as $acao) {
            if ($battle['fim'] !== null) {
                break;
            }

            $lado = $acao['lado'];
            if (!self::ladoTemAtivoVivo($battle, $lado)) {
                continue;
            }

            $quebrou = self::aplicarGolpeEmBattle($battle, $lado, $acao['golpe']);
            if ($quebrou) {
                break;
            }
        }

        self::processarTurnoStatus($battle);

        return $battle;
    }

    private static function aplicarGolpeEmBattle(array &$battle, string $lado, array $golpe): bool
    {
        $atacante = self::pokemonAtivo($battle, $lado);
        $alvoLado = $lado === 'JOGADOR' ? 'INIMIGO' : 'JOGADOR';
        $alvo = self::pokemonAtivo($battle, $alvoLado);

        if ($atacante === null || $alvo === null || $golpe === []) {
            return false;
        }

        $ladoChave = self::chaveLado($lado);
        $alvoChave = self::chaveLado($alvoLado);
        $alvoAntes = (int) $alvo['hp_atual'];
        $errou = !self::golpeAcerta($golpe);
        $efetividade = 1.0;
        $critico = false;
        $dano = 0;

        if (!$errou) {
            $critico = self::ehCritico();
            $efetividade = self::calcularEfetividade(null, $atacante, $alvo, $golpe);
            $dano = self::calcularDano($atacante, $alvo, $golpe, $critico, $efetividade);
            $novoHp = max(0, $alvo['hp_atual'] - $dano);
            $alvo['hp_atual'] = $novoHp;
            $alvo['status'] = $novoHp <= 0 ? 'desmaiado' : 'normal';
            $battle[$alvoChave]['time'][$battle[$alvoChave]['ativo']] = $alvo;
        }

        $battle['eventos'][] = [
            'tipo' => 'golpe',
            'lado' => $lado,
            'golpe' => $golpe['nome'],
            'errou' => $errou,
            'critico' => $critico,
            'efetividade' => round($efetividade, 2),
            'dano' => $dano,
            'hp_alvo_antes' => $alvoAntes,
            'hp_alvo_depois' => max(0, (int) $alvo['hp_atual']),
        ];

        self::processarEfeitosDoGolpe($battle, $lado, $alvoLado, $golpe, $dano, $efetividade);

        if ($alvo['hp_atual'] <= 0) {
            $battle['eventos'][] = [
                'tipo' => 'desmaiou',
                'lado' => $alvoLado,
                'pokemon' => $alvo['nome'],
            ];

            $proximo = self::proximoVivo($battle[$alvoChave]['time'], $battle[$alvoChave]['ativo']);
            if ($proximo !== null) {
                $battle[$alvoChave]['ativo'] = $proximo;
                $battle['eventos'][] = [
                    'tipo' => 'entrou',
                    'lado' => $alvoLado,
                    'pokemon' => $battle[$alvoChave]['time'][$proximo]['nome'],
                ];
            } else {
                $battle['fim'] = $lado === 'JOGADOR' ? 'VITORIA' : 'DERROTA';
                $battle['resultado'] = [
                    'vencedor' => $lado === 'JOGADOR' ? 'JOGADOR' : 'INIMIGO',
                    'status' => $battle['fim'],
                ];
                $battle['eventos'][] = ['tipo' => 'fim', 'lado' => $lado, 'resultado' => $battle['fim']];
                return true;
            }

            if ($lado === 'INIMIGO') {
                $battle['aguardando_troca'] = true;
                return true;
            }

            return true;
        }

        return false;
    }

    private static function compararAtaques(array $a, array $b): int
    {
        $prioridadeA = (int) ($a['golpe']['prioridade'] ?? 0);
        $prioridadeB = (int) ($b['golpe']['prioridade'] ?? 0);

        if ($prioridadeA !== $prioridadeB) {
            return $prioridadeB <=> $prioridadeA;
        }

        $velocidadeA = (int) ($a['atacante']['velocidade'] ?? 0);
        $velocidadeB = (int) ($b['atacante']['velocidade'] ?? 0);

        if ($velocidadeA !== $velocidadeB) {
            return $velocidadeB <=> $velocidadeA;
        }

        return random_int(0, 1) === 0 ? -1 : 1;
    }

    private static function acaoBotJogador(array $pokemon): ?array
    {
        if ($pokemon === null || !is_array($pokemon)) {
            return null;
        }

        $golpes = $pokemon['golpes'] ?? [];
        if ($golpes === []) {
            return null;
        }

        $index = random_int(0, count($golpes) - 1);
        return $golpes[$index];
    }

    private static function acaoBotInimigo(array $pokemon): ?array
    {
        return self::acaoBotJogador($pokemon);
    }

    private static function golpear(array &$battle, array $atacante, array $alvo, array $golpe): int
    {
        $errou = !self::golpeAcerta($golpe);
        if ($errou) {
            $battle['eventos'][] = [
                'tipo' => 'golpe',
                'lado' => self::ladoDoPokemon($battle, $atacante),
                'golpe' => $golpe['nome'],
                'errou' => true,
                'critico' => false,
                'efetividade' => 1.0,
                'dano' => 0,
                'hp_alvo_antes' => (int) $alvo['hp_atual'],
                'hp_alvo_depois' => (int) $alvo['hp_atual'],
            ];
            return 0;
        }

        $critico = self::ehCritico();
        $efetividade = self::calcularEfetividade(null, $atacante, $alvo, $golpe);
        $dano = self::calcularDano($atacante, $alvo, $golpe, $critico, $efetividade);
        $novoHp = max(0, (int) $alvo['hp_atual'] - $dano);
        $alvo['hp_atual'] = $novoHp;

        $battle['eventos'][] = [
            'tipo' => 'golpe',
            'lado' => self::ladoDoPokemon($battle, $atacante),
            'golpe' => $golpe['nome'],
            'errou' => false,
            'critico' => $critico,
            'efetividade' => round($efetividade, 2),
            'dano' => $dano,
            'hp_alvo_antes' => (int) ($alvo['hp_atual'] + $dano),
            'hp_alvo_depois' => $novoHp,
        ];

        return $dano;
    }

    private static function ladoDoPokemon(array $battle, array $pokemon): string
    {
        foreach (['JOGADOR', 'INIMIGO'] as $lado) {
            foreach ($battle[$lado === 'JOGADOR' ? 'jogador' : 'oponente']['time'] as $idx => $timePokemon) {
                if (($timePokemon['id'] ?? null) === ($pokemon['id'] ?? null) || ($timePokemon['nome'] ?? null) === ($pokemon['nome'] ?? null)) {
                    return $lado;
                }
            }
        }

        return 'JOGADOR';
    }

    private static function golpeAcerta(array $golpe): bool
    {
        $precisao = $golpe['precisao'] ?? null;
        if ($precisao === null || $precisao >= 100) {
            return true;
        }

        return random_int(1, 100) <= (int) $precisao;
    }

    private static function ehCritico(): bool
    {
        return random_int(1, 16) === 1;
    }

    private static function processarTurnoStatus(array &$battle): void
    {
        foreach (['JOGADOR', 'INIMIGO'] as $lado) {
            $chave = self::chaveLado($lado);
            $ativo = self::pokemonAtivo($battle, $lado);
            if ($ativo === null) {
                continue;
            }

            $status = self::normalizarStatusNome((string) ($ativo['status'] ?? 'normal'));
            $ativo['status'] = $status;
            $index = (int) ($battle[$chave]['ativo'] ?? 0);

            if ($status === 'sono') {
                $turnos = max(0, (int) ($ativo['turnos_sono'] ?? 1));
                if ($turnos > 0) {
                    $ativo['turnos_sono'] = $turnos - 1;
                    $battle[$chave]['time'][$index] = $ativo;
                    $battle['eventos'][] = [
                        'tipo' => 'nao_pode_agir',
                        'lado' => $lado,
                        'pokemon' => $ativo['nome'],
                        'status' => 'sono',
                        'turnos_restantes' => $turnos - 1,
                    ];
                    continue;
                }

                $ativo['status'] = 'normal';
                $ativo['turnos_sono'] = 0;
                $battle[$chave]['time'][$index] = $ativo;
                $battle['eventos'][] = [
                    'tipo' => 'status_curado',
                    'lado' => $lado,
                    'pokemon' => $ativo['nome'],
                    'status' => 'sono',
                ];
                continue;
            }

            if ($status === 'paralisia' && random_int(1, 100) <= 25) {
                $battle[$chave]['time'][$index] = $ativo;
                $battle['eventos'][] = [
                    'tipo' => 'nao_pode_agir',
                    'lado' => $lado,
                    'pokemon' => $ativo['nome'],
                    'status' => 'paralisia',
                ];
                continue;
            }

            if ($status === 'congelamento' && random_int(1, 100) <= 20) {
                $ativo['status'] = 'normal';
                $battle[$chave]['time'][$index] = $ativo;
                $battle['eventos'][] = [
                    'tipo' => 'status_curado',
                    'lado' => $lado,
                    'pokemon' => $ativo['nome'],
                    'status' => 'congelamento',
                ];
                continue;
            }

            $dano = 0;
            if ($status === 'veneno') {
                $dano = (int) max(1, floor(((int) ($ativo['hp_max'] ?? 1)) / 8));
            } elseif ($status === 'queimadura') {
                $dano = (int) max(1, floor(((int) ($ativo['hp_max'] ?? 1)) / 16));
            }

            if ($dano > 0) {
                $novoHp = max(0, ((int) ($ativo['hp_atual'] ?? 0)) - $dano);
                $ativo['hp_atual'] = $novoHp;
                $battle[$chave]['time'][$index] = $ativo;
                $battle['eventos'][] = [
                    'tipo' => 'dano_status',
                    'lado' => $lado,
                    'pokemon' => $ativo['nome'],
                    'status' => $status,
                    'dano' => $dano,
                    'hp_restante' => $novoHp,
                ];

                if ($novoHp <= 0) {
                    $battle['fim'] = $lado === 'JOGADOR' ? 'DERROTA' : 'VITORIA';
                    $battle['resultado'] = [
                        'vencedor' => $lado === 'JOGADOR' ? 'INIMIGO' : 'JOGADOR',
                        'status' => $battle['fim'],
                    ];
                    $battle['eventos'][] = ['tipo' => 'fim', 'lado' => $lado, 'resultado' => $battle['fim']];
                }
            }
        }
    }

    private static function processarEfeitosDoGolpe(array &$battle, string $lado, string $alvoLado, array $golpe, int $dano, float $efetividade): void
    {
        $efeitos = $golpe['efeitos'] ?? [];
        if ($efeitos === []) {
            return;
        }

        foreach ($efeitos as $efeito) {
            $tipo = strtoupper((string) ($efeito['tipo_efeito'] ?? ''));
            $chance = (int) ($efeito['chance'] ?? 100);
            $alvoEfeito = strtoupper((string) ($efeito['alvo'] ?? 'OPONENTE'));
            $targetLado = $alvoEfeito === 'USUARIO' ? $lado : $alvoLado;
            $targetPokemon = self::pokemonAtivo($battle, $targetLado);

            if ($tipo === 'DRENAR_DANO') {
                if ($targetPokemon === null) {
                    continue;
                }

                $percentual = max(1, (int) ($efeito['percentual'] ?? 0));
                $cura = (int) floor($dano * $percentual / 100);
                $targetPokemon['hp_atual'] = min((int) ($targetPokemon['hp_max'] ?? 0), (int) ($targetPokemon['hp_atual'] ?? 0) + $cura);
                $battle[self::chaveLado($targetLado)]['time'][$battle[self::chaveLado($targetLado)]['ativo']] = $targetPokemon;
                $battle['eventos'][] = [
                    'tipo' => 'dano_status',
                    'lado' => $targetLado,
                    'pokemon' => $targetPokemon['nome'],
                    'status' => 'drenagem',
                    'dano' => $cura,
                ];
                continue;
            }

            if (random_int(1, 100) > $chance) {
                $battle['eventos'][] = ['tipo' => 'falhou', 'lado' => $lado, 'golpe' => $golpe['nome'], 'motivo' => 'chance'];
                continue;
            }

            if ($tipo === 'APLICAR_STATUS') {
                if ($targetPokemon === null) {
                    $battle['eventos'][] = ['tipo' => 'falhou', 'lado' => $lado, 'golpe' => $golpe['nome'], 'motivo' => 'alvo'];
                    continue;
                }

                $status = self::nomeStatusPorId((int) ($efeito['id_status'] ?? 0));
                if ($status === '' || !self::podeAplicarStatus($targetPokemon, $status)) {
                    $battle['eventos'][] = ['tipo' => 'falhou', 'lado' => $lado, 'golpe' => $golpe['nome'], 'motivo' => $status];
                    continue;
                }

                $targetPokemon['status'] = $status;
                if ($status === 'sono') {
                    $targetPokemon['turnos_sono'] = random_int(1, 3);
                }

                $battle[self::chaveLado($targetLado)]['time'][$battle[self::chaveLado($targetLado)]['ativo']] = $targetPokemon;
                $battle['eventos'][] = [
                    'tipo' => 'status_aplicado',
                    'lado' => $targetLado,
                    'pokemon' => $targetPokemon['nome'],
                    'status' => $status,
                ];
                continue;
            }

            if ($tipo === 'ALTERAR_ATRIBUTO') {
                if ($targetPokemon === null) {
                    continue;
                }

                $atributo = strtoupper((string) ($efeito['atributo'] ?? ''));
                $alteracao = (int) ($efeito['alteracao'] ?? 0);
                self::aplicarEstagioAtributo($battle, $targetLado, $atributo, $alteracao);
            }
        }
    }

    private static function aplicarEstagioAtributo(array &$battle, string $lado, string $atributo, int $alteracao): void
    {
        $chave = self::chaveLado($lado);
        $index = (int) ($battle[$chave]['ativo'] ?? 0);
        $pokemon = $battle[$chave]['time'][$index] ?? null;
        if ($pokemon === null) {
            return;
        }

        $estagios = is_array($pokemon['estagios'] ?? null) ? $pokemon['estagios'] : [];
        $novo = max(-6, min(6, ((int) ($estagios[$atributo] ?? 0)) + $alteracao));
        $estagios[$atributo] = $novo;
        $pokemon['estagios'] = $estagios;
        $battle[$chave]['time'][$index] = $pokemon;
        $battle['eventos'][] = [
            'tipo' => 'atributo_mudou',
            'lado' => $lado,
            'pokemon' => $pokemon['nome'],
            'atributo' => $atributo,
            'valor' => $novo,
        ];
    }

    private static function indicePokemon(array $time, string $nome, int $posicao): int
    {
        foreach ($time as $index => $pokemon) {
            if (($pokemon['nome'] ?? '') === $nome && ((int) ($pokemon['posicao'] ?? 0) === $posicao || $index === $posicao)) {
                return $index;
            }
        }

        return 0;
    }

    private static function nomeStatusPorId(int $idStatus): string
    {
        $statusMap = [
            1 => 'veneno',
            2 => 'queimadura',
            3 => 'congelamento',
            4 => 'sono',
            5 => 'paralisia',
        ];

        return $statusMap[$idStatus] ?? '';
    }

    private static function normalizarStatusNome(string $status): string
    {
        $status = strtolower(trim($status));
        $map = [
            'envenenamento' => 'veneno',
            'veneno' => 'veneno',
            'queimadura' => 'queimadura',
            'fogo' => 'queimadura',
            'congelamento' => 'congelamento',
            'sono' => 'sono',
            'paralisia' => 'paralisia',
            'normal' => 'normal',
        ];

        return $map[$status] ?? $status;
    }

    private static function podeAplicarStatus(array $pokemon, string $status): bool
    {
        $status = self::normalizarStatusNome($status);
        if ((string) ($pokemon['status'] ?? 'normal') !== 'normal') {
            return false;
        }

        $tipos = array_map('strtolower', (array) ($pokemon['tipos'] ?? []));
        if ($status === 'queimadura' && in_array('fogo', $tipos, true)) {
            return false;
        }

        if ($status === 'veneno' && in_array('veneno', $tipos, true)) {
            return false;
        }

        return true;
    }

    private static function pokemonPodeAgir(array $battle, string $lado): bool
    {
        $pokemon = self::pokemonAtivo($battle, $lado);
        if ($pokemon === null) {
            return false;
        }

        $status = self::normalizarStatusNome((string) ($pokemon['status'] ?? 'normal'));
        if ($status === 'sono') {
            $turnos = max(0, (int) ($pokemon['turnos_sono'] ?? 0));
            if ($turnos > 0) {
                $battle['eventos'][] = [
                    'tipo' => 'nao_pode_agir',
                    'lado' => $lado,
                    'pokemon' => $pokemon['nome'],
                    'status' => 'sono',
                    'turnos_restantes' => $turnos,
                ];
                return false;
            }

            $pokemon['status'] = 'normal';
            $battle[self::chaveLado($lado)]['time'][$battle[self::chaveLado($lado)]['ativo']] = $pokemon;
            return true;
        }

        if ($status === 'paralisia' && random_int(1, 100) <= 25) {
            $battle['eventos'][] = [
                'tipo' => 'nao_pode_agir',
                'lado' => $lado,
                'pokemon' => $pokemon['nome'],
                'status' => 'paralisia',
            ];
            return false;
        }

        return true;
    }

    private static function multiplicadorEstagio(int $estagio): float
    {
        if ($estagio === 0) {
            return 1.0;
        }

        if ($estagio > 0) {
            return (2 + $estagio) / 2;
        }

        return 2 / (2 - $estagio);
    }

    private static function valorEstatisticaComModificador(array $pokemon, string $atributo): int
    {
        $mapa = [
            'ATAQUE' => 'ataque',
            'DEFESA' => 'defesa',
            'ATAQUE_ESPECIAL' => 'ataque_especial',
            'DEFESA_ESPECIAL' => 'defesa_especial',
            'VELOCIDADE' => 'velocidade',
        ];

        $chave = $mapa[$atributo] ?? strtolower($atributo);
        $base = (int) ($pokemon[$chave] ?? 0);
        $estagios = is_array($pokemon['estagios'] ?? null) ? $pokemon['estagios'] : [];
        $estagio = (int) ($estagios[$atributo] ?? 0);

        return (int) floor($base * self::multiplicadorEstagio($estagio));
    }

    private static function calcularEfetividade(?PDO $conn, array $atacante, array $alvo, array $golpe): float
    {
        $tiposAlvo = $alvo['tipos'] ?? [];
        $tipoGolpe = (int) ($golpe['id_tipo'] ?? 1);

        if ($tiposAlvo === []) {
            return 1.0;
        }

        $valor = 1.0;
        foreach ($tiposAlvo as $tipo) {
            $valor *= self::multiplicadorTipo($conn, $tipoGolpe, (string) $tipo);
        }

        return (float) $valor;
    }

    private static function multiplicadorTipo(?PDO $conn, int $tipoAtaque, string $tipoDefensor): float
    {
        if ($conn === null) {
            return 1.0;
        }

        $cache = self::carregarBaseTipoEfetividade($conn);
        $idDefensor = self::idTipoPorNome($conn, $tipoDefensor);

        return (float) ($cache[$tipoAtaque][$idDefensor] ?? 1.0);
    }

    private static function carregarBaseTipoEfetividade(PDO $conn): array
    {
        static $cache = null;

        if ($cache !== null) {
            return $cache;
        }

        $stmt = $conn->query('SELECT id_tipo_atacante, id_tipo_defensor, multiplicador FROM tipo_efetividade');
        $cache = [];

        while ($linha = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $idAtacante = (int) ($linha['id_tipo_atacante'] ?? 0);
            $idDefensor = (int) ($linha['id_tipo_defensor'] ?? 0);
            $cache[$idAtacante][$idDefensor] = (float) ($linha['multiplicador'] ?? 1.0);
        }

        return $cache;
    }

    private static function idTipoPorNome(PDO $conn, string $tipo): int
    {
        $tipo = trim((string) $tipo);
        if ($tipo === '') {
            return 1;
        }

        if (ctype_digit($tipo)) {
            return (int) $tipo;
        }

        $stmt = $conn->prepare('SELECT id_tipo FROM tipo WHERE nome = :nome LIMIT 1');
        $stmt->execute(['nome' => $tipo]);
        $resultado = $stmt->fetch(PDO::FETCH_ASSOC);

        return (int) ($resultado['id_tipo'] ?? 1);
    }

    private static function calcularDano(array $atacante, array $alvo, array $golpe, bool $critico = false, float $efetividade = 1.0): int
    {
        $categoria = strtolower((string) ($golpe['categoria'] ?? 'DANO'));
        if ($categoria !== 'dano') {
            return 0;
        }

        $poder = (int) ($golpe['poder'] ?? 0);
        if ($poder <= 0) {
            return 0;
        }

        $classe = strtolower((string) ($golpe['classe_dano'] ?? 'physical'));
        $nivel = (int) ($atacante['nivel'] ?? 1);
        $ataque = self::valorEstatisticaComModificador($atacante, $classe === 'special' ? 'ATAQUE_ESPECIAL' : 'ATAQUE');
        $defesa = self::valorEstatisticaComModificador($alvo, $classe === 'special' ? 'DEFESA_ESPECIAL' : 'DEFESA');

        if (self::normalizarStatusNome((string) ($atacante['status'] ?? 'normal')) === 'queimadura' && $classe === 'physical') {
            $ataque = (int) floor($ataque * 0.5);
        }

        $base = (int) floor((((((2 * $nivel) / 5) + 2) * $poder * $ataque) / $defesa) / 50) + 2;
        $escalaDano = 2.5;
        $stab = self::tipoIgual($atacante, $golpe) ? 1.5 : 1.0;
        $criticoValor = $critico ? 1.5 : 1.0;
        $aleatorio = (float) mt_rand(85, 100) / 100;
        $dano = (int) floor($base * $escalaDano * $stab * $efetividade * $criticoValor * $aleatorio);

        if ($efetividade === 0.0) {
            return 0;
        }

        return max(1, $dano);
    }

    private static function tipoIgual(array $pokemon, array $golpe): bool
    {
        $tipoGolpe = strtolower((string) ($golpe['tipo_nome'] ?? ''));
        foreach (($pokemon['tipos'] ?? []) as $tipo) {
            if (strtolower((string) $tipo) === $tipoGolpe) {
                return true;
            }
        }

        return false;
    }

    private static function indicePrimeiroVivo(array $time): int
    {
        foreach ($time as $indice => $pokemon) {
            if (((int) ($pokemon['hp_atual'] ?? 0)) > 0) {
                return $indice;
            }
        }

        return 0;
    }

    private static function pokemonAtivo(array $battle, string $lado): ?array
    {
        $chave = self::chaveLado($lado);
        $time = $battle[$chave]['time'] ?? [];
        $ativo = $battle[$chave]['ativo'] ?? 0;

        if (!isset($time[$ativo])) {
            return null;
        }

        return $time[$ativo];
    }

    private static function chaveLado(string $lado): string
    {
        $ladoNormalizado = strtoupper(trim($lado));

        if ($ladoNormalizado === 'JOGADOR') {
            return 'jogador';
        }

        if ($ladoNormalizado === 'INIMIGO') {
            return 'oponente';
        }

        return strtolower(trim($lado));
    }

    private static function proximoVivo(array $time, int $indiceAtual): ?int
    {
        foreach ($time as $indice => $pokemon) {
            if ($indice === $indiceAtual) {
                continue;
            }
            if ((int) ($pokemon['hp_atual'] ?? 0) > 0) {
                return $indice;
            }
        }

        return null;
    }

    private static function acharPokemonPorPosicao(array $time, int $posicao): ?array
    {
        foreach ($time as $pokemon) {
            if ((int) ($pokemon['posicao'] ?? 0) === $posicao) {
                return $pokemon;
            }
        }

        return null;
    }

    private static function obterGolpePorSlot(array $pokemon, int $slot): ?array
    {
        $golpes = $pokemon['golpes'] ?? [];
        if ($slot < 0 || $slot >= count($golpes)) {
            return null;
        }

        return $golpes[$slot];
    }

    private static function serializarEstado(array $battle): array
    {
        $jogador = self::serializarTime($battle['jogador']['time'] ?? []);
        $oponente = self::serializarTime($battle['oponente']['time'] ?? []);

        return [
            'jogador' => [
                'ativo' => $jogador[$battle['jogador']['ativo'] ?? 0] ?? null,
                'time' => $jogador,
            ],
            'oponente' => [
                'ativo' => $oponente[$battle['oponente']['ativo'] ?? 0] ?? null,
                'time' => $oponente,
            ],
            'aguardando_troca' => (bool) ($battle['aguardando_troca'] ?? false),
            'fim' => $battle['fim'] ?? null,
            'resultado' => $battle['resultado'] ?? null,
        ];
    }

    private static function serializarTime(array $time): array
    {
        $retorno = [];
        foreach ($time as $indice => $pokemon) {
            $retorno[] = [
                'nome' => $pokemon['nome'] ?? 'Pokemon',
                'hp' => (int) ($pokemon['hp_atual'] ?? 0),
                'hp_max' => (int) ($pokemon['hp_max'] ?? 0),
                'status' => $pokemon['status'] ?? 'normal',
                'posicao' => (int) ($pokemon['posicao'] ?? $indice + 1),
                'ativo' => $indice === (int) ($pokemon['ativo'] ?? false),
                'golpes' => $pokemon['golpes'] ?? [],
            ];
        }

        return $retorno;
    }

    private static function montarTimeJogador(PDO $conn, int $idPerfil): array
    {
        $stmt = $conn->prepare('
            SELECT pt.id_pokemon_time, pt.id_pokemon_especie, pt.nivel, pt.hp_atual, pt.hp_max, pt.ataque,
                   pt.defesa, pt.ataque_especial, pt.defesa_especial, pt.velocidade, pt.status, pt.posicao,
                   pe.nome AS nome_especie, pe.imagem_url, pe.hp_base, pe.ataque_base, pe.defesa_base,
                   pe.ataque_especial_base, pe.defesa_especial_base, pe.velocidade_base,
                   GROUP_CONCAT(DISTINCT g.id_golpe ORDER BY peg.slot SEPARATOR ",") AS ids_golpes,
                   pt.id_golpe_status
            FROM pokemon_time pt
            JOIN pokemon_especie pe ON pe.id_pokemon_especie = pt.id_pokemon_especie
            LEFT JOIN pokemon_especie_golpe peg ON peg.id_pokemon_especie = pe.id_pokemon_especie
            LEFT JOIN golpe g ON g.id_golpe = peg.id_golpe
            WHERE pt.id_perfil = :perfil
            GROUP BY pt.id_pokemon_time
            ORDER BY pt.posicao ASC
        ');
        $stmt->execute(['perfil' => $idPerfil]);
        $time = $stmt->fetchAll();

        $resultado = [];

        foreach ($time as $index => $pokemon) {
            $golpes = self::montarGolpesEspecie($conn, (int) $pokemon['id_pokemon_especie'], $pokemon['id_golpe_status'] ?? null);
            $resultado[] = [
                'id' => (int) $pokemon['id_pokemon_time'],
                'nome' => (string) $pokemon['nome_especie'],
                'id_pokemon_especie' => (int) $pokemon['id_pokemon_especie'],
                'nivel' => (int) $pokemon['nivel'],
                'hp_atual' => (int) $pokemon['hp_atual'],
                'hp_max' => (int) $pokemon['hp_max'],
                'ataque' => (int) $pokemon['ataque'],
                'defesa' => (int) $pokemon['defesa'],
                'ataque_especial' => (int) $pokemon['ataque_especial'],
                'defesa_especial' => (int) $pokemon['defesa_especial'],
                'velocidade' => (int) $pokemon['velocidade'],
                'status' => (string) ($pokemon['status'] ?? 'normal'),
                'posicao' => (int) $pokemon['posicao'],
                'tipos' => self::obterTiposDaEspecie($conn, (int) $pokemon['id_pokemon_especie']),
                'estagios' => [
                    'ATAQUE' => 0,
                    'DEFESA' => 0,
                    'ATAQUE_ESPECIAL' => 0,
                    'DEFESA_ESPECIAL' => 0,
                    'VELOCIDADE' => 0,
                ],
                'golpes' => $golpes,
                'ativo' => false,
            ];
            $resultado[$index]['ativo'] = false;
        }

        return $resultado;
    }

    private static function montarTimeOponente(PDO $conn, int $idDesafio): array
    {
        $stmt = $conn->prepare('
            SELECT dp.id_desafio_pokemon, dp.id_pokemon_especie, dp.nivel, dp.ordem, dp.id_golpe_status,
                   pe.nome AS nome_especie, pe.hp_base, pe.ataque_base, pe.defesa_base,
                   pe.ataque_especial_base, pe.defesa_especial_base, pe.velocidade_base
            FROM desafio_pokemon dp
            JOIN pokemon_especie pe ON pe.id_pokemon_especie = dp.id_pokemon_especie
            WHERE dp.id_desafio = :desafio
            ORDER BY dp.ordem ASC
        ');
        $stmt->execute(['desafio' => $idDesafio]);
        $time = $stmt->fetchAll();
        $resultado = [];

        foreach ($time as $index => $pokemon) {
            $nivel = (int) $pokemon['nivel'];
            $especie = [
                'hp_base' => (int) $pokemon['hp_base'],
                'ataque_base' => (int) $pokemon['ataque_base'],
                'defesa_base' => (int) $pokemon['defesa_base'],
                'ataque_especial_base' => (int) $pokemon['ataque_especial_base'],
                'defesa_especial_base' => (int) $pokemon['defesa_especial_base'],
                'velocidade_base' => (int) $pokemon['velocidade_base'],
            ];
            $stats = StatCalculator::calcularStatsEspecie($especie, $nivel);

            $resultado[] = [
                'id' => (int) $pokemon['id_desafio_pokemon'],
                'nome' => (string) $pokemon['nome_especie'],
                'id_pokemon_especie' => (int) $pokemon['id_pokemon_especie'],
                'nivel' => $nivel,
                'hp_atual' => (int) $stats['hp_max'],
                'hp_max' => (int) $stats['hp_max'],
                'ataque' => (int) $stats['ataque'],
                'defesa' => (int) $stats['defesa'],
                'ataque_especial' => (int) $stats['ataque_especial'],
                'defesa_especial' => (int) $stats['defesa_especial'],
                'velocidade' => (int) $stats['velocidade'],
                'status' => 'normal',
                'posicao' => (int) $pokemon['ordem'],
                'tipos' => self::obterTiposDaEspecie($conn, (int) $pokemon['id_pokemon_especie']),
                'estagios' => [
                    'ATAQUE' => 0,
                    'DEFESA' => 0,
                    'ATAQUE_ESPECIAL' => 0,
                    'DEFESA_ESPECIAL' => 0,
                    'VELOCIDADE' => 0,
                ],
                'golpes' => self::montarGolpesEspecie($conn, (int) $pokemon['id_pokemon_especie'], $pokemon['id_golpe_status'] ?? null),
            ];
        }

        return $resultado;
    }

    private static function montarGolpesEspecie(PDO $conn, int $idEspecie, ?int $golpeStatus): array
    {
        $sql = '
            SELECT g.id_golpe, g.nome, g.id_tipo, g.categoria, g.poder, g.precisao, g.prioridade, g.classe_dano,
                   t.nome AS tipo_nome
            FROM pokemon_especie_golpe peg
            JOIN golpe g ON g.id_golpe = peg.id_golpe
            JOIN tipo t ON t.id_tipo = g.id_tipo
            WHERE peg.id_pokemon_especie = :especie
            ORDER BY peg.slot ASC
        ';

        $stmt = $conn->prepare($sql);
        $stmt->execute(['especie' => $idEspecie]);
        $golpes = $stmt->fetchAll();

        if ($golpeStatus !== null) {
            $statusStmt = $conn->prepare('
                SELECT g.id_golpe, g.nome, g.id_tipo, g.categoria, g.poder, g.precisao, g.prioridade, g.classe_dano,
                       t.nome AS tipo_nome
                FROM golpe g
                JOIN tipo t ON t.id_tipo = g.id_tipo
                WHERE g.id_golpe = :golpe
            ');
            $statusStmt->execute(['golpe' => $golpeStatus]);
            $status = $statusStmt->fetch();
            if ($status) {
                $golpes[] = $status;
            }
        }

        return array_values($golpes);
    }

    private static function obterTiposDaEspecie(PDO $conn, int $idEspecie): array
    {
        $stmt = $conn->prepare('
            SELECT t.nome
            FROM pokemon_especie_tipo pet
            JOIN tipo t ON t.id_tipo = pet.id_tipo
            WHERE pet.id_pokemon_especie = :especie
            ORDER BY t.id_tipo ASC
        ');
        $stmt->execute(['especie' => $idEspecie]);

        $tipos = [];
        foreach ($stmt->fetchAll() as $linha) {
            $tipos[] = (string) $linha['nome'];
        }

        return $tipos;
    }

    private static function respostaEstado(array $battle): array
    {
        $eventos = $battle['eventos'] ?? [];
        $estado = self::serializarEstado($battle);

        return [
            'ok' => true,
            'eventos' => $eventos,
            'estado' => $estado,
            'itens' => $battle['itens'] ?? [],
        ];
    }

    private static function finalizarBatalha(?PDO $conn, int $idPerfil, array &$battle): void
    {
        if (($battle['persistida'] ?? false) === true) {
            return;
        }

        $battle['persistida'] = true;

        if ($battle['fim'] === 'VITORIA') {
            $battle['resultado'] = [
                'vencedor' => 'JOGADOR',
                'status' => 'VITORIA',
                'moedas' => self::RECOMPENSA_MOEDAS,
                'niveis' => self::NIVEIS_POR_VITORIA,
            ];
            $battle['eventos'][] = [
                'tipo' => 'recompensa',
                'moedas' => self::RECOMPENSA_MOEDAS,
            ];

            $thisTime = $battle['jogador']['time'] ?? [];
            foreach ($thisTime as $index => $pokemon) {
                $nivelAntes = (int) ($pokemon['nivel'] ?? 1);
                $novoNivel = min(self::NIVEL_MAXIMO, $nivelAntes + self::NIVEIS_POR_VITORIA);
                $battle['jogador']['time'][$index]['nivel'] = $novoNivel;
                $battle['eventos'][] = [
                    'tipo' => 'nivel_subiu',
                    'pokemon' => $pokemon['nome'],
                    'nivel_antes' => $nivelAntes,
                    'nivel_depois' => $novoNivel,
                ];
            }

            if ($conn !== null) {
                $conn->beginTransaction();
                try {
                    $conn->prepare('UPDATE perfil SET dinheiro = dinheiro + :moedas WHERE id_perfil = :perfil')
                        ->execute(['moedas' => self::RECOMPENSA_MOEDAS, 'perfil' => $idPerfil]);

                    $stmt = $conn->prepare('INSERT INTO batalha_log (id_perfil, id_desafio, resultado, dinheiro_ganho, detalhes, finalizada_em) VALUES (:perfil, :desafio, :resultado, :dinheiro, :detalhes, CURRENT_TIMESTAMP)');
                    $stmt->execute([
                        'perfil' => $idPerfil,
                        'desafio' => $battle['id_desafio'],
                        'resultado' => 'VITORIA',
                        'dinheiro' => self::RECOMPENSA_MOEDAS,
                        'detalhes' => json_encode(['eventos' => $battle['eventos']], JSON_UNESCAPED_UNICODE),
                    ]);
                    $idBatalha = (int) $conn->lastInsertId();
                    $battle['id_batalha'] = $idBatalha;

                    $insPokemon = $conn->prepare('INSERT INTO batalha_pokemon (id_batalha, id_pokemon_time, id_pokemon_especie, lado, ordem, nivel, hp_inicial, hp_final) VALUES (:batalha, :time, :especie, :lado, :ordem, :nivel, :hp_inicial, :hp_final)');
                    foreach (['jogador', 'oponente'] as $ladoKey) {
                        $lado = $ladoKey === 'jogador' ? 'JOGADOR' : 'INIMIGO';
                        $time = $battle[$ladoKey]['time'];
                        foreach ($time as $ordem => $pokemon) {
                            $insPokemon->execute([
                                'batalha' => $idBatalha,
                                'time' => $ladoKey === 'jogador' ? ((int) ($pokemon['id'] ?? 0)) : null,
                                'especie' => (int) ($pokemon['id_pokemon_especie'] ?? 0),
                                'lado' => $lado,
                                'ordem' => $ordem + 1,
                                'nivel' => (int) ($pokemon['nivel'] ?? 1),
                                'hp_inicial' => (int) ($pokemon['hp_max'] ?? 0),
                                'hp_final' => (int) ($pokemon['hp_atual'] ?? 0),
                            ]);
                        }
                    }

                    $conn->commit();
                } catch (\Throwable $e) {
                    if ($conn->inTransaction()) {
                        $conn->rollBack();
                    }
                    throw $e;
                }
            }
        }

        if ($battle['fim'] === 'DERROTA') {
            $battle['resultado'] = [
                'vencedor' => 'INIMIGO',
                'status' => 'DERROTA',
                'moedas' => 0,
                'niveis' => 0,
            ];
            $battle['eventos'][] = ['tipo' => 'fim', 'lado' => 'INIMIGO', 'resultado' => 'DERROTA'];

            if ($conn !== null) {
                $conn->beginTransaction();
                try {
                    $stmt = $conn->prepare('INSERT INTO batalha_log (id_perfil, id_desafio, resultado, dinheiro_ganho, detalhes, finalizada_em) VALUES (:perfil, :desafio, :resultado, :dinheiro, :detalhes, CURRENT_TIMESTAMP)');
                    $stmt->execute([
                        'perfil' => $idPerfil,
                        'desafio' => $battle['id_desafio'],
                        'resultado' => 'DERROTA',
                        'dinheiro' => 0,
                        'detalhes' => json_encode(['eventos' => $battle['eventos']], JSON_UNESCAPED_UNICODE),
                    ]);
                    $idBatalha = (int) $conn->lastInsertId();
                    $battle['id_batalha'] = $idBatalha;

                    $insPokemon = $conn->prepare('INSERT INTO batalha_pokemon (id_batalha, id_pokemon_time, id_pokemon_especie, lado, ordem, nivel, hp_inicial, hp_final) VALUES (:batalha, :time, :especie, :lado, :ordem, :nivel, :hp_inicial, :hp_final)');
                    foreach (['jogador', 'oponente'] as $ladoKey) {
                        $lado = $ladoKey === 'jogador' ? 'JOGADOR' : 'INIMIGO';
                        $time = $battle[$ladoKey]['time'];
                        foreach ($time as $ordem => $pokemon) {
                            $insPokemon->execute([
                                'batalha' => $idBatalha,
                                'time' => $ladoKey === 'jogador' ? ((int) ($pokemon['id'] ?? 0)) : null,
                                'especie' => (int) ($pokemon['id_pokemon_especie'] ?? 0),
                                'lado' => $lado,
                                'ordem' => $ordem + 1,
                                'nivel' => (int) ($pokemon['nivel'] ?? 1),
                                'hp_inicial' => (int) ($pokemon['hp_max'] ?? 0),
                                'hp_final' => (int) ($pokemon['hp_atual'] ?? 0),
                            ]);
                        }
                    }

                    $conn->commit();
                } catch (\Throwable $e) {
                    if ($conn->inTransaction()) {
                        $conn->rollBack();
                    }
                    throw $e;
                }
            }
        }
    }

    private static function ladoTemAtivoVivo(array $battle, string $lado): bool
    {
        $ativo = self::pokemonAtivo($battle, $lado);
        return $ativo !== null && (int) ($ativo['hp_atual'] ?? 0) > 0;
    }

    private static function iniciarSessaoSeNecessario(): void
    {
        if (session_status() !== PHP_SESSION_ACTIVE) {
            session_start();
        }
    }
}
