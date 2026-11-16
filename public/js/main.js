'use strict';

const appElement = document.querySelector('#app');
const entryUrl = document.body.dataset.entryUrl.replace(/\/$/, '');
const entryPath = new URL(entryUrl, window.location.origin).pathname;
const state = { usuario: null, autenticado: false, perfil: null, perfis: [], jogo: null, excluindo: false, batalha: null };

function escaparHtml(valor) {
    return String(valor ?? '').replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }[c]));
}
function urlDaRota(rota) { return `${entryUrl}${rota === '/' ? '' : rota}`; }
function rotaAtual() {
    const p = window.location.pathname;
    return p === entryPath ? '/' : (p.startsWith(`${entryPath}/`) ? p.slice(entryPath.length) || '/' : '/');
}
function alterarUrl(rota, substituir = false) {
    const url = urlDaRota(rota);
    substituir ? history.replaceState({}, '', url) : history.pushState({}, '', url);
}
async function requisitarApi(caminho, opcoes = {}) {
    let resposta;
    try {
        resposta = await fetch(`${entryUrl}${caminho}`, {
            method: opcoes.method || 'GET', credentials: 'same-origin',
            headers: { 'Accept': 'application/json', ...(opcoes.body ? { 'Content-Type': 'application/json' } : {}) },
            ...(opcoes.body ? { body: JSON.stringify(opcoes.body) } : {})
        });
    } catch (_) { throw new Error('Não foi possível comunicar com o servidor.'); }
    const tipo = resposta.headers.get('content-type') || '';
    if (!tipo.includes('application/json')) throw new Error('O servidor não retornou JSON. Confira o log do PHP.');
    const dados = await resposta.json();
    if (!resposta.ok || dados.ok === false) throw new Error(dados.message || 'Não foi possível concluir a operação.');
    return dados;
}
function mensagem(texto, tipo = 'erro') { return texto ? `<div class="mensagem ${tipo}" role="status">${escaparHtml(texto)}</div>` : ''; }
function loading(texto = 'Carregando...') { appElement.innerHTML = `<main class="loading-card"><h1>Roguemon</h1><p>${escaparHtml(texto)}</p></main>`; }

function renderizarLogin(msg = null) {
    document.body.className = 'tela-auth';
    appElement.innerHTML = `<main class="auth-card"><header class="auth-header"><p class="eyebrow">MONSTROBOLSO</p><h1>Roguemon</h1><p>Entre para continuar sua aventura em Unova.</p></header>${msg ? mensagem(msg.texto, msg.tipo) : ''}<form id="form-login" class="formulario" novalidate><div class="campo-formulario"><label for="nome_usuario">Nome de usuário</label><input id="nome_usuario" name="nome_usuario" minlength="3" maxlength="50" autocomplete="username" required></div><div class="campo-formulario"><label for="senha">Senha</label><input type="password" id="senha" name="senha" autocomplete="current-password" required></div><button class="botao botao-principal" type="submit">Entrar</button></form><p class="texto-secundario">Ainda não tem uma conta? <a href="${urlDaRota('/register')}" data-rota="/register">Criar conta</a></p></main>`;
}
function renderizarCadastro(msg = null) {
    document.body.className = 'tela-auth';
    appElement.innerHTML = `<main class="auth-card"><header class="auth-header"><p class="eyebrow">MONSTROBOLSO</p><h1>Criar conta</h1><p>Cadastre seu usuário para começar uma nova aventura.</p></header>${msg ? mensagem(msg.texto, msg.tipo) : ''}<form id="form-cadastro" class="formulario" novalidate><div class="campo-formulario"><label for="nome_usuario">Nome de usuário</label><input id="nome_usuario" name="nome_usuario" minlength="3" maxlength="50" autocomplete="username" required></div><div class="campo-formulario"><label for="senha">Senha</label><input type="password" id="senha" name="senha" minlength="8" autocomplete="new-password" required><small>A senha deve ter pelo menos 8 caracteres, incluindo letras e números.</small></div><div class="campo-formulario"><label for="confirmar_senha">Confirmar senha</label><input type="password" id="confirmar_senha" name="confirmar_senha" autocomplete="new-password" required></div><button class="botao botao-principal" type="submit">Criar conta</button></form><p class="texto-secundario">Já possui uma conta? <a href="${urlDaRota('/login')}" data-rota="/login">Voltar para o login</a></p></main>`;
}
function renderizarDashboard(msg = null) {
    document.body.className = 'tela-dashboard';
    appElement.innerHTML = `<main class="dashboard-card"><header class="dashboard-header"><p class="eyebrow">MONSTROBOLSO</p><h1>Bem-vindo ao Roguemon</h1></header>${msg ? mensagem(msg, 'sucesso') : ''}<p>Você entrou com sucesso no sistema.</p><p class="identificacao-usuario">Usuário: <strong>${escaparHtml(state.usuario?.nome_usuario || 'Treinador')}</strong></p><section class="caixa-texto"><p>Se desafie neste jogo muito bem desenvolvido e com batalhas épicas. <strong>SEJA ESTRATEGISTA E VENÇA O DESAFIO!</strong></p></section><div class="acoes-dashboard"><button class="botao botao-jogar" data-acao="jogar">Jogar</button><button class="botao botao-sair" data-acao="logout">Sair</button></div></main>`;
}

