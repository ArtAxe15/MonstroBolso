<?php
declare(strict_types=1);

namespace App\Config;

use PDO;
use PDOException;
use RuntimeException;

final class Database
{
    // Guarda a conexão para reutilizá-la.
    private static ?PDO $connection = null;

    public static function getConnection(): PDO
    {
        // Se já existe uma conexão, reutiliza.
        if (self::$connection !== null) {
            return self::$connection;
        }

        // Dados de conexão do XAMPP.
        $host = 'localhost';
        $database = 'monstrobouso';
        $username = 'root';
        $password = '';

        // String que informa ao PDO onde está o banco.
        $dsn = "mysql:host={$host};dbname={$database};charset=utf8mb4";

        try {
            self::$connection = new PDO(
                $dsn,
                $username,
                $password,
                [
                    // Faz o PDO lançar exceções em caso de erro.
                    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,

                    // Retorna resultados como arrays associativos.
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,

                    // Utiliza prepared statements nativos.
                    PDO::ATTR_EMULATE_PREPARES => false
                ]
            );

            return self::$connection;

        } catch (PDOException $e) {

            // Registra o erro técnico no log do PHP.
            error_log('Erro de conexão com o banco: ' . $e->getMessage());

            // Exibe uma mensagem mais adequada para a aplicação.
            throw new RuntimeException(
                'Não foi possível conectar ao banco de dados.',
                0,
                $e
            );
        }
    }
}
?>
