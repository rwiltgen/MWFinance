## [1.0.0](https://github.com/rwiltgen/MWFinance/compare/v1.4.8...v1.0.0) (2025-10-15)
## [1.4.8](https://github.com/rwiltgen/MWFinance/compare/v1.4.7...v1.4.8) (2025-10-15)

### Features

* **tx-edit:** reintroduz edição de transações + materializar & editar para previsões (v1.4.8) ([4deed48](https://github.com/rwiltgen/MWFinance/commit/4deed4866dd99cd82bc1d0c73dcd5546954c4ecd))
## [1.4.7](https://github.com/rwiltgen/MWFinance/compare/v1.4.6...v1.4.7) (2025-10-15)

### Bug Fixes

* **templates:** links .csv e inclusão dos arquivos de template ([473c706](https://github.com/rwiltgen/MWFinance/commit/473c706e93f4e0f0c5b0e0067b504ef30cbc3250))
* **ui,router:** gate de sessão + seção única visível + corrige classSaldo (v1.4.6) ([2db72b7](https://github.com/rwiltgen/MWFinance/commit/2db72b7687236da01d16e44b47ffdd6690445c2e))
## [1.4.6](https://github.com/rwiltgen/MWFinance/compare/v1.4.5...v1.4.6) (2025-10-11)

### Bug Fixes

* restaura index correto (router navigate) [hotfix] ([8afaf0f](https://github.com/rwiltgen/MWFinance/commit/8afaf0f397e8c6c5c0da3fb2ea1f3793c15d9c3e))
## [1.4.5](https://github.com/rwiltgen/MWFinance/compare/v1.4.4...v1.4.5) (2025-10-11)

### Bug Fixes

* **router:** navegação imediata via navigate(view) + fallback hashchange ([da41a80](https://github.com/rwiltgen/MWFinance/commit/da41a80a3911b03a63607ac9717717f2abe5c18e))
## [1.4.4](https://github.com/rwiltgen/MWFinance/compare/v1.4.3...v1.4.4) (2025-10-11)

### Bug Fixes

* **auth,ui:** oculta app completa até login (body.logged) e mantém templates .csv ([38082fd](https://github.com/rwiltgen/MWFinance/commit/38082fd2e3bfafea9a0a06a91529f96bef762625))
## [1.4.3](https://github.com/rwiltgen/MWFinance/compare/v1.4.2...v1.4.3) (2025-10-11)

### Bug Fixes

* **auth,import:** esconde nav antes do login e corrige links .csv dos templates ([92f26e0](https://github.com/rwiltgen/MWFinance/commit/92f26e07ebffd6b8da592956dce667518cf30181))
* **ui:** nav mobile com ícones, links legíveis e alinhamento dos filtros em Saldos ([f6be397](https://github.com/rwiltgen/MWFinance/commit/f6be397fb00047248cb46d39d5ef9b9b9408c8d0))
## [1.4.2](https://github.com/rwiltgen/MWFinance/compare/v1.4.1...v1.4.2) (2025-10-11)

### Bug Fixes

* **ui,db:** cria categorias + corrige header de Saldos e adiciona links de templates na Importação ([a7e12e9](https://github.com/rwiltgen/MWFinance/commit/a7e12e992d66ff821ba970a48bcfd9790503ad0f))
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

## [1.4.15] — 2025-10-15
### Added
- **backup_db.html:** nova ferramenta para exportar todo o conteúdo do banco (contas, categorias, recorrências e transações) em um arquivo JSON.
- Permite “congelar” o estado do sistema diretamente do navegador, usando a mesma sessão Supabase Auth.
- Facilita auditorias e checkpoints manuais na versão Free do Supabase (sem precisar de pg_dump).

> Esta versão adiciona apenas a funcionalidade de backup via interface web, sem alterações no backend.
