# The Flueco Ecosystem

Flueco is a toolkit for composing Flutter applications from shared service contracts and replaceable implementations. The Flueco CLI scaffolds a Flutter application from the repository example with Flueco configured. The app uses the `flueco` bundle, which brings together `flueco_core` contracts and selected adapters; optional packages add capabilities such as authentication and state management.

The main design idea is that application code should ask for a capability such as `HttpClient` or `LocalStorage`, while a composition root decides which implementation provides it. This keeps vendor-specific choices near application startup and makes them easier to replace, configure, and test.

## Package layers

| Layer | Responsibility | Packages |
| --- | --- | --- |
| App bundle | Convenient app-facing package that bundles core and selected adapters | `flueco` |
| Core | Defines service contracts, lifecycle, and shared behavior | `flueco_core` |
| Adapters | Implement core contracts using concrete libraries | `flueco_get_it`, `flueco_dio`, `flueco_auto_route`, `flueco_hive`, `flueco_shared_preferences`, `flueco_messaging`, `flueco_theming` |
| Optional features | Add capabilities not included in the `flueco` bundle | `flueco_auth` and its strategy/integration packages; `flueco_state_management` |
| Tooling | Scaffolds a Flutter app from the repository example | `flueco_cli` |

The dependency direction is intentional: adapters depend on core contracts, while core does not need to depend on a specific adapter. Application composition brings the selected pieces together.

```mermaid
flowchart LR
 CLI[flueco_cli\nproject scaffolding] -->|generates configured project| APP[Flutter application\ncomposition root]
 APP -->|depends on| BUNDLE[flueco\napp bundle]
 BUNDLE -->|includes| CORE[flueco_core\ncontracts and lifecycle]
 BUNDLE -->|bundles selected| ADAPTERS[Adapters\nGetIt, Dio, AutoRoute, storage, messaging, theming]
 ADAPTERS -->|implement contracts| CORE
 APP -->|may add separately| AUTH[flueco_auth\nand strategies]
 AUTH -->|uses| CORE
 APP -->|may add separately| STATE[flueco_state_management]
```

The CLI is a development-time generator, not a runtime dependency. The generated application selects providers and prerequisite configuration at its composition root. The `flueco` package bundles core and selected adapters for convenience; adapters implement core contracts, while optional authentication and state-management packages are added separately when needed. You can also depend on `flueco_core` and individual adapters directly instead of using the bundle.

## What is a service?

In Flueco, a service is an application capability made available through the service container. `ServiceResolver` exposes lookup, `ServiceInjector` exposes registration, and `ServiceContainer` combines both. A `ServiceProvider` groups registrations and any initialization for a feature or adapter.

For example, the core `LocalStorage` contract describes string reads, writes, removal, and containment. `flueco_shared_preferences` supplies an implementation. The app registers the adapter provider and its prerequisite `SharedPreferences` instance during startup; consumers can then depend on `LocalStorage` rather than directly constructing the plugin wrapper. This is dependency inversion at the application composition boundary, not automatic plugin discovery.

## Choosing a starting point

- Choose `flueco` when building a Flutter app and you want the bundle's selected adapters, default registries, and app-facing services.
- Choose `flueco_core` directly when you need the contracts and lifecycle without the bundle's default UI and infrastructure choices.
- Add an adapter when you need a concrete implementation for a core contract. Include the adapter's prerequisite instances/configuration as well as its provider.
- Add `flueco_auth` with the strategy packages you need, and add `flueco_state_management` separately if using its Provider-based view-model APIs.
- Use `flueco_cli` when the repository example is a suitable starter; it is not a runtime dependency of the generated app.

The [package catalog](../reference/packages.md) lists each package and whether it is re-exported by `flueco`. Follow [Flueco CLI](../getting-started/create-an-app.md) to scaffold the configured example or [Manual installation](../getting-started/installation.md) to compose an app yourself. The [architecture overview](architecture.md) follows a service through registration and use.

Package versions and SDK constraints can change independently. Consult [compatibility](../reference/compatibility.md) and the package manifests before choosing versions.
