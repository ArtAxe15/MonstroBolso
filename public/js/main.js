'use strict';

const appElement = document.querySelector('#app');
const entryUrl = document.body.dataset.entryUrl.replace(/\/$/, '');
const entryPath = new URL(entryUrl, window.location.origin).pathname;
const state = { usuario: null, autenticado: false, perfil: null, perfis: [], jogo: null, excluindo: false, encounterSelection: null, battle: null, battleMenu: 'menu', battleBusy: false, battleLogVisible: [], battleSummary: null, battleMessage: null };

function escaparHtml(valor) {
    return String(valor ?? '').replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }[c]));
}
function formatarNomeFrontend(valor) {
    return String(valor ?? '').replace(/-/g, ' ').replace(/(^|\s)([a-z])/g, (_, espaco, letra) => espaco + letra.toUpperCase());
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
    if (!resposta.ok || dados.ok === false) {
        const erro = new Error(dados.message || 'Não foi possível concluir a operação.');
        erro.status = resposta.status;
        throw erro;
    }
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

async function carregarMapa(aviso = '') {
    loading('Carregando o mapa da sua jornada...');
    const dados = await requisitarApi('/api/game/map');
    if (dados.proxima_etapa === 'starter') { await navegar('/starter'); return; }
    state.jogo = dados;
    state.perfil = dados.perfil;
    renderizarMapa(aviso);
}

function visitarLocalMapa(idMapaNo, acao, item = {}) {
    return requisitarApi('/api/game/map/service', {
        method: 'POST',
        body: { id_mapa_no: idMapaNo, acao, ...item }
    });
}

// Um único Pokémon por ponto POKEBOLA. A oferta fica salva no servidor.
async function abrirPokebola(idMapaNo) {
    const oferta = await requisitarApi(`/api/game/map/pokebola?id_mapa_no=${idMapaNo}`);
    const pokemon = oferta.pokemon;
    const stats = pokemon.atributos || {};
    const nome = formatarNomeFrontend(pokemon.nome);
    const dialogo = document.createElement('dialog');
    dialogo.className = 'pokebola-dialogo';
    dialogo.setAttribute('aria-labelledby', 'pokebola-titulo');
    let ocupado = false;
    const atributos = [
        ['HP', stats.hp_max],
        ['Ataque', stats.ataque],
        ['Defesa', stats.defesa],
        ['At. Especial', stats.ataque_especial],
        ['Def. Especial', stats.defesa_especial],
        ['Velocidade', stats.velocidade]
    ];
    dialogo.innerHTML = `
        <div class="pokebola-cabecalho">
            <p>VOCÊ ENCONTROU UMA POKÉBOLA!</p>
            <h2 id="pokebola-titulo">Um Pokémon apareceu!</h2>
        </div>
        <div class="pokebola-cartao">
            <span class="pokebola-desenho" aria-hidden="true">🔴</span>
            <img src="${escaparHtml(pokemon.imagem_url || '')}" alt="${escaparHtml(nome)}" class="pokebola-sprite">
            <h3>${escaparHtml(nome)}</h3>
            <p class="pokebola-nivel">Nv. ${Number(pokemon.nivel)}</p>
            <p class="pokebola-tipos">${escaparHtml(pokemon.tipos || 'Tipo desconhecido')}</p>
            <dl class="pokebola-atributos">${atributos.map(([titulo, valor]) => `
                <div><dt>${escaparHtml(titulo)}</dt><dd>${Number(valor)}</dd></div>`).join('')}
            </dl>
        </div>
        <p class="pokebola-aviso">${oferta.time_cheio
            ? 'Seu time já está completo (6/6). Não é possível aceitar outro Pokémon.'
            : `Você tem ${Number(oferta.quantidade_time)}/6 Pokémon. Deseja levar este para a equipe?`}</p>
        <div class="pokebola-feedback" role="status" aria-live="polite"></div>
        <div class="pokebola-acoes">
            <button type="button" data-pokebola-escolha="true" ${oferta.time_cheio ? 'disabled' : ''}>Adicionar ao time</button>
            <button type="button" data-pokebola-escolha="false">Deixar para trás</button>
        </div>
        <button type="button" class="pokebola-fechar" data-pokebola-fechar>Voltar ao mapa sem decidir</button>
    `;
    dialogo.addEventListener('cancel', ev => { if (ocupado) ev.preventDefault(); });
    dialogo.addEventListener('close', () => dialogo.remove());
    dialogo.addEventListener('click', async ev => {
        const botaoFechar = ev.target.closest('[data-pokebola-fechar]');
        if (botaoFechar && !ocupado) { dialogo.close(); return; }
        const botao = ev.target.closest('[data-pokebola-escolha]');
        if (!botao || ocupado) return;
        ocupado = true;
        dialogo.querySelectorAll('button').forEach(item => item.disabled = true);
        try {
            const resposta = await requisitarApi('/api/game/map/pokebola', {
                method: 'POST',
                body: { id_mapa_no: idMapaNo, aceitar: botao.dataset.pokebolaEscolha === 'true' }
            });
            dialogo.close();
            await carregarMapa(resposta.message);
        } catch (erro) {
            const feedback = dialogo.querySelector('.pokebola-feedback');
            if (feedback) feedback.innerHTML = mensagem(erro.message);
            dialogo.querySelectorAll('button').forEach(item => {
                item.disabled = oferta.time_cheio && item.dataset.pokebolaEscolha === 'true';
            });
        } finally {
            ocupado = false;
        }
    });
    document.body.appendChild(dialogo);
    dialogo.showModal();
}

async function trocarPosicoesDoTime(primeiro, segundo) {
    const resultado = await requisitarApi('/api/game/team/swap', {
        method: 'POST',
        body: { primeiro, segundo }
    });
    await carregarMapa(resultado.message);
}

async function abrirPokemart(idMapaNo) {
    const catalogo = await requisitarApi(`/api/game/pokemart?id_mapa_no=${idMapaNo}`);
    const dialogo = document.createElement('dialog');
    dialogo.className = 'pokemart-dialogo';
    dialogo.setAttribute('aria-labelledby', 'pokemart-titulo');
    let ocupado = false;
    let comprou = false;

    function renderizar(aviso = '', tipo = 'sucesso') {
        dialogo.innerHTML = `
            <header><h2 id="pokemart-titulo">Poké Mart</h2>
                <button type="button" data-mart-acao="fechar">Fechar</button>
            </header>
            <p>Saldo: ₽ ${Number(catalogo.dinheiro).toLocaleString('pt-BR')}</p>
            ${mensagem(aviso, tipo)}
            <ul class="pokemart-catalogo">
                ${catalogo.itens.map(item => `
                    <li>
                        <div><strong>${escaparHtml(item.nome)}</strong>
                            <p>${escaparHtml(item.descricao)}</p>
                            <small>Na bolsa: ${Number(item.quantidade)}</small></div>
                        <button type="button" data-mart-item="${Number(item.id_item)}"
                            ${Number(item.preco) > Number(catalogo.dinheiro) ? 'disabled' : ''}>
                            Comprar · ₽ ${Number(item.preco).toLocaleString('pt-BR')}
                        </button>
                    </li>`).join('')}
            </ul>
            <button type="button" data-mart-acao="concluir">Concluir visita</button>`;
    }

    dialogo.addEventListener('cancel', ev => { if (ocupado) ev.preventDefault(); });
    dialogo.addEventListener('close', async () => {
        dialogo.remove();
        if (comprou && rotaAtual() === '/map') {
            try { await carregarMapa(); } catch (e) { alert(e.message); }
        }
    });
    dialogo.addEventListener('click', async ev => {
        const botao = ev.target.closest('button');
        if (!botao || ocupado) return;
        if (botao.dataset.martAcao === 'fechar') {
            dialogo.close();
            return;
        }
        ocupado = true;
        dialogo.querySelectorAll('button').forEach(botao => { botao.disabled = true; });
        const idItem = Number(botao.dataset.martItem);
        try {
            if (botao.dataset.martAcao === 'concluir') {
                await visitarLocalMapa(idMapaNo, 'concluir_pokemart');
                comprou = false;
                dialogo.close();
                await carregarMapa('Visita ao Poké Mart concluída.');
                return;
            }
            const item = catalogo.itens.find(item => Number(item.id_item) === idItem);
            const resposta = await visitarLocalMapa(idMapaNo, 'comprar', { id_item: idItem });
            comprou = true;
            catalogo.dinheiro = resposta.dinheiro;
            item.quantidade = Number(item.quantidade) + 1;
            renderizar(`${item.nome} adicionado à bolsa.`);
        } catch (e) {
            if (dialogo.open) renderizar(e.message, 'erro');
            else alert(e.message);
        } finally {
            ocupado = false;
            const foco = dialogo.querySelector(`[data-mart-item="${idItem}"]:enabled`)
                || dialogo.querySelector('[data-mart-acao="concluir"]');
            foco?.focus();
        }
    });
    renderizar();
    appElement.appendChild(dialogo);
    dialogo.showModal();
}

async function abrirBatalha() {
    loading('Preparando a batalha...');

    if (state.encounterSelection) {
        const dados = await requisitarApi('/api/battle/start', {
            method: 'POST',
            body: state.encounterSelection
        });
        state.battle = dados.batalha;
        state.encounterSelection = null;
        state.battleLogVisible = dados.batalha.log || [];
        state.battleSummary = null;
        state.battleMessage = null;
    } else {
        try {
            const dados = await requisitarApi('/api/battle/state');
            state.battle = dados.batalha;
            state.battleLogVisible = (dados.batalha.log || []).slice(-20);
            state.battleSummary = null;
            state.battleMessage = null;
        } catch (e) {
            if (e.status === 404) {
                state.battle = null;
                await navegar('/map', { substituir: true });
                return;
            }
            throw e;
        }
    }

    state.battleMenu = 'menu';
    renderizarBatalha();
}

function renderizarBatalha() {
    const batalha = state.battle;
    if (batalha.finalizada && batalha.resultado !== 'VITORIA') {
        renderizarResultadoBatalha();
        return;
    }

    const mostrarVitoria = batalha.finalizada && !state.battleBusy;
    document.body.className = 'tela-batalha';
    appElement.innerHTML = `
        <main class="battle-shell">
            <header class="game-header">
                <div class="game-brand">MONSTROBOLSO <span>BATALHA</span></div>
                <strong>${escaparHtml(state.perfil?.nome || `Jornada ${batalha.id_perfil}`)}</strong>
            </header>
            <section class="battle-heading">
                <p class="eyebrow">ÁREA ${escaparHtml(batalha.area_atual)}</p>
                <h1>${escaparHtml(batalha.alvo.nome)}</h1>
            </section>
            <div class="battle-teams">
                ${renderizarLadoBatalha(batalha.jogador, 'SEU TIME', true)}
                ${renderizarLadoBatalha(batalha.adversario, 'TIME ADVERSÁRIO', false)}
            </div>
            ${renderizarLogBatalha()}
            ${state.battleMessage ? mensagem(state.battleMessage, 'erro') : ''}
            ${batalha.finalizada ? '' : `<button class="botao botao-voltar" data-acao="voltar-mapa" ${state.battleBusy ? 'disabled' : ''}>Voltar ao mapa</button>`}
        </main>
        ${mostrarVitoria ? renderizarCaixaVitoria() : ''}
    `;
}

function renderizarCaixaVitoria() {
    const batalha = state.battle;
    const pokemons = state.battleSummary?.pokemons || [];
    return `
        <div class="battle-victory-overlay">
            <section class="battle-victory-dialog" role="dialog" aria-modal="true" aria-labelledby="battle-victory-title">
                <p class="eyebrow">VITÓRIA</p>
                <h1 id="battle-victory-title">Você venceu!</h1>
                ${batalha.persistencia_pendente
                    ? '<p>Não foi possível salvar o resultado. Tente novamente.</p>'
                    : pokemons.length ? `
                        <ul class="battle-level-summary">
                            ${pokemons.map(p => `<li><strong>${escaparHtml(p.nome)}</strong><span>Nv. ${Number(p.nivel_antes)} → Nv. ${Number(p.nivel_depois)}</span><span>HP ${Number(p.hp_final)}</span></li>`).join('')}
                        </ul>
                    ` : ''}
                ${Number(state.battleSummary?.dinheiro_ganho) > 0
                    ? `<p class="battle-money-reward">Você recebeu ₽ ${Number(state.battleSummary.dinheiro_ganho).toLocaleString('pt-BR')}!</p>`
                    : ''}
                ${batalha.persistencia_pendente
                    ? `<button class="botao botao-principal" data-acao="tentar-salvar-batalha" ${state.battleBusy ? 'disabled' : ''}>Tentar salvar novamente</button>`
                    : `<button class="botao botao-principal battle-continue" data-acao="continuar-batalha">Continuar</button>`}
            </section>
        </div>
    `;
}

function renderizarResultadoBatalha() {
    const batalha = state.battle;
    const vitoria = batalha.resultado === 'VITORIA';
    const pokemons = state.battleSummary?.pokemons || [];
    document.body.className = 'tela-batalha';
    appElement.innerHTML = `
        <main class="battle-shell">
            <header class="game-header">
                <div class="game-brand">MONSTROBOLSO <span>RESULTADO DA BATALHA</span></div>
                <strong>${escaparHtml(state.perfil?.nome || `Jornada ${batalha.id_perfil}`)}</strong>
            </header>
            <section class="battle-result ${vitoria ? 'vitoria' : 'derrota'}">
                <p class="eyebrow">${vitoria ? 'VITÓRIA' : 'DERROTA'}</p>
                <h1>${vitoria ? 'Você venceu!' : 'Você perdeu!'}</h1>
                ${batalha.persistencia_pendente
                    ? '<p>Não foi possível salvar o resultado. Tente novamente.</p>'
                    : ''}
                ${pokemons.length ? `
                    <ul class="battle-level-summary">
                        ${pokemons.map(p => `<li><strong>${escaparHtml(p.nome)}</strong><span>Nv. ${Number(p.nivel_antes)} → Nv. ${Number(p.nivel_depois)}</span><span>HP ${Number(p.hp_final)}</span></li>`).join('')}
                    </ul>
                ` : ''}
            </section>
            ${renderizarLogBatalha()}
            ${state.battleMessage ? mensagem(state.battleMessage, 'erro') : ''}
            ${batalha.persistencia_pendente
                ? `<button class="botao botao-principal" data-acao="tentar-salvar-batalha" ${state.battleBusy ? 'disabled' : ''}>Tentar salvar novamente</button>`
                : ''}
            <button class="botao botao-voltar" data-acao="voltar-mapa" ${state.battleBusy ? 'disabled' : ''}>Voltar ao mapa</button>
        </main>
    `;
}

function renderizarLogBatalha() {
    const eventos = (state.battleLogVisible || []).slice(-20);
    return `
        <section class="battle-log" aria-label="Registro da batalha">
            <h2>REGISTRO DA BATALHA</h2>
            <ol id="battle-log-list" aria-live="polite">
                ${eventos.map(evento => `<li class="log-${escaparHtml(evento.tipo)}">${escaparHtml(evento.texto)}</li>`).join('')}
            </ol>
        </section>
    `;
}

async function animarEventosBatalha(eventos) {
    for (const evento of eventos) {
        state.battleLogVisible.push(evento);
        state.battleLogVisible = state.battleLogVisible.slice(-20);
        const lista = appElement.querySelector('#battle-log-list');
        if (lista) {
            const item = document.createElement('li');
            item.className = `log-${evento.tipo}`;
            item.textContent = evento.texto;
            lista.appendChild(item);
            while (lista.children.length > 20) lista.firstElementChild.remove();
            lista.scrollTop = lista.scrollHeight;
        }
        await new Promise(resolve => window.setTimeout(resolve, 420));
    }
}

async function recarregarEstadoBatalha() {
    try {
        const dados = await requisitarApi('/api/battle/state');
        state.battle = dados.batalha;
        state.battleLogVisible = (dados.batalha.log || []).slice(-20);
        state.battleSummary = null;
        state.battleMessage = null;
        renderizarBatalha();
    } catch (e) {
        if (e.status === 404) {
            state.battle = null;
            await navegar('/map', { substituir: true });
            return;
        }
        throw e;
    }
}

async function enviarTurnoBatalha(acao) {
    if (state.battleBusy || !state.battle) return;
    state.battleBusy = true;
    state.battleMessage = null;
    renderizarBatalha();
    try {
        const dados = await requisitarApi('/api/battle/turn', {
            method: 'POST',
            body: {
                ...acao,
                turno: state.battle.turno
            }
        });
        state.battle = dados.batalha;
        state.battleSummary = dados.resumo || null;
        state.battleMenu = acao.acao === 'item' ? 'item' : 'fight';
        state.battleLogVisible = state.battleLogVisible || [];
        renderizarBatalha();
        await animarEventosBatalha(dados.eventos || []);
    } catch (e) {
        state.battleMessage = e.message;
        if (e.status === 409 || (e.status && e.status >= 500)) {
            try {
                await recarregarEstadoBatalha();
                state.battleMessage = e.message;
                if (state.battle) renderizarBatalha();
            } catch (erroEstado) {
                state.battleMessage = erroEstado.message;
            }
        }
    } finally {
        state.battleBusy = false;
        if (state.battle) renderizarBatalha();
    }
}

async function tentarSalvarBatalha() {
    if (state.battleBusy || !state.battle?.persistencia_pendente) return;
    state.battleBusy = true;
    state.battleMessage = null;
    renderizarBatalha();
    try {
        const dados = await requisitarApi('/api/battle/turn', {
            method: 'POST',
            body: {
                acao: 'golpe',
                id_golpe: 0,
                turno: state.battle.turno
            }
        });
        state.battle = dados.batalha;
        state.battleSummary = dados.resumo || null;
        state.battleLogVisible = (dados.batalha.log || []).slice(-20);
        renderizarBatalha();
    } catch (e) {
        state.battleMessage = e.message;
        if (e.status === 409 || (e.status && e.status >= 500)) {
            try {
                await recarregarEstadoBatalha();
                state.battleMessage = e.message;
                if (state.battle) renderizarBatalha();
            } catch (erroEstado) {
                state.battleMessage = erroEstado.message;
            }
        }
    } finally {
        state.battleBusy = false;
        if (state.battle) renderizarBatalha();
    }
}

function renderizarLadoBatalha(lado, titulo, ehJogador) {
    const time = Array.isArray(lado.time) ? lado.time : [];
    const indiceAtivo = Number(lado.indice_ativo);
    const ativo = time[indiceAtivo];
    if (!ativo) {
        return `<section class="battle-panel"><h2>${escaparHtml(titulo)}</h2><p class="battle-empty">Nenhum Pokémon disponível.</p></section>`;
    }

    const reserva = time
        .filter((_, indice) => indice !== indiceAtivo)
        .map(renderizarReservaBatalha)
        .join('');

    return `
        <section class="battle-panel">
            <h2>${escaparHtml(titulo)}</h2>
            ${renderizarPokemonAtivo(ativo, ehJogador)}
            <section class="battle-reserve">
                <h3>RESERVA</h3>
                ${reserva || '<p class="battle-empty">Sem outros Pokémon.</p>'}
            </section>
        </section>
    `;
}

function renderizarPokemonAtivo(pokemon, ehJogador) {
    const atributos = pokemon.atributos;
    const hpMax = Math.max(0, Number(atributos.hp_max) || 0);
    const hpAtual = Math.max(0, Math.min(hpMax, Number(atributos.hp_atual) || 0));
    const hpPercentual = hpMax > 0 ? (hpAtual / hpMax) * 100 : 0;
    const tipos = Array.isArray(pokemon.tipos) ? pokemon.tipos.join(', ') : '';
    const status = pokemon.status === 'normal' ? 'Sem condição' : pokemon.status;
    const nome = formatarNomeFrontend(pokemon.nome_exibicao || pokemon.nome_especie);

    return `
        <article class="battle-active">
            <div class="battle-active-heading">
                <img src="${escaparHtml(pokemon.imagem_url || '')}" alt="${escaparHtml(nome)}">
                <div>
                    <strong>${escaparHtml(nome)}</strong>
                    <span>${escaparHtml(tipos || 'Tipo desconhecido')} · Nv. ${escaparHtml(pokemon.nivel)}</span>
                    <span>Condição: ${escaparHtml(status)}</span>
                    ${pokemon.held_item ? `<span>Item: ${escaparHtml(pokemon.held_item.nome)}</span>` : ''}
                </div>
            </div>
            <div class="battle-hp">
                <span>HP ${escaparHtml(hpAtual)} / ${escaparHtml(hpMax)}</span>
                <div class="battle-hp-bar"><i style="width:${hpPercentual}%"></i></div>
            </div>
            ${renderizarAtributosBatalha(atributos, pokemon.ataques_efetivos)}
            ${state.battle.finalizada
                ? '<p class="battle-finished-note">Batalha concluída.</p>'
                : ehJogador ? renderizarMenuAcoesBatalha() : renderizarGolpesAtivos(pokemon.golpes)}
        </article>
    `;
}

function renderizarAtributosBatalha(atributos, ataquesEfetivos = {}) {
    const linhas = [
        ['HP', atributos.hp_max],
        ['ATQ', ataquesEfetivos.ataque ?? atributos.ataque],
        ['DEF', atributos.defesa],
        ['ATQ. ESP', ataquesEfetivos.ataque_especial ?? atributos.ataque_especial],
        ['DEF. ESP', atributos.defesa_especial],
        ['VEL', atributos.velocidade]
    ];

    return `
        <div class="battle-stats" aria-label="Atributos">
            ${linhas.map(([nome, valor]) => `
                <div><span>${escaparHtml(nome)}</span><strong>${escaparHtml(valor)}</strong></div>
            `).join('')}
        </div>
    `;
}

function renderizarGolpesAtivos(golpes, selecionavel = false) {
    const movimentos = (golpes.dano || []).map(golpe => ({ ...golpe, tipo_golpe: 'Dano' }));
    if ([14, 417].includes(golpes.status?.api_id)) {
        movimentos.push({ ...golpes.status, tipo_golpe: 'Status' });
    }

    return `
        <section class="battle-moves">
            <h3>GOLPES DO POKÉMON ATIVO</h3>
            ${movimentos.length ? movimentos.map(golpe => `
                ${selecionavel ? `
                    <button
                        type="button"
                        class="battle-move battle-move-button"
                        data-battle-move="${Number(golpe.id_golpe)}"
                        ${state.battleBusy ? 'disabled' : ''}
                    >
                        <strong>${escaparHtml(formatarNomeFrontend(golpe.nome))}</strong>
                        <span>${golpe.tipo_golpe === 'Status'
                            ? 'Status'
                            : `${escaparHtml(golpe.tipo)} · Poder ${escaparHtml(golpe.poder ?? '—')}`}</span>
                    </button>
                ` : `
                    <article class="battle-move">
                        <strong>${escaparHtml(formatarNomeFrontend(golpe.nome))}</strong>
                        <span>${escaparHtml(golpe.tipo_golpe)} · ${escaparHtml(golpe.tipo)} · ${escaparHtml(golpe.categoria)}</span>
                        <small>Poder: ${escaparHtml(golpe.poder ?? '—')} · PP: ${escaparHtml(golpe.pp ?? '—')}</small>
                    </article>
                `}
            `).join('') : '<p class="battle-empty">Nenhum golpe cadastrado.</p>'}
        </section>
    `;
}

function renderizarMenuAcoesBatalha() {
    const menu = state.battleMenu || 'menu';
    const opcoes = [
        ['fight', 'Lutar'],
        ['switch', 'Trocar'],
        ['item', 'Item']
    ];
    let conteudo = '';

    if (menu === 'fight') {
        const jogador = state.battle.jogador;
        const pokemon = jogador.time[Number(jogador.indice_ativo)];
        conteudo = pokemon ? renderizarGolpesAtivos(pokemon.golpes, true) : '';
    }
    if (menu === 'item') {
        const jogador = state.battle.jogador;
        const itens = jogador.itens || [];
        conteudo = itens.length ? itens.map(item => {
            const alvos = jogador.time.filter(pokemon => {
                const hp = Number(pokemon.atributos.hp_atual);
                if (item.categoria === 'REVIVE') return hp === 0;
                if (hp <= 0) return false;
                const podeCurarHp = ['HP', 'HP_STATUS'].includes(item.categoria)
                    && hp < Number(pokemon.atributos.hp_max);
                return podeCurarHp || item.cura_status?.includes(pokemon.status);
            });
            return `
                <form class="battle-moves" data-item-batalha="${Number(item.id_item)}">
                    <label>
                        <strong>${escaparHtml(item.nome)} · ${Number(item.quantidade)}</strong>
                        <span>${escaparHtml(item.descricao)}</span>
                        <select name="id_pokemon_time" aria-label="Alvo de ${escaparHtml(item.nome)}"
                            required ${!alvos.length || state.battleBusy ? 'disabled' : ''}>
                            <option value="">${alvos.length ? 'Escolha um Pokémon' : 'Sem alvo válido'}</option>
                            ${opcoesAlvoItem(alvos)}
                        </select>
                    </label>
                    <button type="submit" class="battle-move battle-move-button"
                        ${!alvos.length || state.battleBusy ? 'disabled' : ''}>Usar item</button>
                </form>`;
        }).join('') : '<p class="battle-empty">Nenhum item de cura na bolsa.</p>';
    }

    return `
        <section class="battle-actions">
            <h3>O QUE FAZER?</h3>
            <div class="battle-action-menu">
                ${opcoes.map(([valor, rotulo]) => `
                    <button
                        type="button"
                        class="battle-action-option ${menu === valor ? 'selecionada' : ''}"
                        data-battle-menu="${valor}"
                        aria-pressed="${menu === valor}"
                        ${valor === 'switch' || state.battleBusy ? 'disabled' : ''}
                    >${rotulo}</button>
                `).join('')}
            </div>
            <p class="battle-action-note">Trocar e Item: disponível em breve.</p>
            ${menu !== 'menu' ? `
                <button type="button" class="battle-action-back" data-battle-menu="menu">Voltar às opções</button>
                ${conteudo}
            ` : ''}
        </section>
    `;
}

function renderizarReservaBatalha(pokemon) {
    const atributos = pokemon.atributos;
    const nome = formatarNomeFrontend(pokemon.nome_exibicao || pokemon.nome_especie);
    const hpMax = Math.max(0, Number(atributos.hp_max) || 0);
    const hpAtual = Math.max(0, Math.min(hpMax, Number(atributos.hp_atual) || 0));
    const hpPercentual = hpMax > 0 ? (hpAtual / hpMax) * 100 : 0;

    return `
        <article class="battle-reserve-pokemon">
            <img src="${escaparHtml(pokemon.imagem_url || '')}" alt="${escaparHtml(nome)}">
            <div>
                <strong>${escaparHtml(nome)}</strong>
                <small>Nv. ${escaparHtml(pokemon.nivel)} · HP ${escaparHtml(hpAtual)}/${escaparHtml(hpMax)}</small>
                <div class="battle-hp-bar"><i style="width:${hpPercentual}%"></i></div>
            </div>
        </article>
    `;
}


// Histórico consultado do banco: não altera a batalha atual nem navega para /battle.
let historicoCarregando = false;

function formatarDataHistorico(data) {
    const valor = String(data || '');
    const partes = /^(\d{4})-(\d{2})-(\d{2})[ T](\d{2}):(\d{2})/.exec(valor);
    return partes ? `${partes[3]}/${partes[2]}/${partes[1]} às ${partes[4]}:${partes[5]}` : 'Data indisponível';
}

async function abrirHistoricoBatalhas() {
    if (historicoCarregando || document.querySelector('.historico-sobreposicao')) return;
    historicoCarregando = true;
    try {
        const dados = await requisitarApi('/api/battle/history');
        if (rotaAtual() !== '/map') return;

        const batalhas = Array.isArray(dados.batalhas) ? dados.batalhas : [];
        const conteudo = batalhas.length ? batalhas.map((batalha, indice) => {
            const eventos = Array.isArray(batalha.eventos) ? batalha.eventos : [];
            const resultado = batalha.resultado === 'VITORIA' ? 'Vitória' : 'Derrota';
            const classe = batalha.resultado === 'VITORIA' ? 'vitoria' : 'derrota';
            const recompensa = Number(batalha.dinheiro_ganho || 0);
            return `
                <details class="historico-batalha" ${indice === 0 ? 'open' : ''}>
                    <summary>
                        <span class="historico-resumo-texto">
                            <strong>${escaparHtml(batalha.titulo)}</strong>
                            <small>${escaparHtml(formatarDataHistorico(batalha.finalizada_em || batalha.iniciada_em))} · ${Number(batalha.turnos) || 0} turnos</small>
                        </span>
                        <span class="historico-resultado historico-${classe}">${resultado}</span>
                        <span class="historico-recompensa">+₽ ${recompensa.toLocaleString('pt-BR')}</span>
                    </summary>
                    <div class="historico-detalhes">
                        <h3>Registro dos acontecimentos</h3>
                        ${eventos.length ? `<ol class="historico-eventos">${eventos.map(evento => `
                            <li class="historico-evento ${evento.tipo === 'fim' ? 'historico-evento-fim' : evento.tipo === 'recompensa' ? 'historico-evento-premio' : ''}">${escaparHtml(evento.texto)}</li>
                        `).join('')}</ol>` : '<p>Esta batalha não possui eventos detalhados no registro.</p>'}
                    </div>
                </details>`;
        }).join('') : '<p class="historico-vazio">Nenhuma batalha concluída nesta jornada.</p>';

        const sobreposicao = document.createElement('div');
        sobreposicao.className = 'historico-sobreposicao';
        sobreposicao.innerHTML = `
            <section class="historico-janela" role="dialog" aria-modal="true" aria-labelledby="historico-titulo" tabindex="-1">
                <div class="historico-cabecalho">
                    <div><p class="historico-subtitulo">MONSTROBOLSO · JORNADA ATUAL</p><h2 id="historico-titulo">Ver batalhas</h2></div>
                    <button type="button" class="historico-fechar" data-acao="fechar-historico" aria-label="Fechar histórico de batalhas">Fechar ✕</button>
                </div>
                <p class="historico-contagem">${batalhas.length} ${batalhas.length === 1 ? 'batalha registrada' : 'batalhas registradas'}</p>
                <div class="historico-lista">${conteudo}</div>
            </section>`;
        appElement.appendChild(sobreposicao);
        sobreposicao.querySelector('.historico-fechar')?.focus();
    } finally {
        historicoCarregando = false;
    }
}

function opcoesAlvoItem(time) {
    return time.map(pokemon => {
        const atributos = pokemon.atributos ?? pokemon;
        const nome = pokemon.nome_exibicao || pokemon.nome_especie;
        return `<option value="${Number(pokemon.id_pokemon_time)}">${escaparHtml(nome)} · HP ${Number(atributos.hp_atual)}/${Number(atributos.hp_max)} · ${escaparHtml(pokemon.status)}</option>`;
    }).join('');
}

function renderizarMapa(aviso = '') {
    document.body.className = 'tela-mapa';
    const jogo = state.jogo;
    const team = jogo.time || [];
    const nos = jogo.nos || [];
    const conexoes = jogo.conexoes || [];

    const tiposLocal = {
        TREINADOR: { icone: '🧢', nome: 'Treinador', classe: 'treinador' },
        SELVAGEM: { icone: '⚔️', nome: 'Selvagem', classe: 'selvagem' },
        POKEBOLA: { icone: '🔴', nome: 'Pokébola', classe: 'pokebola' },
        CENTRO_POKEMON: { icone: '✚', nome: 'Centro Pokémon', classe: 'centro' },
        POKEMART: { icone: '🛒', nome: 'Poké Mart', classe: 'pokemart' },
        DESAFIO: { icone: '★', nome: 'Desafio', classe: 'desafio' }
    };

    const porId = new Map(nos.map(no => [Number(no.id_mapa_no), no]));
    const linhas = conexoes.map(conexao => {
        const origem = porId.get(Number(conexao.origem));
        const destino = porId.get(Number(conexao.destino));
        if (!origem || !destino) return '';
        return `<line x1="${Number(origem.posicao_x)}" y1="${Number(origem.posicao_y)}" x2="${Number(destino.posicao_x)}" y2="${Number(destino.posicao_y)}" />`;
    }).join('');

    // O início é visual; dele partem as três primeiras opções da rota.
    const linhasInicio = nos.filter(no => Number(no.etapa) === 1).map(no =>
        `<line x1="50" y1="94" x2="${Number(no.posicao_x)}" y2="${Number(no.posicao_y)}" />`
    ).join('');

    const botoesNos = nos.map(no => {
        const tipo = tiposLocal[no.tipo_local] || { icone: '?', nome: 'Local', classe: 'desconhecido' };
        const disponivel = no.status === 'DISPONIVEL';
        const concluido = no.status === 'CONCLUIDO';
        let subtitulo = tipo.nome;
        if (no.tipo_local === 'TREINADOR' && no.tipo_nome) subtitulo = no.tipo_nome;

        const atributosAcao = no.tipo_local === 'TREINADOR'
            ? `data-no="${Number(no.id_mapa_no)}" data-npc="${Number(no.id_npc_mapa || 0)}"`
            : no.tipo_local === 'DESAFIO'
                ? `data-desafio="${Number(jogo.desafio_atual?.id_desafio || 0)}"`
                : `data-no="${Number(no.id_mapa_no)}"`;
        const desabilitado = !disponivel
            || (no.tipo_local === 'TREINADOR' && !Number(no.id_npc_mapa))
            || (no.tipo_local === 'DESAFIO' && !Number(jogo.desafio_atual?.id_desafio));
        const icone = concluido ? '✓' : tipo.icone;

        return `<button class="mapa-no tipo-${tipo.classe} status-${String(no.status).toLowerCase()}"
            style="left:${Number(no.posicao_x)}%;top:${Number(no.posicao_y)}%"
            ${atributosAcao} ${desabilitado ? 'disabled' : ''}
            title="${escaparHtml(subtitulo)}" aria-label="${escaparHtml(subtitulo)}${disponivel ? ', disponível' : concluido ? ', concluído' : ', bloqueado'}">
            <span class="mapa-no-icone">${icone}</span>
            <small>${escaparHtml(subtitulo)}</small>
        </button>`;
    }).join('');

    const teamHtml = team.map((p, indice) => `<div class="mini-pokemon">
        <span class="mini-pokemon-posicao">${indice + 1}</span>
        <img src="${escaparHtml(p.imagem_url || '')}" alt="">
        <div class="mini-pokemon-info"><strong>${escaparHtml(p.nome_exibicao || p.nome_especie)}</strong><small>Nv. ${Number(p.nivel)}</small>
            <div class="barra-hp"><i style="width:${Math.max(0, Math.min(100, Number(p.hp_percentual)))}%"></i></div>
        </div>
        <div class="mini-pokemon-ordenar" aria-label="Mudar posição de ${escaparHtml(p.nome_exibicao || p.nome_especie)}">
            <button type="button" data-time-primeiro="${Number(p.id_pokemon_time)}"
                data-time-segundo="${indice > 0 ? Number(team[indice - 1].id_pokemon_time) : 0}"
                aria-label="Subir ${escaparHtml(p.nome_exibicao || p.nome_especie)}" title="Subir no time" ${indice === 0 ? 'disabled' : ''}>▲</button>
            <button type="button" data-time-primeiro="${Number(p.id_pokemon_time)}"
                data-time-segundo="${indice + 1 < team.length ? Number(team[indice + 1].id_pokemon_time) : 0}"
                aria-label="Descer ${escaparHtml(p.nome_exibicao || p.nome_especie)}" title="Descer no time" ${indice === team.length - 1 ? 'disabled' : ''}>▼</button>
        </div>
    </div>`).join('');

    const etapaAtual = Number(jogo.etapa_atual || 1);
    const textoEtapa = jogo.jornada_concluida
        ? 'Jornada concluída'
        : etapaAtual >= 6 ? 'Desafio de Unova' : `Etapa ${etapaAtual} de 5`;
    const locaisConcluidos = Number(jogo.progresso?.concluidos || 0);
    const totalTreinadores = (jogo.npc || []).length;
    const treinadoresDerrotados = (jogo.npc || []).filter(n => Number(n.derrotado) === 1).length;
    const desafioAtual = jogo.desafio_atual;

    appElement.innerHTML = `
        <main class="game-shell">
            <header class="game-header">
                <div class="game-brand">MONSTROBOLSO <span>ROGUEMON</span></div>
                <div class="game-status">
                    <strong>${escaparHtml(jogo.perfil.nome)}</strong>
                    <span>₽ ${Number(jogo.perfil.dinheiro).toLocaleString('pt-BR')}</span>
                    <button data-acao="perfis">Trocar jornada</button>
                    <button data-acao="logout">Sair</button>
                </div>
            </header>
            <div class="game-layout">
                <aside class="painel-lateral painel-time">
                    <h2>TIME</h2>
                    ${teamHtml || '<p>Seu time está vazio.</p>'}
                    ${team.length > 1 ? '<p class="equipe-ajuda">Use ▲ e ▼ para trocar a ordem dos Pokémon.</p>' : ''}
                </aside>
                <section class="mapa-area">
                    ${mensagem(aviso, 'sucesso')}
                    <div class="mapa-titulo"><span>UNOVA · ÁREA ${Number(jogo.area_atual)}</span><strong>${textoEtapa}</strong></div>
                    <div class="mapa-tabuleiro">
                        <svg class="mapa-conexoes" viewBox="0 0 100 100" preserveAspectRatio="none" aria-hidden="true">
                            ${linhasInicio}${linhas}
                        </svg>
                        <div class="mapa-inicio" style="left:50%;top:94%"><span>🧢</span><small>INÍCIO</small></div>
                        ${botoesNos}
                    </div>
                    <p class="mapa-legenda">Escolha um caminho para avançar. Os caminhos anteriores não poderão ser revisitados.</p>
                </section>
                <aside class="painel-lateral painel-itens">
                    <h2>ITENS</h2>
                    ${jogo.inventario?.length ? `
                        <form id="form-item-mapa">
                            <label>Item
                                <select name="id_item" required>
                                    <option value="">Escolha um item</option>
                                    ${jogo.inventario.map(item =>
                                        `<option value="${Number(item.id_item)}">${escaparHtml(item.nome)} · ${Number(item.quantidade)}</option>`
                                    ).join('')}
                                </select>
                            </label>
                            <label>Pokémon
                                <select name="id_pokemon_time" required>
                                    <option value="">Escolha um Pokémon</option>
                                    ${opcoesAlvoItem(jogo.time || [])}
                                </select>
                            </label>
                            <button type="submit" class="botao botao-principal">Usar item</button>
                        </form>` : '<p>Bolsa vazia</p>'}
                    <h2>PROGRESSO</h2>
                    <p>${locaisConcluidos} locais concluídos</p>
                    <p>Treinadores derrotados: ${treinadoresDerrotados}/${totalTreinadores}</p>
                    <p>${desafioAtual ? `Próximo objetivo: ${escaparHtml(desafioAtual.nome)}` : 'Todos os desafios concluídos.'}</p>
                    <button type="button" class="botao-ver-batalhas" data-acao="ver-batalhas">Ver batalhas</button>
                </aside>
            </div>
        </main>
    `;
}

async function navegar(rota, opcoes = {}) {
    const permitidas = ['/', '/login', '/register', '/dashboard', '/profiles', '/starter', '/map', '/battle'];
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
        else if (rota === '/battle') await abrirBatalha();
        else renderizarLogin(opcoes.mensagem || null);
    } catch (e) {
        if (e.message.includes('sessão') || e.message.includes('Selecione uma jornada')) {
            state.perfil = null;
            await navegar('/profiles', { substituir: true, mensagem: { texto: e.message, tipo: 'erro' } });
        } else {
            const acaoVoltar = rota === '/battle' ? 'voltar-mapa' : 'perfis';
            const textoVoltar = rota === '/battle' ? 'Voltar ao mapa' : 'Voltar';
            appElement.innerHTML = `<main class="loading-card">${mensagem(e.message, 'erro')}<button class="botao botao-principal" data-acao="${acaoVoltar}">${textoVoltar}</button></main>`;
        }
    }
}

