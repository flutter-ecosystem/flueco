# Theming

`flueco_theming` provides a `Theming` service, appearance and theme-mode events, provider interfaces, and an `InheritedModel` for widget consumers. A theme appearance contains a stable `key` plus light and dark theme data. `ThemingConfig` requires a non-empty set of appearances and a `selectedAppearanceKey` that matches one of those entries.

## Configure the service

Create a `ThemingConfig` with the initial appearance and optional initial `ThemeMode`, then pass it to `ThemingServiceProvider`. The provider declares dependencies on `LocalStorage` and `EventHandler`; those services must be provided by the application. During initialization, the service observes platform brightness and, depending on `ThemingThemeModeInitStrategy`, may load a saved mode from local storage.

The service can select an appearance by key, change theme mode, and emits `AppearanceChangedEvent`, `ThemeModeChangedEvent`, and `PlatformBrightnessChangedEvent`. A failed appearance key selection returns `false`. Theme mode changes are persisted asynchronously through `LocalStorage`; account for that behavior when testing or coordinating writes.

## Read theme data in widgets

`Theming` is an `InheritedModel` with focused accessors such as `Theming.appearanceOf(context)`, `Theming.themeModeOf(context)`, and `Theming.platformBrightnessOf(context)`. `ThemingProviderBuilder` subscribes to theme events and rebuilds its builder with the current appearance, mode, and platform brightness. Use the narrower accessors when a widget only depends on one aspect.

See [Events and registries](../concepts/events-and-registries.md), [Storage](storage.md), and the [`flueco_theming` reference](../reference/packages/flueco_theming.md) for public types and package details.
