<?php

declare(strict_types=1);

namespace App\Domain;

/** Herda do tipo base. Pode representar Água, Terra, Grama etc. */
final class TipoElemental extends TipoPokemon
{
    public function __construct(string $nome)
    {
        parent::__construct($nome);
    }
}
