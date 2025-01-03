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
  final Type credentialType;

  /// Creates a new [AuthenticationProviderNotFoundByCredentialsException].
  const AuthenticationProviderNotFoundByCredentialsException(
      {required this.credentialType, super.cause});

  @override
  String toString() =>
      '$runtimeType(cause: $cause, credentialType: $credentialType) \n stackTrace: \n$stackTrace';
}

/// [AuthenticationProviderNotFoundException] thrown when an [AuthenticationProvider] is not found by the
/// given [Authentication].
class AuthenticationProviderNotFoundByAuthenticationException
    extends AuthenticationProviderNotFoundException {
  /// Subtype of [Authentication] that was not found.
  final Type authenticationType;

  /// Creates a new [AuthenticationProviderNotFoundByAuthenticationException].
  const AuthenticationProviderNotFoundByAuthenticationException(
      {required this.authenticationType, super.cause});

  @override
  String toString() =>
      '$runtimeType(cause: $cause, authenticationType: $authenticationType) \n stackTrace: \n$stackTrace';
}
