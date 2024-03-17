import 'authentication_exception.dart';

class AuthenticationProviderNotFoundException extends AuthenticationException {
  const AuthenticationProviderNotFoundException({super.cause});
}

class AuthenticationProviderNotFoundByCredentialsException
    extends AuthenticationProviderNotFoundException {
  final Type credentialType;

  const AuthenticationProviderNotFoundByCredentialsException(
      {required this.credentialType, super.cause});

  @override
  String toString() =>
      '$runtimeType(cause: $cause, credentialType: $credentialType) \n stackTrace: \n$stackTrace';
}

class AuthenticationProviderNotFoundByAuthenticationException
    extends AuthenticationProviderNotFoundException {
  final Type authenticationType;

  const AuthenticationProviderNotFoundByAuthenticationException(
      {required this.authenticationType, super.cause});

  @override
  String toString() =>
      '$runtimeType(cause: $cause, authenticationType: $authenticationType) \n stackTrace: \n$stackTrace';
}
