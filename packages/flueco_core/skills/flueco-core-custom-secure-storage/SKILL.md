---
name: flueco-core-custom-secure-storage
description: Implement Flueco's SecureStorage contract and register it through IOSecureStorageServiceProvider. Use when integrating platform-protected storage for credentials or secrets.
---

# Create a custom secure storage service

Create a separate internal Dart package in the consuming project, such as `my_app_flueco_secure_storage`, for the platform-specific secure storage implementation and provider. It should depend on `flueco_core`, publicly export the provider, and be included as a dependency of the Flutter app. Do not add an app's key-management choices to `flueco_core`.

## Workflow

1. Review the `SecureStorage` contract: async string `get`, `set`, `remove`, and `contains` operations.
2. Select a storage mechanism appropriate for the target platforms and threat model. Implement the contract in the internal package while keeping plugin APIs private to that adapter.
3. Extend `IOSecureStorageServiceProvider` and implement `secureStorageFactory(ServiceResolver resolver)`.
4. Declare every registered prerequisite in `dependsOn()`. Use `initialize(FluecoApp app)` for required post-registration setup, not for hiding failures.
5. Preserve the base lazy-singleton registration and `registered()` behavior; call the base implementation if overriding those methods.
6. Add the provider to the consuming app's kernel and configure platform-specific setup through the app/internal package boundary.
7. Define key generation, access control, backup exclusions, rotation, invalidation, and recovery policy for the app's use case.

## Guardrails

- Do not hard-code secrets or encryption keys, commit key material, or log stored values.
- A package labeled secure does not automatically make data secure on every platform; review platform guarantees and backup behavior.
- Do not fall back silently to `LocalStorage` when secure storage fails.
- Handle plugin errors and unavailable/locked device states intentionally.

## Validate

Test set/get/remove/contains, error and unavailable-device behavior, and persistence across app restarts. Review platform backup/access-control configuration and verify no secret values appear in logs or test artifacts.
