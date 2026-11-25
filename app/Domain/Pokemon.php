<?php

declare(strict_types=1);

namespace App\Domain;

use InvalidArgumentException;

/**
 * Entidade de domínio com mais de dez atributos e tipos agregados.
 * Os tipos são objetos, derivados de TipoPokemon. Isso permite Pokémon de dois
 * tipos sem herança múltipla (que PHP não suporta) e sem depender de traits.
 * Os dados são do banco; a classe não altera as regras de combate.
 */
final class Pokemon
{
    /** @var TipoPokemon[] */
    private array $tipos;

    public function __construct(
        private string $nome,
        private int $nivel,
        private int $hpMax,
        private int $hpAtual,
        private int $ataque,
        private int $defesa,
        private int $ataqueEspecial,
        private int $defesaEspecial,
        private int $velocidade,
        private string $status,
        TipoPokemon ...$tipos
    ) {
        if (count($tipos) < 1 || count($tipos) > 2) {
            throw new InvalidArgumentException('O Pokémon deve ter um ou dois tipos.');
        }
        $this->tipos = $tipos;
    }

    public function nome(): string
    {
        return $this->nome;
    }

    /** @return TipoPokemon[] */
    public function tipos(): array
    {
        return $this->tipos;
    }

    public function descreverTipos(): string
    {
        return implode(' / ', array_map(
            static fn(TipoPokemon $tipo): string => $tipo->nome(), $this->tipos
        ));
    }
}
