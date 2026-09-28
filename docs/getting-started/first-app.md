# Bootstrap Your Application

The composition root decides which Flueco services are available. It constructs the container, registers prerequisite instances/configuration, chooses providers, bootstraps the kernel, and only then starts the widget tree. Platform initialization required by plugins belongs here too; ordinary feature classes should not construct plugin clients or the service container themselves.

The example's `Kernel` is an application-owned wrapper around Flueco's `FluecoKernel`. It centralizes the container, selected providers, platform initialization, and root-widget construction. Here is the relevant class from [`example/lib/bootstrap/kernel.dart`](https://github.com/flutter-ecosystem/flueco/blob/main/example/lib/bootstrap/kernel.dart):

```dart
import 'package:example/foundation/config/app_config.dart';
import 'package:flueco/flueco.dart' hide Hive;
import 'package:flueco_auth/flueco_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import '../foundation/localizations/localizations.dart';
import '../presentation/ui/app.dart';
import '../presentation/ui/theming/theme.dart';
import 'providers/dependencies_service_provider.dart';
import 'providers/injectable_service_provider.dart';

final GetItServiceContainer _container = GetItServiceContainer();

class Kernel {
  final AppConfig appConfig;
  final FluecoKernel _fluecoKernel;

  Kernel({required this.appConfig})
      : _fluecoKernel = FluecoKernel(
          container: _container,
          serviceProviders: <ServiceProvider>{
            DependenciesServiceProvider(appConfig: appConfig),
            AutoRouteServiceProvider(),
            MessagingServiceProvider(),
            DioServiceProvider(),
            FluecoSharedPreferencesServiceProvider(),
            FluecoHiveServiceProvider(),
            ThemingServiceProvider(
              config: ThemingConfig(
                selectedAppearanceKey: defaultAppearance.key,
                appearances: <Appearance>{defaultAppearance},
              ),
            ),
            InjectableServiceProvider(
              container: _container,
              environment: appConfig.environment.name,
            ),
            FluecoAuthProvider(populateOnInitialization: true),
          },
        );

  Future<void> _ensureInitialized() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
  }

  Future<void> bootstrap() async {
    await _ensureInitialized();
    await Hive.initFlutter();
    await _fluecoKernel.bootstrap();
  }

  void run() {
    if (!appConfig.isTest) {
      runApp(build(const App()));
    }
  }

  Widget build(Widget app) {
    return EasyLocalization(
      fallbackLocale: fallbackLocale,
      supportedLocales: supportedLocales,
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),
      child: Flueco(kernel: _fluecoKernel, child: app),
    );
  }
}
```

The application entrypoint stays small because that custom class owns setup:

```dart
import 'package:example/bootstrap/kernel.dart';
import 'package:example/foundation/config/app_config.dart';

Future<void> main() async {
  final Kernel kernel = Kernel(appConfig: AppConfig.fromEnvironment());
  await kernel.bootstrap();
  kernel.run();
}
```

This code is from the repository example, not a minimal template: its imports and providers depend on that app's localization, theme, generated router, authentication, and injectable setup. The custom class provides a useful pattern, while its [`DependenciesServiceProvider`](https://github.com/flutter-ecosystem/flueco/blob/main/example/lib/bootstrap/providers/dependencies_service_provider.dart) registers prerequisites such as `Messaging`, `RootStackRouter`, Dio options, storage configuration, and auth factories before feature providers initialize.

When composing a different app, reproduce the same responsibilities with only the providers you need: initialize platform plugins as required, register adapter prerequisites, declare the provider set, await `bootstrap()`, then build the widget tree. The bundle's `Flueco` root widget expects `Messaging` to be resolvable. Read [Kernel and bootstrap](../concepts/kernel-and-bootstrap.md), [Service providers](../concepts/service-providers.md), and the [package catalog](../reference/packages.md) before assembling integrations.
