# Package Catalog

Flueco is published as focused packages. Choose the package by capability, then check its page for installation, provider prerequisites, and limitations. Installing a package alone does not register it in the application container.

## Application and foundations

- [`flueco`](packages/flueco.md): app-oriented bundle, kernel defaults, and UI services.
- [`flueco_core`](packages/flueco_core.md): contracts and foundational services.
- [`flueco_cli`](packages/flueco_cli.md): command-line app scaffolding.

Use `flueco` for the integrated app surface; use `flueco_core` when you want to compose the foundation and integrations yourself. The CLI is a development tool, not an app runtime dependency.

## Integrations

- [`flueco_get_it`](packages/flueco_get_it.md): GetIt service container.
- [`flueco_dio`](packages/flueco_dio.md): Dio HTTP client.
- [`flueco_auto_route`](packages/flueco_auto_route.md): AutoRoute router adapter.
- [`flueco_messaging`](packages/flueco_messaging.md): event-handling adapter.
- [`flueco_hive`](packages/flueco_hive.md): Hive-backed secure-storage contract implementation.
- [`flueco_shared_preferences`](packages/flueco_shared_preferences.md): shared_preferences local-storage adapter.
- [`flueco_theming`](packages/flueco_theming.md): theme and appearance services.

Adapters generally require both a provider and a prerequisite instance/configuration. For example, Dio needs `DioBaseOptionsProvider`; AutoRoute needs a `RootStackRouter`; shared preferences needs `SharedPreferences`; Hive needs `HiveSecureStorageGetInstanceConfig`; theming needs local storage and event handling.

## Optional features

- [`flueco_auth`](packages/flueco_auth.md): authentication contracts and orchestration.
- [`flueco_auth_basic`](packages/flueco_auth_basic.md): basic authentication strategy.
- [`flueco_auth_token`](packages/flueco_auth_token.md): token authentication strategy.
- [`flueco_auth_dio_interceptor`](packages/flueco_auth_dio_interceptor.md): authentication for Dio requests.
- [`flueco_state_management`](packages/flueco_state_management.md): Provider-based view-model state APIs.

The `flueco` barrel re-exports core, selected adapters, and their upstream APIs. It does not re-export the auth packages, state-management package, or CLI. Verify your resolved package versions and transitive dependencies using [Compatibility](compatibility.md). Start with [Manual installation](../getting-started/installation.md), then follow the capability guide for the service you intend to use. For AI-assisted development workflows, see [AI agent skills](../guides/skills.md).
