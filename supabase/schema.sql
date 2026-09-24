-- ArezoKings cloud backend
-- Supabase SQL Editor: run this entire script once.

create table if not exists public.team_state (
  id boolean primary key default true check (id = true),
  matches jsonb not null default '[]'::jsonb,
  contributions jsonb not null default '[]'::jsonb,
  ground_payments jsonb not null default '[]'::jsonb,
  ground_names jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);

insert into public.team_state (id)
values (true)
on conflict (id) do nothing;

alter table public.team_state enable row level security;

drop policy if exists "Authenticated users can read team state" on public.team_state;
create policy "Authenticated users can read team state"
on public.team_state
for select
to authenticated
using (true);

drop policy if exists "Authenticated users can insert team state" on public.team_state;
create policy "Authenticated users can insert team state"
on public.team_state
for insert
to authenticated
with check (id = true);

drop policy if exists "Authenticated users can update team state" on public.team_state;
create policy "Authenticated users can update team state"
on public.team_state
for update
to authenticated
using (true)
with check (id = true);

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null,
  created_at timestamptz not null default now()
);

create index if not exists profiles_display_name_lower_idx
on public.profiles (lower(display_name));

alter table public.profiles enable row level security;

drop policy if exists "Authenticated users can read profiles" on public.profiles;
create policy "Authenticated users can read profiles"
on public.profiles
for select
to authenticated
using (true);

drop policy if exists "Users can insert own profile" on public.profiles;
create policy "Users can insert own profile"
on public.profiles
for insert
to authenticated
with check (id = auth.uid());

drop policy if exists "Users can update own profile" on public.profiles;
create policy "Users can update own profile"
on public.profiles
for update
to authenticated
using (id = auth.uid())
with check (id = auth.uid());

-- Optional realtime support for future live updates.
alter table public.team_state replica identity full;
