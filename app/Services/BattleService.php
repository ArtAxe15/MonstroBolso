<?php

declare(strict_types=1);

namespace App\Services;

use App\Http\ApiException;
use App\Models\Batalha;
use App\Models\Encontro;
use App\Services\EncerramentoJornada;
use PDO;
use RuntimeException;
use Throwable;

final class BattleService
{
    private const CHANCE_CRITICO_DENOMINADOR = 25;
    private const CHANCE_EFEITO_SECUNDARIO = 25;
    // Dança das Espadas e Nasty Plot: +1 estágio por uso, até +2.
    private const ESTAGIOS_POR_GOLPE_DE_AUMENTO = 1;
    private const LIMITE_ESTAGIOS_DE_ATAQUE = 2;
    // Chance de um NPC escolher o golpe de aumento a cada turno elegível.
    private const CHANCE_AUMENTO_NPC_DENOMINADOR = 6;
    private const NIVEL_MAXIMO = 100;
    private const RECOMPENSA_SELVA = 400;
    private const RECOMPENSA_TREINADOR = 600;
    private const RECOMPENSA_DESAFIO = 900;
    private const CONDICAO_POR_TIPO = [
        'Fogo' => 'Queimadura',
        'Eletrico' => 'Paralisia',
        'Gelo' => 'Congelamento',
        'Veneno' => 'Envenenamento',
        'Psiquico' => 'Sono',
        'Grama' => 'Sono',
        'Agua' => 'Congelamento',
        'Inseto' => 'Envenenamento',
        'Dragao' => 'Queimadura',
    ];
    private const ATRIBUTO_POR_GOLPE_STATUS = [14 => 'ATAQUE', 417 => 'ATAQUE_ESPECIAL'];
    // Preserva as condicoes especiais ja existentes destes golpes de dano.
    // Dragon Breath tambem recebe Queimadura por ser do tipo Dragao.
    private const CONDICAO_POR_GOLPE = [34 => 'Paralisia', 225 => 'Paralisia'];
    private const NIVEIS_POR_ENCONTRO = [
        'treinador' => 4,
        'selvagem' => 3,
        'desafio' => 3,
    ];

    /** Selvagens/treinadores: somente HP dos sobreviventes, sem curar status.
     *  Desafios: HP completo, reviver e remover condicoes de status. */
    private const RECUPERACAO_POS_VITORIA = [
        'selvagem' => 15,
        'treinador' => 20,
        'desafio' => 100,
    ];

    private PDO $conn;
    private Encontro $encontro;
    private Batalha $batalhaModel;
    private MontadorTimeAdversario $montador;
    private CalculadoraAtributos $calculadora;
    private CalculadoraDano $calculadoraDano;
    private FonteAleatoriedade $aleatoriedade;

    public function __construct(PDO $conn, ?FonteAleatoriedade $aleatoriedade = null)
    {
        $this->conn = $conn;
        $this->encontro = new Encontro($conn);
        $this->batalhaModel = new Batalha($conn);
        $this->aleatoriedade = $aleatoriedade ?? new FonteAleatoriedadeNativa();
        $this->montador = new MontadorTimeAdversario($conn, $this->aleatoriedade);
        $this->calculadora = new CalculadoraAtributos();
        $this->calculadoraDano = new CalculadoraDano();
    }

    public function iniciar(int $idPerfil, array $alvo): array
    {
        $encontro = $this->obterEncontro($idPerfil, $alvo);
        $timeJogadorBanco = $this->encontro->encontrarTimeDoJogador($idPerfil);
        if (!array_filter(
            $timeJogadorBanco,
            static fn(array $pokemon): bool => (int) $pokemon['hp_atual'] > 0
        )) {
            throw new ApiException(
                'Seu time não possui Pokémon com HP. Não é possível iniciar a batalha.',
                409
            );
        }

        $timeAdversarioBanco = $encontro['time_adversario'];
        $idsEspecie = array_merge(
            array_column($timeJogadorBanco, 'id_pokemon_especie'),
            array_column($timeAdversarioBanco, 'id_pokemon_especie')
        );
        $opcoesStatus = $this->encontro->encontrarOpcoesDeGolpeStatus($idsEspecie);
        $idsGolpeStatus = array_merge([], ...array_values($opcoesStatus));
        $idsHeldItem = array_merge(
            array_column($timeJogadorBanco, 'id_held_item'),
            array_column($timeAdversarioBanco, 'id_held_item')
        );

        $catalogo = [
            'especies' => $this->encontro->encontrarDadosDasEspecies($idsEspecie),
            'tipos' => $this->encontro->encontrarTiposDasEspecies($idsEspecie),
            'golpes_dano' => $this->encontro->encontrarGolpesDeDanoDasEspecies($idsEspecie),
            'golpes_status' => $this->encontro->encontrarGolpesPorIds($idsGolpeStatus),
            'opcoes_status' => $opcoesStatus,
            'held_items' => $this->encontro->encontrarItensPorIds($idsHeldItem),
            'efetividades' => $this->encontro->encontrarEfetividadesPorNome(),
        ];

        $timeJogador = [];
        foreach ($timeJogadorBanco as $pokemon) {
            $timeJogador[] = $this->montarPokemonJogador($pokemon, $catalogo);
        }

        $timeAdversario = [];
        foreach ($timeAdversarioBanco as $pokemon) {
            $timeAdversario[] = $this->montarPokemonAdversario($pokemon, $catalogo);
        }

        $batalha = [
            'id_perfil' => $idPerfil,
            'area_atual' => (int) $encontro['area_atual'],
            'numero_desafio' => (int) ($this->encontro->encontrarAtual($idPerfil)['ordem'] ?? 0),
            'tipo_encontro' => (string) $encontro['tipo_encontro'],
            'alvo' => $encontro['alvo'],
            'iniciada_em' => date('Y-m-d H:i:s'),
            'turno' => 1,
            'log' => [],
            'finalizada' => false,
            'resultado' => null,
            'persistencia_pendente' => false,
            'jogador' => [
                'indice_ativo' => $this->primeiroPokemonVivo($timeJogador),
                'time' => $timeJogador,
                'itens' => (new UsoDeItens($this->conn))->itensDeBatalha($idPerfil),
            ],
            'adversario' => [
                'indice_ativo' => $this->primeiroPokemonVivo($timeAdversario),
                'time' => $timeAdversario,
            ],
            '_interno' => [
                'golpes_status_atualizados' => true,
                'efetividades' => $catalogo['efetividades'],
                'turnos_processados' => 0,
                'eventos_turno_pendente' => [],
            ],
        ];

        $pokemonAdversarioAtivo = $timeAdversario[$batalha['adversario']['indice_ativo']];
        $pokemonJogadorAtivo = $timeJogador[$batalha['jogador']['indice_ativo']];
        if ($batalha['tipo_encontro'] === 'treinador') {
            $textoInicio = 'Um ' . lcfirst($batalha['alvo']['nome']) . ' quer batalhar!';
        } elseif ($batalha['tipo_encontro'] === 'selvagem') {
            $textoInicio = 'Um Pokémon selvagem apareceu: '
                . $this->nomePokemon($pokemonAdversarioAtivo) . '!';
        } else {
            $textoInicio = $batalha['alvo']['nome'] . ' quer batalhar!';
        }
        $batalha['log'] = [$this->evento('inicio', $textoInicio)];
        if ($batalha['tipo_encontro'] !== 'selvagem') {
            $batalha['log'][] = $this->evento(
                'envio_adversario',
                'Treinador enviou ' . $this->nomePokemon($pokemonAdversarioAtivo) . '!'
            );
        }
        $batalha['log'][] = $this->evento(
            'envio_jogador',
            'Vai! ' . $this->nomePokemon($pokemonJogadorAtivo) . '!'
        );

        $_SESSION['batalha'] = $batalha;

        return $this->estadoPublico($batalha);
    }

