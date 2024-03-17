import 'package:flueco/flueco.dart';
import 'package:flueco_auth/flueco_auth.dart';
import 'package:injectable/injectable.dart';

import '../../domain/contracts/navigation_contracts.dart';
import '../../domain/use_cases/auth/auth.usecase.dart';
import '../../domain/use_cases/logout/logout.usecase.dart';

/// Module to inject dependencies
@module
abstract class DomainModule {
  /// Creates [AuthUseCase]
  @injectable
  AuthUseCase authUseCase({
    required DialogService dialogService,
    required NavigateToHomeContract navigator,
    required Authenticator authenticator,
  }) =>
      AuthUseCase(
        dialogService: dialogService,
        navigator: navigator,
        authenticator: authenticator,
      );

  /// Creates [LogoutUseCase]
  @injectable
  LogoutUseCase logoutUseCase({
    required DialogService dialogService,
    required NavigateToHomeContract navigator,
    required Authenticator authenticator,
  }) =>
      LogoutUseCase(
        dialogService: dialogService,
        navigator: navigator,
        authenticator: authenticator,
      );
}
