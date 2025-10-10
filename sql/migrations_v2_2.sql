-- ============================================
-- MWFinance — v2.2
-- Correção: recorrências não são previstas
-- após o primeiro lançamento materializado.
-- (também aplicado ao somatório histórico)
-- ============================================

-- (Opcional, idempotente) garante coluna periodicidade
alter table if exists public.recorrencias
  add column if not exists periodicidade text default 'mensal';

-- Função principal
create or replace function public.saldos_diarios(conta_nome text, referencia date)
returns table (dia date, saldo numeric, transacoes jsonb)
language sql
stable
as $$
with conta as (
  select id, saldo_inicial
  from public.contas
  where nome = conta_nome
),
periodo as (
  select date_trunc('month', referencia)::date as inicio,
         (date_trunc('month', referencia) + interval '1 month - 1 day')::date as fim
),
dias as (
  select generate_series(
           (select inicio from periodo),
           (select fim    from periodo),
           interval '1 day'
         )::date as dia
),

-- 1) Transações materializadas do mês
tx_mes as (
  select
    t.data::date as dia,
    jsonb_agg(jsonb_build_object(
      'id', t.id,
      'conta_id', t.conta_id,
      'recorrencia_id', t.recorrencia_id,
      'descricao', t.descricao,
      'tipo', t.tipo,
      'valor', t.valor,
      'status', t.status,
      'virtual', false,
      'data', t.data::date
    ) order by t.id) as transacoes,
    sum(case when t.tipo = 'credito' then t.valor else -t.valor end) as delta
  from public.transacoes t
  join conta c on c.id = t.conta_id
  where t.data::date between (select inicio from periodo) and (select fim from periodo)
  group by t.data::date
),

-- 2) Recorrências previstas (não materializadas) dentro do mês
--    ⚠️ CORRIGIDO: não prever a partir do primeiro lançamento materializado
rec_prev as (
  select
    o.occ as dia,
    jsonb_agg(jsonb_build_object(
      'id', null,
      'conta_id', r.conta_id,
      'recorrencia_id', r.id,
      'descricao', r.descricao,
      'tipo', r.tipo,
      'valor', r.valor,
      'status', 'cadastrada',
      'virtual', true,
      'data', o.occ
    ) order by r.id) as transacoes,
    sum(case when r.tipo = 'credito' then r.valor else -r.valor end) as delta
  from public.recorrencias r
  join conta c on c.id = r.conta_id
  cross join periodo p
  -- meses do intervalo consultado
  join generate_series(date_trunc('month', p.inicio), date_trunc('month', p.fim), interval '1 month') m on true
  -- ocorrência candidata no mês m: mesmo dia do mês do início da recorrência
  cross join lateral (
    select (date_trunc('month', m)::date + (extract(day from r.inicio)::int - 1))::date as occ
  ) o
  -- se já houver materialização exatamente nesse dia, não prever
  left join public.transacoes tm
    on tm.recorrencia_id = r.id
   and tm.data::date = o.occ
  where extract(month from o.occ) = extract(month from m)                       -- dia existe no mês
    and o.occ between (select inicio from periodo) and (select fim from periodo)
    and o.occ >= r.inicio::date                                                 -- a partir do início
    and (r.fim is null or o.occ <= r.fim::date)                                 -- até o fim (se houver)
    and tm.id is null                                                           -- não duplicar materializada no mesmo dia
    and not exists (                                                            -- ✅ não prever após a 1ª materialização
      select 1
      from public.transacoes t3
      where t3.recorrencia_id = r.id
        and t3.data::date <= o.occ
    )
  group by o.occ
),

-- 3) Movimentos do mês (materializadas + previstas)
mov_mes as (
  select
    d.dia,
    coalesce(t.transacoes, '[]'::jsonb) || coalesce(r.transacoes, '[]'::jsonb) as transacoes,
    coalesce(t.delta, 0) + coalesce(r.delta, 0) as delta
  from dias d
  left join tx_mes  t on t.dia = d.dia
  left join rec_prev r on r.dia = d.dia
),

-- 4) Saldo base (até véspera do mês): saldo_inicial + históricos
--    ⚠️ CORRIGIDO: previsões históricas também param após 1ª materialização
saldo_base as (
  select
    c.saldo_inicial
    + coalesce((
        select sum(case when t.tipo='credito' then t.valor else -t.valor end)
        from public.transacoes t
        where t.conta_id = c.id
          and t.data::date < (select inicio from periodo)
      ), 0)
    + coalesce((
        select sum(case when r.tipo='credito' then r.valor else -r.valor end)
        from public.recorrencias r
        where r.conta_id = c.id
          and exists (
            select 1
            from generate_series(
                   date_trunc('month', greatest(r.inicio::date, date '0001-01-01')),
                   date_trunc('month', (select inicio from periodo) - interval '1 day'),
                   interval '1 month'
                 ) m2
            cross join lateral (
              select (date_trunc('month', m2)::date + (extract(day from r.inicio)::int - 1))::date as occ2
            ) o2
            where extract(month from o2.occ2) = extract(month from m2)
              and o2.occ2 >= r.inicio::date
              and (r.fim is null or o2.occ2 <= r.fim::date)
              and not exists (                                          -- ✅ para histórico também
                select 1 from public.transacoes t2
                where t2.recorrencia_id = r.id
                  and t2.data::date <= o2.occ2
              )
          )
      ), 0) as valor
  from conta c
)

-- 5) Saída: linha por dia, saldo acumulado e JSON de transações
select
  m.dia,
  (select valor from saldo_base)
  + sum(m.delta) over (order by m.dia rows between unbounded preceding and current row) as saldo,
  coalesce(m.transacoes, '[]'::jsonb) as transacoes
from mov_mes m
order by m.dia;
$$;
