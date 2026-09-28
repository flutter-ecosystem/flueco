---
name: flueco-create-route
description: Add a navigable page to the Flueco example using the router already configured by the app. Use when adding a screen route, nested route, guard, or route transition.
---

# Create a route

Do not assume a routing package. First inspect `example/pubspec.yaml`, `lib/presentation/routing/`, the root app widget, and existing route/navigation services. Use the routing library and version already configured unless the task explicitly requests a migration.

## Workflow

1. Create or update the page widget in the existing presentation screen structure.
2. Follow the active router's page registration, route naming, nesting, argument, and guard conventions. Keep domain code independent of concrete route classes; use existing navigation contracts/services where they provide that boundary.
3. Register the route in the app's route configuration and connect guards only when the feature requires them.
4. If the active router uses code generation, run the repository's configured generator and never hand-edit generated route files. For the current AutoRoute setup, page widgets use `@RoutePage`, routes are declared in `lib/presentation/routing/app_router.dart`, and generated output is `app_router.gr.dart`.
5. Confirm the configured root router is the same instance provided to Flueco and used by navigation services.
6. Add or update deep-link, guard, and navigation tests as relevant.

## Guardrails

- Do not add a second router or change routing libraries as an incidental part of adding a page.
- Avoid placing AutoRoute-specific types in domain contracts or use cases.
- Ensure nested routes and initial paths match the active library's semantics.

## Validate

Run route code generation when applicable, `flutter analyze`, and a focused navigation test. Verify that the route can be opened through the app's real root router and that guards behave correctly.
