# `flueco_auto_route`

Implements the core routing abstractions with AutoRoute. Public exports include AutoRoute APIs and annotations, `AutoRouteRouter`, `AutoRouteServiceProvider`, and root-router provider types.

`AutoRouteServiceProvider` depends on a configured `RootStackRouter`. It registers a lazy `AutoRouteRouter`, then exposes it as the core `Router`, `NavigatorKeyProvider`, and `AutoRouteRootRouterProvider`. The same router instance should back navigation and other services that need the navigator key.

Add the root router to the container before bootstrap and include `AutoRouteServiceProvider`. This package adapts Flueco's small navigation contract; route annotations, generation, guards, nested routers, and deep links remain AutoRoute concerns. Follow AutoRoute's own version-specific instructions for code generation and platform setup.

See the [Routing guide](../../guides/routing.md), [core reference](flueco_core.md), and package [README](../../../packages/flueco_auto_route/README.md).
