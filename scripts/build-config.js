// Gera dist/config.js com as variáveis de ambiente da Vercel
const fs = require('fs');
const path = require('path');

const SUPABASE_URL = process.env.SUPABASE_URL || '';
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY || '';

if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
  console.error('Faltam variáveis SUPABASE_URL e/ou SUPABASE_ANON_KEY no ambiente.');
  process.exit(1);
}

const outDir = path.join(__dirname, '..', 'dist');
if (!fs.existsSync(outDir)) fs.mkdirSync(outDir, { recursive: true });

const content = `window.CONFIG = {
  SUPABASE_URL: "${SUPABASE_URL}",
  SUPABASE_ANON_KEY: "${SUPABASE_ANON_KEY}"
};`;

fs.writeFileSync(path.join(outDir, 'config.js'), content);
console.log('config.js gerado em dist/config.js');
