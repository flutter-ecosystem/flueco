# Manual Installation

Use this guide to create a Flutter project yourself, select its Flueco dependencies, and connect their services at startup. To generate a ready-to-customize project from the repository example instead, use [Flueco CLI](create-an-app.md).

Manual setup has two parts: add the package set that matches your app, then compose and bootstrap the services those packages provide. Adding a dependency alone does not register its services.

## 1. Check prerequisites

Install a current Flutter SDK, which includes Dart. Flueco packages currently declare Dart SDK `>=3.6.0 <4.0.0`; Flutter packages also declare Flutter `>=3.0.0`. Check individual package manifests and the [compatibility table](../reference/compatibility.md) for the versions you select.

## 2. Create a Flutter project

Create a standard Flutter application and enter its directory:

```shell
flutter create my_app --org com.example --platforms android,ios,web
cd my_app
```

Choose only the platforms your app supports. If you already have a Flutter project, continue from its root directory.

## 3. Choose and install packages

For the integrated app bundle, add `flueco`:

```shell
flutter pub add flueco
```

The bundle includes `flueco_core` and selected adapters for GetIt, Dio, AutoRoute, Hive, shared preferences, messaging, and theming. Add optional packages separately when needed. For example:

```shell
flutter pub add flueco_auth flueco_auth_token flueco_auth_dio_interceptor
flutter pub add flueco_state_management
```

For a smaller or more customized dependency surface, compose core and individual integrations instead:

```shell
flutter pub add flueco_core flueco_get_it flueco_dio flueco_auto_route
```

Add only adapters and optional features the app uses. `flueco_cli` is a project-generation tool, not a runtime dependency. Use the [package catalog](../reference/packages.md) and package reference pages to check each package's prerequisites, exports, and limitations.

## 4. Configure adapter prerequisites

Each adapter needs a provider and may need prerequisite instances or configuration in the service container. For example, Dio needs `DioBaseOptionsProvider`, AutoRoute needs a configured `RootStackRouter`, messaging needs a `Messaging` instance, shared preferences needs a `SharedPreferences` instance, and Hive needs its box configuration.

Initialize platform plugins before bootstrapping when required. For example, call `WidgetsFlutterBinding.ensureInitialized()` and `Hive.initFlutter()` before Hive storage initialization. Keep platform setup and app-specific configuration in the composition root, not in feature widgets.

This provider excerpt shows an app service consuming Flueco's HTTP contract. `DioServiceProvider` or another HTTP adapter must register `HttpClient` as a prerequisite:

```dart
import 'package:flueco/flueco.dart';

class ProfileService {
 final HttpClient _httpClient;

 ProfileService(this._httpClient);

 Future<Map<String, dynamic>?> loadProfile() async {
  final HttpResponse<Map<String, dynamic>> response =
    await _httpClient.get<Map<String, dynamic>>('/profile');
  return response.data;
 }
}

class ProfileServiceProvider extends ServiceProvider {
 @override
 Future<void> register(ServiceInjector injector) async {
  injector.lazySingleton<ProfileService>(
   (ServiceResolver resolver) =>
     ProfileService(resolver.resolve<HttpClient>()),
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

You do not need one provider per service. Group related registrations when they share configuration or lifecycle, and accurately report provider prerequisites with `dependsOn()` and registered types with `registered()`. The kernel does not guarantee provider insertion order.

## 5. Compose and bootstrap the kernel

Create a service container and pass the providers your app needs to `FluecoKernel`. An app-owned prerequisite provider registers instances needed by the selected adapters, such as the root router, messaging bus, Dio options, and plugin-backed storage configuration.

```dart
Future<void> main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await Hive.initFlutter(); // Only when using Hive.

 final GetItServiceContainer container = GetItServiceContainer();
 final FluecoKernel kernel = FluecoKernel(
  container: container,
  serviceProviders: <ServiceProvider>{
   AppDependenciesServiceProvider(),
   MessagingServiceProvider(),
   AutoRouteServiceProvider(),
   DioServiceProvider(),
   ProfileServiceProvider(),
  },
 );

 await kernel.bootstrap();
 runApp(Flueco(kernel: kernel, child: const MyApp()));
}
```

`AppDependenciesServiceProvider` is app-owned and must register prerequisites for these providers; for example, `Messaging`, `RootStackRouter`, and `DioBaseOptionsProvider`. Keep only providers that the application uses. `Flueco` also expects a resolvable messaging service and a configured navigator/router for navigation-backed UI services. If using `flueco_core` without the bundle, provide explicit `LogRegistry` and `NotificationRegistry` implementations to its kernel.

The example app centralizes these responsibilities in its own `Kernel` class. Its entrypoint then stays small:

```dart
Future<void> main() async {
 final Kernel kernel = Kernel(appConfig: AppConfig.fromEnvironment());
 await kernel.bootstrap();
 kernel.run();
}
```

The example-specific [`Kernel`](https://github.com/flutter-ecosystem/flueco/blob/main/example/lib/bootstrap/kernel.dart) and [`DependenciesServiceProvider`](https://github.com/flutter-ecosystem/flueco/blob/main/example/lib/bootstrap/providers/dependencies_service_provider.dart) demonstrate plugin initialization, prerequisite registration, and provider composition. Adapt them to your own services; do not copy the example's full provider set blindly.

## 6. Use contracts and verify the app

Inject core contracts such as `HttpClient`, `LocalStorage`, `SecureStorage`, or `Router` into application classes. This lets the app choose or replace adapters at startup without coupling features to a concrete library. Prefer constructor injection; resolve from the widget tree only at UI boundaries below the Flueco root.

1. Run `flutter pub get` and confirm versions against [compatibility](../reference/compatibility.md).
2. Verify every provider prerequisite is registered and each provider's `dependsOn()` and `registered()` declarations are accurate.
3. Run `flutter analyze` and `flutter test`.
4. Run the app on each target platform and exercise startup, navigation, and configured persistence/network integrations.
5. Keep production secrets out of source control and compile-time defines; use an appropriate backend or platform key-management design.

Continue with [Kernel and bootstrap](../concepts/kernel-and-bootstrap.md), [Service providers](../concepts/service-providers.md), [Dependency injection](../concepts/dependency-injection.md), and the [package catalog](../reference/packages.md).
