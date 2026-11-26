<?php
declare(strict_types=1);

namespace App\Services;

use App\Models\Encontro;
use PDO;
use RuntimeException;

final class MontadorTimeAdversario
{
    // O número de adversários segue o desafio, separadamente do estágio
    // evolutivo: a mudança da evolução NÃO altera o tamanho do time NPC.
    private const QUANTIDADE_TIME_POR_DESAFIO = [
        1 => [1, 1],
        2 => [2, 3],
        3 => [2, 3],
        4 => [3, 3],
        5 => [3, 3],
        6 => [3, 3],
    ];

    private const NIVEL_MAXIMO = 100;
    private const NIVEL_MINIMO = 1;

    private Encontro $encontro;
    private FonteAleatoriedade $aleatoriedade;

    public function __construct(PDO $conn, ?FonteAleatoriedade $aleatoriedade = null)
    {
        $this->encontro = new Encontro($conn);
        $this->aleatoriedade = $aleatoriedade ?? new FonteAleatoriedadeNativa();
    }

    public function obterEstadoDoPerfil(int $idPerfil): array
    {
        $rota = $this->encontro->encontrarRotaGerada($idPerfil);
        $area = $rota['area'] ?? $this->areaPorDesafiosConcluidos(
            $this->encontro->contarConcluidos($idPerfil)
        );

        $desafioAtual = $this->encontro->encontrarAtual($idPerfil);
        // A área de cenário (bioma sorteado) NÃO representa o avanço dos ginásios.
        // O estágio dos NPCs depende do próximo desafio, independentemente do bioma.
        $numeroDesafio = (int) ($desafioAtual['ordem'] ?? 6);

        $concluidos = $this->encontro->contarConcluidos($idPerfil);

        return [
            'area_atual' => $area,
            'estagio_npc' => self::estagioNpcSeguro($numeroDesafio, $concluidos),
            'desafio_atual' => $desafioAtual,
        ];
    }

    /**
     * Progressão dos NPCs determinada pelo próximo desafio, NÃO pelo bioma
     * aleatório do mapa: desafios 1–2 = inicial; 3–4 = intermediário;
     * 5–6 = final. O estágio muda só DEPOIS de vencer o ginásio de Água.
     */
    public static function estagioNpcPorDesafio(int $numeroDesafio): int
    {
        if ($numeroDesafio <= 2) {
            return 1;
        }
        if ($numeroDesafio <= 4) {
            return 2;
        }

        return 3;
    }

    /**
     * Defesa adicional contra evoluções antecipadas: não basta a área sorteada
     * nem uma rota antiga indicar estágio avançado; o progresso confirmado
     * do perfil também precisa permitir a evolução.
     */
    public static function estagioNpcSeguro(int $numeroDesafio, int $desafiosConcluidos): int
    {
        // 0–1 ginásios vencidos: inicial; 2–3: intermediário; 4–5: final.
        // Nunca permite a espécie do estágio seguinte antes da vitória.
        $estagioPorProgresso = $desafiosConcluidos <= 1 ? 1
            : ($desafiosConcluidos <= 3 ? 2 : 3);

        return min(self::estagioNpcPorDesafio($numeroDesafio), $estagioPorProgresso);
    }

    public function montarTimeTreinador(
        int $idPerfil,
        int $idNpcMapa,
        int $idNpcTipo
    ): array {
        // O bioma do mapa é sorteado e NÃO determina o estágio evolutivo do NPC.
        // Calculamos o estágio aqui, pelo desafio ainda não concluído, para
        // impedir que um chamador passe a área aleatória por engano.
        $desafioAtual = $this->encontro->encontrarAtual($idPerfil);
        $numeroDesafio = (int) ($desafioAtual['ordem'] ?? 6);
        $desafiosConcluidos = $this->encontro->contarConcluidos($idPerfil);
        $estagioNpc = self::estagioNpcSeguro($numeroDesafio, $desafiosConcluidos);

        $quantidade = self::QUANTIDADE_TIME_POR_DESAFIO[$numeroDesafio] ?? null;
        if ($quantidade === null) {
            throw new RuntimeException('Não há regras configuradas para o próximo desafio do NPC.');
        }

        $nivelTreinador = $this->nivelDaEquipe($idPerfil, 'treinador');


        $slots = $this->encontro->encontrarEspeciesPorArea($idNpcTipo, $estagioNpc);
        if (count($slots) < $quantidade[0]) {
            throw new RuntimeException('O treinador não possui Pokémon suficiente cadastrado para esta área.');
        }

        $seed = hash('sha256', $idNpcMapa . ':' . $estagioNpc);
        usort($slots, static function (array $a, array $b) use ($seed): int {
            $hashA = hash('sha256', $seed . ':slot:' . (int) $a['posicao']);
            $hashB = hash('sha256', $seed . ':slot:' . (int) $b['posicao']);
            $comparacao = strcmp($hashA, $hashB);

            return $comparacao !== 0
                ? $comparacao
                : ((int) $a['posicao'] <=> (int) $b['posicao']);
        });

        $quantidadePokemon = $this->numeroDeterministico(
            $seed,
            $quantidade[0],
            $quantidade[1],
            'quantidade'
        );
        if (count($slots) < $quantidadePokemon) {
            throw new RuntimeException('O treinador não possui todos os Pokémon exigidos para esta área.');
        }
        $slotsSelecionados = array_slice($slots, 0, $quantidadePokemon);
        usort(
            $slotsSelecionados,
            static fn(array $a, array $b): int => (int) $a['posicao'] <=> (int) $b['posicao']
        );

        $idsEspecie = array_map(
            static fn(array $slot): int => (int) $slot['id_pokemon_especie'],
            $slotsSelecionados
        );
        $especies = $this->encontro->encontrarComTipos($idsEspecie);

        $time = [];
        foreach ($slotsSelecionados as $indice => $slot) {
            $idEspecie = (int) $slot['id_pokemon_especie'];
            if (!isset($especies[$idEspecie])) {
                throw new RuntimeException('Uma espécie configurada para o treinador não foi encontrada.');
            }

            $time[] = [
                'id_pokemon_especie' => $idEspecie,
                'nome' => $especies[$idEspecie]['nome'],
                'imagem_url' => $especies[$idEspecie]['imagem_url'],
                'tipos' => $especies[$idEspecie]['tipos'],
                'nivel' => $nivelTreinador,
                'ordem' => $indice + 1,
            ];
        }

        return $time;
    }

