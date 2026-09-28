---
name: flueco-core
description: Build on Flueco core contracts, service providers, lifecycle, registries, and events. Use when adding a core integration or composing Flueco without the app bundle.
---

# Compose with Flueco core

Use `flueco_core` for framework contracts and lifecycle without selecting the app bundle's default adapters and UI services.

## Workflow

1. Define the capability consumers need as a contract, or use an existing contract such as `HttpClient`, `LocalStorage`, `SecureStorage`, or `Router`.
2. Implement vendor-specific behavior in an adapter/provider, not in core consumers.
3. Declare provider prerequisites and registrations explicitly. Keep `dependsOn()` and `registered()` aligned with the services the provider actually resolves and installs.
4. Construct `FluecoKernel` with a service container, provider set, and the required log and notification registries.
5. Await bootstrap before resolving services or building widgets. Use the injector/resolver widgets only where widget-tree access is appropriate.
6. Use `EventHandler` and channel registries for event-based communication; keep event ownership and subscription lifecycle explicit.

## Guardrails

- Core defines contracts; it does not supply production HTTP, persistent storage, routing, messaging, or container adapters.
- `BasicMemoryStorage` is an in-memory helper, not durable or secure persistence.
- Do not make core depend on a concrete adapter when the dependency can live at the composition boundary.
- Use the `flueco` bundle only when its defaults and bundled integrations are wanted.

## Validate

Test provider registration and dependency resolution independently. For a new adapter, verify the core contract behavior through the adapter and verify bootstrap fails clearly when a declared prerequisite is missing.
