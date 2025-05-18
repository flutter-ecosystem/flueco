import 'package:flueco_auth/flueco_auth.dart';

/// Base credentials
base class BasicAuthenticationCredentials extends AuthenticationCredentials {
  static const String classId = 'auth_basic:credentials';

  /// Creates an instance of [BasicAuthenticationCredentials]
  const BasicAuthenticationCredentials() : super(classId);
}

/// Implementation of [BasicAuthenticationCredentials] for username and password
/// authentication.
base class UsernamePasswordBasicAuthenticationCredentials
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
