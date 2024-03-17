import 'dart:async';

import 'package:flueco/flueco.dart';
import 'package:flueco_auth/flueco_auth.dart';
import 'package:flueco_auth_token/flueco_auth_token.dart';

import '../../../foundation/abstractions/use_case.dart';
import '../../contracts/navigation_contracts.dart';

/// Use case for authentication
class AuthUseCase implements UseCase<void> {
  final Authenticator _authenticator;
  final DialogService _dialogService;
  final NavigateToHomeContract _navigator;

  /// Creates an instance of [AuthUseCase]
  AuthUseCase({
    required Authenticator authenticator,
    required DialogService dialogService,
    required NavigateToHomeContract navigator,
  })  : _authenticator = authenticator,
        _dialogService = dialogService,
        _navigator = navigator;

  AuthData? _data;

  /// Set the data used during auth
  void setData(AuthData? data) {
    _data = data;
  }

  @override
  Future<void> execute() async {
    final AuthData? data = _data;
    if (data == null) {
      throw InvalidAuthenticationCredentialsException();
    }

    unawaited(LoadingDialog.show(_dialogService));
    try {
      await _authenticator.authenticate(
        UsernamePasswordTokenAuthenticationCredentials(
          username: data.auth,
          password: data.password,
        ),
      );
      await LoadingDialog.hide(_dialogService);

      unawaited(
        _navigator.navigateToHome(
          replacementStrategy: RouteReplacementStrategy.all,
        ),
      );
    } catch (e) {
      await LoadingDialog.hide(_dialogService);
      rethrow;
    }
  }
}

/// Data used during auth
class AuthData {
  /// Auth / Email
  final String auth;

  /// Password / Code
  final String password;

  /// Creates an instance of [AuthData]
  const AuthData({
    required this.auth,
    required this.password,
  });
}
