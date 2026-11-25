<?php

declare(strict_types=1);

namespace App\Services;

use App\Http\ApiException;
use App\Models\Batalha;
use App\Models\Encontro;
use PDO;
use Throwable;

final class UsoDeItens
{
    private Encontro $encontro;

    public function __construct(private PDO $conn)
    {
        $this->encontro = new Encontro($conn);
    }

    public function itensDeBatalha(int $idPerfil): array
    {
        $curas = $this->encontro->encontrarCurasDeStatus();
        $itens = [];
        foreach ($this->encontro->encontrarInventario($idPerfil) as $item) {
            if ($item['categoria'] !== 'EVOLUCAO') {
                $item['cura_status'] = $curas[(int) $item['id_item']] ?? [];
                $itens[] = $item;
            }
        }
        return $itens;
    }

    public static function aplicarCura(array $item, array &$pokemon): void
    {
        $atributos = &$pokemon['atributos'];
        $hp = (int) $atributos['hp_atual'];
        $maximo = (int) $atributos['hp_max'];
        $categoria = $item['categoria'];

        if ($hp === 0 && $categoria === 'REVIVE') {
            $atributos['hp_atual'] = max(1, intdiv($maximo * (int) $item['valor_efeito'], 100));
            $pokemon['status'] = 'normal';
            unset($pokemon['turnos_condicao']);
            return;
        }

        $curaHp = $hp > 0 && $hp < $maximo && in_array($categoria, ['HP', 'HP_STATUS'], true);
        $curaStatus = $hp > 0 && in_array($pokemon['status'], $item['cura_status'], true);
        if (!$curaHp && !$curaStatus) {
            throw new ApiException('Este item não tem efeito no Pokémon escolhido.', 422);
        }

        if ($curaHp) {
            $valor = (int) $item['valor_efeito'];
            $recuperacao = $item['tipo_efeito'] === 'PERCENTUAL' ? intdiv($maximo * $valor, 100) : $valor;
            $atributos['hp_atual'] = min($maximo, $hp + $recuperacao);
        }
        if ($curaStatus) {
            $pokemon['status'] = 'normal';
            unset($pokemon['turnos_condicao']);
        }
    }

    /** Retorna a mensagem e, quando houver evolução por item, os sprites para a cena visual. */
    public function usarNoMapa(int $idPerfil, int $idItem, int $idPokemon): array
    {
        $this->conn->beginTransaction();
        try {
            $itens = array_column($this->encontro->encontrarInventario($idPerfil), null, 'id_item');
            $item = $itens[$idItem] ?? null;
            if ($item === null) {
                throw new ApiException('Este item não está disponível no inventário.', 422);
            }

            $consulta = $this->conn->prepare(
                'SELECT pt.*, pe.nome AS nome_especie, pe.imagem_url AS imagem_especie FROM pokemon_time pt
                 JOIN pokemon_especie pe USING (id_pokemon_especie)
                 WHERE pt.id_perfil = ? AND pt.id_pokemon_time = ? FOR UPDATE'
            );
            $consulta->execute([$idPerfil, $idPokemon]);
            $pokemon = $consulta->fetch(PDO::FETCH_ASSOC);
            if ($pokemon === false) {
                throw new ApiException('Pokémon não encontrado nesta jornada.', 404);
            }

            $pokemon['atributos'] = array_intersect_key($pokemon, array_flip([
                'hp_atual', 'hp_max', 'ataque', 'defesa', 'ataque_especial', 'defesa_especial', 'velocidade',
            ]));
            $nome = trim((string) $pokemon['apelido']) ?: ucfirst($pokemon['nome_especie']);
            $evolucaoVisual = null;
            if ($item['categoria'] === 'EVOLUCAO') {
                // A atualização continua transacional, mas o navegador recebe os dois
                // sprites para exibir a mesma animação utilizada após as batalhas.
                $nomeAnterior = (string) $pokemon['nome_especie'];
                $imagemAnterior = (string) ($pokemon['imagem_especie'] ?? '');
                $destino = $this->evoluirComItem($idItem, $pokemon);
                $evolucaoVisual = [
                    'antes' => $nomeAnterior,
                    'depois' => (string) $destino['nome'],
                    'imagem_antes' => $imagemAnterior,
                    'imagem_depois' => (string) ($destino['imagem_url'] ?? ''),
                ];
                $mensagem = $nome . ' evoluiu para ' . ucfirst((string) $destino['nome']) . '!';
            } else {
                $item['cura_status'] = $this->encontro->encontrarCurasDeStatus()[$idItem] ?? [];
                self::aplicarCura($item, $pokemon);
                $mensagem = $item['nome'] . ' foi usado em ' . $nome . '!';
            }

            if (!$this->encontro->consumirItem($idPerfil, $idItem)) {
                throw new ApiException('Este item não está mais disponível.', 409);
            }

            (new Batalha($this->conn))->atualizarPokemonTime($idPerfil, $pokemon);
            $this->conn->commit();
            return ['message' => $mensagem, 'evolucao' => $evolucaoVisual];
        } catch (Throwable $e) {
            $this->conn->rollBack();
            throw $e;
        }
    }

    private function evoluirComItem(int $idItem, array &$pokemon): array
    {
        $consulta = $this->conn->prepare(
            "SELECT pe.* FROM evolucao e
             JOIN pokemon_especie pe ON pe.id_pokemon_especie = e.id_pokemon_destino
             JOIN item i ON i.id_item = :item
             WHERE e.id_pokemon_origem = :origem
               AND (e.id_item = i.id_item OR i.nome = 'Moon Stone')
             ORDER BY e.id_item <=> i.id_item DESC, e.id_evolucao
             LIMIT 1"
        );
        $consulta->execute(['item' => $idItem, 'origem' => $pokemon['id_pokemon_especie']]);
        $destino = $consulta->fetch(PDO::FETCH_ASSOC);
        if ($destino === false) {
            throw new ApiException('Este Pokémon não tem uma evolução disponível para o item.', 422);
        }

        $atributos = (new CalculadoraAtributos())->calcular(
            (int) $destino['hp_base'],
            (int) $destino['ataque_base'],
            (int) $destino['defesa_base'],
            (int) $destino['ataque_especial_base'],
            (int) $destino['defesa_especial_base'],
            (int) $destino['velocidade_base'],
            (int) $pokemon['nivel']
        );
        $hp = (int) $pokemon['hp_atual'];
        $atributos['hp_atual'] = $hp === 0 ? 0 : max(
            1,
            min($atributos['hp_max'], $hp + $atributos['hp_max'] - (int) $pokemon['hp_max'])
        );
        $pokemon['atributos'] = $atributos;
        $pokemon['id_pokemon_especie'] = (int) $destino['id_pokemon_especie'];

        return $destino;
    }
}