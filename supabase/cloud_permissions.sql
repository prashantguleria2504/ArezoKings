-- Run this once in the ArezoKings Supabase SQL Editor after the initial schema.
grant usage on schema public to authenticated;
grant select, insert, update on table public.team_state to authenticated;
grant select, insert, update on table public.profiles to authenticated;

do $$
begin
  begin
    alter publication supabase_realtime add table public.team_state;
  exception when duplicate_object then null;
  end;
end $$;