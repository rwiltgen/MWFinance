# Changelog
Todas as mudanças notáveis deste projeto serão documentadas neste arquivo.
O formato segue (quando possível) o [Conventional Changelog](https://www.conventionalcommits.org/).

## [1.0.0](https://github.com/rwiltgen/MWFinance/compare/v1.4.0...v1.0.0) (2025-10-11)
## [1.4.0](https://github.com/rwiltgen/MWFinance/compare/v1.3.1...v1.4.0) (2025-10-11)

### Features

* **router:** separa app em views (Saldos, Contas, Categorias, Importar) e adiciona CRUD de contas/categorias e importação CSV ([6dddb75](https://github.com/rwiltgen/MWFinance/commit/6dddb75533aa029515404fe075b34df7b81e5941))
## [1.3.1](https://github.com/rwiltgen/MWFinance/compare/v1.3.0...v1.3.1) (2025-10-11)

### Bug Fixes

* **api:** adiciona header apikey nas chamadas REST (PostgREST) ([db8c719](https://github.com/rwiltgen/MWFinance/commit/db8c71906bcbe55d3958e55c1a3e2e4de1e68db4))
## [1.3.0](https://github.com/rwiltgen/MWFinance/compare/v1.2.0...v1.3.0) (2025-10-11)

### Bug Fixes

* **ui:** modal de nova transação não abre por padrão e fecha corretamente (ESC/fundo) ([198f298](https://github.com/rwiltgen/MWFinance/commit/198f2980275c91dfd35fef1fe63958e7967080c5))
## [1.0.0](https://github.com/rwiltgen/MWFinance/compare/7c475ba61844b33fea530fe3f9fead3710c6aaad...v1.0.0) (2025-10-10)

### Features

* **v2:** criação de transações (única/parcelada/recorrente) ([02e0508](https://github.com/rwiltgen/MWFinance/commit/02e05080eb5ca532a0e33100de758ed219bcc462))

### Reverts

* Revert "UX: botão Nova Transação" ([7c475ba](https://github.com/rwiltgen/MWFinance/commit/7c475ba61844b33fea530fe3f9fead3710c6aaad))

## v1.4.1 — Hotfix: categorias + UX
- Cria tabela `public.categorias` com RLS (policies idempotentes).
- Corrige desalinhamento na tela de **Saldos** (remove sticky agressivo do header).
- Templates de importação agora com links para download na aba **Importar**.

## v1.4.2 — UX mobile e alinhamento
- Navegação mobile com ícones e rolagem horizontal (sem quebra de linha).
- Links de templates com cor legível no tema escuro.
- Cabeçalho da seção **Saldos** realinhado (grupo de filtros com baseline uniforme).


## v1.4.3 — Correções de acesso e templates
- Esconde navegação antes do login (menus só aparecem após sessão autenticada).
- Links de download dos templates apontando corretamente para arquivos `.csv`.

## v1.4.4 — Gate de sessão + templates
- Esconde TODA a aplicação (nav + seções) até o usuário estar autenticado (`body.logged`).
- `boot()` não força navegação para `#/saldos` quando não logado.
- Templates de importação garantidos como `.csv` (links corrigidos).

## v1.4.5 — Navegação responsiva
- Menu passa a usar `navigate(view)` para trocar de seção de forma imediata.
- `hashchange` fica como fallback; guarda impede navegação sem sessão.

## v1.4.6 — Hotfix navegação/visibilidade
- Garante gate de sessão (nada aparece antes de logar).
- Router robusto: apenas uma seção visível (`[data-sec].show`).
- Corrige `classSaldo is not defined`.
- Evita conflito entre `hidden` antigo e estilos atuais.

---

## [1.4.7](https://github.com/rwiltgen/MWFinance/compare/v1.4.6...v1.4.7) — 2025-10-12
### Fixes
- **templates CSV:** garantidos como arquivos **`.csv` reais** e **links de download** corrigidos em `/templates/*.csv`.
- **gate de sessão:** menus/seções do app só aparecem **após login**.
- **router:** navegação via SPA mais robusta (fallback por `hashchange` e bloqueio quando não autenticado).

---


## [1.4.8](https://github.com/rwiltgen/MWFinance/compare/v1.4.7...v1.4.8) — 2025-10-14
### Added
- **Saldos diários corretos** via RPC `saldos_diarios` (saldo do mês N inicia do saldo final do mês N-1; inclui previsões de recorrências sem materializar; considera todas as transações independente do status).
- **CRUD** de **transações**, **recorrências**, **contas** e **categorias**.
- **Importação CSV** (templates e upload simples).
- **Autenticação Supabase Auth** (e-mail/senha + Google OAuth).
- **RLS por usuário** nas quatro tabelas (políticas USING/WITH CHECK + trigger para preencher `user_id`).

> Estado consolidado da aplicação, preparando o terreno para relatórios e categorias nas telas de transações.

--


## [1.4.9](https://github.com/rwiltgen/MWFinance/compare/v1.4.8...v1.4.9) — 2025-10-15
### Fixes
- **recorrências:** ao efetivar/materializar uma previsão, agora a transação é criada **com `recorrencia_id`**, impedindo que a RPC volte a prever a mesma ocorrência no mês (sem duplicar entradas/saídas).
- **lista de transações:** mantém o estado de **dias expandidos** após editar ou atualizar o mês (persistência da UI).
- **colapso:** botão **toggle** realmente abre/fecha a seção de transações do dia.
- **UI:** rótulo de versão atualizado para **v1.4.9**.

> Impacto: elimina duplicidade de previsões após materialização, melhora a usabilidade da tela de saldos (não “fecha tudo” ao atualizar/editar) e corrige o comportamento de colapsar.

---
