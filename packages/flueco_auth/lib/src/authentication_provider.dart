import 'authentication_store.dart';
import 'authenticator_agent.dart';
import 'refresh_agent.dart';

abstract class AuthenticationProvider {
  /// Store of the authentication
  AuthenticationStore get store;

  /// Agent to authenticate
  AuthenticatorAgent get authenticatorAgent;

  /// Agent to refresh
  RefreshAgent? get refreshAgent;

  /// Check if refresh is supported
  bool get supportsRefresh;

  /// Set of type of [Authentication] unique class ids supported by the provider.
  Set<String> get supportedAuthenticationClassIds;

  /// Set of type of [AuthenticationCredentials] unique class ids supported by the provider.
  Set<String> get supportedCredentialsClassIds;
}

/// Factory class to get the list of providers when needed
abstract class AuthenticationProvidersFactory {
  /// Get the list of [AuthenticationProvider]
  Iterable<AuthenticationProvider> getProviders();
}
