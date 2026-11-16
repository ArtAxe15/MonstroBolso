<?php
declare(strict_types=1);

$uri = '/MonstroBolso/public/index.php/login';
$scriptName = '/MonstroBolso/public/index.php';
$scriptDir = rtrim(dirname($scriptName), '/');

if ($scriptDir !== '' && $scriptDir !== '/') {
    $uri = preg_replace('#^' . preg_quote($scriptDir, '#') . '#', '', $uri, 1) ?? $uri;
}

$uri = preg_replace('#^/index\.php#', '', $uri, 1) ?? $uri;

echo $uri . PHP_EOL;