    public function obterEstado(int $idPerfil): ?array
    {
        $batalha = $_SESSION['batalha'] ?? null;
        if (
            !is_array($batalha)
            || !isset($batalha['id_perfil'], $batalha['turno'], $batalha['_interno'])
        ) {
            return null;
        }

        if ((int) $batalha['id_perfil'] !== $idPerfil) {
            return null;
        }
        $this->atualizarGolpesStatusDaSessao($batalha);
        return $this->estadoPublico($batalha);
    }

    public function executarTurno(int $idPerfil, array $solicitacao): array
    {
        $batalha = $_SESSION['batalha'] ?? null;
        if (
            !is_array($batalha)
            || !isset($batalha['id_perfil'], $batalha['turno'], $batalha['_interno'])
            || (int) $batalha['id_perfil'] !== $idPerfil
        ) {
            throw new ApiException(
                'Não há uma batalha atual nesta jornada. Inicie o encontro novamente.',
                409
            );
        }

        $acao = $solicitacao['acao'] ?? null;
        if (!in_array($acao, ['golpe', 'item'], true)) {
            throw new ApiException('A ação da batalha é inválida.', 422);
        }

        $turno = $this->inteiroSolicitado($solicitacao['turno'] ?? null, 'turno');
        if ($turno !== (int) ($batalha['turno'] ?? 0)) {
            throw new ApiException('Este turno já foi processado ou está desatualizado.', 409);
        }

        if (($batalha['persistencia_pendente'] ?? false) === true) {
            return $this->persistirBatalhaFinalizada($batalha);
        }
        if (($batalha['finalizada'] ?? false) === true) {
            throw new ApiException('Esta batalha já foi finalizada.', 409);
        }

        $this->atualizarGolpesStatusDaSessao($batalha);
        $indiceJogador = (int) $batalha['jogador']['indice_ativo'];
        $pokemonJogador = $batalha['jogador']['time'][$indiceJogador] ?? null;
        if (
            !is_array($pokemonJogador)
            || (int) $pokemonJogador['atributos']['hp_atual'] <= 0
        ) {
            throw new ApiException('O Pokémon ativo do jogador não pode atacar.', 409);
        }

        $golpeJogador = $acao === 'golpe'
            ? $this->selecionarGolpe($pokemonJogador, $this->inteiroSolicitado($solicitacao['id_golpe'] ?? null, 'golpe'))
            : null;

        $indiceAdversario = (int) $batalha['adversario']['indice_ativo'];
        $pokemonAdversario = $batalha['adversario']['time'][$indiceAdversario] ?? null;
        if (
            !is_array($pokemonAdversario)
            || (int) $pokemonAdversario['atributos']['hp_atual'] <= 0
        ) {
            throw new RuntimeException('O Pokémon ativo do adversário está inválido.');
        }
        $golpesAdversario = $pokemonAdversario['golpes']['dano'] ?? [];
        if ($golpesAdversario === []) {
            throw new RuntimeException('O Pokémon adversário não possui golpe de dano.');
        }
        $golpeAdversario = $golpesAdversario[
            $this->aleatoriedade->inteiro(0, count($golpesAdversario) - 1)
        ];
        $statusAdversario = $pokemonAdversario['golpes']['status'] ?? null;
        $atributo = self::ATRIBUTO_POR_GOLPE_STATUS[$statusAdversario['api_id'] ?? 0] ?? null;
        if ($atributo !== null
            && (int) ($pokemonAdversario['estagios'][$atributo] ?? 0) < self::LIMITE_ESTAGIOS_DE_ATAQUE
            && $this->aleatoriedade->inteiro(1, self::CHANCE_AUMENTO_NPC_DENOMINADOR) === 1
        ) {
            $golpeAdversario = $statusAdversario;
        }

        $ordem = $golpeJogador === null ? [['adversario', $golpeAdversario]] : $this->determinarOrdem(
            $pokemonJogador,
            $golpeJogador,
            $pokemonAdversario,
            $golpeAdversario
        );
        $eventos = [];
        $idItem = null;
        if ($acao === 'item') {
            $idItem = $this->inteiroSolicitado($solicitacao['id_item'] ?? null, 'item');
            $idAlvo = isset($solicitacao['id_pokemon_time'])
                ? $this->inteiroSolicitado($solicitacao['id_pokemon_time'], 'Pokémon')
                : (int) $pokemonJogador['id_pokemon_time'];
            $this->usarItemDeCura($batalha, $idItem, $idAlvo, $eventos);
        }
        foreach ($ordem as [$lado, $golpe]) {
            $outroLado = $lado === 'jogador' ? 'adversario' : 'jogador';
            $atacante = $batalha[$lado]['time'][$batalha[$lado]['indice_ativo']];
            $alvo = $batalha[$outroLado]['time'][$batalha[$outroLado]['indice_ativo']];
            if (
                (int) $atacante['atributos']['hp_atual'] <= 0
                || (int) $alvo['atributos']['hp_atual'] <= 0
            ) {
                continue;
            }
            $this->executarGolpe($batalha, $lado, $golpe, $eventos);
        }

        $this->aplicarDanoDeCondicao($batalha, $eventos);
        $this->trocarDesmaiadosAutomaticamente($batalha, $eventos);
        if ($idItem !== null) {
            if (!$this->encontro->consumirItem($idPerfil, $idItem)) {
                throw new ApiException('Este item não está mais disponível.', 409);
            }
            $batalha['jogador']['itens'] = array_values(array_filter(
                $batalha['jogador']['itens'],
                static fn(array $item): bool => (int) $item['quantidade'] > 0
            ));
        }
        $batalha['_interno']['turnos_processados']++;
        $batalha['log'] = array_merge($batalha['log'], $eventos);

        $jogadorSemPokemon = !$this->timePossuiPokemonVivo($batalha['jogador']['time']);
        $adversarioSemPokemon = !$this->timePossuiPokemonVivo($batalha['adversario']['time']);
        if ($jogadorSemPokemon || $adversarioSemPokemon) {
            $batalha['finalizada'] = true;
            foreach (['jogador', 'adversario'] as $lado) {
                foreach ($batalha[$lado]['time'] as &$pokemon) {
                    $pokemon['estagios'] = $this->estagiosIniciais();
                }
                unset($pokemon);
            }
            $batalha['resultado'] = $jogadorSemPokemon ? 'DERROTA' : 'VITORIA';
            $eventoFinal = $batalha['resultado'] === 'VITORIA'
                ? $this->evento(
                    'fim',
                    $this->mensagemVitoria((string) $batalha['tipo_encontro'])
                )
                : $this->evento('fim', 'Todos os seus Pokémon desmaiaram!');
            $eventos[] = $eventoFinal;
            $batalha['log'][] = $eventoFinal;
            $batalha['persistencia_pendente'] = true;
            $batalha['_interno']['eventos_turno_pendente'] = $eventos;
            $_SESSION['batalha'] = $batalha;

            return $this->persistirBatalhaFinalizada($batalha);
        }

        $batalha['turno']++;
        $_SESSION['batalha'] = $batalha;

        return [
            'eventos' => $eventos,
            'batalha' => $this->estadoPublico($batalha),
            'finalizada' => false,
            'resultado' => null,
        ];
    }

