<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Models\User;
use PDO;

class AuthController
{
    private PDO $conn;

    public function __construct(PDO $conn)
    {
        $this->conn = $conn;
    }

    private function basePath(string $path): string
    {
        $scriptName = $_SERVER['SCRIPT_NAME'] ?? '/index.php';
        $scriptDir = dirname($scriptName);

        if ($scriptDir === '/' || $scriptDir === '\\') {
            return '/index.php' . $path;
        }

        return rtrim($scriptDir, '/') . '/index.php' . $path;
    }

    public function index(): void
    {
        require __DIR__ . '/../Views/auth/login.php';
    }

    public function showRegister(): void
    {
        require __DIR__ . '/../Views/auth/register.php';
    }

    public function dashboard(): void
    {
        if (empty($_SESSION['usuario'])) {
            $_SESSION['erro'] = 'Você precisa fazer login para acessar o painel.';
            header('Location: /login');
            exit;
        }

        require __DIR__ . '/../Views/dashboard.php';
    }

    public function login(): void
    {
        $nomeUsuario = trim((string) ($_POST['nome_usuario'] ?? ''));
        $password = (string) ($_POST['senha'] ?? '');

        if ($nomeUsuario === '' || $password === '') {
            $_SESSION['erro'] = 'Preencha o nome de usuário e a senha.';
            header('Location: ' . $this->basePath('/login'));
            exit;
        }

        if (mb_strlen($nomeUsuario) < 3 || mb_strlen($nomeUsuario) > 50) {
            $_SESSION['erro'] = 'O nome de usuário deve ter entre 3 e 50 caracteres.';
            $_SESSION['nome_usuario'] = $nomeUsuario;
            header('Location: ' . $this->basePath('/login'));
            exit;
        }

        $userModel = new User($this->conn);
        $user = $userModel->findByNomeUsuario($nomeUsuario);

        if (!$user) {
            $_SESSION['erro'] = 'Usuário não encontrado.';
            $_SESSION['nome_usuario'] = $nomeUsuario;
            header('Location: ' . $this->basePath('/login'));
            exit;
        }

        if (!password_verify($password, $user['senha_hash'])) {
            $_SESSION['erro'] = 'Senha inválida.';
            $_SESSION['nome_usuario'] = $nomeUsuario;
            header('Location: ' . $this->basePath('/login'));
            exit;
        }

        $_SESSION['usuario'] = [
            'id_usuario' => (int) $user['id_usuario'],
            'nome_usuario' => $user['nome_usuario'],
        ];

        $_SESSION['sucesso'] = 'Login realizado com sucesso!';
        header('Location: ' . $this->basePath('/dashboard'));
        exit;
    }

    public function register(): void
    {
        $nomeUsuario = trim((string) ($_POST['nome_usuario'] ?? ''));
        $password = (string) ($_POST['senha'] ?? '');
        $confirmPassword = (string) ($_POST['confirmar_senha'] ?? '');

        if ($nomeUsuario === '' || $password === '' || $confirmPassword === '') {
            $_SESSION['erro'] = 'Preencha todos os campos do cadastro.';
            $_SESSION['nome_usuario'] = $nomeUsuario;
            header('Location: ' . $this->basePath('/register'));
            exit;
        }

        if (!preg_match('/^[a-zA-Z0-9_-]+$/', $nomeUsuario)) {
            $_SESSION['erro'] = 'O nome de usuário só pode conter letras, números, underline e hífen.';
            $_SESSION['nome_usuario'] = $nomeUsuario;
            header('Location: ' . $this->basePath('/register'));
            exit;
        }

        if (mb_strlen($nomeUsuario) < 3 || mb_strlen($nomeUsuario) > 50) {
            $_SESSION['erro'] = 'O nome de usuário deve ter entre 3 e 50 caracteres.';
            $_SESSION['nome_usuario'] = $nomeUsuario;
            header('Location: ' . $this->basePath('/register'));
            exit;
        }

        if (mb_strlen($password) < 8) {
            $_SESSION['erro'] = 'A senha deve ter no mínimo 8 caracteres.';
            header('Location: ' . $this->basePath('/register'));
            exit;
        }

        if (!preg_match('/^(?=.*[A-Za-z])(?=.*\d).+$/', $password)) {
            $_SESSION['erro'] = 'A senha deve conter letras e números.';
            header('Location: ' . $this->basePath('/register'));
            exit;
        }

        if ($password !== $confirmPassword) {
            $_SESSION['erro'] = 'As senhas não conferem.';
            $_SESSION['nome_usuario'] = $nomeUsuario;
            header('Location: ' . $this->basePath('/register'));
            exit;
        }

        $userModel = new User($this->conn);

        if ($userModel->findByNomeUsuario($nomeUsuario) !== null) {
            $_SESSION['erro'] = 'Este nome de usuário já existe.';
            $_SESSION['nome_usuario'] = $nomeUsuario;
            header('Location: ' . $this->basePath('/register'));
            exit;
        }

        $senhaHash = password_hash($password, PASSWORD_DEFAULT);

        if (!$userModel->create($nomeUsuario, $senhaHash)) {
            $_SESSION['erro'] = 'Não foi possível criar o usuário.';
            $_SESSION['nome_usuario'] = $nomeUsuario;
            header('Location: ' . $this->basePath('/register'));
            exit;
        }

        $_SESSION['sucesso'] = 'Usuário criado com sucesso! Faça login.';
        header('Location: ' . $this->basePath('/login'));
        exit;
    }

    public function logout(): void
    {
        $_SESSION = [];
        session_destroy();
        header('Location: ' . $this->basePath('/login'));
        exit;
    }
}
