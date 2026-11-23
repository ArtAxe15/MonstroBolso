<?php

declare(strict_types=1);

use App\Controllers\AuthController;
use App\Controllers\ProfileController;
use App\Controllers\GameController;
use App\Controllers\BattleController;
use App\Controllers\BattleHistoryController;
use App\Controllers\FinalController;

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
    'GET /api/game/map/pokebola' => [GameController::class, 'oferecerPokebola'],
    'POST /api/game/map/pokebola' => [GameController::class, 'resolverPokebola'],
    'POST /api/game/team/swap' => [GameController::class, 'trocarPosicoesTime'],
    'GET /api/game/pc' => [GameController::class, 'pc'],
    'POST /api/game/pc' => [GameController::class, 'movimentarPc'],
    'GET /api/game/pokemart' => [GameController::class, 'pokemart'],
    'POST /api/game/map/service' => [GameController::class, 'visitarServicoMapa'],
    'POST /api/game/items/use' => [GameController::class, 'usarItem'],
    'GET /api/game/encounter' => [GameController::class, 'encounter'],

    'GET /api/battle/history' => [BattleHistoryController::class, 'index'],
    'GET /api/game/ultima-derrota' => [FinalController::class, 'ultimaDerrota'],
    'POST /api/game/reiniciar' => [FinalController::class, 'reiniciar'],
    'GET /api/game/campeao' => [FinalController::class, 'campeao'],
    'POST /api/battle/start' => [BattleController::class, 'start'],
    'POST /api/battle/turn' => [BattleController::class, 'turn'],
    'GET /api/battle/state' => [BattleController::class, 'state'],
];
