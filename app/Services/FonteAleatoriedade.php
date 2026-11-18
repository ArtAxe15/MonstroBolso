<?php

declare(strict_types=1);

namespace App\Services;

interface FonteAleatoriedade
{
    public function inteiro(int $minimo, int $maximo): int;
}
