# Kernel and Bootstrap

`FluecoKernel` coordinates application startup. Its `bootstrap()` method optionally ensures Flutter bindings are initialized, registers the core application and registries, asks service providers to register their services, registers registry handlers, and then initializes providers.

Await `bootstrap()` before `runApp` so services are ready before widgets request them. `ensureInitialized` defaults to `true` and invokes `WidgetsFlutterBinding.ensureInitialized()`; set it to `false` only when the application already performs the required Flutter initialization.

The `flueco` package provides a convenience `FluecoKernel` with default log and notification registries, then emits app bootstrap and first-build events through the registered `EventHandler`. Its `Flueco` root widget additionally provides the app/kernel to descendants and installs messaging lifecycle and toast wrappers. These conveniences still require their dependencies to be registered. With `flueco_core` directly, the core kernel requires explicit `LogRegistry` and `NotificationRegistry` instances and does not add the bundle's UI services.

## Startup phases

1. Initialize Flutter and any plugins that require setup before use.
2. The kernel registers `FluecoApp`, `LogRegistry`, and `NotificationRegistry` in the container.
3. Provider `register()` methods add factories and instances.
4. Registry handlers are connected to the resolver.
5. Provider `initialize()` methods perform asynchronous work using `FluecoApp`.
6. The application builds its root widget tree.

Providers receive `FluecoApp` only after registration has completed, so initialization can resolve other registered services. Flueco does not replace platform-specific setup that must happen before bootstrap.

```dart
final kernel = FluecoKernel(
  container: GetItServiceContainer(),
  serviceProviders: configuredProviders,
);
await kernel.bootstrap();
runApp(const MyApp());
```

The kernel coordinates providers; it does not infer which features the application needs. Providers are supplied as a `Set`, so do not rely on insertion order. Declare dependencies with each provider's `dependsOn()` and ensure those prerequisite services/configuration are actually supplied. The [example kernel](https://github.com/flutter-ecosystem/flueco/blob/main/example/lib/bootstrap/kernel.dart) demonstrates initialization outside Flueco itself. See [Service providers](service-providers.md) and [Dependency injection](dependency-injection.md).
