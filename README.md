<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

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

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
