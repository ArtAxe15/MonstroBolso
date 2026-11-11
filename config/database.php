<?php
declare(strict_types=1);

namespace App\Config;

use PDO;
use PDOException;
use RuntimeException;

final class Database
{
    private static ?PDO $connection = null;

    public static function getConnection(): PDO
    {
        if (self::$connection !== null) {
            return self::$connection;
        }

        $host = 'localhost';
        $database = 'monstrobouso';
        $username = 'root';
        $password = '';

        $dsn = "mysql:host={$host};dbname={$database};charset=utf8mb4";

        try {
            self::$connection = new PDO(
                $dsn,
                $username,
                $password,
                [
                    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                    PDO::ATTR_EMULATE_PREPARES => false
                ]
            );

            return self::$connection;

        } catch (PDOException $e) {
            error_log(
                'Erro de conexão com o banco: ' . $e->getMessage()
            );

            throw new RuntimeException(
                'Não foi possível conectar ao banco de dados.',
                0,
                $e
            );
        }
    }
}
