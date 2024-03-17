import 'package:example/application/services/app_installation_handler_service.dart';
import 'package:example/application/services/device_info_provider.dart';
import 'package:example/application/services/error_handler_service.dart';
import 'package:example/application/services/navigation_service.dart';
import 'package:example/bootstrap/implementations/auth_user_provider.dart';
import 'package:example/data/sources/remote/http/clients/installation_http_client.dart';
import 'package:example/domain/contracts/navigation_contracts.dart';
import 'package:example/presentation/routing/app_router.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flueco/flueco.dart';
import 'package:flueco_auth/flueco_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../application/managers/auth/auth.manager.dart';
import '../../data/sources/local/db/auth_db.dart';
import '../../data/sources/local/db/users_db.dart';
import '../../data/sources/remote/http/clients/users_http_client.dart';

/// Module to inject dependencies
@module
abstract class ApplicationModule {
  /// Creates [ErrorHandler]
  @injectable
  ErrorHandler errorHandler({
    required DialogService dialogService,
    required LoggerService loggerService,
  }) =>
      ErrorHandler(
        dialogService: dialogService,
        loggerService: loggerService,
      );

  /// Creates [NavigationService]
  @lazySingleton
  NavigationService navigationService(AppRouter appRouter) => NavigationService(
        appRouter: appRouter,
      );

  /// Creates [NavigateToAuthContract]
  @injectable
  NavigateToAuthContract navigateToAuthContract(
    NavigationService navigationService,
  ) =>
      navigationService;

  /// Creates [NavigateToHomeContract]
  @injectable
  NavigateToHomeContract navigateToHomeContract(
    NavigationService navigationService,
  ) =>
      navigationService;

  /// Creates [DeviceInfoProvider]
  @preResolve
  @singleton
  Future<DeviceInfoProvider> deviceInfoProvider(
    DeviceInfoPlugin deviceInfoPlugin,
    PackageInfo packageInfo,
  ) =>
      DeviceInfoProvider.create(
        infoPlugin: deviceInfoPlugin,
        packageInfo: packageInfo,
      );

  /// Creates [AppInstallationHandler]
  @lazySingleton
  AppInstallationHandler appInstallationHandler({
    required DioInstanceProvider dioInstanceProvider,
    required InstallationHttpClient installationHttpClient,
    required LocalStorage localStorage,
    required DeviceInfoProvider deviceInfoProvider,
  }) =>
      AppInstallationHandler(
        dio: dioInstanceProvider.dio,
        client: installationHttpClient,
        localStorage: localStorage,
        deviceInfoProvider: deviceInfoProvider,
      );

  /// Creates [AuthUserProvider]
  @injectable
  AuthUserProvider authUserProvider({
    required UsersDB usersDB,
    required AuthDB authDB,
    required UsersHttpClient usersHttpClient,
  }) =>
      ExampleAuthUserProvider(
        usersDB: usersDB,
        authDB: authDB,
        usersHttpClient: usersHttpClient,
      );

  /// Creates [AuthManager]
  @lazySingleton
  AuthManager authManager({
    required Authenticator authenticator,
    required AuthUserProvider authUserProvider,
    required EventHandler eventHandler,
    required ErrorHandler errorHandler,
  }) =>
      AuthManager(
        authenticator: authenticator,
        authUserProvider: authUserProvider,
        eventHandler: eventHandler,
        errorHandler: errorHandler,
      );
}
