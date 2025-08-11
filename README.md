# MWMoney Front (estático)

Front simples (HTML + JS puro) que consome a função RPC `public.saldos_diarios` do Supabase via REST.

## Pré-requisitos
- Função `public.saldos_diarios` criada no Supabase (SQL Editor).
- Tabela `contas` com pelo menos 1 conta.

## Como rodar localmente

1. Duplique `config.example.js` para `config.js` e preencha:
   - `SUPABASE_URL`: Project URL do Supabase (Settings → API)
   - `SUPABASE_ANON_KEY`: anon key (Settings → API)

2. Suba um servidor estático local (recomendado):
   - **Python 3**:
     ```bash
     python3 -m http.server 5173
     ```
     Acesse: http://localhost:5173
   - **Node (npx serve)**:
     ```bash
     npx serve .
     ```
   - **VS Code**:
     Extensão “Live Server” → “Open with Live Server”.

> Evite abrir `index.html` direto com `file://` — alguns navegadores bloqueiam `fetch` em `file://`.

## Deploy (Vercel)
- Conecte o repo e faça deploy como “Other / Static HTML”.
- Como usa `config.js` local, para produção você pode:
  - Manter `config.js` versionado no ambiente de preview com chaves de teste **ou**
  - Usar um bundler (Vite/Next) para injetar variáveis de ambiente — opcional.

