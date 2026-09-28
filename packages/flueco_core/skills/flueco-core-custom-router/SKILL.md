---
name: flueco-core-custom-router
description: Implement Flueco's Router and NavigatorKeyProvider contracts through a custom RouterServiceProvider. Use when adapting a navigation library or app-owned navigator.
---

# Create a custom router service

Keep the router adapter and provider in a separate internal Dart package in the consuming project, for example `my_app_flueco_router`. Make that package depend on `flueco_core`, export the provider from its public library, and add the package as a dependency of the Flutter app. Do not couple `flueco_core` to the app's routing library.

## Workflow

1. Review the core `Router` contract (`pushWidget`, `pushPage`, and `pop`) and `NavigatorKeyProvider` contract.
2. Implement an adapter for the routing library already used by the consuming app. Preserve its stack, result, and pop semantics while translating to the core API.
3. Extend `RouterServiceProvider`. Implement `routerFactory(ServiceResolver resolver)` and `navigatorKeyProviderFactory(ServiceResolver resolver)`.
4. Ensure both factories use the same underlying router/navigator and expose the key that actually drives the app's navigation tree.
5. Declare registered router/configuration prerequisites in `dependsOn()`. Implement initialization only when required and preserve the base registration of both `Router` and `NavigatorKeyProvider` if overriding methods.
6. Export the provider from the internal package and register it in the consuming kernel. Use core `Router` for library-independent navigation; keep router-specific guards, deep links, and generated route types in app/router-specific code.

## Guardrails

- Do not create a second navigator key or router instance for Flueco services; dialogs and navigation must target the visible app navigator.
- Do not leak concrete routing-library types into core contracts or unrelated domain code.
- Account for asynchronous navigation results and the active library's behavior when replacing or popping routes.

## Validate

Test push, pop, result propagation, and navigator-key identity. Verify the app's root widget and Flueco services resolve the same router/key after bootstrap using the internal package dependency.
