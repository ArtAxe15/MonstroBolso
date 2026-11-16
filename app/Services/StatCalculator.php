<?php

declare(strict_types=1);

namespace App\Services;

final class StatCalculator
{
    private const FATOR_CRESCIMENTO = 0.06;

    public static function calcular(int $base, int $nivel): int
    {
        if ($nivel <= 1) {
            return $base;
        }

        return (int) floor($base * (1 + self::FATOR_CRESCIMENTO * ($nivel - 1)));
    }

    public static function calcularHp(int $base, int $nivel): int
    {
        return self::calcular($base, $nivel);
    }

    /**
     * Helper para montar os stats de uma espécie em um nível específico.
     */
    public static function calcularStatsEspecie(array $especie, int $nivel): array
    {
        if (!isset($especie['hp_base'], $especie['ataque_base'], $especie['defesa_base'], $especie['ataque_especial_base'], $especie['defesa_especial_base'], $especie['velocidade_base'])) {
            throw new \InvalidArgumentException('Dados da espécie incompletos para cálculo de stats.');
        }

        return [
            'nivel' => $nivel,
            'hp_max' => self::calcularHp((int) $especie['hp_base'], $nivel),
            'ataque' => self::calcular((int) $especie['ataque_base'], $nivel),
            'defesa' => self::calcular((int) $especie['defesa_base'], $nivel),
            'ataque_especial' => self::calcular((int) $especie['ataque_especial_base'], $nivel),
            'defesa_especial' => self::calcular((int) $especie['defesa_especial_base'], $nivel),
            'velocidade' => self::calcular((int) $especie['velocidade_base'], $nivel),
        ];
    }
}
