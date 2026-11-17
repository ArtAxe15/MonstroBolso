<?php

declare(strict_types=1);

namespace App\Services;

use InvalidArgumentException;

final class CalculadoraAtributos
{
    private const MULTIPLICADOR_BASE = 2;
    private const DIVISOR_NIVEL = 100;
    private const BONUS_HP = 10;
    private const BONUS_OUTROS_ATRIBUTOS = 5;
    private const NIVEL_MINIMO = 1;
    private const NIVEL_MAXIMO = 100;

    public function calcular(
        int $hpBase,
        int $ataqueBase,
        int $defesaBase,
        int $ataqueEspecialBase,
        int $defesaEspecialBase,
        int $velocidadeBase,
        int $nivel
    ): array {
        if ($nivel < self::NIVEL_MINIMO || $nivel > self::NIVEL_MAXIMO) {
            throw new InvalidArgumentException('O nível deve estar entre 1 e 100.');
        }

        $bases = [
            'hp' => $hpBase,
            'ataque' => $ataqueBase,
            'defesa' => $defesaBase,
            'ataque_especial' => $ataqueEspecialBase,
            'defesa_especial' => $defesaEspecialBase,
            'velocidade' => $velocidadeBase,
        ];
        foreach ($bases as $atributo => $base) {
            if ($base < 0) {
                throw new InvalidArgumentException(
                    "O atributo base {$atributo} não pode ser negativo."
                );
            }
        }

        $calcularBase = static fn(int $base): int => intdiv(
            self::MULTIPLICADOR_BASE * $base * $nivel,
            self::DIVISOR_NIVEL
        );

        return [
            'hp_max' => $calcularBase($hpBase) + $nivel + self::BONUS_HP,
            'ataque' => $calcularBase($ataqueBase) + self::BONUS_OUTROS_ATRIBUTOS,
            'defesa' => $calcularBase($defesaBase) + self::BONUS_OUTROS_ATRIBUTOS,
            'ataque_especial' => $calcularBase($ataqueEspecialBase) + self::BONUS_OUTROS_ATRIBUTOS,
            'defesa_especial' => $calcularBase($defesaEspecialBase) + self::BONUS_OUTROS_ATRIBUTOS,
            'velocidade' => $calcularBase($velocidadeBase) + self::BONUS_OUTROS_ATRIBUTOS,
        ];
    }
}