async function carregarPerfis() {
    loading('Consultando suas jornadas...');
    const dados = await requisitarApi('/api/profiles');
    state.perfis = dados.perfis || [];
    state.excluindo = false;
    renderizarPerfis();
}
function renderizarPerfis(msg = null) {
    document.body.className = 'tela-jogo';
    const cards = state.perfis.map((p, i) => `<button class="perfil-card" data-perfil-selecionar="${Number(p.id_perfil)}"><span class="perfil-numero">JORNADA ${i + 1}</span><strong>${escaparHtml(p.nome)}</strong><span>${Number(p.qtd_pokemon) > 0 ? `${Number(p.qtd_pokemon)} Pokémon no time` : 'Ainda não começou'}</span><span class="perfil-dinheiro">₽ ${Number(p.dinheiro).toLocaleString('pt-BR')}</span>${state.excluindo ? '<em>Selecionar para excluir</em>' : '<em>Continuar jornada →</em>'}</button>`).join('');
    const acoes = [];

    if (state.perfis.length < 3) {
        acoes.push(`
            <button class="acao-perfil acao-nova" data-acao="nova-jornada">
                ＋ Começar nova jornada
                <small>${3 - state.perfis.length} espaço(s) disponível(is)</small>
            </button>
        `);
    }

    if (state.perfis.length > 0) {
        acoes.push(`
            <button class="acao-perfil acao-excluir" data-acao="modo-excluir">
                ${state.excluindo ? 'Cancelar exclusão' : 'Excluir perfil'}
            </button>
        `);
    }
    appElement.innerHTML = `<main class="selecao-shell"><header class="jogo-topo"><div><p class="eyebrow">MONSTROBOLSO</p><h1>Suas jornadas</h1><p>Olá, ${escaparHtml(state.usuario?.nome_usuario)}. Escolha onde continuar.</p></div><button class="botao botao-voltar" data-acao="dashboard">Voltar</button></header>${msg ? mensagem(msg.texto, msg.tipo) : ''}<section class="perfis-grid">${cards || '<div class="perfil-vazio">Você ainda não possui jornadas salvas.</div>'}</section><section class="acoes-perfis">${acoes.join('')}</section>${state.excluindo ? '<p class="aviso-exclusao">Selecione a jornada que deseja excluir. A exclusão remove permanentemente o time, dinheiro, itens e progresso dessa jornada.</p>' : ''}</main>`;
}
async function abrirStarter() {
    loading('Preparando a escolha do Pokémon inicial...');
    const dados = await requisitarApi('/api/game/starters');
    renderizarStarter(dados.iniciais || []);
}

