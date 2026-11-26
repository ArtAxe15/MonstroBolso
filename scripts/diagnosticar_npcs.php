<?php
declare(strict_types=1);
/**
 * Diagnóstico somente leitura: php scripts/diagnosticar_npcs.php ID_DO_PERFIL
 * Mostra o estágio real da jornada no MariaDB do XAMPP e as espécies cadastradas.
 */
if (PHP_SAPI !== 'cli') {
    http_response_code(403);
    exit('Execute este diagnóstico apenas pelo terminal.');
}
if (($argc ?? 0) !== 2 || !ctype_digit((string)$argv[1]) || (int)$argv[1] <= 0) {
    fwrite(STDERR, "Uso: php scripts/diagnosticar_npcs.php ID_DO_PERFIL\n");
    exit(1);
}
require_once dirname(__DIR__) . '/app/Autoload.php';

use App\Config\Database;
use App\Models\Encontro;
use App\Services\MontadorTimeAdversario;

try {
    $pdo = Database::getConnection();
    $perfil = (int) $argv[1];
    $encontro = new Encontro($pdo);
    $desafio = $encontro->encontrarAtual($perfil);
    $concluidos = $encontro->contarConcluidos($perfil);
    $numero = (int) ($desafio['ordem'] ?? 6);
    $estagio = MontadorTimeAdversario::estagioNpcSeguro($numero, $concluidos);
    echo "Perfil #{$perfil} | Desafios concluídos: {$concluidos} | Próximo confronto: {$numero} | Estágio NPC: {$estagio}\n";
    echo "Estágio 1: Ginásios 1-2; estágio 2: Ginásios 3-4; estágio 3: Ex-campeão e Rival.\n";

    $sql = 'SELECT nt.id_npc_tipo, t.nome AS tipo, np.posicao,
                   a.nome AS inicial, b.nome AS intermediario, c.nome AS final
            FROM npc_tipo nt
            JOIN tipo t ON t.id_tipo = nt.id_tipo
            JOIN npc_tipo_pokemon np ON np.id_npc_tipo = nt.id_npc_tipo
            JOIN pokemon_especie a ON a.id_pokemon_especie = np.id_pokemon_0_1
            JOIN pokemon_especie b ON b.id_pokemon_especie = np.id_pokemon_2_3
            JOIN pokemon_especie c ON c.id_pokemon_especie = np.id_pokemon_4_6
            ORDER BY nt.id_npc_tipo, np.posicao';
    foreach ($pdo->query($sql) as $npc) {
        $nomes = [$npc['inicial'], $npc['intermediario'], $npc['final']];
        printf("NPC %-12s posição %d: %-14s -> %-14s -> %-14s | AGORA: %s\n",
            $npc['tipo'], $npc['posicao'], $nomes[0], $nomes[1], $nomes[2], $nomes[$estagio - 1]);
    }
} catch (Throwable $e) {
    fwrite(STDERR, "Diagnóstico falhou: {$e->getMessage()}\n");
    exit(2);
}
