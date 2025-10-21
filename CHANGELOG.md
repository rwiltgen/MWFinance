# Changelog
Todas as mudanças notáveis deste projeto serão documentadas neste arquivo.

---

## [1.4.25] — 2025-10-20
### Fixed
- [cite_start]**Categorias (Lista e Modal):** Corrigida a exibição de categorias na lista [cite: 1] [cite_start]e a seleção na modal de edição[cite: 3]. [cite_start]A busca de categoria por ID agora usa coerção de tipo (`==`) para compatibilizar IDs (número/string), resolvendo o *bug* em que a categoria aparecia como "(sem categoria)"[cite: 3, 4].
- [cite_start]**Excluir Recorrência (UX):** Corrigido o fluxo de exclusão de recorrência[cite: 5]. [cite_start]O `Cancelar` da primeira confirmação agora de fato cancela a operação[cite: 5]. [cite_start]Um segundo *prompt* permite escolher entre excluir a [ Série ] inteira ou apenas as [ Futuras ][cite: 6].
- [cite_start]**Materialização de Recorrência:** Corrigida a materialização de ocorrência virtual (agendar/efetivar)[cite: 4]. [cite_start]A transação materializada agora é vinculada à `recorrencia_id`, suprimindo a ocorrência virtual duplicada na listagem[cite: 4].

---

## [1.4.24] — 2025-10-20
### Fixed
- **Lista de transações:** exibe a **categoria** mesmo sem `categoria_id` (fallback por nome com normalização de acentos).
- **Modal de edição:** categoria **pré-selecionada** por `categoria_id` ou, na ausência, por nome.

### Changed
- **Excluir recorrência:** opção de **“dali em diante”** (define `fim = dia-1` da ocorrência clicada).

### Behavior
- **Materializar ocorrência de recorrência:** agora **não** vincula `recorrencia_id` para **preservar previsões futuras**.

---

## [1.4.23] — 2025-10-19
### Fixed
- **Lista de transações**: exibe a **categoria** mesmo quando o RPC não envia `categoria_id` (fallback por nome).
- **Modal de edição**: a **categoria é pré-selecionada** usando `categoria_id` ou, na ausência, _match_ por `categoria_nome`.

### UX
- Mantido badge compacto **[D]/[C]** (com tooltip) e pill com **nome da categoria**.

---

## [1.4.22] — 2025-10-19
### Added
- **Categorias: editar e excluir** na aba “Categorias”.
- **Lista de transações:** exibe badge compacto **[D]/[C]** + pill com **categoria**.

### Changed
- **Dropdown de categorias** filtrado por tipo (Débito/Crédito) e **ordenado por nome**.
- **Modal de edição** agora **preenche a categoria existente** e repovoa opções ao trocar o tipo.

### Fixed
- Mantidas correções da 1.4.21 para respostas 201/204 sem corpo e `categoria_id` opcional.

---

## [1.4.21] — 2025-10-19
### Fixed
- **PostgREST 201/204 sem corpo:** cliente agora trata respostas vazias com segurança (evita “Unexpected end of JSON input”).
- **`categoria_id` opcional:** detecção automática quando a coluna não existe no schema; reenviamos a operação sem `categoria_id`.
- **CRUD com RLS:** mantido envio explícito de `user_id = auth.uid()` em todas as criações/edições para passar pelas políticas `WITH CHECK`.

---

## [1.4.20] — 2025-10-19
### Fixed
- **Auto-refresh pós-login:** carrega contas e executa `consultar()` automaticamente após autenticar.
- **Expansão/colapso:** botão mostra setas ▼/▲ em vez de “Abrir/Fechar”.
- **Salvar sem categoria:** não envia `categoria_id` quando vazio; se o schema não tiver a coluna, detecta o erro e opera sem categorias nas transações, reenviando a operação sem falhar.
- **RLS (categorias/CRUD):** agora enviamos `user_id = session.user.id` nas criações/edições de `contas`, `categorias`, `transacoes` e `recorrencias`, satisfazendo políticas `WITH CHECK (auth.uid() = user_id)` mesmo sem trigger.

---

## [1.4.19] — 2025-10-19
### Fixed
- **Login Google (OAuth):** adiciona `state` com a URL atual e lógica de retorno automático.
  - Mesmo que o Supabase redirecione para a **Site URL** (produção), o app detecta e **volta ao Preview original**.
- Mantém redirecionamento dinâmico (preview ↔ produção) e a UI/funcionalidades da 1.4.18.

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
