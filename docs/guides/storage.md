# Storage

Core defines separate `LocalStorage` and `SecureStorage` contracts. Both expose asynchronous string `get`, `set`, `remove`, and `contains` operations. Core also has `BasicMemoryStorage` for in-memory typed values; it is useful for transient state and test fixtures, not persistence across process restarts.

Choose a backend based on the data classification and lifecycle. The API contract alone does not make a backend secure: confirm encryption, key storage, backup behavior, and platform guarantees for your threat model. In particular, do not store secrets in ordinary preferences.

## Local storage

`flueco_shared_preferences` adapts `shared_preferences` to `LocalStorage`. Its provider requires a `SharedPreferences` instance registered in the container before bootstrap. Create the plugin instance during app setup:

```dart
final preferences = await SharedPreferences.getInstance();
container.singleton<SharedPreferences>((_) => preferences);
providers.add(FluecoSharedPreferencesServiceProvider());
```

This is a setup fragment; initialize the Flutter binding and plugin prerequisites as required by the app. Values are strings at the Flueco contract boundary, even though the underlying plugin supports additional primitive types.

## Secure storage

`flueco_hive` adapts Hive CE to `SecureStorage`. Initialize Hive for the target platform before Flueco bootstrap, then register a `HiveSecureStorageGetInstanceConfig` containing a configured `HiveBoxFactory` and optional box name. Add `FluecoHiveServiceProvider`; it initializes its box during provider initialization.

The package's `BasicHiveBoxFactory` supports encrypted and unencrypted boxes. If using encryption, manage a cryptographically strong key outside source control and follow the platform's secure key-storage practices. The current `fromEncryptionKey` helper transforms strings by truncating/padding and is not a key-derivation function; review it before use and do not use it as a production key-management strategy. Do not assume that selecting a class named “secure storage” alone establishes an adequate security policy.

## Testing and replacement

Depend on the storage contract in application services, not on the plugin-specific box/preferences API. Use an in-memory or fake implementation for unit tests, then add integration tests for persistence and platform behavior. `LocalStorage` and `SecureStorage` are separate contracts, so keep consumers typed to the distinction they require.

See the [`flueco_core`](../reference/packages/flueco_core.md), [`flueco_shared_preferences`](../reference/packages/flueco_shared_preferences.md), and [`flueco_hive`](../reference/packages/flueco_hive.md) references for the exported APIs.
