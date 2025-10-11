-- 1) Coluna user_id nas tabelas "donas"
alter table public.contas
  add column if not exists user_id uuid;

-- opcional: se quiser ver dono em todas, também adicione user_id direto:
alter table public.transacoes
  add column if not exists user_id uuid;

alter table public.recorrencias
  add column if not exists user_id uuid;

-- 2) Índices
create index if not exists contas_user_id_idx on public.contas(user_id);
create index if not exists transacoes_user_id_idx on public.transacoes(user_id);
create index if not exists recorrencias_user_id_idx on public.recorrencias(user_id);

-- 3) Triggers para preencher user_id automaticamente
create or replace function public.set_user_id()
returns trigger language plpgsql as $$
begin
  if new.user_id is null then
    new.user_id := auth.uid();
  end if;
  return new;
end$$;

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

-- 4) RLS policies: só vê/altera o que é do próprio user
alter table public.contas enable row level security;
alter table public.transacoes enable row level security;
alter table public.recorrencias enable row level security;

-- Limpe policies abertas (se existirem)
do $$
begin
  if exists (select 1 from pg_policies where schemaname='public' and tablename='contas') then
    -- opcionalmente remova políticas antigas abertas a anon
    null;
  end if;
end$$;

-- CONTAS
drop policy if exists "contas sel" on public.contas;
drop policy if exists "contas ins" on public.contas;
drop policy if exists "contas upd" on public.contas;
drop policy if exists "contas del" on public.contas;

create policy "contas sel" on public.contas
for select to authenticated
using (user_id = auth.uid());

create policy "contas ins" on public.contas
for insert to authenticated
with check (user_id = auth.uid());

create policy "contas upd" on public.contas
for update to authenticated
using (user_id = auth.uid()) with check (user_id = auth.uid());

create policy "contas del" on public.contas
for delete to authenticated
using (user_id = auth.uid());

-- TRANSACOES
drop policy if exists "tx sel" on public.transacoes;
drop policy if exists "tx ins" on public.transacoes;
drop policy if exists "tx upd" on public.transacoes;
drop policy if exists "tx del" on public.transacoes;

create policy "tx sel" on public.transacoes
for select to authenticated
using (
  -- por segurança aceite se user_id casa
  (user_id = auth.uid())
  or exists (select 1 from public.contas c where c.id = transacoes.conta_id and c.user_id = auth.uid())
);

create policy "tx ins" on public.transacoes
for insert to authenticated
with check (
  -- garante dono
  (user_id = auth.uid())
  and exists (select 1 from public.contas c where c.id = conta_id and c.user_id = auth.uid())
);

create policy "tx upd" on public.transacoes
for update to authenticated
using (
  (user_id = auth.uid())
  or exists (select 1 from public.contas c where c.id = transacoes.conta_id and c.user_id = auth.uid())
)
with check (
  (user_id = auth.uid())
  and exists (select 1 from public.contas c where c.id = conta_id and c.user_id = auth.uid())
);

create policy "tx del" on public.transacoes
for delete to authenticated
using (
  (user_id = auth.uid())
  or exists (select 1 from public.contas c where c.id = transacoes.conta_id and c.user_id = auth.uid())
);

-- RECORRENCIAS
drop policy if exists "rec sel" on public.recorrencias;
drop policy if exists "rec ins" on public.recorrencias;
drop policy if exists "rec del" on public.recorrencias;

create policy "rec sel" on public.recorrencias
for select to authenticated
using (
  (user_id = auth.uid())
  or exists (select 1 from public.contas c where c.id = recorrencias.conta_id and c.user_id = auth.uid())
);

create policy "rec ins" on public.recorrencias
for insert to authenticated
with check (
  (user_id = auth.uid())
  and exists (select 1 from public.contas c where c.id = conta_id and c.user_id = auth.uid())
);

create policy "rec del" on public.recorrencias
for delete to authenticated
using (
  (user_id = auth.uid())
  or exists (select 1 from public.contas c where c.id = recorrencias.conta_id and c.user_id = auth.uid())
);

-- 5) Permissões RPC: só user autenticado
grant usage on schema public to authenticated;
revoke usage on schema public from anon;
grant execute on function public.saldos_diarios(text, date) to authenticated;
revoke execute on function public.saldos_diarios(text, date) from anon;