function renderizarStarter(iniciais) {
    document.body.className = 'tela-jogo tela-starter';

    // Cria um card para cada Pokémon inicial
    const cards = iniciais.map(p => `
        <button
            class="starter-card"
            data-starter="${escaparHtml(p.nome)}"
        >
            <img
                src="${escaparHtml(p.imagem_url || '')}"
                alt="${escaparHtml(p.nome)}"
            >

            <h2>${escaparHtml(p.nome)}</h2>

            <span class="tipo-tag">
                ${escaparHtml(p.tipos || 'Tipo desconhecido')}
            </span>

            <div class="starter-stats">
                <span>
                    HP <b>${p.hp_base}</b>
                </span>

                <span>
                    ATQ <b>${p.ataque_base}</b>
                </span>

                <span>
                    DEF <b>${p.defesa_base}</b>
                </span>

                <span>
                    ATQ. ESP <b>${p.ataque_especial_base}</b>
                </span>

                <span>
                    DEF. ESP <b>${p.defesa_especial_base}</b>
                </span>

                <span>
                    VEL <b>${p.velocidade_base}</b>
                </span>
            </div>

            <small>Escolher este Pokémon</small>
        </button>
    `).join('');

    // Monta a tela de escolha do inicial
    appElement.innerHTML = `
        <main class="starter-shell">

            <p class="eyebrow">
                SUA AVENTURA EM UNOVA COMEÇA AGORA
            </p>

            <h1>Escolha seu Pokémon inicial</h1>

            <p class="starter-subtitulo">
                Esta escolha será permanente nesta jornada.
            </p>

            <section class="starter-grid">
                ${cards}
            </section>

            <button
                class="botao botao-voltar"
                data-acao="perfis"
            >
                Voltar às jornadas
            </button>

        </main>
    `;
}

async function carregarMapa() {
    loading('Carregando o mapa da sua jornada...');
    const dados = await requisitarApi('/api/game/map');
    if (dados.proxima_etapa === 'starter') { await navegar('/starter'); return; }
    state.jogo = dados;
    state.perfil = dados.perfil;
    renderizarMapa();
}
function renderizarMapa() {
    document.body.className = 'tela-mapa';
    const jogo = state.jogo;
    const team = jogo.time || [];
    const npcs = jogo.npc || [];
    const linhas = [[0, 1], [0, 2], [1, 3], [2, 3], [3, 4], [3, 5], [3, 6], [3, 7], [4, 8], [5, 8], [5, 9], [6, 9], [7, 9], [8, 10], [9, 10], [10, 11]];
    const pontos = [[50, 8], [27, 18], [73, 18], [50, 30], [16, 41], [39, 45], [65, 45], [84, 41], [27, 62], [73, 62], [50, 77], [50, 92]];
    const svgLinhas = linhas.map(([a, b]) => `<line x1="${pontos[a][0]}%" y1="${pontos[a][1]}%" x2="${pontos[b][0]}%" y2="${pontos[b][1]}%" />`).join('');
    const nos = npcs.map(n => `<button class="mapa-npc ${Number(n.derrotado) === 1 ? 'derrotado' : ''}" style="left:${Number(n.posicao_x) / 10}%;top:${Number(n.posicao_y) / 10}%" data-npc="${Number(n.id_npc_mapa)}" title="Treinador tipo ${escaparHtml(n.tipo_nome)}">${Number(n.derrotado) === 1 ? '✓' : '🧢'}<small>${escaparHtml(n.tipo_nome)}</small></button>`).join('');
    const principal = team[0];
    const teamHtml = team.map(p => `<div class="mini-pokemon"><img src="${escaparHtml(p.imagem_url || '')}" alt=""><div><strong>${escaparHtml(p.nome_exibicao)}</strong><small>Nv. ${p.nivel}</small><div class="barra-hp"><i style="width:${Math.max(0, Math.min(100, Number(p.hp_percentual)))}%"></i></div></div></div>`).join('');
    appElement.innerHTML = `<main class="game-shell"><header class="game-header"><div class="game-brand">MONSTROBOLSO <span>ROGUEMON</span></div><div class="game-status"><strong>${escaparHtml(jogo.perfil.nome)}</strong><span>₽ ${Number(jogo.perfil.dinheiro).toLocaleString('pt-BR')}</span><button data-acao="perfis">Trocar jornada</button><button data-acao="logout">Sair</button></div></header><div class="game-layout"><aside class="painel-lateral painel-time"><h2>TIME</h2>${teamHtml || '<p>Seu time está vazio.</p>'}</aside><section class="mapa-area"><div class="mapa-titulo"><span>UNOVA</span><strong>Rota inicial</strong></div><div class="mapa-tabuleiro"><svg class="mapa-conexoes" viewBox="0 0 100 100" preserveAspectRatio="none">${svgLinhas}</svg><div class="mapa-inicio" style="left:50%;top:92%">VOCÊ</div>${nos}<div class="mapa-chegada" style="left:50%;top:8%">★</div></div><p class="mapa-legenda">Selecione um treinador para consultar o desafio. As posições são salvas nesta jornada.</p></section><aside class="painel-lateral painel-itens"><h2>ITENS</h2><p>Bolsa vazia</p><h2>PROGRESSO</h2><p>Treinadores derrotados: ${npcs.filter(n => Number(n.derrotado) === 1).length}/${npcs.length}</p><button class="botao botao-secundario" data-acao="perfis">Jornadas</button></aside></div></main>`;
}

