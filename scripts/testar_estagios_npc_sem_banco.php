<?php
declare(strict_types=1);

/**
 * Execute: php scripts/testar_estagios_npc_sem_banco.php
 * Testa a seleção COMPLETA do time NPC com PDO simulado, nos seis ginásios
 * e nos três biomas. Não modifica o banco de dados.
 */
require_once dirname(__DIR__) . '/app/Autoload.php';

use App\Services\MontadorTimeAdversario;
use App\Services\BattleService;

final class NpcTesteStatement extends PDOStatement
{
    private array $resultado = [];

    public function __construct(private NpcTestePDO $pdo, private string $sql) {}

    public function execute(?array $params = null): bool
    {
        $params ??= [];
        $dados = $this->pdo->fixture;
        if (str_contains($this->sql, 'SELECT COUNT(*)') && str_contains($this->sql, 'FROM progresso_desafio')) {
            $this->resultado = [['total' => $this->pdo->concluidos]];
        } elseif (str_contains($this->sql, 'FROM desafio d') && str_contains($this->sql, 'NOT EXISTS')) {
            $this->resultado = [['id_desafio' => $this->pdo->gin, 'ordem' => $this->pdo->gin, 'nome' => 'Ginásio', 'tipo' => 'ginasio']];
        } elseif (str_contains($this->sql, 'FROM pokemon_time') && str_contains($this->sql, 'ORDER BY nivel')) {
            $this->resultado = [['nivel' => 21], ['nivel' => 18]];
        } elseif (str_contains($this->sql, 'MIN(dp.nivel)')) {
            $this->resultado = [['nivel_minimo' => 12, 'nivel_maximo' => 50]];
        } elseif (str_contains($this->sql, 'SELECT DISTINCT') && str_contains($this->sql, 'FROM npc_tipo_pokemon')) {
            preg_match('/SELECT DISTINCT id_pokemon_([0-9_]+)/', $this->sql, $matches);
            $col = ['0_1' => 0, '2_3' => 1, '4_6' => 2][$matches[1] ?? ''] ?? null;
            if ($col === null) throw new RuntimeException('Coluna selvagem inválida');
            $ids = [];
            foreach ($dados['npcs'] as $grupo) {
                foreach ($grupo as $r) $ids[$r['stages'][$col]] = true;
            }
            $this->resultado = array_map(static fn($id) => [$id], array_keys($ids));
        } elseif (str_contains($this->sql, 'FROM npc_tipo_pokemon')) {
            preg_match('/id_pokemon_([0-9_]+) AS id_pokemon_especie/', $this->sql, $matches);
            $col = ['0_1' => 0, '2_3' => 1, '4_6' => 2][$matches[1] ?? ''] ?? null;
            if ($col === null) throw new RuntimeException('Coluna de estágio inválida: ' . $this->sql);
            $this->resultado = array_map(static fn($r) => [
                'posicao' => $r['posicao'],
                'id_pokemon_especie' => $r['stages'][$col],
            ], $dados['npcs'][(int) $params['tipo']]);
        } elseif (str_contains($this->sql, 'FROM pokemon_especie pe') && str_contains($this->sql, 'GROUP_CONCAT')) {
            $this->resultado = array_map(static fn($id) => [
                'id_pokemon_especie' => $id,
                'nome' => $dados['names'][$id],
                'imagem_url' => '',
                'tipos' => 'Normal',
            ], array_map('intval', $params));
        } elseif (str_contains($this->sql, 'FROM npc_mapa nm')) {
            $this->resultado = [[
                'id_npc_mapa' => (int) ($params['npc_mapa'] ?? 100),
                'id_npc_tipo' => $this->pdo->npcTipo,
                'posicao_y' => 500,
                'derrotado' => 0,
                'descricao' => 'Treinador de teste',
                'tipo_nome' => 'Teste',
            ]];
        } elseif (str_contains($this->sql, 'FROM perfil_log')) {
            $this->resultado = [['detalhes' => json_encode(['area' => $this->pdo->bioma], JSON_THROW_ON_ERROR)]];
        } elseif (str_contains($this->sql, 'FROM mapa_no') && str_contains($this->sql, 'SELVAGEM')) {
            $this->resultado = [['id_mapa_no' => 123, 'posicao_y' => 50, 'status' => 'DISPONIVEL']];
        } else {
            throw new RuntimeException('Consulta não simulada: ' . $this->sql);
        }
        return true;
    }

    public function fetch(int $mode = PDO::FETCH_DEFAULT, int $cursorOrientation = PDO::FETCH_ORI_NEXT, int $cursorOffset = 0): mixed
    {
        return array_shift($this->resultado) ?: false;
    }

    public function fetchAll(int $mode = PDO::FETCH_DEFAULT, mixed ...$args): array
    {
        if ($mode === PDO::FETCH_COLUMN) {
            return array_map(static fn($r) => reset($r), $this->resultado);
        }
        return $this->resultado;
    }

    public function fetchColumn(int $column = 0): mixed
    {
        $primeiro = array_shift($this->resultado);
        return $primeiro === null ? false : array_values($primeiro)[$column] ?? false;
    }
}

final class NpcTestePDO extends PDO
{
    public int $gin = 1;
    public int $concluidos = 0;
    public int $bioma = 1;
    public int $npcTipo = 1;
    public array $fixture;
    public function __construct()
    {
        $this->fixture = json_decode(file_get_contents(__DIR__ . '/teste_npc_fixture.json'), true, 512, JSON_THROW_ON_ERROR);
    }
    public function prepare(string $query, array $options = []): PDOStatement|false
    {
        return new NpcTesteStatement($this, $query);
    }
}

