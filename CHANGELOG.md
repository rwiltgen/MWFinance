# Changelog
Todas as mudanças notáveis deste projeto serão documentadas neste arquivo.
O formato segue (quando possível) o [Conventional Changelog](https://www.conventionalcommits.org/).

---

## [1.4.13] — 2025-10-15
### Fixes
- **Login (UX):** remove o aviso sobre RLS/RPC da tela de login e simplifica mensagens de feedback.
- **Acessibilidade:** foco visível em inputs/botões, mensagens de erro consistentes.

> Observação: Não há alterações de backend nesta versão; somente ajustes de UI/UX no fluxo de autenticação.

---

## [1.4.12] — 2025-10-15
### Status
- **Yanked** (não chegou a ser publicado em `main`). Alterações foram substituídas diretamente por 1.4.13.

---

## [1.4.11] — 2025-10-15
### Chore
- **bump de versão:** incrementa UI e documentação para `v1.4.11` após ajustes de hotfix anteriores, garantindo rastreabilidade.
- Sem mudanças funcionais além do número de versão.

---

## [1.4.10] — 2025-10-15
### Fixes
- **UI topo:** restaura cabeçalho (menus, login, botão “Sair”) com `body.logged` controlando visibilidade.
- **Saldos/Dia:** coluna “Dia” exibe **apenas o número do dia** (ex.: 1, 2, ... 31).
- **Filtro do mês:** chamadas à RPC `saldos_diarios` garantem referência `YYYY-MM-01`, mantendo o mês correto.
- **Regressão:** preservados os ajustes da 1.4.9 (materialização de recorrência sem duplicar, persistência de expansão e toggle de colapso).

---

## [1.4.9] — 2025-10-15
### Fixes
- **Recorrências:** ao efetivar/materializar uma previsão, cria transação **com `recorrencia_id`**, impedindo que a RPC volte a prever a mesma ocorrência no mês (sem duplicidade).
- **Lista de transações:** mantém o estado de **dias expandidos** após editar ou atualizar o mês.
- **Colapso:** botão **toggle** abre/fecha a seção de transações do dia.
- **UI:** rótulo de versão atualizado no topo.

---

## [1.4.8] — 2025-10-14
### Added
- **Saldos diários** via RPC `saldos_diarios` (saldo do mês N inicia do saldo final do mês N-1; inclui previsões de recorrências sem materializar; considera todas as transações independentemente do status).
- **CRUD** de **transações**, **recorrências**, **contas** e **categorias**.
- **Importação CSV** (templates e upload simples).
- **Autenticação Supabase Auth** (e-mail/senha + Google OAuth).
- **RLS por usuário** nas quatro tabelas (políticas USING/WITH CHECK + trigger para preencher `user_id`).

---

## [1.4.7] — 2025-10-12
### Fixes
- **Templates CSV:** garantidos como arquivos `.csv` reais e links de download corrigidos em `/templates/*.csv`.
- **Gate de sessão:** menus/seções do app só aparecem após login.
- **Router:** navegação via SPA mais robusta (fallback por `hashchange` e bloqueio quando não autenticado).

---

## [1.4.6] — 2025-10-11
### Fixes
- Garante gate de sessão (nada aparece antes de logar).
- Router robusto: apenas uma seção visível por vez.
- Corrige `classSaldo is not defined`.
- Evita conflito entre `hidden` antigo e estilos atuais.
