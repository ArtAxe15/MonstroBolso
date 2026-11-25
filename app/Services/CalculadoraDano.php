<?php

declare(strict_types=1);

namespace App\Services;

use InvalidArgumentException;

final class CalculadoraDano
{
    private const MULTIPLICADOR_CRITICO = 1.25;
    private const FATOR_STAB_NUMERADOR = 3;
    private const FATOR_STAB_DENOMINADOR = 2;
    private const EFETIVIDADE_ESCALA = 100;
    private const FATOR_ALEATORIO_MINIMO = 85;
    private const FATOR_ALEATORIO_MAXIMO = 100;

    public function ataqueEfetivo(array $pokemon, string $atributo): int
    {
        $base = (int) $pokemon['atributos'][$atributo];
        $estagio = (int) ($pokemon['estagios'][strtoupper($atributo)] ?? 0);

        return intdiv($base * (2 + max(0, $estagio)), 2);
    }

    public function calcular(
        array $atacante,
        array $defensor,
        array $golpe,
        float $efetividade,
        bool $critico,
        int $fatorAleatorio
    ): array {
        if ($efetividade < 0 || !is_finite($efetividade)) {
            throw new InvalidArgumentException('A efetividade do golpe é inválida.');
        }
        if (
            $fatorAleatorio < self::FATOR_ALEATORIO_MINIMO
            || $fatorAleatorio > self::FATOR_ALEATORIO_MAXIMO
        ) {
            throw new InvalidArgumentException('O fator aleatório deve estar entre 85 e 100.');
        }

        if ($efetividade === 0.0) {
            return ['dano' => 0, 'efetividade' => $efetividade, 'critico' => false];
        }

        $atributosDefensor = $defensor['atributos'];
        $classeDano = $golpe['classe_dano'] ?? null;
        if ($classeDano === 'PHYSICAL') {
            $ataque = $this->ataqueEfetivo($atacante, 'ataque');
            $defesa = (int) $atributosDefensor['defesa'];
        } elseif ($classeDano === 'SPECIAL') {
            $ataque = $this->ataqueEfetivo($atacante, 'ataque_especial');
            $defesa = (int) $atributosDefensor['defesa_especial'];
        } else {
            throw new InvalidArgumentException('A classe de dano do golpe é inválida.');
        }

        $nivel = (int) $atacante['nivel'];
        $poder = (int) ($golpe['poder'] ?? 0);
        if ($nivel < 1 || $poder <= 0 || $ataque < 0) {
            throw new InvalidArgumentException('Os dados do golpe ou do atacante são inválidos.');
        }

        $defesa = max(1, $defesa);
        $base = intdiv(
            intdiv((intdiv(2 * $nivel, 5) + 2) * $poder * $ataque, $defesa),
            50
        ) + 2;

        if ($critico) {
            $base = (int) floor(
                $base * self::MULTIPLICADOR_CRITICO
            );
        }

        $stab = in_array((string) $golpe['tipo'], $atacante['tipos'] ?? [], true);
        if ($stab) {
            $base = intdiv(
                $base * self::FATOR_STAB_NUMERADOR,
                self::FATOR_STAB_DENOMINADOR
            );
        }

        $efetividadeEscalada = (int) round($efetividade * self::EFETIVIDADE_ESCALA);
        $dano = intdiv($base * $efetividadeEscalada, self::EFETIVIDADE_ESCALA);
        $dano = intdiv($dano * $fatorAleatorio, self::EFETIVIDADE_ESCALA);

        return [
            'dano' => max(1, $dano),
            'efetividade' => $efetividade,
            'critico' => $critico,
        ];
    }
}
