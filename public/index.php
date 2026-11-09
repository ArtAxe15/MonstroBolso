<?php

declare(strict_types=1);

session_start();

require_once __DIR__ . '/../app/Autoload.php';

use App\Config\Database;
use App\Controllers\AuthController;

$db = Database::getConnection();
$controller = new AuthController($db);

$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH) ?? '/';
$scriptName = $_SERVER['SCRIPT_NAME'] ?? '/index.php';
$scriptDir = rtrim(dirname($scriptName), '/');

if ($scriptDir !== '' && $scriptDir !== '/') {
    $uri = preg_replace('#^' . preg_quote($scriptDir, '#') . '#', '', $uri, 1) ?? $uri;
}

$uri = preg_replace('#^/index\.php#', '', $uri, 1) ?? $uri;

if ($uri === '' || $uri === '/') {
    $redirect = ($scriptDir !== '' && $scriptDir !== '/') ? $scriptDir . '/index.php/login' : '/index.php/login';
    header('Location: ' . $redirect);
    exit;
}

if ($uri === '/login' && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $controller->login();
}

if ($uri === '/login' && $_SERVER['REQUEST_METHOD'] === 'GET') {
    $controller->index();
    exit;
}

if ($uri === '/register' && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $controller->register();
}

if ($uri === '/register' && $_SERVER['REQUEST_METHOD'] === 'GET') {
    $controller->showRegister();
    exit;
}

if ($uri === '/dashboard') {
    $controller->dashboard();
    exit;
}

if ($uri === '/logout') {
    $controller->logout();
}

http_response_code(404);
echo 'Página não encontrada';
