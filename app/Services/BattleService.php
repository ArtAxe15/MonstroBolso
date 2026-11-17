<?php

declare(strict_types=1);

namespace App\Services;

use App\Http\ApiException;
use App\Models\Encontro;
use PDO;
use RuntimeException;

final class BattleService
{
    private Encontro $encontro;
    private MontadorTimeAdversario $montador;
    private CalculadoraAtributos $calculadora;

    public function __construct(PDO $conn)
    {
        $this->encontro = new Encontro($conn);
        $this->montador = new MontadorTimeAdversario($conn);
        $this->calculadora = new CalculadoraAtributos();
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
        $idsGolpeStatus = array_merge(
            array_column($timeJogadorBanco, 'id_golpe_status'),
            array_column($timeAdversarioBanco, 'id_golpe_status')
        );
        $idsHeldItem = array_merge(
            array_column($timeJogadorBanco, 'id_held_item'),
            array_column($timeAdversarioBanco, 'id_held_item')
        );

        $catalogo = [
            'especies' => $this->encontro->encontrarDadosDasEspecies($idsEspecie),
            'tipos' => $this->encontro->encontrarTiposDasEspecies($idsEspecie),
            'golpes_dano' => $this->encontro->encontrarGolpesDeDanoDasEspecies($idsEspecie),
            'golpes_status' => $this->encontro->encontrarGolpesPorIds($idsGolpeStatus),
            'held_items' => $this->encontro->encontrarItensPorIds($idsHeldItem),
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
            'alvo' => $encontro['alvo'],
            'iniciada_em' => date(DATE_ATOM),
            'jogador' => [
                'indice_ativo' => $this->primeiroPokemonVivo($timeJogador),
                'time' => $timeJogador,
                'itens' => $this->encontro->encontrarInventario($idPerfil),
            ],
            'adversario' => [
                'indice_ativo' => $this->primeiroPokemonVivo($timeAdversario),
                'time' => $timeAdversario,
            ],
        ];

        $_SESSION['batalha'] = $batalha;

        return $batalha;
    }

    public function obterEstado(int $idPerfil): ?array
    {
        $batalha = $_SESSION['batalha'] ?? null;
        if (!is_array($batalha) || !isset($batalha['id_perfil'])) {
            return null;
        }

        return (int) $batalha['id_perfil'] === $idPerfil ? $batalha : null;
    }

    public function obterEncontro(int $idPerfil, array $alvo): array
    {
        if (count($alvo) !== 1) {
            throw new ApiException(
                'Informe somente um id_npc_mapa ou id_desafio válido.',
                422
            );
        }

        $chave = array_key_first($alvo);
        if (!in_array($chave, ['id_npc_mapa', 'id_desafio'], true)) {
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

            $limitesVerticais = $this->encontro->encontrarLimitesVerticaisDoPerfil($idPerfil);
            if ($limitesVerticais === null) {
                throw new RuntimeException(
                    'Não há posições de treinador cadastradas nesta jornada.'
                );
            }

            $timeAdversario = $this->montador->montarTimeTreinador(
                (int) $npc['id_npc_mapa'],
                (int) $npc['id_npc_tipo'],
                $area,
                (int) $npc['posicao_y'],
                $estadoDesafios['desafio_atual'],
                $limitesVerticais
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
            'nome_exibicao' => trim((string) ($pokemon['apelido'] ?? '')) !== ''
                ? $pokemon['apelido']
                : $pokemon['nome_especie'],
            'nome_especie' => $pokemon['nome_especie'],
            'imagem_url' => $pokemon['imagem_url'],
            'tipos' => $catalogo['tipos'][$idEspecie] ?? [],
            'nivel' => (int) $pokemon['nivel'],
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

        $golpeStatus = null;
        if ($idGolpeStatus !== null) {
            $idGolpeStatus = (int) $idGolpeStatus;
            $golpeStatus = $catalogo['golpes_status'][$idGolpeStatus] ?? null;
            if ($golpeStatus === null) {
                throw new RuntimeException('Um golpe de status configurado não foi encontrado.');
            }
            $golpeStatus = $this->formatarGolpe($golpeStatus);
        }

        return [
            'dano' => $golpesDeDano,
            'status' => $golpeStatus,
        ];
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