function renderizarBatalha(resposta = null) {
    const dados = resposta || state.batalha;
    const estado = dados?.estado || { jogador: { ativo: null, time: [] }, oponente: { ativo: null, time: [] } };
    const jogador = estado.jogador?.time || [];
    const oponente = estado.oponente?.time || [];
    const jogadorAtivo = estado.jogador?.ativo || null;
    const oponenteAtivo = estado.oponente?.ativo || null;
    const ataqueJogador = jogadorAtivo ? jogador[jogadorAtivo] : null;
    const ataqueOponente = oponenteAtivo ? oponente[oponenteAtivo] : null;
    const itens = Array.isArray(dados?.itens) ? dados.itens : [];
    const eventos = Array.isArray(dados?.eventos) ? dados.eventos.slice(-8) : [];

    const renderTime = (lado, time, ativoIndex) => time.map((pokemon, index) => {
        const hpAtual = Number(pokemon.hp || pokemon.hp_atual || 0);
        const hpMax = Number(pokemon.hp_max || pokemon.hp || 1);
        const largura = Math.max(0, Math.min(100, (hpAtual / Math.max(1, hpMax)) * 100));
        const ativo = index === Number(ativoIndex);
        return `
            <div class="battle-card ${ativo ? 'is-active' : ''}">
                <div class="battle-card-top">
                    <span>${ativo ? 'ATIVO' : 'RESERVA'}</span>
                    <strong>${escaparHtml(pokemon.nome || 'Pokemon')}</strong>
                </div>
                <div class="battle-card-status">
                    <small>HP ${hpAtual}/${hpMax}</small>
                    <div class="barra-hp"><i style="width:${largura}%"></i></div>
                </div>
            </div>
        `;
    }).join('') || '<p>Sem Pokémon.</p>';

    const renderGolpes = () => {
        if (!ataqueJogador || !Array.isArray(ataqueJogador.golpes)) return '<p>Este Pokémon não possui golpes.</p>';
        return ataqueJogador.golpes.map((golpe, slot) => `
            <button class="botao botao-principal batalha-acao" data-acao="atacar" data-slot="${slot}">
                ${escaparHtml(golpe.nome || `Golpe ${slot + 1}`)}
            </button>
        `).join('');
    };

    const renderItens = () => {
        if (!itens.length) return '<p>Bolsa vazia.</p>';
        return itens.map(item => `
            <button class="botao botao-secundario batalha-item" data-acao="usar-item" data-item-id="${Number(item.id_item)}" data-item-alvo="1">
                ${escaparHtml(item.nome || 'Item')} (${Number(item.quantidade || 0)})
            </button>
        `).join('');
    };

    const renderEventos = () => eventos.map(ev => `
        <li>
            <strong>${escaparHtml(ev.tipo || 'evento')}</strong>
            <span>${escaparHtml((ev.pokemon || ev.golpe || ev.item || ev.lado || 'Batalha'))}</span>
        </li>
    `).join('') || '<li>Sem eventos recentes.</li>';

    appElement.innerHTML = `
        <main class="battle-shell">
            <header class="battle-header">
                <div>
                    <p class="eyebrow">MONSTROBOLSO</p>
                    <h1>Batalha ativa</h1>
                </div>
                <button class="botao botao-voltar" data-acao="mapa-batalha">Voltar ao mapa</button>
            </header>

            <section class="battle-viewport">
                <div class="battle-side">
                    <h2>Seu time</h2>
                    ${renderTime('JOGADOR', jogador, jogadorAtivo)}
                </div>
                <div class="battle-side enemy">
                    <h2>Oponente</h2>
                    ${renderTime('INIMIGO', oponente, oponenteAtivo)}
                </div>
            </section>

            <section class="battle-actions">
                <div class="battle-panel">
                    <h3>Golpes</h3>
                    <div class="battle-buttons">
                        ${renderGolpes()}
                    </div>
                </div>
                <div class="battle-panel">
                    <h3>Itens</h3>
                    <div class="battle-buttons">
                        ${renderItens()}
                    </div>
                </div>
            </section>

            <section class="battle-log">
                <h3>Últimos eventos</h3>
                <ul>${renderEventos()}</ul>
            </section>
        </main>
    `;
}

