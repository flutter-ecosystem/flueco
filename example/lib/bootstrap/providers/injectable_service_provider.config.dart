// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_info_plus/device_info_plus.dart' as _i8;
import 'package:example/application/managers/auth/auth.manager.dart' as _i17;
import 'package:example/application/services/app_installation_handler_service.dart'
    as _i16;
import 'package:example/application/services/device_info_provider.dart' as _i7;
import 'package:example/application/services/error_handler_service.dart'
    as _i10;
import 'package:example/application/services/navigation_service.dart' as _i12;
import 'package:example/bootstrap/injections/application.module.dart' as _i23;
import 'package:example/bootstrap/injections/data.module.dart' as _i22;
import 'package:example/bootstrap/injections/domain.module.dart' as _i24;
import 'package:example/data/sources/local/db/auth_db.dart' as _i3;
import 'package:example/data/sources/local/db/db_initializer.dart' as _i6;
import 'package:example/data/sources/local/db/users_db.dart' as _i14;
import 'package:example/data/sources/remote/http/clients/auth_http_client.dart'
    as _i5;
import 'package:example/data/sources/remote/http/clients/installation_http_client.dart'
    as _i11;
import 'package:example/data/sources/remote/http/clients/users_http_client.dart'
    as _i15;
import 'package:example/domain/contracts/navigation_contracts.dart' as _i18;
import 'package:example/domain/use_cases/auth/auth.usecase.dart' as _i20;
import 'package:example/domain/use_cases/logout/logout.usecase.dart' as _i21;
import 'package:example/presentation/routing/app_router.dart' as _i13;
import 'package:flueco/flueco.dart' as _i4;
import 'package:flueco_auth/flueco_auth.dart' as _i19;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i9;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dataModule = _$DataModule();
    final applicationModule = _$ApplicationModule();
    final domainModule = _$DomainModule();
    gh.factory<_i3.AuthDB>(() => dataModule.authDB(gh<_i4.SecureStorage>()));
    gh.factory<_i5.AuthHttpClient>(
        () => dataModule.authHttpClient(gh<_i4.DioInstanceProvider>()));
    await gh.singletonAsync<_i6.DBInitializer>(
      () => dataModule.dBInitializer(gh<_i4.HiveBoxFactory>()),
      preResolve: true,
    );
    await gh.singletonAsync<_i7.DeviceInfoProvider>(
      () => applicationModule.deviceInfoProvider(
        gh<_i8.DeviceInfoPlugin>(),
        gh<_i9.PackageInfo>(),
      ),
      preResolve: true,
    );
    gh.factory<_i10.ErrorHandler>(() => applicationModule.errorHandler(
          dialogService: gh<_i4.DialogService>(),
          loggerService: gh<_i4.LoggerService>(),
        ));
    gh.factory<_i11.InstallationHttpClient>(
        () => dataModule.installationHttpClient(gh<_i4.DioInstanceProvider>()));
    gh.lazySingleton<_i12.NavigationService>(
        () => applicationModule.navigationService(gh<_i13.AppRouter>()));
    gh.factory<_i14.UsersDB>(() => dataModule.usersDB(gh<_i6.DBInitializer>()));
    gh.factory<_i15.UsersHttpClient>(
        () => dataModule.usersHttpClient(gh<_i4.DioInstanceProvider>()));
    gh.lazySingleton<_i16.AppInstallationHandler>(
        () => applicationModule.appInstallationHandler(
              dioInstanceProvider: gh<_i4.DioInstanceProvider>(),
              installationHttpClient: gh<_i11.InstallationHttpClient>(),
              localStorage: gh<_i4.LocalStorage>(),
              deviceInfoProvider: gh<_i7.DeviceInfoProvider>(),
            ));
    gh.factory<_i17.AuthUserProvider>(() => applicationModule.authUserProvider(
          usersDB: gh<_i14.UsersDB>(),
          authDB: gh<_i3.AuthDB>(),
          usersHttpClient: gh<_i15.UsersHttpClient>(),
        ));
    gh.factory<_i18.NavigateToAuthContract>(() =>
        applicationModule.navigateToAuthContract(gh<_i12.NavigationService>()));
    gh.factory<_i18.NavigateToHomeContract>(() =>
        applicationModule.navigateToHomeContract(gh<_i12.NavigationService>()));
    gh.lazySingleton<_i17.AuthManager>(() => applicationModule.authManager(
          authenticator: gh<_i19.Authenticator>(),
          authUserProvider: gh<_i17.AuthUserProvider>(),
          eventHandler: gh<_i4.EventHandler>(),
          errorHandler: gh<_i10.ErrorHandler>(),
        ));
    gh.factory<_i20.AuthUseCase>(() => domainModule.authUseCase(
          dialogService: gh<_i4.DialogService>(),
          navigator: gh<_i18.NavigateToHomeContract>(),
          authenticator: gh<_i19.Authenticator>(),
        ));
    gh.factory<_i21.LogoutUseCase>(() => domainModule.logoutUseCase(
          dialogService: gh<_i4.DialogService>(),
          navigator: gh<_i18.NavigateToHomeContract>(),
          authenticator: gh<_i19.Authenticator>(),
        ));
    return this;
  }
}

class _$DataModule extends _i22.DataModule {}

class _$ApplicationModule extends _i23.ApplicationModule {}

class _$DomainModule extends _i24.DomainModule {}
