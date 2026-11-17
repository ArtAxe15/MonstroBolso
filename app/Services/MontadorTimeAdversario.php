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
    private const NIVEL_INICIAL_TREINADOR = 3;
    private const REDUCAO_NIVEL_MAXIMO = 2;
    private const ORDEM_DESAFIO_FINAL = 6;

    private Encontro $encontro;

    public function __construct(PDO $conn)
    {
        $this->encontro = new Encontro($conn);
    }

    public function obterEstadoDoPerfil(int $idPerfil): array
    {
        $area = $this->areaPorDesafiosConcluidos(
            $this->encontro->contarConcluidos($idPerfil)
        );

        return [
            'area_atual' => $area,
            'desafio_atual' => $this->encontro->encontrarAtual($idPerfil),
        ];
    }

    public function montarTimeTreinador(
        int $idNpcMapa,
        int $idNpcTipo,
        int $area,
        int $posicaoY,
        ?array $desafioAtual,
        array $limitesVerticais
    ): array {
        $quantidade = self::QUANTIDADE_TIME_POR_AREA[$area] ?? null;
        if ($quantidade === null) {
            throw new RuntimeException('Não há regras configuradas para a área atual.');
        }

        $ordemDesafio = $desafioAtual === null
            ? self::ORDEM_DESAFIO_FINAL
            : (int) $desafioAtual['ordem'];
        if ($ordemDesafio < 1 || $ordemDesafio > self::ORDEM_DESAFIO_FINAL) {
            throw new RuntimeException('A ordem do desafio atual é inválida.');
        }

        $limitesDesafioAtual = $this->encontro->encontrarLimitesDeNivel(
            $ordemDesafio,
            $ordemDesafio
        );
        if ($limitesDesafioAtual === null) {
            throw new RuntimeException('Não há níveis cadastrados para o desafio atual.');
        }

        if ($ordemDesafio === 1) {
            $nivelMinimo = self::NIVEL_INICIAL_TREINADOR;
        } else {
            $limitesDesafioAnterior = $this->encontro->encontrarLimitesDeNivel(
                $ordemDesafio - 1,
                $ordemDesafio - 1
            );
            if ($limitesDesafioAnterior === null) {
                throw new RuntimeException('Não há níveis cadastrados para o desafio anterior.');
            }
            $nivelMinimo = $limitesDesafioAnterior['nivel_minimo'];
        }

        $nivelMinimo = max(self::NIVEL_MINIMO, min(self::NIVEL_MAXIMO, $nivelMinimo));
        $nivelMaximo = max(
            self::NIVEL_MINIMO,
            min(
                self::NIVEL_MAXIMO,
                $limitesDesafioAtual['nivel_maximo'] - self::REDUCAO_NIVEL_MAXIMO
            )
        );
        if ($nivelMaximo < $nivelMinimo) {
            throw new RuntimeException('A faixa de nível configurada para esta área é inválida.');
        }

        if (
            !isset($limitesVerticais['posicao_superior'], $limitesVerticais['posicao_inferior'])
            || $limitesVerticais['posicao_inferior'] < $limitesVerticais['posicao_superior']
        ) {
            throw new RuntimeException('As posições dos treinadores desta jornada são inválidas.');
        }
        $nivelTreinador = $this->nivelPorPosicao(
            $posicaoY,
            (int) $limitesVerticais['posicao_superior'],
            (int) $limitesVerticais['posicao_inferior'],
            $nivelMinimo,
            $nivelMaximo
        );

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

    private function nivelPorPosicao(
        int $posicaoY,
        int $posicaoSuperior,
        int $posicaoInferior,
        int $nivelMinimo,
        int $nivelMaximo
    ): int {
        if ($posicaoInferior === $posicaoSuperior) {
            return $nivelMinimo;
        }

        $posicaoY = max($posicaoSuperior, min($posicaoInferior, $posicaoY));
        $progresso = ($posicaoInferior - $posicaoY)
            / ($posicaoInferior - $posicaoSuperior);

        return $nivelMinimo + (int) floor($progresso * ($nivelMaximo - $nivelMinimo));
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