    public function montarPokemonSelvagem(
        int $idPerfil,
        int $estagioEvolutivo
    ): array {
        $nivel = $this->nivelDaEquipe($idPerfil, 'selvagem');
        $idsEspecie = $this->encontro->encontrarEspeciesSelvagensPorArea($estagioEvolutivo);
        if ($idsEspecie === []) {
            throw new RuntimeException('Não há Pokémon selvagens cadastrados para esta área.');
        }

        $idEspecie = $idsEspecie[
            $this->aleatoriedade->inteiro(0, count($idsEspecie) - 1)
        ];
        $especie = $this->encontro->encontrarComTipos([$idEspecie])[$idEspecie] ?? null;
        if ($especie === null) {
            throw new RuntimeException('A espécie escolhida para o encontro selvagem não foi encontrada.');
        }

        return [
            [
                'id_pokemon_especie' => $idEspecie,
                'id_held_item' => null,
                'id_golpe_status' => null,
                'nome' => $especie['nome'],
                'imagem_url' => $especie['imagem_url'],
                'tipos' => $especie['tipos'],
                'nivel' => $nivel,
                'ordem' => 1,
            ],
        ];
    }

    /**
     * Treinadores: nível do Pokémon vivo mais forte - 5 (com teto no próximo
     * desafio). Selvagens: segundo mais forte - margem adaptativa original.
     * Os chefes continuam em seus níveis fixos.
     * Método independente do banco para testes rápidos.
     */
    public static function calcularNivelAdaptativo(array $niveis, string $tipo, ?int $nivelMaximoDesafio = null): int
    {
        if (!in_array($tipo, ['treinador', 'selvagem'], true)) {
            throw new \InvalidArgumentException('O tipo de encontro adaptativo é inválido.');
        }

        $niveis = array_values(array_filter(
            array_map('intval', $niveis),
            static fn(int $nivel): bool => $nivel >= 1 && $nivel <= self::NIVEL_MAXIMO
        ));
        if ($niveis === []) {
            throw new RuntimeException('Não existe Pokémon apto a lutar para calcular o nível adversário.');
        }

        rsort($niveis, SORT_NUMERIC);
        // Selvagens e treinadores: 5 níveis abaixo do
        // Pokémon vivo mais forte do jogador.
        $nivel = max(self::NIVEL_MINIMO, $niveis[0] - 5);

        // Mantém o limite do próximo chefe apenas para treinadores.
        if ($tipo === 'treinador' && $nivelMaximoDesafio !== null) {
            $nivel = min(
                $nivel,
                max(self::NIVEL_MINIMO, $nivelMaximoDesafio - 2)
            );
        }

        return min(self::NIVEL_MAXIMO, $nivel);
    }

    private function nivelDaEquipe(int $idPerfil, string $tipo): int
    {
        $niveis = $this->encontro->encontrarNiveisAtivosDoTime($idPerfil);
        $desafio = $this->encontro->encontrarAtual($idPerfil);
        $limites = $desafio === null ? null : $this->encontro->encontrarLimitesDeNivel(
            (int) $desafio['ordem'],
            (int) $desafio['ordem']
        );

        return self::calcularNivelAdaptativo(
            $niveis,
            $tipo,
            $limites === null ? null : (int) $limites['nivel_maximo']
        );
    }

    private function areaPorDesafiosConcluidos(int $quantidadeConcluida): int
    {
        if ($quantidadeConcluida <= 1) {
            return 1;
        }
        if ($quantidadeConcluida <= 3) {
            return 2;
        }

        return 3;
    }

    private function numeroDeterministico(
        string $seed,
        int $minimo,
        int $maximo,
        string $chave
    ): int {
        if ($maximo < $minimo) {
            throw new RuntimeException('Não é possível gerar um número dentro da faixa configurada.');
        }

        $valor = (int) hexdec(substr(hash('sha256', $seed . ':' . $chave), 0, 7));

        return $minimo + ($valor % ($maximo - $minimo + 1));
    }
}
