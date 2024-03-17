import 'package:example/foundation/config/app_config.dart';
import 'package:flueco/flueco.dart' hide Hive;
import 'package:flueco_auth/flueco_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../foundation/localizations/localizations.dart';
import '../presentation/ui/app.dart';
import '../presentation/ui/theming/theme.dart';
import 'providers/dependencies_service_provider.dart';
import 'providers/injectable_service_provider.dart';

final GetItServiceContainer _container = GetItServiceContainer();

///
class Kernel {
  ///
  final AppConfig appConfig;

  final FluecoKernel _fluecoKernel;

  ///
  Kernel({
    required this.appConfig,
  }) : _fluecoKernel = FluecoKernel(
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
            FluecoAuthProvider(
              populateOnInitialization: true,
            ),
          },
        );

  Future<void> _ensureInitialized() async {
    // Initialize widgets
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize translations
    await EasyLocalization.ensureInitialized();
  }

  /// Proceed to all initialization
  Future<void> bootstrap() async {
    await _ensureInitialized();

    await Hive.initFlutter();

    await _fluecoKernel.bootstrap();
  }

  /// Global service container
  ServiceContainer get container => _container;

  /// Run the application
  void run() {
    if (!appConfig.isTest) {
      _run();
    }
  }

  void _run() {
    runApp(
      build(const App()),
    );
  }

  /// Build [app] surrounded by all necessary widgets
  Widget build(Widget app) {
    return EasyLocalization(
      fallbackLocale: fallbackLocale,
      supportedLocales: supportedLocales,
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),
      child: Flueco(
        kernel: _fluecoKernel,
        child: app,
      ),
    );
  }
}
