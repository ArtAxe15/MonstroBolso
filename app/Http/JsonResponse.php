<?php

declare(strict_types=1);

namespace App\Http;

/** Padroniza as respostas JSON enviadas pela API. */
final class JsonResponse
{
    public static function send(array $data, int $statusCode = 200): void
    {
        http_response_code($statusCode);
        header('Content-Type: application/json; charset=utf-8');
        header('Cache-Control: no-store, no-cache, must-revalidate, max-age=0');
        header('X-Content-Type-Options: nosniff');

        $json = json_encode(
            $data,
            JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES
        );

        if ($json === false) {
            http_response_code(500);
            echo '{"ok":false,"message":"Não foi possível montar a resposta."}';
            exit;
        }

        echo $json;
        exit;
    }
}