    private function persistirBatalhaFinalizada(array $batalha): array
    {
        if (($batalha['finalizada'] ?? false) !== true) {
            throw new RuntimeException('Não é possível persistir uma batalha não finalizada.');
        }

        $batalhaFinal = $batalha;
        $eventos = $batalha['_interno']['eventos_turno_pendente'] ?? [];
        // A recompensa é definida pelo tipo de encontro e concedida uma só vez,
        // na mesma transação que salva o resultado e o histórico da batalha.
        $dinheiroGanho = $batalha['resultado'] === 'VITORIA'
            ? match ($batalha['tipo_encontro']) {
                'selvagem' => self::RECOMPENSA_SELVA,
                'treinador' => self::RECOMPENSA_TREINADOR,
                'desafio' => self::RECOMPENSA_DESAFIO,
                default => 0,
            }
            : 0;
        $campeao = $batalha['resultado'] === 'VITORIA'
            && $batalha['tipo_encontro'] === 'desafio'
            && ($batalha['alvo']['tipo_desafio'] ?? '') === 'rival';
        $nomeJornadaDerrotada = null;
        $resumo = [
            'campeao' => $campeao,
            'resultado' => $batalha['resultado'],
            'pokemons' => [],
            'dinheiro_ganho' => $dinheiroGanho,
        ];
        $_SESSION['batalha'] = $batalha;

        try {
            $this->conn->beginTransaction();
            $idsStatus = $this->batalhaModel->encontrarIdsStatus();
            if ($batalha['resultado'] === 'VITORIA') {
                $resumo['pokemons'] = $this->aplicarVitoria(
                    $batalhaFinal,
                    $eventos
                );
            } else {
                foreach ($batalha['jogador']['time'] as $pokemon) {
                    $resumo['pokemons'][] = [
                        'nome' => $this->nomePokemon($pokemon),
                        'nivel_antes' => (int) $pokemon['nivel'],
                        'nivel_depois' => (int) $pokemon['nivel'],
                        'hp_final' => (int) $pokemon['atributos']['hp_atual'],
                    ];
                }
            }
            if ($dinheiroGanho > 0) {
                $eventos[] = $this->evento(
                    'recompensa',
                    'Você recebeu ₽ ' . $dinheiroGanho . '!'
                );
            }
            $batalhaFinal['log'] = array_merge(
                $batalhaFinal['log'],
                array_slice($eventos, count($batalha['_interno']['eventos_turno_pendente'] ?? []))
            );

            if ($batalha['resultado'] === 'VITORIA' && $batalha['tipo_encontro'] === 'treinador') {
                $this->batalhaModel->marcarTreinadorDerrotado(
                    (int) $batalha['id_perfil'],
                    (int) $batalha['alvo']['id']
                );
            } elseif ($batalha['resultado'] === 'VITORIA' && $batalha['tipo_encontro'] === 'desafio') {
                $this->batalhaModel->marcarDesafioConcluido(
                    (int) $batalha['id_perfil'],
                    (int) $batalha['alvo']['id']
                );
            } elseif ($batalha['resultado'] === 'VITORIA' && $batalha['tipo_encontro'] === 'selvagem') {
                $this->batalhaModel->marcarNoSelvagemConcluido(
                    (int) $batalha['id_perfil'],
                    (int) $batalha['alvo']['id']
                );
            }

            // Tanto treinadores quanto selvagens recebem a recompensa.
            // Executar aqui evita pagamentos duplicados para o mesmo encontro.
            if ($dinheiroGanho > 0) {
                $this->batalhaModel->adicionarDinheiroPerfil(
                    (int) $batalha['id_perfil'],
                    $dinheiroGanho
                );
            }

            $detalhesJson = json_encode(
                [
                    'tipo_encontro' => $batalha['tipo_encontro'],
                    'id_alvo' => (int) $batalha['alvo']['id'],
                    'turnos' => (int) $batalha['_interno']['turnos_processados'],
                    'log' => $batalhaFinal['log'],
                ],
                JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_THROW_ON_ERROR
            );
            $idBatalha = $this->batalhaModel->inserirHistorico(
                (int) $batalha['id_perfil'],
                $batalha['tipo_encontro'] === 'desafio'
                    ? (int) $batalha['alvo']['id']
                    : null,
                (string) $batalha['resultado'],
                $detalhesJson,
                (string) $batalha['iniciada_em'],
                $dinheiroGanho
            );

            foreach (['jogador', 'adversario'] as $lado) {
                foreach ($batalha[$lado]['time'] as $indice => $pokemon) {
                    $status = mb_strtolower(trim((string) $pokemon['status']));
                    $idStatus = $status === 'normal'
                        ? null
                        : ($idsStatus[$status] ?? null);
                    if ($status !== 'normal' && $idStatus === null) {
                        throw new RuntimeException('O status final de um Pokémon não existe no catálogo.');
                    }

                    $this->batalhaModel->inserirPokemonHistorico($idBatalha, [
                        'id_pokemon_time' => $lado === 'jogador'
                            ? (int) $pokemon['id_pokemon_time']
                            : null,
                        'id_pokemon_especie' => (int) $pokemon['id_pokemon_especie'],
                        'lado' => $lado === 'jogador' ? 'JOGADOR' : 'INIMIGO',
                        'ordem' => $lado === 'jogador'
                            ? (int) $pokemon['posicao']
                            : (int) ($pokemon['ordem'] ?? ($indice + 1)),
                        'nivel' => (int) $pokemon['nivel'],
                        'hp_inicial' => (int) $pokemon['hp_inicial'],
                        'hp_final' => (int) $pokemon['atributos']['hp_atual'],
                        'id_status_final' => $idStatus,
                        'id_held_item' => $pokemon['held_item']['id_held_item'] ?? null,
                    ]);
                }
            }

            // A derrota encerra a jornada somente se os logs e o restante da
            // batalha foram persistidos com sucesso. Tudo é atômico.
            if ($batalha['resultado'] === 'DERROTA') {
                $nomeJornadaDerrotada = (new EncerramentoJornada($this->conn))
                    ->encerrarPorDerrota((int) $batalha['id_perfil']);
            }
            $this->conn->commit();
        } catch (Throwable $e) {
            if ($this->conn->inTransaction()) {
                $this->conn->rollBack();
            }
            $batalha['persistencia_pendente'] = true;
            $_SESSION['batalha'] = $batalha;
            throw $e;
        }

        $batalhaFinal['_interno']['eventos_turno_pendente'] = [];
        $batalhaFinal['persistencia_pendente'] = false;
        unset($_SESSION['batalha']);
        if ($batalha['resultado'] === 'DERROTA') {
            $_SESSION['ultima_derrota'] = [
                'nome_jornada' => $nomeJornadaDerrotada,
                'equipe' => array_map(static function (array $pokemon): array {
                    return [
                        'nome' => $pokemon['nome_exibicao'] ?? $pokemon['nome_especie'],
                        'imagem_url' => $pokemon['imagem_url'],
                        'nivel' => (int) $pokemon['nivel'],
                        'hp_atual' => (int) $pokemon['atributos']['hp_atual'],
                        'hp_max' => (int) $pokemon['atributos']['hp_max'],
                    ];
                }, $batalhaFinal['jogador']['time']),
            ];
            if ((int) ($_SESSION['perfil']['id_perfil'] ?? 0) === (int) $batalha['id_perfil']) {
                unset($_SESSION['perfil']);
            }
            $resumo['jornada_encerrada'] = true;
        }

        return [
            'eventos' => $eventos,
            'batalha' => $this->estadoPublico($batalhaFinal),
            'finalizada' => true,
            'resultado' => $batalhaFinal['resultado'],
            'resumo' => $resumo,
        ];
    }

