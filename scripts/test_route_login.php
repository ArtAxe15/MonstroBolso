<?php
declare(strict_types=1);

$scriptName = '/MonstroBolso/public/index.php';
$scriptDir = rtrim(dirname($scriptName), '/');
$redirectA = ($scriptDir !== '' && $scriptDir !== '/') ? $scriptDir . '/index.php/login' : '/index.php/login';

echo $redirectA . PHP_EOL;

$scriptName2 = '/index.php';
$scriptDir2 = rtrim(dirname($scriptName2), '/');
$redirectB = ($scriptDir2 !== '' && $scriptDir2 !== '/') ? $scriptDir2 . '/index.php/login' : '/index.php/login';

echo $redirectB . PHP_EOL;
