import 'package:flueco_auth/src/exceptions/authentication_exception.dart';

/// Base credentials
abstract class Credentials {
  /// Creates an instance of [Credentials]
  const Credentials();
}

/// Credentials sent for authentication.
abstract class AuthenticationCredentials extends Credentials {
  /// Creates an instance of [AuthenticationCredentials]
  const AuthenticationCredentials();
}

/// Credentials used to refresh authentication
abstract class RefreshCredentials extends Credentials {
  /// Creates an instance of [RefreshCredentials]
  const RefreshCredentials();
}

/// Exception thrown when invalid credentials are provided.
class InvalidAuthenticationCredentialsException
    extends AuthenticationException {
  /// Creates an instance of [InvalidAuthenticationCredentialsException].
  const InvalidAuthenticationCredentialsException({
    super.cause,
    super.stackTrace,
  });
}

/// Exception thrown when invalid refresh credentials are provided.
class InvalidRefreshCredentialsException extends AuthenticationException {
  /// Creates an instance of [InvalidRefreshCredentialsException]].
  const InvalidRefreshCredentialsException({
    super.cause,
    super.stackTrace,
  });
}
