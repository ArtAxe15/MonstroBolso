<?php

$cssUrl = $baseUrl . '/css/monstrobolso.css';
$jsUrl = $baseUrl . '/js/main.js';

?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="theme-color" content="#285a91">
    <title>Roguemon | MONSTROBOLSO</title>

    <link rel="stylesheet" href="<?= htmlspecialchars($cssUrl, ENT_QUOTES, 'UTF-8') ?>">
    <script src="<?= htmlspecialchars($jsUrl, ENT_QUOTES, 'UTF-8') ?>" defer></script>
</head>
<body data-entry-url="<?= htmlspecialchars($entryUrl, ENT_QUOTES, 'UTF-8') ?>">
    <div id="app" class="app-shell" aria-live="polite">
        <div class="loading-card">
            <h1>Roguemon</h1>
            <p>Carregando sua aventura...</p>
        </div>
    </div>

    <noscript>
        <p class="noscript-message">Ative o JavaScript para jogar MONSTROBOLSO.</p>
    </noscript>
</body>
</html>
