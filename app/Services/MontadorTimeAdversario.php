<?php
declare(strict_types=1);

namespace App\Services;

use App\Models\Encontro;
use PDO;
use RuntimeException;

final class MontadorTimeAdversario
{
    private const QUANTIDADE_TIME_POR_AREA = [
        1 => [1, 2],
        2 => [2, 3],
        3 => [3, 3],
    ];

    private const NIVEL_MAXIMO = 100;
    private const NIVEL_MINIMO = 1;

    private Encontro $encontro;
    private FonteAleatoriedade $aleatoriedade;

    public function __construct(PDO $conn, ?FonteAleatoriedade $aleatoriedade = null)
    {
        $this->encontro = new Encontro($conn);
        $this->aleatoriedade = $aleatoriedade ?? new FonteAleatoriedadeNativa();
    }

    public function obterEstadoDoPerfil(int $idPerfil): array
    {
        $rota = $this->encontro->encontrarRotaGerada($idPerfil);
        $area = $rota['area'] ?? $this->areaPorDesafiosConcluidos(
            $this->encontro->contarConcluidos($idPerfil)
        );

        return [
            'area_atual' => $area,
            'desafio_atual' => $this->encontro->encontrarAtual($idPerfil),
        ];
    }

    public function montarTimeTreinador(
        int $idPerfil,
        int $idNpcMapa,
        int $idNpcTipo,
        int $area
    ): array {
        $quantidade = self::QUANTIDADE_TIME_POR_AREA[$area] ?? null;
        if ($quantidade === null) {
            throw new RuntimeException('Não há regras configuradas para a área atual.');
        }

        $nivelTreinador = $this->nivelDaEquipe($idPerfil);


        $slots = $this->encontro->encontrarEspeciesPorArea($idNpcTipo, $area);
        if (count($slots) < $quantidade[0]) {
            throw new RuntimeException('O treinador não possui Pokémon suficiente cadastrado para esta área.');
        }

        $seed = hash('sha256', $idNpcMapa . ':' . $area);
        usort($slots, static function (array $a, array $b) use ($seed): int {
            $hashA = hash('sha256', $seed . ':slot:' . (int) $a['posicao']);
            $hashB = hash('sha256', $seed . ':slot:' . (int) $b['posicao']);
            $comparacao = strcmp($hashA, $hashB);

            return $comparacao !== 0
                ? $comparacao
                : ((int) $a['posicao'] <=> (int) $b['posicao']);
        });

        $quantidadePokemon = $this->numeroDeterministico(
            $seed,
            $quantidade[0],
            $quantidade[1],
            'quantidade'
        );
        if (count($slots) < $quantidadePokemon) {
            throw new RuntimeException('O treinador não possui todos os Pokémon exigidos para esta área.');
        }
        $slotsSelecionados = array_slice($slots, 0, $quantidadePokemon);
        usort(
            $slotsSelecionados,
            static fn(array $a, array $b): int => (int) $a['posicao'] <=> (int) $b['posicao']
        );

        $idsEspecie = array_map(
            static fn(array $slot): int => (int) $slot['id_pokemon_especie'],
            $slotsSelecionados
        );
        $especies = $this->encontro->encontrarComTipos($idsEspecie);

        $time = [];
        foreach ($slotsSelecionados as $indice => $slot) {
            $idEspecie = (int) $slot['id_pokemon_especie'];
            if (!isset($especies[$idEspecie])) {
                throw new RuntimeException('Uma espécie configurada para o treinador não foi encontrada.');
            }

            $time[] = [
                'id_pokemon_especie' => $idEspecie,
                'nome' => $especies[$idEspecie]['nome'],
                'imagem_url' => $especies[$idEspecie]['imagem_url'],
                'tipos' => $especies[$idEspecie]['tipos'],
                'nivel' => $nivelTreinador,
                'ordem' => $indice + 1,
            ];
        }

        return $time;
    }

    public function montarPokemonSelvagem(
        int $idPerfil,
        int $area
    ): array {
        $nivel = $this->nivelDaEquipe($idPerfil);
        $idsEspecie = $this->encontro->encontrarEspeciesSelvagensPorArea($area);
        if ($idsEspecie === []) {
            throw new RuntimeException('Não há Pokémon selvagens cadastrados para esta área.');
        }

        $idEspecie = $idsEspecie[
            $this->aleatoriedade->inteiro(0, count($idsEspecie) - 1)
        ];
        $especie = $this->encontro->encontrarComTipos([$idEspecie])[$idEspecie] ?? null;
        if ($especie === null) {
            throw new RuntimeException('A espécie escolhida para o encontro selvagem não foi encontrada.');
        }

        return [
            [
                'id_pokemon_especie' => $idEspecie,
                'id_held_item' => null,
                'id_golpe_status' => null,
                'nome' => $especie['nome'],
                'imagem_url' => $especie['imagem_url'],
                'tipos' => $especie['tipos'],
                'nivel' => $nivel,
                'ordem' => 1,
            ],
        ];
    }

    /** Treinadores comuns e selvagens ficam três níveis abaixo do melhor Pokémon no time. */
    private function nivelDaEquipe(int $idPerfil): int
    {
        $nivelMaisAlto = $this->encontro->encontrarMaiorNivelDoTime($idPerfil);
        if ($nivelMaisAlto === null) {
            throw new RuntimeException('Não existe Pokémon no time para calcular o nível adversário.');
        }
        return max(self::NIVEL_MINIMO, min(self::NIVEL_MAXIMO, $nivelMaisAlto - 3));
    }

    private function areaPorDesafiosConcluidos(int $quantidadeConcluida): int
    {
        if ($quantidadeConcluida <= 1) {
            return 1;
        }
        if ($quantidadeConcluida <= 3) {
            return 2;
        }

        return 3;
    }

    private function numeroDeterministico(
        string $seed,
        int $minimo,
        int $maximo,
        string $chave
    ): int {
        if ($maximo < $minimo) {
            throw new RuntimeException('Não é possível gerar um número dentro da faixa configurada.');
        }

        $valor = (int) hexdec(substr(hash('sha256', $seed . ':' . $chave), 0, 7));

        return $minimo + ($valor % ($maximo - $minimo + 1));
    }
}
