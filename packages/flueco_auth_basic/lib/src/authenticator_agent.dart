import 'package:flueco_auth/flueco_auth.dart';
import 'authentication_credentials.dart';
import 'authentication.dart';

/// Authentication handler
abstract class BasicAuthenticationHandler {
  /// Handle the [credentials]
  Future<BasicAuthentication> handle(
      BasicAuthenticationCredentials credentials);
}

/// Factory class used to create a new [BasicAuthenticationHandler]
abstract class BasicAuthenticationHandlerFactory {
  /// Creates an instance of [BasicAuthenticationHandler]
  BasicAuthenticationHandler create();
}

/// Agent used to authenticate using a token.
class BasicAuthenticatorAgent extends AuthenticatorAgent {
  final BasicAuthenticationHandlerFactory _authenticationHandlerFactory;

  /// Creates an instance of [BasicAuthenticatorAgent]
  BasicAuthenticatorAgent(
      {required BasicAuthenticationHandlerFactory authenticationHandlerFactory})
      : _authenticationHandlerFactory = authenticationHandlerFactory;
  @override
  Future<Authentication> authenticate(
      AuthenticationCredentials credentials) async {
    if (credentials is! BasicAuthenticationCredentials) {
      throw InvalidAuthenticationCredentialsException();
    }

    final handler = _authenticationHandlerFactory.create();

    try {
      return handler.handle(credentials);
    } catch (e, s) {
      throw AuthenticateOperationException(
        cause: e,
        stackTrace: s,
      );
    }
  }

  @override
  Future<bool> verify(Authentication authentication) async {
    return authentication is BasicAuthentication && authentication.isValid;
  }
}
