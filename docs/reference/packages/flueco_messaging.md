# `flueco_messaging`

Adapts the external `messaging` package to core event handling. Its public library exports messaging APIs, `MessagingEventHandler`, and `MessagingServiceProvider`.

The provider requires a `Messaging` instance and registers `MessagingEventHandler` as the core `EventHandler`. Register the messaging instance before including `MessagingServiceProvider`; the adapter does not construct/configure the external messaging bus for the application.

Use this package when Flueco features or application code need the core event API backed by `messaging`. `flueco` also wraps its root widget in `MessagingScopeProvider` and expects a resolvable messaging instance for lifecycle handling. Decide where the underlying bus is created and how subscriptions are disposed according to the external package's lifecycle rules.

Related pages: [Events and registries](../../concepts/events-and-registries.md), [Theming](../../guides/theming.md), and the package [README](../../../packages/flueco_messaging/README.md).