    private function aplicarVitoria(
        array &$batalha,
        array &$eventos
    ): array {
        $tipoEncontro = (string) $batalha['tipo_encontro'];
        $niveisGanhos = self::NIVEIS_POR_ENCONTRO[$tipoEncontro] ?? null;
        if ($niveisGanhos === null) {
            throw new RuntimeException('O tipo de encontro não possui regra de experiência.');
        }

        $idsEspecie = array_column($batalha['jogador']['time'], 'id_pokemon_especie');
        $especies = $this->encontro->encontrarDadosDasEspecies($idsEspecie);
        $resumo = [];
        $recuperacaoPercentual = self::RECUPERACAO_POS_VITORIA[$tipoEncontro] ?? 0;
        $reviverTime = $tipoEncontro === 'desafio';
        $quantidadeRecuperada = 0;
        foreach ($batalha['jogador']['time'] as &$pokemon) {
            $nivelAntes = (int) $pokemon['nivel'];
            $nomeAntesDaEvolucao = $this->nomePokemon($pokemon);
            $evolucoesVisuais = [];
            $nivelDepois = $nivelAntes;
            if ($pokemon['vivo_no_inicio']) {
                $nivelDepois = min(self::NIVEL_MAXIMO, $nivelAntes + $niveisGanhos);
            }

            if ($nivelDepois > $nivelAntes) {
                $idEspecie = (int) $pokemon['id_pokemon_especie'];
                $especie = $especies[$idEspecie] ?? null;
                if ($especie === null) {
                    throw new RuntimeException('A espécie do Pokémon não foi encontrada.');
                }
                $eventos[] = $this->evento(
                    'nivel',
                    $this->nomePokemon($pokemon) . ' subiu para o Nv. ' . $nivelDepois . '!'
                );

                $nivelEvolucao = $nivelAntes + 1;
                while ($nivelEvolucao <= $nivelDepois) {
                    $evolucao = $this->encontro->encontrarEvolucaoPorNivel($idEspecie, $nivelDepois);
                    if ($evolucao === null) {
                        break;
                    }

                    $idEspecie = (int) $evolucao['id_pokemon_destino'];
                    $destino = $this->encontro->encontrarDadosDasEspecies([$idEspecie])[$idEspecie] ?? null;
                    if ($destino === null) {
                        throw new RuntimeException('A espécie do Pokémon evoluído não foi encontrada.');
                    }

                    $evolucoesVisuais[] = [
                        'antes' => $especie['nome'],
                        'depois' => $destino['nome'],
                        'imagem_antes' => $especie['imagem_url'],
                        'imagem_depois' => $destino['imagem_url'],
                    ];
                    // A evolução permanece no histórico salvo. A interface a esconde
                    // durante o combate e mostra a animação após a vitória.
                    $eventos[] = $this->evento(
                        'evolucao',
                        $this->formatarNome($especie['nome']) . ' evoluiu para '
                        . $this->formatarNome($destino['nome']) . '!'
                    );
                    $especie = $destino;
                    $nivelEvolucao = max($nivelEvolucao, (int) $evolucao['nivel_requisito']) + 1;
                }

                if ($idEspecie !== (int) $pokemon['id_pokemon_especie']) {
                    $apelido = $pokemon['apelido'] ?? (
                        $pokemon['nome_exibicao'] !== $pokemon['nome_especie'] ? $pokemon['nome_exibicao'] : ''
                    );
                    $pokemon['id_pokemon_especie'] = $idEspecie;
                    $pokemon['nome_especie'] = $especie['nome'];
                    $pokemon['nome_exibicao'] = trim($apelido) !== '' ? $apelido : $especie['nome'];
                    $pokemon['imagem_url'] = $especie['imagem_url'];
                    $pokemon['tipos'] = $this->encontro->encontrarTiposDasEspecies([$idEspecie])[$idEspecie] ?? [];
                }

                $atributosAntigos = $pokemon['atributos'];
                $atributosNovos = $this->calculadora->calcular(
                    (int) $especie['hp_base'],
                    (int) $especie['ataque_base'],
                    (int) $especie['defesa_base'],
                    (int) $especie['ataque_especial_base'],
                    (int) $especie['defesa_especial_base'],
                    (int) $especie['velocidade_base'],
                    $nivelDepois
                );
                $hpAtual = (int) $atributosAntigos['hp_atual'];
                $atributosNovos['hp_atual'] = $hpAtual > 0
                    ? max(1, min(
                        $atributosNovos['hp_max'],
                        $hpAtual + ($atributosNovos['hp_max'] - (int) $atributosAntigos['hp_max'])
                    ))
                    : 0;
                $pokemon['nivel'] = $nivelDepois;
                $pokemon['atributos'] = $atributosNovos;
            }

            // A cura ocorre depois do ganho de nivel e de eventuais evolucoes.
            // Em desafios, inclusive os desmaiados recebem HP maximo e status normal.
            if ($this->recuperarPokemonAposVitoria($pokemon, $recuperacaoPercentual, $reviverTime)) {
                $quantidadeRecuperada++;
            }

            $this->batalhaModel->atualizarPokemonTime(
                (int) $batalha['id_perfil'],
                $pokemon
            );
            $resumo[] = [
                'nome' => $nomeAntesDaEvolucao,
                'nivel_antes' => $nivelAntes,
                'nivel_depois' => $nivelDepois,
                'hp_final' => (int) $pokemon['atributos']['hp_atual'],
                'evolucoes' => $evolucoesVisuais,
            ];
        }
        unset($pokemon);

        if ($reviverTime) {
            $eventos[] = $this->evento(
                'recuperacao',
                'Desafio vencido! Todo o time recuperou 100% do HP, os desmaiados reviveram e as condicoes foram curadas!'
            );
        } elseif ($quantidadeRecuperada > 0) {
            $eventos[] = $this->evento(
                'recuperacao',
                'A equipe recuperou parte do HP após a vitória!'
            );
        }

        return $resumo;
    }

