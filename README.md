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

# Scio – comprehension measurement tool 💡

This package simplies measuring the users comprehension of your mobile application. After a quick setup you can ask questions to your users and improve your user experience with the generated insights. The questions are displayed in a survey-like environment and can require multiple choice, single choice or text answers. The questions can be static as well as contextual, where your app provides all necessary information to personalize your survey.

Text |  Multiple Choice | Single Choice
:---:|:----------------:|:--------------:
![Text Widget](https://user-images.githubusercontent.com/16440155/176430213-163a1854-1bcb-44db-80b8-b2f7385cb8d9.png) |![Multiple Choice Widget](https://user-images.githubusercontent.com/16440155/176430341-85da1d1e-9f46-4adf-a964-03f69be9678e.png)  |  ![Single Choice Widget](https://user-images.githubusercontent.com/16440155/176429898-2bc845cb-a13b-418c-80ef-dbc52ccb743b.png)

<!--
TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.
-->

## Features

- Customizable Intro Widget and Completion

Intro | Completion
:----:|:---------:
![Intro Widget](https://user-images.githubusercontent.com/16440155/176430625-c093a420-6d71-4662-9e89-da1118315300.png) | ![Completion Widget](https://user-images.githubusercontent.com/16440155/176430651-e748b365-5185-46d6-885b-4818444d4ef8.png)

- Contextual Questions
- Opt-out
- Persistent Storage of already answered questions


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

## Usage

There are multiple ways to integrate comprehension measurement using this package.

1. [Use `measureComprehension`-function](#use-measurecomprehension-function)
2. [Use `ComprehensionHelper`-class](#use-comprehensionhelper-class)
3. [Use `AutoComprehensiblePage`](#use-autocomprehensiblepage)

### Use `measureComprehension`-function

To have complete control over when the survey component is opened, it can be
called with the measureComprehension method. When calling this method the
hive boxes are initialized first and then filled with the previously saved data. If the
user opted out of surveys or the specified survey is already completed the method
returns without a widget.

This method can be called from any page and displays the survey correctly, so
it enables the developer to define a custom logic on when to call the survey, e.g
the survey should only be shown when specific conditions are met. This method
takes all parameters needed to create the comprehension model and comprehension
widget.

### Use `ComprehensionHelper`-class

When pushing a new page we can attach the helper method `ComprehensionHelper.attach` to it. This is done by passing a method call like `context.router.push(Route())` to the singleton. After the page is popped from the router stack, which means that the user has left the page, the survey is called. For example, this class can be used when the tab is changed, since this does not pop the target page from the router stack, but still leaves the page.

### Use `AutoComprehensiblePage`

Developers looking for fast results without extra effort into survey control should use the `AutoComprehensiblePage`. This page extends `StatefulWidget` and provides the functionality to open a comprehension measurement widget based on chance when the `AutoComprehensiblePage` is left.

For this to work, you have to add the class `AutoRouteObserver` to your [`AutoRoute`-configuration](https://pub.dev/packages/auto_route#navigation-observers).

## Contextual Questions

This package enables you to personalize questions based on the context of your application. Just pass a `questionContext` to the package, with key value pairs you are referencing in the database with `is_contextual` set to true and the `context` set to the key.

## Additional information

<!--
TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
-->

This package was developed in the context of the project [PharMe](https://github.com/hpi-dhc/PharMe). Their you can find an example integration.
