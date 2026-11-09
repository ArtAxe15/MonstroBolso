<?php
declare(strict_types=1);

require_once dirname(__DIR__) . '/app/Autoload.php';

use App\Config\Database;
use App\Models\User;

try {
    $db = Database::getConnection();
    $user = new User($db);

    $nome = 'teste_login_2026';
    $hash = password_hash('Senha123', PASSWORD_DEFAULT);

    $user->create($nome, $hash);

    $dados = $user->findByNomeUsuario($nome);

    if ($dados === null || !password_verify('Senha123', $dados['senha_hash'])) {
        throw new RuntimeException('Falha no login real');
    }

    $db->prepare('DELETE FROM usuario WHERE nome_usuario = :nome')
        ->execute([':nome' => $nome]);

    echo 'VALIDACAO_OK';
} catch (Throwable $e) {
    echo 'ERRO: ' . $e->getMessage();
    exit(1);
}
