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