$pdo = new NpcTestePDO();
$montador = new MontadorTimeAdversario($pdo);
$servicoDeBatalhas = new BattleService($pdo);
$testes = 0;
$testesSelvagens = 0;
foreach (range(1, 6) as $gin) {
    $pdo->gin = $gin;
    $pdo->concluidos = $gin - 1;
    $indice = $gin <= 2 ? 0 : ($gin <= 4 ? 1 : 2);
    foreach (range(1, 3) as $bioma) {
        $pdo->bioma = $bioma;
        $estado = $montador->obterEstadoDoPerfil(1);
        if ($estado['area_atual'] !== $bioma || $estado['estagio_npc'] !== $indice + 1) {
            throw new RuntimeException('Bioma influenciou o estágio evolutivo do NPC');
        }
        // Selvagens também devem seguir o estágio, não o bioma aleatório.
        $selvagem = $montador->montarPokemonSelvagem(1, $estado['estagio_npc']);
        $especiesPermitidas = [];
        foreach ($pdo->fixture['npcs'] as $grupo) {
            foreach ($grupo as $r) $especiesPermitidas[] = $r['stages'][$indice];
        }
        if (!in_array($selvagem[0]['id_pokemon_especie'], $especiesPermitidas, true)) {
            throw new RuntimeException('Selvagem de estágio incorreto');
        }
        // Testa também o DESPACHO real da abertura da batalha selvagem.
        $encontro = $servicoDeBatalhas->obterEncontro(1, ['id_mapa_no' => 123]);
        $idsAdversarios = array_column($encontro['time_adversario'], 'id_pokemon_especie');
        if (array_diff($idsAdversarios, $especiesPermitidas)) {
            throw new RuntimeException('A API da batalha selecionou estágio selvagem errado');
        }
        ++$testesSelvagens;
        foreach (array_keys($pdo->fixture['npcs']) as $tipo) {
            $pdo->npcTipo = (int) $tipo;
            $time = $montador->montarTimeTreinador(1, 99 + $bioma, (int) $tipo);
            $quantidadeEsperada = $gin === 1 ? [1, 1] : ($gin <= 3 ? [2, 3] : [3, 3]);
            if (count($time) < $quantidadeEsperada[0] || count($time) > $quantidadeEsperada[1]) {
                throw new RuntimeException('Quantidade de NPCs mudou ao ajustar o estágio: ginásio ' . $gin);
            }
            $permitidos = array_map(static fn($r) => $r['stages'][$indice], $pdo->fixture['npcs'][$tipo]);
            foreach ($time as $pokemon) {
                if (!in_array($pokemon['id_pokemon_especie'], $permitidos, true)) {
                    throw new RuntimeException("Estágio incorreto: ginásio {$gin}, bioma {$bioma}, NPC {$tipo}, {$pokemon['nome']}");
                }
                if ($gin <= 4 && $tipo == 3 && $pokemon['nome'] === 'krookodile') {
                    throw new RuntimeException('Krookodile apareceu antes do Ex-campeão');
                }
                if ($gin <= 2 && $tipo == 1 && in_array($pokemon['nome'], ['galvantula', 'accelgor'], true)) {
                    throw new RuntimeException('Inseto evoluiu antes de vencer o ginásio de Água');
                }
            }
            // Confere o caminho da API usado pelo botão que inicia batalha NPC.
            $batalha = $servicoDeBatalhas->obterEncontro(1, ['id_npc_mapa' => 99 + $bioma]);
            if ($batalha['tipo_encontro'] !== 'treinador') {
                throw new RuntimeException('API não abriu um treinador');
            }
            $idsPermitidos = array_map(static fn(array $r): int => (int) $r['stages'][$indice], $pdo->fixture['npcs'][$tipo]);
            if (array_diff(array_column($batalha['time_adversario'], 'id_pokemon_especie'), $idsPermitidos)) {
                throw new RuntimeException("API abriu estágio errado: ginásio {$gin}, NPC {$tipo}");
            }
            ++$testes;
        }
    }
}
// Verifica proteção extra se o desafio diz 4 mas o progresso comprova só 1 ginásio.
if (MontadorTimeAdversario::estagioNpcSeguro(4, 1) !== 1) {
    throw new RuntimeException('Falha na proteção contra evolução prematura');
}
if (MontadorTimeAdversario::calcularNivelAdaptativo([21, 18], 'treinador') !== 16) {
    throw new RuntimeException('NPC não está cinco níveis abaixo do mais forte');
}
if (MontadorTimeAdversario::calcularNivelAdaptativo([8], 'treinador') !== 3) {
    throw new RuntimeException('NPC contra inicial nível 8 deveria ser nível 3');
}
if (MontadorTimeAdversario::calcularNivelAdaptativo([21, 18], 'selvagem') !== 15) {
    throw new RuntimeException('Fórmula selvagem original foi alterada');
}
echo "OK: {$testes} cenários reais do montador simulados; 6 ginásios x 3 biomas x 6 NPCs.\n";
echo "OK: {$testesSelvagens} encontros selvagens, inclusive despacho da API, respeitam os ginásios.\n";
echo "OK: Ginásios 1-2 iniciais, 3-4 intermediários e 5-6 finais; Galvantula/Accelgor só após Água.\n";
echo "OK: Times NPC mantêm quantidades anteriores e NPCs estão -5 níveis.\n";
