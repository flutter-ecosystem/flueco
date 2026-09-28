---
name: flueco-app
description: Compose a Flutter application with the Flueco bundle, kernel, providers, and app-facing services. Use when bootstrapping an app or integrating Flueco UI services.
---

# Compose a Flueco application

Use this skill when an app wants the integrated Flueco surface. The `flueco` package bundles `flueco_core` with selected adapters and adds the convenience kernel, root widget, and UI services.

## Workflow

1. Add `flueco` as a dependency. Add `flueco_auth`, `flueco_state_management`, or `flueco_cli` separately when needed; they are not re-exported by this package.
2. Choose the adapters the app actually uses. The bundle exports AutoRoute, Dio, GetIt, Hive, messaging, shared preferences, and theming, but an export is not a configured service.
3. In the composition root, create the service container and register adapter prerequisites before bootstrapping the kernel. Examples include a root router, Dio options, messaging instance, storage config, and plugin-backed instances.
4. Register the corresponding service providers and await kernel bootstrap before building the app tree.
5. Wrap the app with `Flueco` to expose app services. Its root widget expects a resolvable `Messaging` service. Configure a router/navigator for navigation-backed UI services.
6. Use the registered log, toast, dialog, modal, or notification service at the UI boundary rather than constructing infrastructure clients inside feature widgets.

## Guardrails

- Do not assume that importing a barrel registers an adapter or creates its prerequisite instances.
- Keep provider setup and platform initialization in the composition root.
- Use `flueco_core` plus selected adapters instead when the bundle's dependencies or defaults are not appropriate.
- Do not treat the CLI, auth packages, or state-management package as part of the bundle.

## Validate

Bootstrap the app in a focused test or run it on a target platform. If using `Flueco`, verify that messaging and any router-backed services resolve during the first build.
