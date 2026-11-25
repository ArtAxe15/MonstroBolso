<?php

declare(strict_types=1);

/** Verificacoes offline: php scripts/testar_efeitos_secundarios_sem_banco.php */
require dirname(__DIR__) . '/app/Autoload.php';

use App\Services\BattleService;
use App\Services\FonteAleatoriedade;

$sorteioFixo = new class implements FonteAleatoriedade {
    public int $resultado = 1;
    public function inteiro(int $minimo, int $maximo): int
    {
        if ($this->resultado < $minimo || $this->resultado > $maximo) {
            throw new RuntimeException('Sorteio de teste fora do intervalo.');
        }
        return $this->resultado;
    }
};

$classe = new ReflectionClass(BattleService::class);
$motor = $classe->newInstanceWithoutConstructor();
$classe->getProperty('aleatoriedade')->setValue($motor, $sorteioFixo);
$metodo = $classe->getMethod('sortearCondicaoSecundaria');

$casos = [
    [1, ['Queimadura'], 'Queimadura'],
    [25, ['Queimadura'], 'Queimadura'],
    [26, ['Queimadura'], null],
    [100, ['Queimadura'], null],
    [1, ['Queimadura', 'Paralisia'], 'Queimadura'],
    [25, ['Queimadura', 'Paralisia'], 'Queimadura'],
    [26, ['Queimadura', 'Paralisia'], 'Paralisia'],
    [50, ['Queimadura', 'Paralisia'], 'Paralisia'],
    [51, ['Queimadura', 'Paralisia'], null],
    [100, ['Queimadura', 'Paralisia'], null],
];
foreach ($casos as [$valor, $condicoes, $esperado]) {
    $sorteioFixo->resultado = $valor;
    $obtido = $metodo->invoke($motor, $condicoes);
    if ($obtido !== $esperado) {
        throw new RuntimeException('Probabilidade incorreta para sorteio ' . $valor);
    }
}

$esperadas = [
    'Fogo' => 'Queimadura',
    'Eletrico' => 'Paralisia',
    'Gelo' => 'Congelamento',
    'Veneno' => 'Envenenamento',
    'Psiquico' => 'Sono',
    'Grama' => 'Sono',
    'Agua' => 'Congelamento',
    'Inseto' => 'Envenenamento',
    'Dragao' => 'Queimadura',
];
if ($classe->getConstant('CONDICAO_POR_TIPO') !== $esperadas) {
    throw new RuntimeException('Mapa de efeitos por tipo incorreto.');
}
if ($classe->getConstant('CONDICAO_POR_GOLPE') !== [34 => 'Paralisia', 225 => 'Paralisia']) {
    throw new RuntimeException('Body Slam ou Dragon Breath perdeu o efeito existente.');
}

echo 'OK: 10 sorteios de fronteira, nove tipos e dois golpes especiais. ';
echo 'Sem necessidade de banco de dados.' . PHP_EOL;
