<?php

declare(strict_types=1);

namespace App\Services;

use InvalidArgumentException;

final class CalculadoraAtributos
{
    private const BONUS_POR_NIVEL = 3;
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

        $bonusNivel = self::BONUS_POR_NIVEL * ($nivel - 1);

        return [
            'hp_max' => $hpBase + $bonusNivel,
            'ataque' => $ataqueBase + $bonusNivel,
            'defesa' => $defesaBase + $bonusNivel,
            'ataque_especial' => $ataqueEspecialBase + $bonusNivel,
            'defesa_especial' => $defesaEspecialBase + $bonusNivel,
            'velocidade' => $velocidadeBase + $bonusNivel,
        ];
    }
}
