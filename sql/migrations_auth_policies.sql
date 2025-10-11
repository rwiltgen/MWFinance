-- ============================================
-- MWFinance — Auth & RLS (idempotente)
-- Cria colunas user_id, triggers, ativa RLS e policies por usuário.
-- Seguro para rodar múltiplas vezes.
-- ============================================

-- 0) Colunas user_id (se não existirem)
alter table if exists public.contas
  add column if not exists user_id uuid references auth.users(id);
alter table if exists public.transacoes
  add column if not exists user_id uuid references auth.users(id);
alter table if exists public.recorrencias
  add column if not exists user_id uuid references auth.users(id);

-- 1) Índices
create index if not exists contas_user_id_idx       on public.contas(user_id);
create index if not exists transacoes_user_id_idx   on public.transacoes(user_id);
create index if not exists recorrencias_user_id_idx on public.recorrencias(user_id);

-- 2) Trigger function: user_id = auth.uid() em INSERT
create or replace function public.set_user_id()
returns trigger
language plpgsql
as $$
begin
  if new.user_id is null then
    new.user_id := auth.uid();
  end if;
  return new;
end
$$;

-- 3) Triggers
drop trigger if exists set_user_id_contas on public.contas;
create trigger set_user_id_contas
before insert on public.contas
for each row execute function public.set_user_id();

drop trigger if exists set_user_id_transacoes on public.transacoes;
create trigger set_user_id_transacoes
before insert on public.transacoes
for each row execute function public.set_user_id();

drop trigger if exists set_user_id_recorrencias on public.recorrencias;
create trigger set_user_id_recorrencias
before insert on public.recorrencias
for each row execute function public.set_user_id();

-- 4) Habilita RLS
alter table if exists public.contas       enable row level security;
alter table if exists public.transacoes   enable row level security;
alter table if exists public.recorrencias enable row level security;

-- 5) Policies — CONTAS
drop policy if exists "contas user read"  on public.contas;
drop policy if exists "contas user write" on public.contas;

create policy "contas user read"
on public.contas
for select
to authenticated
using (auth.uid() = user_id);

create policy "contas user write"
on public.contas
for all
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

-- 6) Policies — TRANSACOES
drop policy if exists "transacoes user read"  on public.transacoes;
drop policy if exists "transacoes user write" on public.transacoes;

create policy "transacoes user read"
on public.transacoes
for select
to authenticated
using (auth.uid() = user_id);

create policy "transacoes user write"
on public.transacoes
for all
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

-- 7) Policies — RECORRENCIAS
drop policy if exists "recorrencias user read"  on public.recorrencias;
drop policy if exists "recorrencias user write" on public.recorrencias;

create policy "recorrencias user read"
on public.recorrencias
for select
to authenticated
using (auth.uid() = user_id);

create policy "recorrencias user write"
on public.recorrencias
for all
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

-- 8) Grants úteis
grant usage on schema public to authenticated;
grant select, insert, update, delete
  on public.contas, public.transacoes, public.recorrencias
  to authenticated;

-- 9) RPC: apenas authenticated
grant execute on function public.saldos_diarios(text, date) to authenticated;
revoke execute on function public.saldos_diarios(text, date) from anon;
