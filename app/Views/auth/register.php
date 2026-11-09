<?php
$scriptName = $_SERVER['SCRIPT_NAME'] ?? '';
if (str_contains($scriptName, '/public/index.php')) {
    $basePath = dirname($scriptName);
    if ($basePath === '/' || $basePath === '\\') {
        $basePath = '';
    }
    $registerAction = $basePath . '/index.php/register';
    $loginLink = $basePath . '/index.php/login';
} else {
    $registerAction = '../../../public/index.php/register';
    $loginLink = '../../../public/index.php/login';
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Criar usuário</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }

        .box {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            width: 420px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        h2 {
            margin-top: 0;
            text-align: center;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 16px;
            border-radius: 8px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #2e7d32;
            border: none;
            color: #fff;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
        }

        .mensagem {
            margin-bottom: 16px;
            padding: 10px;
            border-radius: 8px;
            font-size: 14px;
        }

        .erro {
            background: #ffebee;
            color: #c62828;
        }

        .link {
            display: block;
            margin-top: 14px;
            text-align: center;
            color: #1e88e5;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="box">
        <h2>Criar usuário</h2>

        <?php if (!empty($_SESSION['erro'])): ?>
            <div class="mensagem erro"><?php echo htmlspecialchars($_SESSION['erro']); unset($_SESSION['erro']); ?></div>
        <?php endif; ?>

        <form method="POST" action="<?php echo htmlspecialchars($registerAction); ?>">
            <label for="nome_usuario">Nome de usuário</label>
            <input type="text" id="nome_usuario" name="nome_usuario" value="<?php echo htmlspecialchars($_SESSION['nome_usuario'] ?? ''); ?>" required>

            <label for="senha">Senha</label>
            <input type="password" id="senha" name="senha" required>

            <label for="confirmar_senha">Confirmar senha</label>
            <input type="password" id="confirmar_senha" name="confirmar_senha" required>

            <button type="submit">Cadastrar</button>
        </form>

        <a class="link" href="<?php echo htmlspecialchars($loginLink); ?>">Voltar para login</a>
    </div>
</body>
</html>
