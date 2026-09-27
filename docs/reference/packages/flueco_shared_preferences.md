# `flueco_shared_preferences`

Adapts the `shared_preferences` package to core `LocalStorage`. The public library exports shared_preferences APIs, `SharedPreferencesStorage`, and `FluecoSharedPreferencesServiceProvider`.

Register a `SharedPreferences` instance in the service container before adding the provider. The provider's `dependsOn()` declares `SharedPreferences`, then registers the concrete adapter and exposes it as `LocalStorage`. The storage contract handles strings; it does not expose the plugin's full set of typed preference APIs through the abstraction.

Use this for ordinary preference-like data, not credentials or cryptographic key material. Persistence, platform behavior, and test plugin setup follow the upstream package. See the [Storage guide](../../guides/storage.md), [core reference](flueco_core.md), and package [README](../../../packages/flueco_shared_preferences/README.md).