    /** Atualiza o proprio Pokemon, antes de salva-lo em pokemon_time. */
    private function recuperarPokemonAposVitoria(array &$pokemon, int $percentual, bool $reviverTime): bool
    {
        $hpAtual = (int) $pokemon['atributos']['hp_atual'];
        $hpMaximo = (int) $pokemon['atributos']['hp_max'];

        if ($reviverTime) {
            $alterado = $hpAtual !== $hpMaximo || ($pokemon['status'] ?? 'normal') !== 'normal';
            $pokemon['atributos']['hp_atual'] = $hpMaximo;
            $pokemon['status'] = 'normal';
            unset($pokemon['turnos_condicao']);
            return $alterado;
        }

        // Selvagens e treinadores: sem reviver nem remover status negativos.
        if ($hpAtual <= 0 || $hpAtual >= $hpMaximo || $percentual <= 0) {
            return false;
        }
        $cura = intdiv($hpMaximo * $percentual + 99, 100);
        $pokemon['atributos']['hp_atual'] = min($hpMaximo, $hpAtual + $cura);
        return true;
    }

    /**
     * Cada condicao elegivel ocupa uma faixa exclusiva de 25% no sorteio.
     * Assim Dragon Breath possui 25% de Queimadura e 25% de Paralisia,
     * sem aplicar duas condicoes no mesmo golpe.
     * Golpes sem efeito secundario nao fazem sorteio.
     */
    private function sortearCondicaoSecundaria(array $condicoes): ?string
    {
        if ($condicoes === []) {
            return null;
        }

        $sorteio = $this->aleatoriedade->inteiro(1, 100);
        foreach (array_values(array_unique($condicoes)) as $indice => $condicao) {
            $limite = ($indice + 1) * self::CHANCE_EFEITO_SECUNDARIO;
            if ($sorteio <= $limite) {
                return $condicao;
            }
        }

        return null;
    }

    private function determinarOrdem(
        array $pokemonJogador,
        array $golpeJogador,
        array $pokemonAdversario,
        array $golpeAdversario
    ): array {
        $prioridadeJogador = (int) $golpeJogador['prioridade'];
        $prioridadeAdversario = (int) $golpeAdversario['prioridade'];
        if ($prioridadeJogador !== $prioridadeAdversario) {
            $jogadorPrimeiro = $prioridadeJogador > $prioridadeAdversario;
        } else {
            $velocidadeJogador = (int) $pokemonJogador['atributos']['velocidade'];
            $velocidadeAdversario = (int) $pokemonAdversario['atributos']['velocidade'];
            $jogadorPrimeiro = $velocidadeJogador === $velocidadeAdversario
                ? $this->aleatoriedade->inteiro(0, 1) === 0
                : $velocidadeJogador > $velocidadeAdversario;
        }

        return $jogadorPrimeiro
            ? [['jogador', $golpeJogador], ['adversario', $golpeAdversario]]
            : [['adversario', $golpeAdversario], ['jogador', $golpeJogador]];
    }

    private function executarGolpe(
        array &$batalha,
        string $ladoAtacante,
        array $golpe,
        array &$eventos
    ): void {
        $ladoDefensor = $ladoAtacante === 'jogador' ? 'adversario' : 'jogador';
        $indiceAtacante = (int) $batalha[$ladoAtacante]['indice_ativo'];
        $indiceDefensor = (int) $batalha[$ladoDefensor]['indice_ativo'];
        $atacante = &$batalha[$ladoAtacante]['time'][$indiceAtacante];
        $defensor = &$batalha[$ladoDefensor]['time'][$indiceDefensor];
        if (!$this->podeAtacar($atacante, $eventos)) {
            return;
        }
        $eventos[] = $this->evento(
            'golpe',
            $this->nomePokemon($atacante) . ' usou '
                . $this->formatarNome((string) $golpe['nome']) . '!'
        );

        $atributo = self::ATRIBUTO_POR_GOLPE_STATUS[$golpe['api_id'] ?? 0] ?? null;
        if ($atributo !== null) {
            $estagio = (int) ($atacante['estagios'][$atributo] ?? 0);
            $atacante['estagios'][$atributo] = min(
                self::LIMITE_ESTAGIOS_DE_ATAQUE,
                $estagio + self::ESTAGIOS_POR_GOLPE_DE_AUMENTO
            );
            $nomeAtributo = $atributo === 'ATAQUE' ? 'Ataque' : 'Ataque Especial';
            $eventos[] = $this->evento('status', $estagio >= self::LIMITE_ESTAGIOS_DE_ATAQUE
                ? $nomeAtributo . ' já está no máximo!'
                : $nomeAtributo . ' de ' . $this->nomePokemon($atacante) . ' aumentou!');
            return;
        }

        // Precisao de todos os golpes fixada em 100%; imunidades continuam valendo.

        $tabela = new TabelaEfetividade($batalha['_interno']['efetividades']);
        $efetividade = $tabela->contra(
            (string) $golpe['tipo'],
            $defensor['tipos'] ?? []
        );
        if ($efetividade === 0.0) {
            $eventos[] = $this->evento(
                'imunidade',
                'Não afetou ' . $this->nomePokemon($defensor) . '...'
            );
            return;
        }

        $critico = $this->aleatoriedade->inteiro(
            1,
            self::CHANCE_CRITICO_DENOMINADOR
        ) === 1;
        $fatorAleatorio = $this->aleatoriedade->inteiro(85, 100);
        $resultado = $this->calculadoraDano->calcular(
            $atacante,
            $defensor,
            $golpe,
            $efetividade,
            $critico,
            $fatorAleatorio
        );
        if ($resultado['critico']) {
            $eventos[] = $this->evento('critico', 'Um golpe crítico!');
        }
        if ($efetividade > 1.0) {
            $eventos[] = $this->evento('efetividade', 'Foi super efetivo!');
        } elseif ($efetividade < 1.0) {
            $eventos[] = $this->evento('efetividade', 'Não foi muito efetivo...');
        }

        $hpAtual = (int) $defensor['atributos']['hp_atual'];
        $defensor['atributos']['hp_atual'] = max(
            0,
            $hpAtual - (int) $resultado['dano']
        );
        $hpPerdido = $hpAtual - $defensor['atributos']['hp_atual'];
        $eventos[] = $this->evento('dano', $this->nomePokemon($defensor) . ' perdeu ' . $hpPerdido . ' HP.');
        if ($defensor['atributos']['hp_atual'] === 0) {
            $eventos[] = $this->evento(
                'desmaio',
                $this->nomePokemon($defensor) . ' desmaiou!'
            );
            return;
        }

        if ($defensor['status'] === 'normal') {
            $condicoes = [];
            $condicaoTipo = self::CONDICAO_POR_TIPO[(string) $golpe['tipo']] ?? null;
            $condicaoGolpe = self::CONDICAO_POR_GOLPE[(int) ($golpe['api_id'] ?? 0)] ?? null;
            if ($condicaoTipo !== null) {
                $condicoes[] = $condicaoTipo;
            }
            if ($condicaoGolpe !== null) {
                $condicoes[] = $condicaoGolpe;
            }
            $condicao = $this->sortearCondicaoSecundaria($condicoes);
            if ($condicao !== null) {
                $defensor['status'] = $condicao;
                $defensor['turnos_condicao'] = 0;
                $eventos[] = $this->evento('status', $this->nomePokemon($defensor) . ' recebeu ' . $condicao . '!');
            }
        }
    }

