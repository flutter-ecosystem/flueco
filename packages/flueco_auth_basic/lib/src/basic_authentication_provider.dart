import 'package:flueco_auth/flueco_auth.dart';
import 'package:flueco_core/flueco_core.dart';

import 'authentication.dart';
import 'authentication_credentials.dart';
import 'authentication_store.dart';
import 'authenticator_agent.dart';

/// Implementation of [AuthenticationProvider] for basic authentication
/// through header.
final class BasicAuthenticationProvider extends AuthenticationProvider {
  final BasicAuthenticationStore _authenticationStore;
  final BasicAuthenticatorAgent _authenticatorAgent;

  /// Creates a new [BasicAuthenticationProvider]
  BasicAuthenticationProvider({
    required SecureStorage secureStorage,
    required BasicAuthenticationHandlerFactory
        basicAuthenticationHandlerFactory,
  })  : _authenticationStore = BasicAuthenticationStore(
          secureStorage: secureStorage,
        ),
        _authenticatorAgent = BasicAuthenticatorAgent(
          authenticationHandlerFactory: basicAuthenticationHandlerFactory,
        );

  @override
  Set<Type> get authenticationSupported => <Type>{
        BasicAuthentication,
      };

  @override
  AuthenticatorAgent get authenticatorAgent => _authenticatorAgent;

  @override
  Set<Type> get credentialsSupported => {
        BasicAuthenticationCredentials,
        UsernamePasswordBasicAuthenticationCredentials,
      };

  @override
  RefreshAgent? get refreshAgent => null;

  @override
  AuthenticationStore get store => _authenticationStore;

  @override
  bool get supportsRefresh => false;
}