async function verificarSessaoInicial() {
    loading('Carregando sua aventura...');
    try {
        const dados = await requisitarApi('/api/session');
        state.autenticado = dados.autenticado === true; state.usuario = dados.usuario || null;
        let rota = rotaAtual();
        if (!['/', '/login', '/register', '/dashboard', '/profiles', '/starter', '/map', '/battle'].includes(rota)) rota = '/';
        await navegar(rota, { substituir: true });
    } catch (e) { state.autenticado = false; state.usuario = null; await navegar('/login', { substituir: true, mensagem: { texto: e.message, tipo: 'erro' } }); }
}

document.addEventListener('submit', async ev => {
    const form = ev.target;
    if (form.matches('[data-item-batalha], #form-item-mapa')) {
        ev.preventDefault();
        const botao = form.querySelector('button[type="submit"]');
        if (botao.disabled) return;
        const dados = new FormData(form);
        const idPokemon = Number(dados.get('id_pokemon_time'));
        botao.disabled = true;
        try {
            if (form.matches('[data-item-batalha]')) {
                await enviarTurnoBatalha({
                    acao: 'item',
                    id_item: Number(form.dataset.itemBatalha),
                    id_pokemon_time: idPokemon
                });
            } else {
                const resposta = await requisitarApi('/api/game/items/use', {
                    method: 'POST',
                    body: { id_item: Number(dados.get('id_item')), id_pokemon_time: idPokemon }
                });
                await carregarMapa(resposta.message);
            }
        } catch (e) {
            alert(e.message);
        } finally {
            if (botao.isConnected) botao.disabled = false;
        }
        return;
    }
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
        const menuBatalha = ev.target.closest('[data-battle-menu]');
        if (menuBatalha && state.battle) {
            state.battleMenu = menuBatalha.dataset.battleMenu;
            renderizarBatalha();
            return;
        }
        const golpeBatalha = ev.target.closest('[data-battle-move]');
        if (golpeBatalha && state.battle) {
            await enviarTurnoBatalha({ acao: 'golpe', id_golpe: Number(golpeBatalha.dataset.battleMove) });
            return;
        }
        const comandoTime = ev.target.closest('[data-time-primeiro]');
        if (comandoTime && !comandoTime.disabled) {
            comandoTime.disabled = true;
            await trocarPosicoesDoTime(Number(comandoTime.dataset.timePrimeiro), Number(comandoTime.dataset.timeSegundo));
            return;
        }
        if (acao === 'ver-batalhas') { await abrirHistoricoBatalhas(); return; }
        if (acao === 'fechar-historico') { ev.target.closest('.historico-sobreposicao')?.remove(); return; }
        if (acao === 'tentar-salvar-batalha') {
            await tentarSalvarBatalha();
            return;
        }
        if (acao === 'jogar') { await navegar('/profiles'); return; }
        if (acao === 'dashboard') { await navegar('/dashboard'); return; }
        if (acao === 'perfis') { state.perfil = null; state.encounterSelection = null; state.battle = null; await navegar('/profiles'); return; }
        if (acao === 'voltar-mapa' || acao === 'continuar-batalha') {
            state.encounterSelection = null;
            state.battle = null;
            await navegar('/map');
            return;
        }
        if (acao === 'nova-jornada') {
            const nome = prompt('Qual será o nome desta jornada?'); if (nome === null) return;
            const r = await requisitarApi('/api/profiles', { method: 'POST', body: { nome } }); state.perfil = { id_perfil: r.id_perfil, nome }; await navegar('/starter'); return;
        }
        if (acao === 'modo-excluir') { state.excluindo = !state.excluindo; renderizarPerfis(); return; }
        if (acao === 'logout') { await requisitarApi('/api/logout', { method: 'POST' }); state.autenticado = false; state.usuario = null; state.perfil = null; state.jogo = null; state.encounterSelection = null; state.battle = null; await navegar('/login', { mensagem: { texto: 'Você saiu da sua conta.', tipo: 'sucesso' } }); return; }
        const perfilCard = ev.target.closest('[data-perfil-selecionar]');
        if (perfilCard) {
            const id = Number(perfilCard.dataset.perfilSelecionar);
            if (state.excluindo) {
                const perfil = state.perfis.find(p => Number(p.id_perfil) === id);
                if (!confirm(`Excluir permanentemente a jornada "${perfil?.nome || ''}"? Essa ação não pode ser desfeita.`)) return;
                await requisitarApi('/api/profiles/delete', { method: 'POST', body: { id_perfil: id } }); await carregarPerfis(); return;
            }
            const r = await requisitarApi('/api/profiles/select', { method: 'POST', body: { id_perfil: id } });
            state.perfil = r.perfil || null; state.encounterSelection = null; state.battle = null; await navegar(r.proxima_etapa === 'starter' ? '/starter' : '/map'); return;
        }
        const starter = ev.target.closest('[data-starter]');
        if (starter) {
            if (!confirm(`Escolher ${starter.dataset.starter.toUpperCase()} como inicial desta jornada?`)) return;
            await requisitarApi('/api/game/starter', { method: 'POST', body: { nome: starter.dataset.starter } }); await navegar('/map'); return;
        }
        const noBotao = ev.target.closest('[data-no]');
        if (noBotao) {
            const no = (state.jogo?.nos || []).find(item => Number(item.id_mapa_no) === Number(noBotao.dataset.no));
            if (!no || no.status !== 'DISPONIVEL') return;

            if (no.tipo_local === 'CENTRO_POKEMON' || no.tipo_local === 'POKEMART') {
                noBotao.disabled = true;
                try {
                    if (no.tipo_local === 'CENTRO_POKEMON') {
                        await visitarLocalMapa(Number(no.id_mapa_no), 'curar');
                        await carregarMapa('Toda a equipe foi curada.');
                    } else {
                        await abrirPokemart(Number(no.id_mapa_no));
                    }
                } finally {
                    noBotao.disabled = false;
                }
                return;
            }
            if (no.tipo_local === 'POKEBOLA') {
                noBotao.disabled = true;
                try { await abrirPokebola(Number(no.id_mapa_no)); }
                finally { noBotao.disabled = false; }
                return;
            }
            if (no.tipo_local === 'SELVAGEM') {
                state.encounterSelection = { id_mapa_no: Number(no.id_mapa_no) };
                await navegar('/battle');
                return;
            }
            if (no.tipo_local !== 'TREINADOR') {
                alert('A ação deste local ainda será integrada.');
                return;
            }
        }
        const npc = ev.target.closest('[data-npc]');
        if (npc) {
            const item = (state.jogo?.npc || []).find(n => Number(n.id_npc_mapa) === Number(npc.dataset.npc));
            if (item && Number(item.derrotado) !== 1) {
                state.encounterSelection = { id_npc_mapa: Number(item.id_npc_mapa) };
                await navegar('/battle');
            }
            return;
        }
        const desafio = ev.target.closest('[data-desafio]');
        if (desafio) {
            state.encounterSelection = { id_desafio: Number(desafio.dataset.desafio) };
            await navegar('/battle');
        }
    } catch (e) { alert(e.message); }
});
document.addEventListener('keydown', ev => {
    if (ev.key === 'Escape') {
        const historico = document.querySelector('.historico-sobreposicao');
        if (historico) { historico.remove(); ev.preventDefault(); }
        return;
    }
    if (ev.key !== 'Enter' && ev.key !== ' ') return;
    const desafio = ev.target.closest('[data-desafio]');
    if (!desafio) return;
    ev.preventDefault();
    desafio.click();
});
window.addEventListener('popstate', () => navegar(rotaAtual(), { atualizarUrl: false }));
verificarSessaoInicial();
