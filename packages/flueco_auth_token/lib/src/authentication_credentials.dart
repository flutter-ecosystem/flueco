import 'package:flueco_auth/flueco_auth.dart';

/// Base credentials
base class TokenAuthenticationCredentials extends AuthenticationCredentials {
  static const String classId = 'auth_token:credentials';

  /// Creates an instance of [TokenAuthenticationCredentials]
  const TokenAuthenticationCredentials() : super(classId);
}

/// Credentials send to authenticate.
base class UsernamePasswordTokenAuthenticationCredentials
    extends TokenAuthenticationCredentials {
  /// Username to authenticate with.
  final String username;

  /// Password to authenticate with.
  final String password;

  /// Creates an instance of [UsernamePasswordTokenAuthenticationCredentials]
  const UsernamePasswordTokenAuthenticationCredentials({
    required this.username,
    required this.password,
  });
}
