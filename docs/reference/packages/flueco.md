# `flueco`

The app-oriented package bundles core with selected Flueco integrations and adds application services and widgets. Its barrel exports AutoRoute, Dio, GetIt, Hive, messaging, shared_preferences, and theming integrations, alongside core APIs. It also provides `FluecoKernel`, log/toast/dialog services, modal support, and dialog widgets.

## What it adds

The convenience kernel supplies default log and notification registries and emits app bootstrap/first-build events. `Flueco` is a root widget that exposes app services and wraps the tree with messaging lifecycle and toast support. The bundle includes dialog components and services for logging, toast, modal, and notification interactions.

## Composition requirements

Include only the providers needed by the application, but satisfy all adapter prerequisites. The `Flueco` root widget resolves a `Messaging` service, so apps using this wrapper must register the messaging integration and its prerequisite. Navigation-backed UI services also need a configured navigator/router. Follow [Bootstrap](../../getting-started/first-app.md) and the [example composition](https://github.com/flutter-ecosystem/flueco/blob/main/example/lib/bootstrap/kernel.dart).

This bundle re-exports core and selected adapters, increasing convenience but also bringing those dependencies into the application. It does not export the auth packages, `flueco_state_management`, or `flueco_cli`; add those separately if needed. For a smaller dependency surface or custom registries, compose `flueco_core` and individual packages instead.

Start with [Installation](../../getting-started/installation.md), [Bootstrap](../../concepts/kernel-and-bootstrap.md), and [Logging and notifications](../../guides/logging-and-notifications.md). The package's [README](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco/README.md) is also available.
