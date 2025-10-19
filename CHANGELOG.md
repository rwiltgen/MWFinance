# Changelog
Todas as mudanças notáveis deste projeto serão documentadas neste arquivo.

---


## [1.4.18] — 2025-10-19
### Fixed
- **Autenticação:** restaura gate de sessão e `onAuthStateChange`, impedindo retorno automático à tela de login após autenticar.
- **UI completa:** reintroduz cabeçalho, navegação e telas (Saldos, Contas, Categorias, Importar) que faltaram na 1.4.17.
- **Login Google:** mantém redirecionamento dinâmico (preview permanece no preview; produção permanece na produção).

> Esta versão substitui a 1.4.17 no ambiente de testes.

---

## [1.4.17] — 2025-10-18
### Fixed
- **Login Google (OAuth):** redirecionamento agora é dinâmico:
  - Em **produção** (`mwfinance.vercel.app`) → redireciona para a produção.
  - Em **preview/local** → redireciona para o próprio domínio atual.
- Permite testar o login Google diretamente nas **previews da Vercel**, sem cair na produção.
- **Configuração Supabase recomendada:** adicionar `https://mwfinance-git-*.vercel.app` e `http://localhost:3000` na lista de Redirect URLs.

---

## [1.4.16] — 2025-10-18
### Added
- **Google OAuth (UI):** botão estilizado com logo e cores oficiais.
- **Categorias nas transações:** seleção e exibição de categorias.
- **UI de dias:** passados em cinza; hoje verde/vermelho; borda vermelha se saldo negativo.
- **Edição com escopo de recorrência:** ocorrência, série ou dali para frente.
- **Bloqueio de efetivadas:** impede edição/exclusão sem desbloquear antes.

---

## [1.4.15] — 2025-10-15
### Added
- **backup_db.html:** exporta snapshot JSON (contas, categorias, recorrências e transações) usando a sessão Supabase Auth — útil na versão Free (sem snapshots nativos).

---

## [1.4.14] — 2025-10-15
### Revert
- **Rollback** para o commit `2db72b7` (deploy estável na Vercel `HhSGeDjYL`), restaurando o comportamento da **v1.4.6** e substituindo releases com regressões.

---

## [1.4.13] — 2025-10-15
### Fixes
- **Login (UX):** remove aviso técnico da tela e melhora feedback de erro.

---
