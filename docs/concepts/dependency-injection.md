# Dependency Injection

Dependency injection (DI) makes a class's collaborators explicit and lets the application choose their implementations. In Flueco, the composition root builds the dependency graph; feature classes receive the objects they need instead of constructing plugin clients or reaching into global state.

## The three roles

- `ServiceInjector` registers factories or instances.
- `ServiceResolver` looks up registered services by type, optionally by name.
- `ServiceContainer` combines both interfaces and is generally owned by the application composition root.

`flueco_core` defines these contracts. `flueco_get_it` provides `GetItServiceContainer`, a GetIt-backed implementation. Providers receive an injector in `register()` and the application resolver in `initialize()`. Ordinary services can receive their dependencies in their constructors.

## Choose a registration lifetime

- Use `factory` when each resolution should create a new object, such as a short-lived operation object.
- Use `singleton` when the same already-available instance should be shared.
- Use `lazySingleton` when one shared object should be created on first use, such as a client or repository.
- Use `singletonAsync` when construction itself is asynchronous. If asynchronous work is service initialization rather than object construction, prefer the provider's `initialize()` phase.

The injector also supports optional names when the same type has multiple registrations, and a `force` option where replacement is appropriate. Keep named registrations exceptional and document which name consumers should resolve. With `GetItServiceContainer`, each container owns a new GetIt instance unless an existing one is passed to its constructor.

## Register a service and its dependency

This provider registers a profile service backed by the core `HttpClient` contract. `HttpClient` must be registered by an HTTP adapter provider such as `DioServiceProvider`:

```dart
class ProfileService {
 final HttpClient _httpClient;

 ProfileService(this._httpClient);

 Future<Map<String, dynamic>?> loadProfile() async {
  final response = await _httpClient.get<Map<String, dynamic>>('/profile');
  return response.data;
 }
}

class ProfileServiceProvider extends ServiceProvider {
 @override
 Future<void> register(ServiceInjector injector) async {
  injector.lazySingleton<ProfileService>(
   (resolver) => ProfileService(resolver.resolve<HttpClient>()),
  );
 }

 @override
 Future<void> initialize(FluecoApp app) async {}

 @override
 Set<Type> dependsOn() => <Type>{HttpClient};

 @override
 Set<Type> registered() => <Type>{ProfileService};
}
```

**Note:** You don't need to create a provider for every service. You can create one specific service provider that will be in charge of registering multiple services. The example above is for demonstration purposes only. Checkout the [example](../../example/lib/bootstrap/providers/) for examples.

Add both `DioServiceProvider` and `ProfileServiceProvider` to the kernel's provider set, along with the Dio options prerequisite. The feature depends on `HttpClient`, not on `Dio`; replacing the adapter then does not require changing `ProfileService`. See [Service providers](service-providers.md) for the provider contract and dependency declarations.

## Resolve from a widget

The `Flueco` root places the resolver/injector in the descendant widget tree. For a widget that needs a service at the UI boundary, resolve it with `FluecoSR`:

```dart
final ProfileService profiles = FluecoSR.of(context).resolve<ProfileService>();
```

The context must be below the `Flueco` root and still mounted. For ordinary classes, prefer constructor injection so dependencies remain visible and the class is easy to instantiate in a unit test. Avoid passing the container or resolver deep into the application as a service locator; that hides dependencies and allows classes to reach for unrelated services.

## When DI is useful

Use DI for required collaborators with a clear request/response relationship: a repository needs an HTTP client, a service needs a storage contract, or a view model needs an application service. Use events when the sender should announce a fact without knowing which independent consumers react. DI does not replace Flutter widget state management; providers such as `flueco_state_management` own that separate concern.

For tests, construct the class with a fake implementation directly. Use a test container only when testing provider registration or the application composition root. This keeps unit tests independent of GetIt and makes a missing dependency visible at construction time.

See [Service providers](service-providers.md), [Kernel and bootstrap](kernel-and-bootstrap.md), and the [`flueco_get_it` reference](../reference/packages/flueco_get_it.md).
