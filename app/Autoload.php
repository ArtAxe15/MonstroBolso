<?php
declare(strict_types=1);

spl_autoload_register(function (string $class): void {

    // Caminho específico da classe Database.
    if ($class === 'App\Config\Database') {
        $file = dirname(__DIR__) . '/config/database.php';

        if (is_file($file)) {
            require_once $file;
        }

        return;
    }

    // Classes pertencentes à pasta app.
    $prefix = 'App\\';

    if (strncmp($prefix, $class, strlen($prefix)) !== 0) {
        return;
    }

    $relativeClass = substr($class, strlen($prefix));

    $file = __DIR__ . '/'
        . str_replace('\\', DIRECTORY_SEPARATOR, $relativeClass)
        . '.php';

    if (is_file($file)) {
        require_once $file;
    }
});
