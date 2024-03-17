import 'dart:async';

import 'package:flueco/flueco.dart';
import 'package:flueco_auth/flueco_auth.dart';

import '../../../foundation/abstractions/use_case.dart';
import '../../../foundation/localizations/localizations.dart';
import '../../contracts/navigation_contracts.dart';

/// Use case for logout
final class LogoutUseCase implements UseCase<void> {
  final Authenticator _authenticator;
  final DialogService _dialogService;
  final NavigateToHomeContract _navigator;

  /// Creates an instance of [LogoutUseCase]
  LogoutUseCase({
    required Authenticator authenticator,
    required DialogService dialogService,
    required NavigateToHomeContract navigator,
  })  : _authenticator = authenticator,
        _dialogService = dialogService,
        _navigator = navigator;

  @override
  Future<void> execute() async {
    final confirmed = await _dialogService.confirm(
      data: ConfirmDialogData(
        title: LocaleKeys.logout.tr(),
        content: LocaleKeys.logoutConfirmationMessage.tr(),
      ),
    );

    if (confirmed != true) return;

    unawaited(LoadingDialog.show(_dialogService));
    try {
      final authentication = _authenticator.authentication;
      if (authentication != null) {
        await _authenticator.invalidate(authentication);
      }
      await LoadingDialog.hide(_dialogService);

      // Could also navigate to login
      // what it is more appropriate
      // but with the route guard
      // navigating to home will automatically
      // redirect to login. What allows us to test
      // that the logout succeed in the [Authenticator]
      // package.
      _navigator.navigateToHome(
        replacementStrategy: RouteReplacementStrategy.all,
      );
    } catch (e) {
      await LoadingDialog.hide(_dialogService);
      rethrow;
    }
  }
}
