import 'package:flueco_auth/flueco_auth.dart';
import 'package:flueco_auth_token/src/authentication.dart';
import 'package:flueco_auth_token/src/authentication_credentials.dart';

/// Authentication handler
abstract class TokenAuthenticationHandler {
  /// Handle the [credentials]
  Future<TokenAuthentication> handle(
      TokenAuthenticationCredentials credentials);
}

/// Factory class used to create a new [TokenAuthenticationHandler]
abstract class TokenAuthenticationHandlerFactory {
  /// Creates an instance of [TokenAuthenticationHandler]
  TokenAuthenticationHandler create();
}

class TokenAuthenticatorAgent extends AuthenticatorAgent {
  final TokenAuthenticationHandlerFactory _authenticationHandlerFactory;

  TokenAuthenticatorAgent(
      {required TokenAuthenticationHandlerFactory authenticationHandlerFactory})
      : _authenticationHandlerFactory = authenticationHandlerFactory;
  @override
  Future<Authentication> authenticate(
      AuthenticationCredentials credentials) async {
    if (credentials is! TokenAuthenticationCredentials) {
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
    if (authentication is TokenAuthentication) {
      return authentication.isValid;
    }

    return false;
  }
}
