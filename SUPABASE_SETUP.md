# ArezoKings Cloud Backend

This branch prepares ArezoKings to use Supabase for shared authentication and shared team data.

## Architecture

GitHub Pages hosts the static website.

Supabase provides:
- email/password authentication
- PostgreSQL database
- row-level security
- optional realtime synchronization

All authenticated ArezoKings users share the single `team_state` row, so a match created by one logged-in user is visible to other logged-in users.

## Authentication

The cloud version should use Supabase email/password authentication. The existing browser-only username/password mechanism is not suitable for shared cross-device authentication.

The UI can still collect a display name (for example, the player's name), but authentication should use email + password.

## Setup

1. Create a Supabase project.
2. Open SQL Editor.
3. Run `supabase/schema.sql`.
4. In Supabase Authentication settings, enable Email provider.
5. Get the project's Project URL and anon/public key.
6. Put those values into the ArezoKings frontend configuration.

Do not put a Supabase `service_role` key in the frontend or GitHub repository.

## Data model

`team_state`
- `matches`
- `contributions`
- `ground_payments`
- `ground_names`

The browser backup/restore feature can remain as an additional manual backup mechanism.
