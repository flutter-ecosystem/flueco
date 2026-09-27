# Service Providers

A `ServiceProvider` groups service registration and initialization for a feature or integration. Providers are passed to `FluecoKernel` and participate in two phases: `register(ServiceInjector)` and `initialize(FluecoApp)`.

Providers also implement `dependsOn()` to declare service types they require and `registered()` to identify the types they provide. The kernel uses these declarations to coordinate provider registration and initialization. Providers should report actual registrations and prerequisites accurately, and applications must include the dependencies those declarations name.

## Create an application-owned provider

You can create a `ServiceProvider` for application-specific setup; providers are not limited to Flueco packages. The repository example uses `InjectableServiceProvider` to connect generated `injectable` registrations to the same GetIt instance used by Flueco. The following excerpt is from [`example/lib/bootstrap/providers/injectable_service_provider.dart`](../../example/lib/bootstrap/providers/injectable_service_provider.dart):

```dart
const List<Type> _dependencies = <Type>[
  AppConfig,
  AppRouter,
  Authenticator,
  EventHandler,
  Messaging,
  ServiceInjector,
  ServiceResolver,
  DioInstanceProvider,
  SecureStorage,
  LocalStorage,
  DialogService,
  LoggerService,
  ModalService,
  ToastService,
  HiveBoxFactory,
];

@InjectableInit(ignoreUnregisteredTypes: _dependencies)
Future<GetIt> _initializeInjections(
  GetItInstanceProvider getItInstanceProvider,
  String environment,
) =>
    getItInstanceProvider.getIt.init(environment: environment);

class InjectableServiceProvider extends ServiceProvider {
  final GetItServiceContainer _container;
  final String _environment;

  InjectableServiceProvider({
    required GetItServiceContainer container,
    required String environment,
  })  : _container = container,
        _environment = environment;

  @override
  Set<Type> dependsOn() => <Type>{
        ..._dependencies,
      };

  @override
  Future<void> register(ServiceInjector injector) async {
    injector.singleton<GetItServiceContainer>(
      (_) => _container,
    );
    await _initializeInjections(_container, _environment);
  }

  @override
  Future<void> initialize(FluecoApp app) async {
    // Generated dependencies are registered during register().
  }

  @override
  Set<Type> registered() => <Type>{GetItServiceContainer};
}
```

Here, `_dependencies` serves two related purposes: `@InjectableInit` tells the generator which types are supplied externally, and `dependsOn()` declares the service types this provider expects to exist before it runs. `_initializeInjections` calls the generated GetIt initializer for the selected environment. The provider also registers the shared `GetItServiceContainer` through Flueco's injector; `registered()` reports that direct Flueco registration.

Add the provider to the kernel's provider set. The example passes the same container and the environment selected by application configuration:

```dart
final providers = <ServiceProvider>{
  // Other providers supply the types listed in _dependencies.
  InjectableServiceProvider(
    container: container,
    environment: appConfig.environment.name,
  ),
};
```

The example's [kernel](../../example/lib/bootstrap/kernel.dart) includes this provider alongside the Flueco adapters. Keep platform setup and external configuration at the composition root or in a dedicated prerequisite provider. When changing generated dependencies, update the external-type list and regenerate the Injectable configuration as required by the app's build workflow.

## Registration and initialization

Use `register()` to make factories or instances resolvable. Use `initialize()` for asynchronous work that must happen after registrations are available, such as opening storage or loading persisted configuration. The kernel awaits both phases.

`dependsOn()` names service types, not package names. A provider depending on `LocalStorage` declares that contract; the composition root chooses which adapter satisfies it. `registered()` should include the types downstream providers need. Since providers are supplied as a `Set`, never use insertion order as a dependency mechanism. Include required instances/configuration and test bootstrap with the complete set. Missing or circular prerequisites are composition errors to diagnose explicitly.

Adapters generally provide their own `ServiceProvider`. Check the [package catalog](../reference/packages.md) for required configuration and dependencies. See [Dependency injection](dependency-injection.md) for registration and resolution contracts.
