# `flueco_theming`

Theming and appearance services for Flueco. Public exports include `ThemingServiceProvider`, `ThemingConfig`, provider interfaces, appearance models, theme/brightness events, and the Flutter theming provider widget.

`ThemingServiceProvider` depends on core `LocalStorage` and `EventHandler` services. `ThemingConfig` requires a non-empty appearance set and a selected key matching one appearance. The service can restore theme mode from storage depending on `ThemingThemeModeInitStrategy`, observes platform brightness, persists mode changes, and emits events when mode, appearance, or platform brightness changes.

The `Theming` inherited model exposes appearance, theme mode, and platform brightness to widgets; `ThemingProviderBuilder` subscribes to events and rebuilds its builder. Appearance selection by an unknown key returns `false`. Consumers should handle that result if appearance choices can be dynamic.

See the [Theming guide](../../guides/theming.md), [Storage](../../guides/storage.md), and package [README](../../../packages/flueco_theming/README.md).