async function iniciarBatalhaNpc(idNpc, idDesafio = null) {
    const desafio = Number(idDesafio ?? 1);
    loading('Preparando a batalha...');
    const resposta = await requisitarApi('/api/battle/start', {
        method: 'POST',
        body: { id_desafio: desafio }
    });
    state.batalha = resposta;
    renderizarBatalha(resposta);
}

async function executarTurnoBatalha(payload) {
    const resposta = await requisitarApi('/api/battle/turn', {
        method: 'POST',
        body: payload
    });
    state.batalha = resposta;
    renderizarBatalha(resposta);
    if (resposta.estado?.fim) {
        const resultado = resposta.estado?.resultado || { status: resposta.estado.fim };
        setTimeout(() => alert(`Batalha finalizada: ${resultado.status || resposta.estado.fim}`), 120);
    }
}

async function navegar(rota, opcoes = {}) {
    const permitidas = ['/', '/login', '/register', '/dashboard', '/profiles', '/starter', '/map'];
    if (!permitidas.includes(rota)) rota = '/';
    if (!state.autenticado && !['/', '/login', '/register'].includes(rota)) rota = '/login';
    if (state.autenticado && ['/', '/login', '/register'].includes(rota)) rota = '/dashboard';
    if (opcoes.atualizarUrl !== false) alterarUrl(rota, opcoes.substituir === true);
    try {
        if (rota === '/register') renderizarCadastro(opcoes.mensagem || null);
        else if (rota === '/dashboard') renderizarDashboard(opcoes.mensagem || null);
        else if (rota === '/profiles') await carregarPerfis();
        else if (rota === '/starter') await abrirStarter();
        else if (rota === '/map') await carregarMapa();
        else renderizarLogin(opcoes.mensagem || null);
    } catch (e) {
        if (e.message.includes('sessão') || e.message.includes('Selecione uma jornada')) {
            state.perfil = null;
            await navegar('/profiles', { substituir: true, mensagem: { texto: e.message, tipo: 'erro' } });
        } else {
            appElement.innerHTML = `<main class="loading-card">${mensagem(e.message, 'erro')}<button class="botao botao-principal" data-acao="perfis">Voltar</button></main>`;
        }
    }
}

async function verificarSessaoInicial() {
    loading('Carregando sua aventura...');
    try {
        const dados = await requisitarApi('/api/session');
        state.autenticado = dados.autenticado === true; state.usuario = dados.usuario || null;
        let rota = rotaAtual();
        if (!['/', '/login', '/register', '/dashboard', '/profiles', '/starter', '/map'].includes(rota)) rota = '/';
        await navegar(rota, { substituir: true });
    } catch (e) { state.autenticado = false; state.usuario = null; await navegar('/login', { substituir: true, mensagem: { texto: e.message, tipo: 'erro' } }); }
}

document.addEventListener('submit', async ev => {
    const form = ev.target;
    if (!['form-login', 'form-cadastro'].includes(form.id)) return;
    ev.preventDefault(); const btn = form.querySelector('button[type="submit"]'); const old = btn.textContent; btn.disabled = true; btn.textContent = 'Enviando...';
    try {
        const dados = Object.fromEntries(new FormData(form).entries());
        if (form.id === 'form-login') { const r = await requisitarApi('/api/login', { method: 'POST', body: dados }); state.autenticado = true; state.usuario = r.usuario; await navegar('/dashboard', { mensagem: r.message }); }
        else { const r = await requisitarApi('/api/register', { method: 'POST', body: dados }); await navegar('/login', { mensagem: { texto: r.message, tipo: 'sucesso' } }); }
    } catch (e) { const m = { texto: e.message, tipo: 'erro' }; form.id === 'form-login' ? renderizarLogin(m) : renderizarCadastro(m); }
    finally { if (btn.isConnected) { btn.disabled = false; btn.textContent = old; } }
});

