import 'package:flueco_auth/flueco_auth.dart';

/// Base credentials
class BasicAuthenticationCredentials extends AuthenticationCredentials {
  /// Creates an instance of [BasicAuthenticationCredentials]
  const BasicAuthenticationCredentials();
}

/// Implementation of [BasicAuthenticationCredentials] for username and password
/// authentication.
class UsernamePasswordBasicAuthenticationCredentials
    extends BasicAuthenticationCredentials {
  /// Username to authenticate with.
  final String username;

  /// Password to authenticate with.
  final String password;

  /// Creates an instance of [UsernamePasswordBasicAuthenticationCredentials]
  const UsernamePasswordBasicAuthenticationCredentials({
    required this.username,
    required this.password,
  });
}
