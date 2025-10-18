# Changelog
Todas as mudanças notáveis deste projeto serão documentadas neste arquivo.
O formato segue (quando possível) o [Conventional Changelog](https://www.conventionalcommits.org/).

---

## [1.4.16] — 2025-10-18
### Added
- **Google OAuth (UI):** botão de “Entrar com Google” com cores e logo oficiais.
- **Categorias nas transações:** seleção de categoria no modal de criação/edição; exibição da categoria na lista expandida; cache local para `categoria_id → nome`.
- **UI de dias:** dias passados com número **cinza**; **hoje** verde (saldo ≥ 0) ou vermelho (saldo < 0); linhas com saldo negativo com **borda vermelha**.
- **Versão visível:** título e header atualizados para **v1.4.16**.

### Changed
- **Edição de recorrências (virtuais):** pergunta escopo ao editar:
  - **Somente esta ocorrência** → materializa apenas essa data como transação única com os novos valores.
  - **Toda a recorrência** → `PATCH` na tabela `recorrencias` (descrição/tipo/valor) para a série inteira.
  - **Dali para frente** → encerra recorrência atual (`fim = dia-1`) e cria nova recorrência a partir da data editada.

### Fixed
- **Proteção de efetivadas:** transações com `status = efetivada` **não podem ser editadas ou excluídas**. Mensagem instrui a “desbloquear” mudando o status para `cadastrada` antes.
- **Status em previsões de recorrência:** ocorrências virtuais são **cadastradas por padrão**; ao trocar para **agendada** ou **efetivada**:
  - se ainda virtual → **materializa** e define o status correspondente;
  - se já materializada (ex.: foi agendada antes) → apenas atualiza o status da transação única.

---

## [1.4.15] — 2025-10-15
### Added
- **backup_db.html:** exporta snapshot JSON (contas, categorias, recorrências, transações) usando a sessão do Supabase Auth — útil na versão Free (sem snapshots nativos).

---

## [1.4.14] — 2025-10-15
### Revert
- **Rollback** para o commit `2db72b7` (deploy estável na Vercel `HhSGeDjYL`), restaurando o comportamento da **v1.4.6** e substituindo releases com regressões.

---

## [1.4.13] — 2025-10-15
### Fixes
- **Login (UX):** remove aviso técnico da tela e melhora feedback de erro.
- **Acessibilidade:** foco visível em inputs/botões.

---

## [1.4.12] — 2025-10-15
### Status
- **Yanked** (substituída por 1.4.13).

---

## [1.4.11] — 2025-10-15
### Chore
- Bump de versão para rastreabilidade (sem mudanças funcionais).

---

## [1.4.10] — 2025-10-15
### Fixes
- **UI topo:** restaura cabeçalho (menus, login, Sair) com gate de sessão.
- **Saldos/Dia:** coluna exibe apenas o número do dia; filtro de mês corrigido.
- **Persistência:** mantém dias expandidos e toggle de colapso funcional.

---

## [1.4.9] — 2025-10-15
### Fixes
- **Recorrências:** materialização cria transação com `recorrencia_id` e evita duplicidade de previsão no mês.
- **Lista:** mantém estado expandido após editar/atualizar.
- **UI:** rótulo de versão atualizado.

---

## [1.4.8] — 2025-10-14
### Added
- **RPC `saldos_diarios`** (previsões sem materializar; saldo de N inicia do final de N-1; considera todos os status).
- **CRUD:** transações, recorrências, contas e categorias.
- **Importação CSV** e **Supabase Auth** (e-mail/senha + Google OAuth).
- **RLS por usuário** em todas as tabelas.

---

## [1.4.7] — 2025-10-12
### Fixes
- **Templates CSV reais** e links de download.
- **Gate de sessão** e **SPA** com uma seção visível por vez.

---

## [1.4.6] — 2025-10-11
### Fixes
- Gate de sessão antes de exibir menus.
- Router robusto e correção de `classSaldo is not defined`.
