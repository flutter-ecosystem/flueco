import 'package:flueco_auth/flueco_auth.dart';

class TokenAuthenticationCredentials extends AuthenticationCredentials {}

class UsernamePasswordTokenAuthenticationCredentials
    extends TokenAuthenticationCredentials {
  final String username;
  final String password;

  /// Creates an instance of [UsernamePasswordTokenAuthenticationCredentials]
  UsernamePasswordTokenAuthenticationCredentials({
    required this.username,
    required this.password,
  });
}
