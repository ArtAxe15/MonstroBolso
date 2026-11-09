<?php

spl_autoload_register(function ($class) {
    $prefixApp = 'App\\';
    $baseDirApp = __DIR__ . DIRECTORY_SEPARATOR;

    if (strncmp($class, $prefixApp, strlen($prefixApp)) === 0) {
        $relativeClass = substr($class, strlen($prefixApp));

        if ($relativeClass === 'Config\\Database') {
            $file = dirname(__DIR__) . DIRECTORY_SEPARATOR . 'config' . DIRECTORY_SEPARATOR . 'database.php';
            if (file_exists($file)) {
                require $file;
                return;
            }
        }

        $file = $baseDirApp . str_replace('\\', DIRECTORY_SEPARATOR, $relativeClass) . '.php';

        if (file_exists($file)) {
            require $file;
            return;
        }
    }
});
