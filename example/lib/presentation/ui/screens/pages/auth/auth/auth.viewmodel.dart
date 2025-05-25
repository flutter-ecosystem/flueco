import 'package:example/application/services/error_handler_service.dart';
import 'package:example/domain/use_cases/auth/auth.usecase.dart';
import 'package:example/foundation/helpers/validators.dart';
import 'package:flueco_state_management/flueco_state_management.dart'
    show ViewModel;
import 'package:flutter/material.dart';

import 'auth.viewstate.dart';

/// Viewmodel of Auth view
final class AuthViewModel extends ViewModel<AuthViewState> {
  /// Key for the authentication form
  final GlobalKey<FormState> formKey = GlobalKey();

  /// Email text field controller
  final TextEditingController emailController = TextEditingController();

  /// Password text field controller
  final TextEditingController passwordController = TextEditingController();

  /// Password focus node
  final FocusNode passwordFocusNode = FocusNode();

  final AuthUseCase _authUseCase;
  final ErrorHandler _errorHandler;

  /// Creates an instance of [AuthViewModel]
  AuthViewModel({
    required AuthUseCase authUseCase,
    required ErrorHandler errorHandler,
  })  : _authUseCase = authUseCase,
        _errorHandler = errorHandler,
        super(const AuthViewState.initial());

  /// Handle continue action
  void handleContinue() {
    if (formKey.currentState?.validate() == true) {
      _handleContinue();
    }
  }

  /// Validate email
  String? validateEmail(String? value) {
    final Validation validation = const Validators().validate(
      value,
      validators: <Validator>[
        const NotEmptyValidator(),
        const EmailValidator(),
      ],
    );
    if (validation.failed) {
      return validation.message;
    }

    return null;
  }

  /// Validate password
  String? validatePassword(String? value) {
    final Validation validation = const Validators().validate(
      value,
      validators: <Validator>[
        const NotEmptyValidator(),
      ],
    );
    if (validation.failed) {
      return validation.message;
    }

    return null;
  }

  Future<void> _handleContinue() async {
    _authUseCase.setData(AuthData(
      auth: emailController.text,
      password: passwordController.text,
    ));

    try {
      await _authUseCase.execute();
    } catch (e, s) {
      await _errorHandler.handleError(
        e,
        stackTrace: s,
        severity: ErrorSeverity.high,
      );
    }
  }
}
