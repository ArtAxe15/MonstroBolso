<?php

declare(strict_types=1);

namespace App\Services;

final class TabelaEfetividade
{
    private array $multiplicadores;

    public function __construct(array $linhas)
    {
        $this->multiplicadores = [];
        foreach ($linhas as $linha) {
            $atacante = (string) $linha['tipo_atacante'];
            $defensor = (string) $linha['tipo_defensor'];
            $this->multiplicadores[$atacante][$defensor] = (float) $linha['multiplicador'];
        }
    }

    public function contra(string $tipoAtacante, array $tiposDefensor): float
    {
        $multiplicador = 1.0;
        foreach ($tiposDefensor as $tipoDefensor) {
            $multiplicador *= $this->multiplicadores[$tipoAtacante][$tipoDefensor] ?? 1.0;
        }

        return $multiplicador;
    }
}
