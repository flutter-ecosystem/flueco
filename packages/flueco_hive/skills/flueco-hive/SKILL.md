---
name: flueco-hive
description: Configure Hive CE as an implementation of Flueco SecureStorage. Use when initializing Hive, registering its provider, or reviewing encryption-key handling.
---

# Configure Hive secure storage

`FluecoHiveServiceProvider` implements core `SecureStorage` using Hive CE. Platform initialization, box configuration, and encryption-key lifecycle belong to the application.

## Workflow

1. Initialize Hive for the target platform before kernel bootstrap (for Flutter apps, typically with `Hive.initFlutter()`).
2. Register a `HiveSecureStorageGetInstanceConfig` containing a `HiveBoxFactory` and, if needed, the box name.
3. Add `FluecoHiveServiceProvider` to the kernel. It creates storage during provider registration and opens the box during initialization.
4. Resolve the core `SecureStorage` contract rather than exposing the Hive box throughout feature code.
5. Generate encryption keys with a reviewed secure source and define how keys are stored, rotated, recovered, or invalidated.

## Guardrails

- Never hard-code encryption keys or treat an arbitrary string as key material.
- `BasicHiveBoxFactory.fromEncryptionKey` truncates/pads a string; it is not a key-derivation function and should not be used to derive production keys.
- A secure box alone does not define backup, recovery, rotation, or multi-user isolation policy.

## Validate

Test initialization and read/write/remove behavior on each target platform. Verify that the app can reopen existing data with the intended key-management path and does not log key material.
