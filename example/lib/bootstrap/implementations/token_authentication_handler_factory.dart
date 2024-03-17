import 'dart:convert';

import 'package:flueco_auth/flueco_auth.dart';
import 'package:flueco_auth_token/flueco_auth_token.dart';

/// Implementation of [TokenAuthenticationHandlerFactory]
class ExampleTokenAuthenticationHandlerFactory
    implements TokenAuthenticationHandlerFactory {
  /// Creates an instance of [ExampleTokenAuthenticationHandlerFactory]
  ExampleTokenAuthenticationHandlerFactory();
  @override
  TokenAuthenticationHandler create() {
    return ExampleTokenAuthenticationHandler();
  }
}

/// Implementation of [TokenAuthenticationHandler]
class ExampleTokenAuthenticationHandler implements TokenAuthenticationHandler {
  /// Creates an instance of [ExampleTokenAuthenticationHandler]
  ExampleTokenAuthenticationHandler();

  @override
  Future<TokenAuthentication> handle(
    TokenAuthenticationCredentials credentials,
  ) async {
    if (credentials is! UsernamePasswordTokenAuthenticationCredentials) {
      throw const AuthenticateOperationException();
    }
    final String username = credentials.username;
    final String password = credentials.password;

    try {
      return TokenAuthentication(
        token: base64Encode('$username+$password'.codeUnits),
      );
    } catch (e, s) {
      throw AuthenticateOperationException(cause: e, stackTrace: s);
    }
  }
}
