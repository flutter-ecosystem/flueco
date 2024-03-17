import 'package:example/application/managers/auth/auth.manager.dart';
import 'package:example/application/services/app_installation_handler_service.dart';
import 'package:example/bootstrap/implementations/authentication_providers_factory.dart';
import 'package:example/bootstrap/implementations/flueco_auth_dio_interceptor.dart';
import 'package:example/bootstrap/implementations/navigation_key_provider.dart';
import 'package:example/bootstrap/implementations/token_authentication_handler_factory.dart';
import 'package:example/foundation/config/app_config.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flueco/flueco.dart';
import 'package:flueco_auth/flueco_auth.dart';
import 'package:flueco_auth_token/flueco_auth_token.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../presentation/routing/app_router.dart';

///
class DependenciesServiceProvider extends ServiceProvider {
  ///
  final AppConfig appConfig;

  ///
  DependenciesServiceProvider({
    required this.appConfig,
  });
  @override
  Set<Type> dependsOn() {
    return <Type>{};
  }

  @override
  Future<void> initialize(FluecoApp app) async {
    await app.resolver.resolve<AppInstallationHandler>().initialize();
    await app.resolver.resolve<ExampleFluecoAuthDioInterceptor>().initialize();
    await app.resolver.resolve<AuthManager>().initialize();
  }

  @override
  Future<void> register(ServiceInjector injector) async {
    injector
      ..lazySingleton<AppConfig>((_) => appConfig)
      ..lazySingleton<NavigatorKeyProvider>(
        (_) => ExampleNavigationKeyProvider(),
      )
      ..factory<DialogService>(
        (ServiceResolver resolver) => DialogService(
          navigatorKeyProvider: resolver.resolve<NavigatorKeyProvider>(),
        ),
      )
      ..factory<ModalService>(
        (ServiceResolver resolver) => ModalService(
          navigatorKeyProvider: resolver.resolve<NavigatorKeyProvider>(),
        ),
      )
      ..factory<ToastService>(
        (ServiceResolver resolver) => ToastService(
          navigatorKeyProvider: resolver.resolve<NavigatorKeyProvider>(),
        ),
      )
      ..factory<LoggerService>(
        (ServiceResolver resolver) => LoggerService(
          enable: resolver.resolve<AppConfig>().isDev,
        ),
      )

      /// Dependencies of [MessagingServiceProvider]
      ..lazySingleton<Messaging>((_) => Messaging())

      /// Dependencies of [AutoRouteServiceProvider]
      ..lazySingleton<AppRouter>(
        (ServiceResolver resolver) => AppRouter(
          resolverOfAuthenticator: () => resolver.resolve<Authenticator>(),
          navigatorKey: resolver.resolve<NavigatorKeyProvider>().navigatorKey,
        ),
      )
      ..factory<RootStackRouter>(
        (ServiceResolver resolver) => resolver.resolve<AppRouter>(),
      )

      /// Dependencies of [DioServiceProvider]
      ..factory<DioBaseOptionsProvider>(
        (ServiceResolver resolver) => DefaultDioBaseOptionsProvider(
          resolver.resolve<AppConfig>().apiBaseUrl ?? '',
        ),
      );

    /// Dependencies of [FluecoSharedPreferencesServiceProvider]
    await injector.singletonAsync<SharedPreferences>(
      (_) => SharedPreferences.getInstance(),
    );

    /// Dependencies of [FluecoHiveServiceProvider]
    injector
      ..lazySingleton<HiveBoxFactory>(
        (ServiceResolver resolver) => BasicHiveBoxFactory.fromEncryptionKey(
          resolver.resolve<AppConfig>().appEncryptionKey,
        ),
      )
      ..lazySingleton<HiveSecureStorageGetInstanceConfig>(
        (ServiceResolver resolver) => HiveSecureStorageGetInstanceConfig(
          boxName: 'woofbox',
          hiveBoxFactory: resolver.resolve<HiveBoxFactory>(),
        ),
      )

      /// Dependencies of [FluecoAuthProvider]
      ..lazySingleton<ExampleFluecoAuthDioInterceptor>(
        (ServiceResolver resolver) => ExampleFluecoAuthDioInterceptor(
          authenticator: () => resolver.resolve<Authenticator>(),
          dio: resolver.resolve<DioInstanceProvider>().dio,
        ),
      )
      ..lazySingleton<AuthenticationInterceptors>(
        (ServiceResolver resolver) => AuthenticationInterceptors(
          interceptors: <AuthenticationInterceptor>[
            resolver.resolve<ExampleFluecoAuthDioInterceptor>(),
          ],
        ),
      )
      ..lazySingleton<TokenAuthenticationHandlerFactory>(
        (ServiceResolver resolver) =>
            ExampleTokenAuthenticationHandlerFactory(),
      )
      ..lazySingleton<AuthenticationProvidersFactory>(
        (ServiceResolver resolver) => ExampleAuthenticationProvidersFactory(
          localStorageResolver: () => resolver.resolve<LocalStorage>(),
          secureStorageResolver: () => resolver.resolve<SecureStorage>(),
          tokenAuthenticationHandlerFactoryResolver: () =>
              resolver.resolve<TokenAuthenticationHandlerFactory>(),
        ),
      )

      /// Dependencies
      ..factory<DeviceInfoPlugin>(
        (_) => DeviceInfoPlugin(),
      );
    await injector.singletonAsync<PackageInfo>(
      (_) => PackageInfo.fromPlatform(),
    );
  }

  @override
  Set<Type> registered() {
    return <Type>{
      AppConfig,
      Messaging,
      AppRouter,
      RootStackRouter,
      DioBaseOptionsProvider,
      SharedPreferences,
      HiveBoxFactory,
      HiveSecureStorageGetInstanceConfig,
    };
  }
}
