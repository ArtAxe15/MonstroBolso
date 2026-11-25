<?php

declare(strict_types=1);

namespace App\Services;

use InvalidArgumentException;

final class CalculadoraAtributos
{
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

        return [
            'hp_max' => intdiv(2 * $hpBase * $nivel, 100) + $nivel + 10,
            'ataque' => intdiv(2 * $ataqueBase * $nivel, 100) + 5,
            'defesa' => intdiv(2 * $defesaBase * $nivel, 100) + 5,
            'ataque_especial' => intdiv(2 * $ataqueEspecialBase * $nivel, 100) + 5,
            'defesa_especial' => intdiv(2 * $defesaEspecialBase * $nivel, 100) + 5,
            'velocidade' => intdiv(2 * $velocidadeBase * $nivel, 100) + 5,
        ];
    }
}
