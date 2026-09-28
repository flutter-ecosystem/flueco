---
name: flueco-cli
description: Scaffold a Flutter application from the Flueco example using the flueco command-line tool. Use when creating a starter app or troubleshooting project generation.
---

# Scaffold with flueco_cli

Use this skill when the repository example is a suitable starting point for a new Flutter app.

## Workflow

1. Ensure Dart, Flutter, and Git are installed and available on `PATH`.
2. Activate the CLI with `dart pub global activate flueco_cli` if it is not already installed.
3. Run `flueco create <output-directory>`. Use `flueco create --help` to review supported Flutter create options.
4. Add `--interactive` to enter project values through prompts. Pass Flutter creation options through to `flutter create`; use `--no-pub` to defer dependency resolution or `--pub` to retain it.
5. Resolve dependencies and run the generated app with Flutter.
6. Before release, review inherited application identifiers, API endpoints, credentials, environment values, and example-only configuration.

## Guardrails

- This package is development tooling, not a runtime dependency for the generated app.
- The command starts from the Flueco repository example; it does not produce a blank, minimal project.
- Do not publish example credentials or assume example endpoints are suitable for production.

## Validate

Generate into a clean output directory, confirm Flutter platform files were created, resolve dependencies, and run the app on the intended target.
