import 'package:flueco_auth/src/exceptions/authentication_exception.dart';

/// Base credentials
abstract base class Credentials {
  /// Creates an instance of [Credentials]
  ///
  /// The [uniqueClassId] is used to identify the type of credentials.
  /// It should be unique for each implementation of [Credentials].
  const Credentials(this.uniqueClassId);

  final String uniqueClassId;
}

/// Credentials sent for authentication.
abstract base class AuthenticationCredentials extends Credentials {
  /// Creates an instance of [AuthenticationCredentials]
  const AuthenticationCredentials(super.uniqueClassId);
}

/// Credentials used to refresh authentication
abstract base class RefreshCredentials extends Credentials {
  /// Creates an instance of [RefreshCredentials]
  const RefreshCredentials(super.uniqueClassId);
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
