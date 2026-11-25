<?php

declare(strict_types=1);

namespace App\Services;

final class FonteAleatoriedadeNativa implements FonteAleatoriedade
{
    public function inteiro(int $minimo, int $maximo): int
    {
        return random_int($minimo, $maximo);
    }
}
