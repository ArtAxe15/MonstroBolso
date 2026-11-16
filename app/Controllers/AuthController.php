<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Http\JsonResponse;
use App\Models\User;
use PDO;
use Throwable;

class AuthController
{
    private PDO $conn;

    public function __construct(PDO $conn)
    {
        $this->conn = $conn;
    }

    /** Lê o corpo JSON enviado pelo JavaScript. */
    private function obterDadosJson(): array
    {
        $corpo = file_get_contents('php://input');
        $dados = json_decode($corpo ?: '', true);

        if (!is_array($dados)) {
            JsonResponse::send([
                'ok' => false,
                'message' => 'A solicitação não contém um JSON válido.'
            ], 400);
        }

        return $dados;
    }

    /** Informa ao frontend se existe um usuário autenticado na sessão. */
    public function session(): void
    {
        $usuario = $_SESSION['usuario'] ?? null;

        JsonResponse::send([
            'ok' => true,
            'autenticado' => is_array($usuario),
            'usuario' => is_array($usuario) ? [
                'id_usuario' => (int) ($usuario['id_usuario'] ?? 0),
                'nome_usuario' => (string) ($usuario['nome_usuario'] ?? '')
            ] : null
        ]);
    }

    /** Autentica o usuário sem redirecionar ou renderizar uma página PHP. */
    public function login(): void
    {
        $dados = $this->obterDadosJson();
        $nomeUsuario = trim((string) ($dados['nome_usuario'] ?? ''));
        $password = (string) ($dados['senha'] ?? '');

        if ($nomeUsuario === '' || $password === '') {
            JsonResponse::send([
                'ok' => false,
                'message' => 'Preencha o nome de usuário e a senha.'
            ], 422);
        }

        $tamanhoNome = mb_strlen($nomeUsuario);
        if ($tamanhoNome < 3 || $tamanhoNome > 50) {
            JsonResponse::send([
                'ok' => false,
                'message' => 'O nome de usuário deve ter entre 3 e 50 caracteres.'
            ], 422);
        }

        $userModel = new User($this->conn);
        $user = $userModel->findByNomeUsuario($nomeUsuario);

        if ($user === null || !password_verify($password, $user['senha_hash'])) {
            // A mensagem não revela se o usuário existe ou se a senha está errada.
            JsonResponse::send([
                'ok' => false,
                'message' => 'Nome de usuário ou senha inválidos.'
            ], 401);
        }

        // Troca o identificador da sessão após a autenticação.
        session_regenerate_id(true);

        $_SESSION['usuario'] = [
            'id_usuario' => (int) $user['id_usuario'],
            'nome_usuario' => (string) $user['nome_usuario']
        ];

        JsonResponse::send([
            'ok' => true,
            'message' => 'Login realizado com sucesso!',
            'usuario' => $_SESSION['usuario']
        ]);
    }

    /** Cria uma conta e devolve o resultado em JSON. */
    public function register(): void
    {
        $dados = $this->obterDadosJson();
        $nomeUsuario = trim((string) ($dados['nome_usuario'] ?? ''));
        $password = (string) ($dados['senha'] ?? '');
        $confirmPassword = (string) ($dados['confirmar_senha'] ?? '');

        if ($nomeUsuario === '' || $password === '' || $confirmPassword === '') {
            JsonResponse::send([
                'ok' => false,
                'message' => 'Preencha todos os campos do cadastro.'
            ], 422);
        }

        if (!preg_match('/^[a-zA-Z0-9_-]+$/', $nomeUsuario)) {
            JsonResponse::send([
                'ok' => false,
                'message' => 'O nome de usuário só pode conter letras, números, underline e hífen.'
            ], 422);
        }

        $tamanhoNome = mb_strlen($nomeUsuario);
        if ($tamanhoNome < 3 || $tamanhoNome > 50) {
            JsonResponse::send([
                'ok' => false,
                'message' => 'O nome de usuário deve ter entre 3 e 50 caracteres.'
            ], 422);
        }

        if (mb_strlen($password) < 8) {
            JsonResponse::send([
                'ok' => false,
                'message' => 'A senha deve ter no mínimo 8 caracteres.'
            ], 422);
        }

        if (!preg_match('/^(?=.*[A-Za-z])(?=.*\d).+$/', $password)) {
            JsonResponse::send([
                'ok' => false,
                'message' => 'A senha deve conter letras e números.'
            ], 422);
        }

        if ($password !== $confirmPassword) {
            JsonResponse::send([
                'ok' => false,
                'message' => 'As senhas não conferem.'
            ], 422);
        }

        $userModel = new User($this->conn);

        if ($userModel->findByNomeUsuario($nomeUsuario) !== null) {
            JsonResponse::send([
                'ok' => false,
                'message' => 'Este nome de usuário já existe.'
            ], 409);
        }

        $senhaHash = password_hash($password, PASSWORD_DEFAULT);

        try {
            $criado = $userModel->create($nomeUsuario, $senhaHash);
        } catch (Throwable $e) {
            error_log('Erro ao cadastrar usuário: ' . $e->getMessage());
            JsonResponse::send([
                'ok' => false,
                'message' => 'Não foi possível concluir o cadastro.'
            ], 500);
        }

        if (!$criado) {
            JsonResponse::send([
                'ok' => false,
                'message' => 'Não foi possível criar o usuário.'
            ], 500);
        }

        JsonResponse::send([
            'ok' => true,
            'message' => 'Conta criada com sucesso! Agora você pode entrar.'
        ], 201);
    }

    /** Encerra a sessão atual sem recarregar a página. */
    public function logout(): void
    {
        $_SESSION = [];

        if (ini_get('session.use_cookies')) {
            $params = session_get_cookie_params();
            setcookie(
                session_name(),
                '',
                time() - 42000,
                $params['path'],
                $params['domain'],
                (bool) $params['secure'],
                (bool) $params['httponly']
            );
        }

        session_destroy();

        JsonResponse::send([
            'ok' => true,
            'message' => 'Você saiu da sua conta.'
        ]);
    }
}
