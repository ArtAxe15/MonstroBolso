<?php
declare(strict_types=1);

$scriptName = '/MonstroBolso/public/index.php';
$basePath = dirname($scriptName);

if ($basePath === '/' || $basePath === '\\') {
    $basePath = '';
}

$logoutLink = ($basePath === '') ? '/index.php/logout' : $basePath . '/index.php/logout';

echo $logoutLink . PHP_EOL;
