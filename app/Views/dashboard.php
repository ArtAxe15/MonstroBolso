<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Painel</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f7ff;
            margin: 0;
            padding: 30px;
        }

        .card {
            max-width: 700px;
            margin: 60px auto;
            background: #fff;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
        }

        h1 {
            margin-top: 0;
        }

        .botao {
            display: inline-block;
            background: #c62828;
            color: #fff;
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 8px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="card">
        <h1>Bem-vindo</h1>

        <?php if (!empty($_SESSION['sucesso'])): ?>
            <p><?php echo htmlspecialchars($_SESSION['sucesso']); unset($_SESSION['sucesso']); ?></p>
        <?php endif; ?>

        <p>Você entrou com sucesso no sistema.</p>
        <p>Usuário: <strong><?php echo htmlspecialchars($_SESSION['usuario']['nome_usuario'] ?? ''); ?></strong></p>

        <?php
        $scriptName = $_SERVER['SCRIPT_NAME'] ?? '';
        if (str_contains($scriptName, '/public/index.php')) {
            $basePath = dirname($scriptName);
            if ($basePath === '/' || $basePath === '\\') {
                $basePath = '';
            }
            $logoutLink = $basePath . '/index.php/logout';
        } else {
            $logoutLink = '../../../public/index.php/logout';
        }
        ?>
        <a class="botao" href="<?php echo htmlspecialchars($logoutLink); ?>">Sair</a>
    </div>
</body>
</html>
