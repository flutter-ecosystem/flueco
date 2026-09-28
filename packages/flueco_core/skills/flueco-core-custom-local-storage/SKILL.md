---
name: flueco-core-custom-local-storage
description: Implement Flueco's LocalStorage contract and register it through IOLocalStorageServiceProvider. Use when adapting an app database or key-value store for ordinary local data.
---

# Create a custom local storage service

Put the storage adapter and provider in a separate internal Dart package in the consuming project, for example `my_app_flueco_local_storage`. Make it depend on `flueco_core`, export its provider publicly, and add it as a Flutter app dependency. Do not place a project-specific storage adapter in `flueco_core`.

## Workflow

1. Review the `LocalStorage` contract: async string `get`, `set`, `remove`, and `contains` operations.
2. Implement `LocalStorage` using the chosen database or key-value library. Keep vendor-specific APIs and models inside the internal package.
3. Extend `IOLocalStorageServiceProvider` and implement `localStorageFactory(ServiceResolver resolver)`.
4. If the factory resolves configuration or an already-registered database instance, include its service type in `dependsOn()`. Implement `initialize(FluecoApp app)` for migrations or opening resources that must happen after registration.
5. Preserve the base provider's lazy-singleton registration and `registered()` declaration. If overriding either method, call `super` as required.
6. Add the provider to the consuming app's kernel. Keep schema, migration, encryption, and platform configuration in the internal package or app configuration, not in core.

## Guardrails

- `LocalStorage` is string-oriented and is not a secure credential store. Use `SecureStorage` for secrets.
- Define behavior for missing keys, serialization, persistence failures, and concurrent access. Do not return success after silently dropping a write.
- Keep the adapter contract-compatible even if the underlying store offers additional operations.

## Validate

Test absent-key reads, set/get round trips, contains, remove, persistence across reopening, and error behavior. Verify the app resolves `LocalStorage` after kernel bootstrap using the internal package provider.
