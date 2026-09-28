---
name: flueco-shared-preferences
description: Use shared_preferences through Flueco's LocalStorage contract. Use when registering the adapter or deciding whether data belongs in ordinary preferences.
---

# Use shared_preferences as LocalStorage

`FluecoSharedPreferencesServiceProvider` adapts a supplied `SharedPreferences` instance to core `LocalStorage`.

## Workflow

1. Initialize and obtain `SharedPreferences` using the upstream package's current API.
2. Register the instance in the Flueco service container before adding `FluecoSharedPreferencesServiceProvider`.
3. Add the provider to the kernel and consume the core `LocalStorage` contract for string reads, writes, removal, and containment.
4. Use the upstream API directly only when the app deliberately needs preference types or operations that the Flueco string contract does not expose.
5. In tests, configure the upstream plugin's test implementation as required by the target platform.

## Guardrails

- This adapter exposes the string-oriented `LocalStorage` contract, not every typed preference API.
- Use it for ordinary preference-like data, not credentials, secrets, or cryptographic key material.
- Account for upstream plugin persistence and platform behavior; the adapter does not make preferences secure storage.

## Validate

Test reading a missing key, writing and reading a value, checking containment, and removing a value using the app's configured plugin test setup.
