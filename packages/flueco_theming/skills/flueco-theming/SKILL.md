---
name: flueco-theming
description: Configure Flueco appearance and theme-mode services and consume their updates in Flutter widgets. Use when adding selectable appearances or persisted theme behavior.
---

# Configure Flueco theming

`ThemingServiceProvider` coordinates appearances, theme mode, platform brightness, persistence, and appearance/theme events.

## Workflow

1. Define a non-empty set of appearances and ensure the selected appearance key matches an entry.
2. Register core `LocalStorage` and `EventHandler` services before adding `ThemingServiceProvider`.
3. Choose the `ThemingThemeModeInitStrategy` that matches whether the app should restore a saved mode or use its configured initial value.
4. Build the Flutter theme from the current appearance, theme mode, and platform brightness using the theming model/provider widgets.
5. Use `ThemingProviderBuilder` or the documented inherited model to react to changes; persist mode changes through the service.
6. If appearance options are dynamic, handle a `false` result when selecting an unknown key.

## Guardrails

- Do not pass an empty appearance set or an initial selection key that is absent from the set.
- Register both storage and event handling before theming initialization.
- Keep app-specific `ThemeData` construction in the app while using the service for appearance state and events.

## Validate

Test initial selection, saved-mode restoration behavior, mode/appearance changes, and platform brightness updates. Confirm widgets rebuild and unknown appearance keys are handled.
