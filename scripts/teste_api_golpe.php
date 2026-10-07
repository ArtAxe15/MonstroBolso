<?php

$url = 'https://pokeapi.co/api/v2/move/body-slam';

$resposta = file_get_contents($url);

if ($resposta === false) {
    die('Não foi possível consultar a PokéAPI.');
}

$golpe = json_decode($resposta, true);

echo '<pre>';
echo "ID: " . $golpe['id'] . "<br>";
echo "Nome: " . $golpe['name'] . "<br>";
echo "Poder: " . $golpe['power'] . "<br>";
echo "Precisão: " . $golpe['accuracy'] . "<br>";
echo "PP: " . $golpe['pp'] . "<br>";
echo "Prioridade: " . $golpe['priority'] . "<br>";
echo "Tipo: " . $golpe['type']['name'] . "<br>";
echo "Classe: " . $golpe['damage_class']['name'] . "<br>";
echo '</pre>';
?>