    private function selecionarGolpe(array $pokemon, int $idGolpe): array
    {
        $status = $pokemon['golpes']['status'] ?? null;
        if (isset(self::ATRIBUTO_POR_GOLPE_STATUS[$status['api_id'] ?? 0])
            && (int) $status['id_golpe'] === $idGolpe
        ) {
            return $status;
        }
        foreach ($pokemon['golpes']['dano'] as $golpe) {
            if ((int) $golpe['id_golpe'] === $idGolpe) {
                return $golpe;
            }
        }
        throw new ApiException('Esse golpe não pertence ao Pokémon ativo.', 422);
    }

    private function podeAtacar(array &$pokemon, array &$eventos): bool
    {
        $condicao = $pokemon['status'];
        if ($condicao === 'Paralisia' && $this->aleatoriedade->inteiro(1, 100) <= 20) {
            $eventos[] = $this->evento('status', $this->nomePokemon($pokemon) . ' travou de paralisia!');
            return false;
        }
        if ($condicao !== 'Sono' && $condicao !== 'Congelamento') {
            return true;
        }

        $turnos = (int) ($pokemon['turnos_condicao'] ?? 0) + 1;
        if ($turnos >= 3 || $this->aleatoriedade->inteiro(1, 100) <= 20) {
            $pokemon['status'] = 'normal';
            unset($pokemon['turnos_condicao']);
            $mensagem = $condicao === 'Sono' ? ' acordou!' : ' descongelou!';
            $eventos[] = $this->evento('status', $this->nomePokemon($pokemon) . $mensagem);
            return true;
        }

        $pokemon['turnos_condicao'] = $turnos;
        $mensagem = $condicao === 'Sono' ? ' está dormindo!' : ' está congelado!';
        $eventos[] = $this->evento('status', $this->nomePokemon($pokemon) . $mensagem);
        return false;
    }

    private function aplicarDanoDeCondicao(array &$batalha, array &$eventos): void
    {
        foreach (['jogador', 'adversario'] as $lado) {
            $pokemon = &$batalha[$lado]['time'][$batalha[$lado]['indice_ativo']];
            $percentual = match ($pokemon['status']) {
                'Queimadura' => 3,
                'Envenenamento' => 6,
                default => 0,
            };
            if ($percentual === 0 || (int) $pokemon['atributos']['hp_atual'] <= 0) {
                continue;
            }

            $dano = max(1, intdiv((int) $pokemon['atributos']['hp_max'] * $percentual, 100));
            $pokemon['atributos']['hp_atual'] = max(0, (int) $pokemon['atributos']['hp_atual'] - $dano);
            $nome = $this->nomePokemon($pokemon);
            $eventos[] = $this->evento('status', $nome . ' perdeu HP por ' . $pokemon['status'] . '!');
            if ($pokemon['atributos']['hp_atual'] === 0) {
                $eventos[] = $this->evento('desmaio', $nome . ' desmaiou!');
            }
        }
    }

    private function usarItemDeCura(array &$batalha, int $idItem, int $idAlvo, array &$eventos): void
    {
        $jogador = &$batalha['jogador'];
        $jogador['itens'] = (new UsoDeItens($this->conn))->itensDeBatalha((int) $batalha['id_perfil']);
        $indice = array_search($idAlvo, array_column($jogador['time'], 'id_pokemon_time'), true);
        if ($indice === false) {
            throw new ApiException('Pokémon não encontrado no seu time.', 404);
        }

        foreach ($jogador['itens'] as &$item) {
            if ((int) $item['id_item'] === $idItem) {
                $pokemon = &$jogador['time'][$indice];
                UsoDeItens::aplicarCura($item, $pokemon);
                $item['quantidade']--;
                $eventos[] = $this->evento('item', $item['nome'] . ' foi usado em ' . $this->nomePokemon($pokemon) . '!');
                return;
            }
        }

        throw new ApiException('Este item não está disponível no inventário.', 422);
    }

    private function trocarDesmaiadosAutomaticamente(array &$batalha, array &$eventos): void
    {
        foreach (['jogador', 'adversario'] as $lado) {
            $indiceAtivo = (int) $batalha[$lado]['indice_ativo'];
            $ativo = $batalha[$lado]['time'][$indiceAtivo] ?? null;
            if (!is_array($ativo) || (int) $ativo['atributos']['hp_atual'] > 0) {
                continue;
            }

            foreach ($batalha[$lado]['time'] as $indice => $pokemon) {
                if ((int) $pokemon['atributos']['hp_atual'] <= 0) {
                    continue;
                }
                $batalha[$lado]['indice_ativo'] = (int) $indice;
                $texto = $lado === 'jogador'
                    ? 'Vai! ' . $this->nomePokemon($pokemon) . '!'
                    : 'Treinador enviou ' . $this->nomePokemon($pokemon) . '!';
                $eventos[] = $this->evento('troca_automatica', $texto);
                break;
            }
        }
    }

    private function timePossuiPokemonVivo(array $time): bool
    {
        foreach ($time as $pokemon) {
            if ((int) $pokemon['atributos']['hp_atual'] > 0) {
                return true;
            }
        }

        return false;
    }

