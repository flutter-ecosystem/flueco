import 'dart:async';

import 'package:example/application/managers/auth/auth.event.dart';
import 'package:example/application/services/error_handler_service.dart';
import 'package:example/domain/entities/user.dart';
import 'package:flueco/flueco.dart';
import 'package:flueco_auth/flueco_auth.dart';

import 'auth.state.dart';

/// Manager of authentication
final class AuthManager extends StateNotifier<AuthState>
    implements EventSubscriber {
  final Authenticator _authenticator;
  final AuthUserProvider _authUserProvider;
  final EventHandler _eventHandler;
  final ErrorHandler _errorHandler;

  /// Creates an instance of [AuthManager]
  AuthManager({
    required Authenticator authenticator,
    required AuthUserProvider authUserProvider,
    required EventHandler eventHandler,
    required ErrorHandler errorHandler,
  })  : _authenticator = authenticator,
        _authUserProvider = authUserProvider,
        _eventHandler = eventHandler,
        _errorHandler = errorHandler,
        super(
          AuthState(
            authentication: authenticator.authentication,
            user: null,
          ),
        );

  /// Wether we are authenticated
  bool get authenticated =>
      state.authentication != null || _authenticator.authentication != null;

  @override
  void dispose() {
    _eventHandler.unsubscribeAll(this);

    super.dispose();
  }

  /// Initialize this manager
  Future<void> initialize() async {
    _eventHandler
      ..subscribe(AuthenticateEndEvent, this)
      ..subscribe(RefreshEndEvent, this)
      ..subscribe(InvalidateEndEvent, this)
      ..subscribe(PopulateEndEvent, this);
  }

  @override
  Future<void> onEvent(Event event) async {
    if (event is AuthenticateEndEvent) {
      final Authentication? authentication = event.authentication;
      if (authentication != null) {
        await _handleAuthentication(authentication: authentication);
      }
    }

    if (event is PopulateEndEvent) {
      final Authentication? authentication = _authenticator.authentication;
      if (authentication != null) {
        await _handleAuthentication(authentication: authentication);
      }
    }

    if (event is RefreshEndEvent) {
      final Authentication? authentication = event.authentication;
      if (authentication != null) {
        await _handleAuthentication(authentication: authentication);
      } else {
        await _logout();
      }
    }

    if (event is InvalidateEndEvent) {
      if (event.hasError == false) {
        await _logout();
      }
    }
  }

  Future<void> _handleAuthentication({
    required Authentication authentication,
  }) async {
    setState(state.copyWith(authentication: authentication));

    try {
      final User user = await _authUserProvider.getAuthUser();
      setState(state.copyWith(user: user));
      _eventHandler.emit(AuthUserRefreshEvent(user: user));
    } catch (e, s) {
      unawaited(_logout());
      unawaited(_errorHandler.handleError(e, stackTrace: s));
    }
  }

  Future<void> _logout() async {
    // TODO: Call use case of logout and await its end
    setState(const AuthState.initial());
  }
}

/// Provider for authenticated user
interface class AuthUserProvider {
  /// Get authentication user
  Future<User> getAuthUser() async {
    throw UnimplementedError();
  }
}