document.addEventListener('click', async ev => {
    const link = ev.target.closest('[data-rota]'); if (link) { ev.preventDefault(); await navegar(link.dataset.rota); return; }
    const acao = ev.target.closest('[data-acao]')?.dataset.acao;
    try {
        if (acao === 'jogar') { await navegar('/profiles'); return; }
        if (acao === 'dashboard') { await navegar('/dashboard'); return; }
        if (acao === 'perfis') { state.perfil = null; await navegar('/profiles'); return; }
        if (acao === 'nova-jornada') {
            const nome = prompt('Qual será o nome desta jornada?'); if (nome === null) return;
            const r = await requisitarApi('/api/profiles', { method: 'POST', body: { nome } }); state.perfil = { id_perfil: r.id_perfil, nome }; await navegar('/starter'); return;
        }
        if (acao === 'modo-excluir') { state.excluindo = !state.excluindo; renderizarPerfis(); return; }
        if (acao === 'logout') { await requisitarApi('/api/logout', { method: 'POST' }); state.autenticado = false; state.usuario = null; state.perfil = null; state.jogo = null; await navegar('/login', { mensagem: { texto: 'Você saiu da sua conta.', tipo: 'sucesso' } }); return; }
        const perfilCard = ev.target.closest('[data-perfil-selecionar]');
        if (perfilCard) {
            const id = Number(perfilCard.dataset.perfilSelecionar);
            if (state.excluindo) {
                const perfil = state.perfis.find(p => Number(p.id_perfil) === id);
                if (!confirm(`Excluir permanentemente a jornada "${perfil?.nome || ''}"? Essa ação não pode ser desfeita.`)) return;
                await requisitarApi('/api/profiles/delete', { method: 'POST', body: { id_perfil: id } }); await carregarPerfis(); return;
            }
            const r = await requisitarApi('/api/profiles/select', { method: 'POST', body: { id_perfil: id } });
            state.perfil = r.perfil || null; await navegar(r.proxima_etapa === 'starter' ? '/starter' : '/map'); return;
        }
        const starter = ev.target.closest('[data-starter]');
        if (starter) {
            if (!confirm(`Escolher ${starter.dataset.starter.toUpperCase()} como inicial desta jornada?`)) return;
            await requisitarApi('/api/game/starter', { method: 'POST', body: { nome: starter.dataset.starter } }); await navegar('/map'); return;
        }
        const npc = ev.target.closest('[data-npc]');
        if (npc) {
            const item = (state.jogo?.npc || []).find(n => Number(n.id_npc_mapa) === Number(npc.dataset.npc));
            if (!item) return;
            if (Number(item.derrotado) === 1) {
                alert('Este treinador já foi derrotado.');
                return;
            }
            const desafioId = Number(item.ordem || item.id_npc_mapa || 1);
            await iniciarBatalhaNpc(Number(item.id_npc_mapa), desafioId);
            return;
        }

        if (acao === 'mapa-batalha') {
            state.batalha = null;
            await carregarMapa();
            return;
        }

        if (acao === 'atacar') {
            const slot = Number(ev.target.closest('[data-slot]')?.dataset.slot ?? -1);
            await executarTurnoBatalha({ acao: 'golpe', slot });
            return;
        }

        if (acao === 'usar-item') {
            const itemId = Number(ev.target.closest('[data-item-id]')?.dataset.itemId ?? 0);
            if (!itemId) return;
            await executarTurnoBatalha({ acao: 'item', id_item: itemId, alvo_posicao: 1 });
            return;
        }
    } catch (e) { alert(e.message); }
});
window.addEventListener('popstate', () => navegar(rotaAtual(), { atualizarUrl: false }));
verificarSessaoInicial();
