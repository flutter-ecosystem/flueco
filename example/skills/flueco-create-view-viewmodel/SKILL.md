---
name: flueco-create-view-viewmodel
description: Create a Flutter view and Provider-backed ViewModel in the Flueco example. Use when adding a screen or changing presentation behavior and state.
---

# Create a view and view model

The example separates screen widgets from behavior: views live under `lib/presentation/ui/screens/`, view models and state live alongside their screen, and state uses `flueco_state_management`.

## Workflow

1. Find the closest existing screen and follow its folder and filename conventions, such as `auth.view.dart`, `auth.viewmodel.dart`, and `auth.viewstate.dart`.
2. Define an immutable `ViewState` with all rendered state represented in fields and included in `props`. Use the existing copy-with generator pattern when state updates benefit from it.
3. Implement a `ViewModel<ViewState>` that exposes user-intent methods, validates or coordinates input, and calls injected use cases/services. Keep widget construction and navigation-library types out of the view model unless an existing app-level contract requires them.
4. Register newly required collaborators through the correct Injectable module. The view's provider wrapper can resolve dependencies from `FluecoSR` and create the view model with `ChangeNotifierProvider`, following the auth screen.
5. Keep the view declarative: watch state for rendering, call view-model methods for actions, and reuse the app's localization and UI conventions.
6. Ensure controllers, focus nodes, subscriptions, and other resources have an owner and are disposed at the correct lifecycle boundary.
7. Add tests for state transitions and important presentation behavior.

## Guardrails

- Do not mutate a state object in place; equality-based notifications depend on immutable, correctly compared state.
- Use `read` for actions and `watch`/`select` for rendered dependencies; avoid resolving services repeatedly from deep widget code.
- Provider owns and disposes instances it creates. Avoid a second conflicting owner.
- Keep generated state files generated; do not edit `.g.dart` manually.

## Validate

Run the focused view-model/widget tests and `flutter analyze` from `example/`. Regenerate copy-with or route output when annotations or route declarations change.
