---
name: flueco-auto-route
description: Connect an AutoRoute root router to Flueco's routing and navigator contracts. Use when registering routes, guards, or navigation-backed services.
---

# Connect AutoRoute to Flueco

`flueco_auto_route` adapts an AutoRoute `RootStackRouter` to Flueco's `Router`, `NavigatorKeyProvider`, and root-router provider APIs.

## Workflow

1. Define the app's root router using the AutoRoute APIs and annotations for the resolved AutoRoute version.
2. Run the project's configured code generator and keep generated route output in sync with declarations.
3. Register the configured root router instance in the service container before bootstrap.
4. Add `AutoRouteServiceProvider` to the kernel's provider set.
5. Use Flueco's routing contract for framework-level navigation. Use AutoRoute-specific APIs for guards, nested routers, deep links, and generated route types.
6. Ensure navigation-backed services use the same router and navigator key.

## Guardrails

- The adapter does not construct or configure the root router.
- Keep AutoRoute generation instructions aligned with the app's resolved package version.
- Do not register one router for Flueco and a different router for the visible widget tree.

## Validate

Run code generation and analysis, then test a route transition and any authentication guard with the router instance used by the app.
