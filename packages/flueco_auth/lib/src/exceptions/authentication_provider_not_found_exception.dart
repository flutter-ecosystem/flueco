import 'authentication_exception.dart';

/// Exception thrown when an authentication provider is not found.
class AuthenticationProviderNotFoundException extends AuthenticationException {
  /// Creates a new [AuthenticationProviderNotFoundException].
  const AuthenticationProviderNotFoundException({super.cause});
}

/// [AuthenticationProviderNotFoundException] thrown when an [AuthenticationProvider] is not found by the
/// given [Credentials].
class AuthenticationProviderNotFoundByCredentialsException
    extends AuthenticationProviderNotFoundException {
  /// Subtype of [Credentials] that was not found.
  final String credentialClassId;

  /// Creates a new [AuthenticationProviderNotFoundByCredentialsException].
  const AuthenticationProviderNotFoundByCredentialsException(
      {required this.credentialClassId, super.cause});

  @override
  String toString() =>
      '$runtimeType(cause: $cause, credentialClassId: $credentialClassId) \n stackTrace: \n$stackTrace';
}

/// [AuthenticationProviderNotFoundException] thrown when an [AuthenticationProvider] is not found by the
/// given [Authentication].
class AuthenticationProviderNotFoundByAuthenticationException
    extends AuthenticationProviderNotFoundException {
  /// Subtype of [Authentication] that was not found.
  final String authenticationClassId;

  /// Creates a new [AuthenticationProviderNotFoundByAuthenticationException].
  const AuthenticationProviderNotFoundByAuthenticationException(
      {required this.authenticationClassId, super.cause});

  @override
  String toString() =>
      '$runtimeType(cause: $cause, authenticationClassId: $authenticationClassId) \n stackTrace: \n$stackTrace';
}
