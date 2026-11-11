<?php

declare(strict_types=1);

use App\Controllers\AuthController;
use App\Controllers\ProfileController;
use App\Controllers\GameController;

/*
 * Rotas da API.
 * As telas /login, /register e /dashboard são controladas pelo JavaScript;
 * aqui ficam somente as requisições que precisam conversar com o backend.
 */
return [
    'GET /api/session' => [AuthController::class, 'session'],

    'POST /api/login' => [AuthController::class, 'login'],
    'POST /api/register' => [AuthController::class, 'register'],
    'POST /api/logout' => [AuthController::class, 'logout'],

    'GET /api/profiles' => [ProfileController::class, 'index'],
    'POST /api/profiles' => [ProfileController::class, 'create'],
    'POST /api/profiles/select' => [ProfileController::class, 'select'],
    'POST /api/profiles/delete' => [ProfileController::class, 'delete'],

    'GET /api/game/starters' => [GameController::class, 'starters'],
    'POST /api/game/starter' => [GameController::class, 'chooseStarter'],
    'GET /api/game/map' => [GameController::class, 'map'],
];
