## Getting started

1. Clone this project
2. [Setup Database](#setup-database-supabase)

### Setup Database (Supabase)

Detailed instructions can be found here: [Supabase Local Development](https://supabase.com/docs/guides/local-development)

**Prerequisites:** [Supabase Prerequisites](https://supabase.com/docs/guides/local-development#prerequisites)

**Steps:**

1. Run `supabase start` in package root directory to start a local supabase emulator.
2. Run `supabase db reset` to run migrations and fill local database with seed data.
3. [Create supabase project](https://app.supabase.com/).
4. [Link your CLI to your project](https://supabase.com/docs/guides/local-development#linking-your-project).
5. Run `supabase db push` to deploy local database migrations to remote database.

In your app you need to create a `SupabaseConfig`-instance with your credentials to pass it to the package.

```dart
final supabaseConfig = SupabaseConfig(<supabaseUrl>, <supabaseKey>)
```

**Values for local database:**
After running `supabase start` you get your credentials:

```console
supabaseUrl = API URL
supabaseKey = anon key
```

**Values for remote database:**
Go to your project on Supabase and then go to `API > Authentication` to find your credentials there.