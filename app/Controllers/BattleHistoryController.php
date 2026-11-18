<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Http\JsonResponse;
use App\Http\PerfilAtivo;
use PDO;

/**
 * Consulta as batalhas já salvas pelo sistema atual, sem alterar
 * o início, os turnos ou a finalização de uma batalha.
 */
final class BattleHistoryController
{
    public function __construct(private PDO $conn) {}

    public function index(): void
    {
        $idPerfil = PerfilAtivo::validar($this->conn);

        $consulta = $this->conn->prepare(
            'SELECT bl.id_batalha, bl.id_desafio, bl.resultado, bl.dinheiro_ganho, '
            . 'bl.detalhes, bl.iniciada_em, bl.finalizada_em, d.nome AS nome_desafio '
            . 'FROM batalha_log bl '
            . 'LEFT JOIN desafio d ON d.id_desafio = bl.id_desafio '
            . 'WHERE bl.id_perfil = :perfil '
            . 'ORDER BY bl.finalizada_em DESC, bl.id_batalha DESC'
        );
        $consulta->execute(['perfil' => $idPerfil]);

        $historico = [];
        foreach ($consulta->fetchAll(PDO::FETCH_ASSOC) as $registro) {
            $detalhes = json_decode((string) ($registro['detalhes'] ?? ''), true);
            if (!is_array($detalhes)) {
                $detalhes = [];
            }

            $logBruto = $detalhes['log'] ?? [];
            $eventos = [];
            if (is_array($logBruto)) {
                foreach ($logBruto as $evento) {
                    if (!is_array($evento)) {
                        continue;
                    }
                    $eventos[] = [
                        'tipo' => (string) ($evento['tipo'] ?? ''),
                        'texto' => (string) ($evento['texto'] ?? ''),
                    ];
                }
            }

            $tipo = (string) ($detalhes['tipo_encontro'] ?? '');
            $historico[] = [
                'id_batalha' => (int) $registro['id_batalha'],
                'titulo' => $this->tituloBatalha($tipo, $eventos, $registro['nome_desafio']),
                'tipo_encontro' => $tipo,
                'resultado' => (string) $registro['resultado'],
                'dinheiro_ganho' => (int) $registro['dinheiro_ganho'],
                'iniciada_em' => $registro['iniciada_em'],
                'finalizada_em' => $registro['finalizada_em'],
                'turnos' => (int) ($detalhes['turnos'] ?? 0),
                'eventos' => $eventos,
            ];
        }

        JsonResponse::send(['ok' => true, 'batalhas' => $historico]);
    }

    private function tituloBatalha(string $tipo, array $eventos, ?string $nomeDesafio): string
    {
        $mensagemInicial = (string) ($eventos[0]['texto'] ?? '');

        if ($tipo === 'selvagem') {
            if (preg_match('/^Um Pokémon selvagem apareceu:\s*(.+?)!$/u', $mensagemInicial, $partes)) {
                return 'Batalha selvagem: ' . $partes[1];
            }
            return 'Batalha selvagem';
        }

        if ($tipo === 'treinador') {
            if (preg_match('/^Um\s+(.+?)\s+quer batalhar!$/ui', $mensagemInicial, $partes)) {
                return 'Batalha contra ' . ucfirst($partes[1]);
            }
            return 'Batalha contra treinador';
        }

        if ($tipo === 'desafio') {
            if ($nomeDesafio !== null && trim($nomeDesafio) !== '') {
                return 'Batalha contra ' . $nomeDesafio;
            }
            if (preg_match('/^(.+?)\s+quer batalhar!$/ui', $mensagemInicial, $partes)) {
                return 'Batalha contra ' . $partes[1];
            }
            return 'Batalha de desafio';
        }

        return 'Batalha registrada';
    }
}