    private function estadoPublico(array $batalha): array
    {
        unset($batalha['_interno']);

        foreach (['jogador', 'adversario'] as $lado) {
            foreach ($batalha[$lado]['time'] as &$pokemon) {
                $pokemon['ataques_efetivos'] = [
                    'ataque' => $this->calculadoraDano->ataqueEfetivo($pokemon, 'ataque'),
                    'ataque_especial' => $this->calculadoraDano->ataqueEfetivo($pokemon, 'ataque_especial'),
                ];
            }
            unset($pokemon);
        }

        return $batalha;
    }

    private function inteiroSolicitado(mixed $valor, string $campo): int
    {
        if (
            !(is_int($valor) || (is_string($valor) && ctype_digit($valor)))
            || (int) $valor <= 0
        ) {
            throw new ApiException('O identificador do ' . $campo . ' é inválido.', 422);
        }

        return (int) $valor;
    }

    private function evento(string $tipo, string $texto): array
    {
        return ['tipo' => $tipo, 'texto' => $texto];
    }

    private function nomePokemon(array $pokemon): string
    {
        return $this->formatarNome(
            (string) ($pokemon['nome_exibicao'] ?? $pokemon['nome_especie'] ?? '')
        );
    }

    private function formatarNome(string $nome): string
    {
        return ucwords(str_replace('-', ' ', $nome));
    }

    private function mensagemVitoria(string $tipoEncontro): string
    {
        if ($tipoEncontro === 'treinador') {
            return 'Você venceu o treinador!';
        }
        if ($tipoEncontro === 'desafio') {
            return 'Você venceu o desafio!';
        }

        return 'Você venceu a batalha!';
    }

    public function obterEncontro(int $idPerfil, array $alvo): array
    {
        if (count($alvo) !== 1) {
            throw new ApiException(
                'Informe somente um id_npc_mapa, id_desafio ou id_mapa_no válido.',
                422
            );
        }

        $chave = array_key_first($alvo);
        if (!in_array($chave, ['id_npc_mapa', 'id_desafio', 'id_mapa_no'], true)) {
            throw new ApiException('O identificador do encontro é inválido.', 422);
        }

        $valorId = $alvo[$chave];
        if (
            !(is_int($valorId) || (is_string($valorId) && ctype_digit($valorId)))
            || (int) $valorId <= 0
        ) {
            throw new ApiException('O identificador do encontro é inválido.', 422);
        }

        $id = (int) $valorId;
        $estadoDesafios = $this->montador->obterEstadoDoPerfil($idPerfil);
        $area = (int) $estadoDesafios['area_atual'];

        if ($chave === 'id_npc_mapa') {
            $npc = $this->encontro->encontrarDoPerfil($id, $idPerfil);
            if ($npc === null) {
                throw new ApiException('Treinador não encontrado nesta jornada.', 404);
            }
            if ((int) $npc['derrotado'] === 1) {
                throw new ApiException('Este treinador já foi derrotado.', 409);
            }

            $timeAdversario = $this->montador->montarTimeTreinador(
                $idPerfil,
                (int) $npc['id_npc_mapa'],
                (int) $npc['id_npc_tipo']
            );

            return [
                'area_atual' => $area,
                'tipo_encontro' => 'treinador',
                'alvo' => [
                    'tipo' => 'treinador',
                    'id' => (int) $npc['id_npc_mapa'],
                    'nome' => 'Treinador tipo ' . $npc['tipo_nome'],
                ],
                'treinador' => [
                    'id_npc_mapa' => (int) $npc['id_npc_mapa'],
                    'tipo_nome' => $npc['tipo_nome'],
                    'descricao' => $npc['descricao'],
                ],
                'time_adversario' => $timeAdversario,
            ];
        }

        if ($chave === 'id_mapa_no') {
            $no = $this->encontro->encontrarNoSelvagemDoPerfil($id, $idPerfil);
            if ($no === null) {
                throw new ApiException('Encontro selvagem não encontrado nesta jornada.', 404);
            }
            if ($no['status'] !== 'DISPONIVEL') {
                throw new ApiException('Este encontro selvagem não está mais disponível.', 409);
            }

            return [
                'area_atual' => $area,
                'tipo_encontro' => 'selvagem',
                'alvo' => [
                    'tipo' => 'selvagem',
                    'id' => $id,
                    'nome' => 'Encontro selvagem',
                ],
                'time_adversario' => $this->montador->montarPokemonSelvagem(
                    $idPerfil,
                    $area
                ),
            ];
        }

        $desafio = $this->encontro->encontrarPorId($id);
        if ($desafio === null) {
            throw new ApiException('Desafio não encontrado.', 404);
        }

        $desafioAtual = $this->encontro->encontrarAtual($idPerfil);
        if (
            $desafioAtual === null
            || (int) $desafioAtual['id_desafio'] !== (int) $desafio['id_desafio']
        ) {
            throw new ApiException('Somente o desafio atual pode ser enfrentado.', 409);
        }

        $timeAdversario = $this->encontro->encontrarPokemon($id);
        if ($timeAdversario === []) {
            throw new RuntimeException('O desafio atual não possui Pokémon cadastrado.');
        }

        return [
            'area_atual' => $area,
            'tipo_encontro' => 'desafio',
            'alvo' => [
                'tipo' => 'desafio',
                'id' => (int) $desafio['id_desafio'],
                'nome' => $desafio['nome'],
                'tipo_desafio' => $desafio['tipo'],
            ],
            'desafio' => $desafio,
            'time_adversario' => $timeAdversario,
        ];
    }

    private function montarPokemonJogador(array $pokemon, array $catalogo): array
    {
        $idEspecie = (int) $pokemon['id_pokemon_especie'];
        $especie = $catalogo['especies'][$idEspecie] ?? null;
        if ($especie === null) {
            throw new RuntimeException('Uma espécie do time do jogador não foi encontrada.');
        }

        return [
            'id_pokemon_time' => (int) $pokemon['id_pokemon_time'],
            'id_pokemon_especie' => $idEspecie,
            'apelido' => $pokemon['apelido'] ?? null,
            'nome_exibicao' => trim((string) ($pokemon['apelido'] ?? '')) !== ''
                ? $pokemon['apelido']
                : $pokemon['nome_especie'],
            'nome_especie' => $pokemon['nome_especie'],
            'imagem_url' => $pokemon['imagem_url'],
            'tipos' => $catalogo['tipos'][$idEspecie] ?? [],
            'nivel' => (int) $pokemon['nivel'],
            'hp_inicial' => (int) $pokemon['hp_atual'],
            'vivo_no_inicio' => (int) $pokemon['hp_atual'] > 0,
            'atributos' => [
                'hp_max' => (int) $pokemon['hp_max'],
                'hp_atual' => (int) $pokemon['hp_atual'],
                'ataque' => (int) $pokemon['ataque'],
                'defesa' => (int) $pokemon['defesa'],
                'ataque_especial' => (int) $pokemon['ataque_especial'],
                'defesa_especial' => (int) $pokemon['defesa_especial'],
                'velocidade' => (int) $pokemon['velocidade'],
            ],
            'status' => (string) $pokemon['status'],
            'held_item' => $this->heldItemDoCatalogo(
                $pokemon['id_held_item'],
                $catalogo
            ),
            'golpes' => $this->golpesDoPokemon(
                $idEspecie,
                $pokemon['id_golpe_status'],
                $catalogo
            ),
            'estagios' => $this->estagiosIniciais(),
            'posicao' => (int) $pokemon['posicao'],
        ];
    }

