-- TABELA CATEGORIAS (idempotente)
create table if not exists public.categorias (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  nome text not null,
  tipo text not null check (tipo in ('credito','debito')),
  descricao text,
  created_at timestamptz not null default now()
);

create index if not exists categorias_user_id_idx on public.categorias(user_id);

-- RLS
alter table public.categorias enable row level security;

-- Policies (drop se existir, depois cria)
drop policy if exists "categorias user read"  on public.categorias;
drop policy if exists "categorias user write" on public.categorias;

create policy "categorias user read"
on public.categorias
for select
to authenticated
using (auth.uid() = user_id);

create policy "categorias user write"
on public.categorias
for all
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);
