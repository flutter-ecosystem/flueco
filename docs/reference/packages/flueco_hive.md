# `flueco_hive`

Hive CE-backed implementation of core `SecureStorage`. The public library exports Hive CE APIs, `HiveSecureStorage`, and `FluecoHiveServiceProvider`.

Before registering the provider, initialize Hive for the target platform and register a `HiveSecureStorageGetInstanceConfig` in the container. The config requires a `HiveBoxFactory` and optionally sets the box name. The provider creates the storage during registration and opens the box during initialization. `BasicHiveBoxFactory` supports secure and unsecure boxes; the storage provider uses its secure-box operation.

**Key management matters.** Hive box encryption only helps if key material is generated and stored safely. Do not hard-code keys or treat an arbitrary string as a key. The current `BasicHiveBoxFactory.fromEncryptionKey` helper transforms strings by truncating/padding and does not provide a key-derivation function; review its implementation carefully and do not rely on it for production key derivation. Prefer a securely generated, correctly sized key supplied by a reviewed key-management path.

Hive initialization/platform behavior and encryption-key lifecycle are application responsibilities. The Flueco `SecureStorage` interface provides basic string operations but does not define backup, recovery, rotation, or multi-user isolation policy.

See the [Storage guide](../../guides/storage.md), [core reference](flueco_core.md), and package [README](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_hive/README.md).