    private function montarPokemonAdversario(array $pokemon, array $catalogo): array
    {
        $idEspecie = (int) $pokemon['id_pokemon_especie'];
        $especie = $catalogo['especies'][$idEspecie] ?? null;
        if ($especie === null) {
            throw new RuntimeException('Uma espécie do time adversário não foi encontrada.');
        }

        $nivel = (int) $pokemon['nivel'];
        $atributos = $this->calculadora->calcular(
            (int) $especie['hp_base'],
            (int) $especie['ataque_base'],
            (int) $especie['defesa_base'],
            (int) $especie['ataque_especial_base'],
            (int) $especie['defesa_especial_base'],
            (int) $especie['velocidade_base'],
            $nivel
        );
        $atributos['hp_atual'] = $atributos['hp_max'];

        return [
            'id_pokemon_especie' => $idEspecie,
            'nome_exibicao' => $especie['nome'],
            'nome_especie' => $especie['nome'],
            'imagem_url' => $especie['imagem_url'],
            'tipos' => $catalogo['tipos'][$idEspecie] ?? [],
            'nivel' => $nivel,
            'hp_inicial' => (int) $atributos['hp_atual'],
            'atributos' => $atributos,
            'status' => 'normal',
            'held_item' => $this->heldItemDoCatalogo(
                $pokemon['id_held_item'] ?? null,
                $catalogo
            ),
            'golpes' => $this->golpesDoPokemon(
                $idEspecie,
                $pokemon['id_golpe_status'] ?? null,
                $catalogo
            ),
            'estagios' => $this->estagiosIniciais(),
            'ordem' => (int) $pokemon['ordem'],
        ];
    }

    private function golpesDoPokemon(
        int $idEspecie,
        mixed $idGolpeStatus,
        array $catalogo
    ): array {
        $golpesDeDano = [];
        foreach ($catalogo['golpes_dano'][$idEspecie] ?? [] as $golpe) {
            $golpesDeDano[] = $this->formatarGolpe($golpe);
        }

        return [
            'dano' => $golpesDeDano,
            'status' => $this->golpeStatusDoPokemon($idEspecie, $idGolpeStatus, $catalogo),
        ];
    }

    private function golpeStatusDoPokemon(int $idEspecie, mixed $idGolpeStatus, array $catalogo): ?array
    {
        $opcoes = $catalogo['opcoes_status'][$idEspecie] ?? [];
        $idGolpeStatus = in_array((int) $idGolpeStatus, $opcoes, true)
            ? (int) $idGolpeStatus
            : ($opcoes[0] ?? null);
        $golpeStatus = $catalogo['golpes_status'][$idGolpeStatus] ?? null;

        return $golpeStatus === null ? null : $this->formatarGolpe($golpeStatus);
    }

    private function atualizarGolpesStatusDaSessao(array &$batalha): void
    {
        if (($batalha['_interno']['golpes_status_atualizados'] ?? false) || ($batalha['finalizada'] ?? false)) {
            return;
        }

        $idsEspecie = array_merge(
            array_column($batalha['jogador']['time'], 'id_pokemon_especie'),
            array_column($batalha['adversario']['time'], 'id_pokemon_especie')
        );
        $opcoes = $this->encontro->encontrarOpcoesDeGolpeStatus($idsEspecie);
        $catalogo = [
            'opcoes_status' => $opcoes,
            'golpes_status' => $this->encontro->encontrarGolpesPorIds(array_merge([], ...array_values($opcoes))),
        ];
        foreach (['jogador', 'adversario'] as $lado) {
            foreach ($batalha[$lado]['time'] as &$pokemon) {
                $pokemon['golpes']['status'] = $this->golpeStatusDoPokemon(
                    (int) $pokemon['id_pokemon_especie'],
                    $pokemon['golpes']['status']['id_golpe'] ?? null,
                    $catalogo
                );
            }
            unset($pokemon);
        }
        $batalha['_interno']['golpes_status_atualizados'] = true;
        $_SESSION['batalha'] = $batalha;
    }

    private function heldItemDoCatalogo(mixed $idHeldItem, array $catalogo): ?array
    {
        if ($idHeldItem === null) {
            return null;
        }

        $idHeldItem = (int) $idHeldItem;
        $item = $catalogo['held_items'][$idHeldItem] ?? null;
        if ($item === null) {
            throw new RuntimeException('Um held item configurado não foi encontrado.');
        }

        return [
            'id_held_item' => $idHeldItem,
            'nome' => $item['nome'],
            'tipo_efeito' => $item['tipo_efeito'],
            'base_calculo' => $item['base_calculo'],
            'numerador' => (int) $item['numerador'],
            'denominador' => (int) $item['denominador'],
            'gatilho' => $item['gatilho'],
            'limiar_hp' => $item['limiar_hp'] === null
                ? null
                : (int) $item['limiar_hp'],
            'consumivel' => (bool) $item['consumivel'],
        ];
    }

    private function formatarGolpe(array $golpe): array
    {
        return [
            'id_golpe' => (int) $golpe['id_golpe'],
            'api_id' => (int) ($golpe['api_id'] ?? 0),
            'nome' => $golpe['nome'],
            'tipo' => $golpe['tipo'],
            'categoria' => $golpe['categoria'],
            'poder' => $golpe['poder'] === null ? null : (int) $golpe['poder'],
            'precisao' => $golpe['precisao'] === null ? null : (int) $golpe['precisao'],
            'pp' => $golpe['pp'] === null ? null : (int) $golpe['pp'],
            'prioridade' => (int) $golpe['prioridade'],
            'classe_dano' => $golpe['classe_dano'],
            'descricao' => $golpe['descricao'],
        ];
    }

    private function estagiosIniciais(): array
    {
        return [
            'ATAQUE' => 0,
            'DEFESA' => 0,
            'ATAQUE_ESPECIAL' => 0,
            'DEFESA_ESPECIAL' => 0,
            'VELOCIDADE' => 0,
        ];
    }

    private function primeiroPokemonVivo(array $time): int
    {
        foreach ($time as $indice => $pokemon) {
            if ((int) $pokemon['atributos']['hp_atual'] > 0) {
                return $indice;
            }
        }

        throw new RuntimeException('O time adversário não possui Pokémon com HP.');
    }
}
