import 'package:flueco_auth/flueco_auth.dart';

/// Base credentials
class BasicAuthenticationCredentials extends AuthenticationCredentials {}

/// Credentials send to authenticate.
class UsernamePasswordTokenAuthenticationCredentials
    extends BasicAuthenticationCredentials {
  /// Username to authenticate with.
  final String username;

  /// Password to authenticate with.
  final String password;

  /// Creates an instance of [UsernamePasswordTokenAuthenticationCredentials]
  UsernamePasswordTokenAuthenticationCredentials({
    required this.username,
    required this.password,
  });
}
