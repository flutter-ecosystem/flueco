import 'package:flueco_auth/flueco_auth.dart';
import 'package:flueco_auth_token/src/authentication.dart';
import 'package:flueco_auth_token/src/authentication_credentials.dart';
import 'package:flueco_auth_token/src/authentication_store.dart';
import 'package:flueco_auth_token/src/authenticator_agent.dart';
import 'package:flueco_core/flueco_core.dart';

/// Implementation of [AuthenticationProvider] for token authentication
/// through authorization header.
final class TokenAuthenticationProvider extends AuthenticationProvider {
  final TokenAuthenticationStore _authenticationStore;
  final TokenAuthenticatorAgent _authenticatorAgent;

  /// Creates a new [TokenAuthenticationProvider]
  TokenAuthenticationProvider(
      {required SecureStorage secureStorage,
      required LocalStorage localStorage,
      required TokenAuthenticationHandlerFactory
          tokenAuthenticationHandlerFactory,
      required TokenKeys tokenKeys})
      : _authenticationStore = TokenAuthenticationStore(
          localStorage: localStorage,
          secureStorage: secureStorage,
          tokenKeys: tokenKeys,
        ),
        _authenticatorAgent = TokenAuthenticatorAgent(
          authenticationHandlerFactory: tokenAuthenticationHandlerFactory,
        );

  @override
  Set<String> get supportedAuthenticationClassIds => <String>{
        TokenAuthentication.classId,
      };

  @override
  Set<String> get supportedCredentialsClassIds => <String>{
        TokenAuthenticationCredentials.classId,
      };

  @override
  AuthenticatorAgent get authenticatorAgent => _authenticatorAgent;

  @override
  AuthenticationStore get store => _authenticationStore;

  @override
  RefreshAgent? get refreshAgent => null;

  @override
  bool get supportsRefresh => false;
}
