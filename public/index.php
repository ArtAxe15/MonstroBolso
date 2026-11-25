<?php
declare(strict_types=1);

session_start();

require_once __DIR__ . '/../app/Autoload.php';

use App\Config\Database;
use App\Http\JsonResponse;
use App\Http\ApiException;

// Identifica o caminho acessado, inclusive quando a URL contém /index.php/dashboard.
$uriCompleta = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?: '/';
$scriptName = str_replace('\\', '/', $_SERVER['SCRIPT_NAME'] ?? '/index.php');
$scriptDir = rtrim(str_replace('\\', '/', dirname($scriptName)), '/');
$entryPath = ($scriptDir === '' ? '' : $scriptDir) . '/index.php';

if ($uriCompleta === $entryPath) {
    $rota = '/';
} elseif (str_starts_with($uriCompleta, $entryPath . '/')) {
    $rota = substr($uriCompleta, strlen($entryPath));
} else {
    $rota = '/';
}

$metodo = strtoupper($_SERVER['REQUEST_METHOD'] ?? 'GET');
$chaveRota = $metodo . ' ' . $rota;
$rotas = require __DIR__ . '/../routes/routes.php';

// 1. Requisições da API: recebem e devolvem JSON.
if (isset($rotas[$chaveRota])) {
    // Confrontos em andamento são obrigatórios: nenhuma ação de mapa,
    // perfil ou logout pode ser usada para abandonar uma luta.
    $batalhaAberta = $_SESSION['batalha'] ?? null;
    if (is_array($batalhaAberta) && (empty($batalhaAberta['finalizada']) || !empty($batalhaAberta['persistencia_pendente']))
        && !in_array($chaveRota, ['GET /api/session', 'GET /api/battle/state', 'POST /api/battle/turn'], true)) {
        JsonResponse::send([
            'ok' => false,
            'message' => 'Há uma batalha em andamento. Vença o confronto para continuar a jornada.'
        ], 409);
    }
    [$controllerClass, $metodoController] = $rotas[$chaveRota];

    try {
        $controller = new $controllerClass(Database::getConnection());
        $controller->{$metodoController}();
    } catch (ApiException $e) {
        JsonResponse::send(['ok' => false, 'message' => $e->getMessage()], $e->statusCode());
    } catch (Throwable $e) {
        error_log('Erro na API (' . $chaveRota . '): ' . $e->getMessage());

        JsonResponse::send([
            'ok' => false,
            'message' => 'Ocorreu um erro interno. Consulte o log do PHP para mais detalhes.'
        ], 500);
    }
}

// 2. Endpoints /api inexistentes não devem devolver HTML.
if (str_starts_with($rota, '/api/')) {
    JsonResponse::send([
        'ok' => false,
        'message' => 'Endpoint da API não encontrado.'
    ], 404);
}

// 3. Rotas da interface: todas devolvem o mesmo app shell.
$rotasFrontend = ['/', '/login', '/register', '/dashboard', '/profiles', '/starter', '/map', '/pc', '/battle', '/champion'];

if (in_array($rota, $rotasFrontend, true)) {
    $baseUrl = $scriptDir;
    $entryUrl = $entryPath;

    require __DIR__ . '/../app/Views/app.php';
    exit;
}

http_response_code(404);
echo 'Página não encontrada.';
