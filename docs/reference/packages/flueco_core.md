# `flueco_core`

Core contracts and foundations for the Flueco ecosystem. Public exports include `FluecoKernel`, `FluecoApp`, `ServiceContainer`, `ServiceInjector`, `ServiceResolver`, `ServiceProvider`, event-handling APIs, channel registries, log and notification APIs, and abstract HTTP, storage, and routing services.

## Main API areas

- **Lifecycle and DI:** `FluecoKernel`, `FluecoApp`, `ServiceProvider`, `ServiceContainer`, `ServiceInjector`, and `ServiceResolver`.
- **Events and channels:** event/subscriber contracts, `EventHandler`, `ChannelRegistry`, and channel handlers.
- **Cross-cutting services:** log and notification registries, handlers, and message types.
- **Infrastructure contracts:** `HttpClient`/`HttpResponse`, `LocalStorage`, `SecureStorage`, `Router`, and `NavigatorKeyProvider`, with provider base classes.
- **Flutter integration:** `FluecoApp` and injector/resolver widgets.

Core also includes `BasicMemoryStorage`, an in-memory typed key/value helper; it is not a persistent storage provider. The core kernel requires explicit log and notification registries. The `flueco` package supplies a convenience kernel with defaults and additional app services.

Core defines contracts, not concrete production adapters for HTTP, local storage, secure storage, routing, or service-container implementation. Choose and configure the corresponding package, and include its provider and prerequisites.

Related pages: [Architecture](../../overview/architecture.md), [Dependency injection](../../concepts/dependency-injection.md), [Events and registries](../../concepts/events-and-registries.md), [HTTP](../../guides/http.md), and [Storage](../../guides/storage.md). See the package [README](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_core/README.md).
