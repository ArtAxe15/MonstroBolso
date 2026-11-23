<?php

declare(strict_types=1);

namespace App\Domain;

/** Contrato abstrato dos tipos Pokémon. */
abstract class TipoPokemon
{
    public function __construct(protected string $nome) {}

    public function nome(): string
    {
        return $this->nome;
    }
}
