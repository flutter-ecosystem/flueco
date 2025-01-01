// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_info_plus/device_info_plus.dart' as _i833;
import 'package:example/application/managers/auth/auth.manager.dart' as _i227;
import 'package:example/application/services/app_installation_handler_service.dart'
    as _i470;
import 'package:example/application/services/device_info_provider.dart'
    as _i473;
import 'package:example/application/services/error_handler_service.dart'
    as _i711;
import 'package:example/application/services/navigation_service.dart' as _i927;
import 'package:example/bootstrap/injections/application.module.dart' as _i923;
import 'package:example/bootstrap/injections/data.module.dart' as _i164;
import 'package:example/bootstrap/injections/domain.module.dart' as _i689;
import 'package:example/data/sources/local/db/auth_db.dart' as _i664;
import 'package:example/data/sources/local/db/db_initializer.dart' as _i467;
import 'package:example/data/sources/local/db/users_db.dart' as _i140;
import 'package:example/data/sources/remote/http/clients/auth_http_client.dart'
    as _i93;
import 'package:example/data/sources/remote/http/clients/installation_http_client.dart'
    as _i15;
import 'package:example/data/sources/remote/http/clients/users_http_client.dart'
    as _i128;
import 'package:example/domain/contracts/navigation_contracts.dart' as _i1064;
import 'package:example/domain/use_cases/auth/auth.usecase.dart' as _i543;
import 'package:example/domain/use_cases/logout/logout.usecase.dart' as _i824;
import 'package:example/presentation/routing/app_router.dart' as _i966;
import 'package:flueco/flueco.dart' as _i265;
import 'package:flueco_auth/flueco_auth.dart' as _i873;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:package_info_plus/package_info_plus.dart' as _i655;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final applicationModule = _$ApplicationModule();
    final dataModule = _$DataModule();
    final domainModule = _$DomainModule();
    gh.factory<_i711.ErrorHandler>(() => applicationModule.errorHandler(
          dialogService: gh<_i265.DialogService>(),
          loggerService: gh<_i265.LoggerService>(),
        ));
    gh.lazySingleton<_i927.NavigationService>(
        () => applicationModule.navigationService(gh<_i966.AppRouter>()));
    gh.factory<_i93.AuthHttpClient>(
        () => dataModule.authHttpClient(gh<_i265.DioInstanceProvider>()));
    gh.factory<_i128.UsersHttpClient>(
        () => dataModule.usersHttpClient(gh<_i265.DioInstanceProvider>()));
    gh.factory<_i15.InstallationHttpClient>(() =>
        dataModule.installationHttpClient(gh<_i265.DioInstanceProvider>()));
    await gh.singletonAsync<_i467.DBInitializer>(
      () => dataModule.dBInitializer(gh<_i265.HiveBoxFactory>()),
      preResolve: true,
    );
    gh.factory<_i140.UsersDB>(
        () => dataModule.usersDB(gh<_i467.DBInitializer>()));
    await gh.singletonAsync<_i473.DeviceInfoProvider>(
      () => applicationModule.deviceInfoProvider(
        gh<_i833.DeviceInfoPlugin>(),
        gh<_i655.PackageInfo>(),
      ),
      preResolve: true,
    );
    gh.factory<_i1064.NavigateToAuthContract>(() => applicationModule
        .navigateToAuthContract(gh<_i927.NavigationService>()));
    gh.factory<_i1064.NavigateToHomeContract>(() => applicationModule
        .navigateToHomeContract(gh<_i927.NavigationService>()));
    gh.factory<_i664.AuthDB>(
        () => dataModule.authDB(gh<_i265.SecureStorage>()));
    gh.factory<_i227.AuthUserProvider>(() => applicationModule.authUserProvider(
          usersDB: gh<_i140.UsersDB>(),
          authDB: gh<_i664.AuthDB>(),
          usersHttpClient: gh<_i128.UsersHttpClient>(),
        ));
    gh.factory<_i543.AuthUseCase>(() => domainModule.authUseCase(
          dialogService: gh<_i265.DialogService>(),
          navigator: gh<_i1064.NavigateToHomeContract>(),
          authenticator: gh<_i873.Authenticator>(),
        ));
    gh.factory<_i824.LogoutUseCase>(() => domainModule.logoutUseCase(
          dialogService: gh<_i265.DialogService>(),
          navigator: gh<_i1064.NavigateToHomeContract>(),
          authenticator: gh<_i873.Authenticator>(),
        ));
    gh.lazySingleton<_i227.AuthManager>(() => applicationModule.authManager(
          authenticator: gh<_i873.Authenticator>(),
          authUserProvider: gh<_i227.AuthUserProvider>(),
          eventHandler: gh<_i265.EventHandler>(),
          errorHandler: gh<_i711.ErrorHandler>(),
        ));
    gh.lazySingleton<_i470.AppInstallationHandler>(
        () => applicationModule.appInstallationHandler(
              dioInstanceProvider: gh<_i265.DioInstanceProvider>(),
              installationHttpClient: gh<_i15.InstallationHttpClient>(),
              localStorage: gh<_i265.LocalStorage>(),
              deviceInfoProvider: gh<_i473.DeviceInfoProvider>(),
            ));
    return this;
  }
}

class _$ApplicationModule extends _i923.ApplicationModule {}

class _$DataModule extends _i164.DataModule {}

class _$DomainModule extends _i689.DomainModule {}
