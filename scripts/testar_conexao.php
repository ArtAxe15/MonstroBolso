
<?php

declare(strict_types=1);

require_once dirname(__DIR__) . '/config/database.php';

use App\Config\Database;

try {
    $pdo = Database::getConnection();

    $consulta = $pdo->query(
        'SELECT DATABASE() AS banco, VERSION() AS versao'
    );

    $resultado = $consulta->fetch();

    echo '<h2>Conexão realizada com sucesso!</h2>';
    echo '<p>Banco: ' . htmlspecialchars($resultado['banco']) . '</p>';
    echo '<p>MariaDB: ' . htmlspecialchars($resultado['versao']) . '</p>';

} catch (Throwable $e) {
    echo '<h2>Erro ao conectar!</h2>';
    echo '<p>' . htmlspecialchars($e->getMessage()) . '</p>';
}
?>
