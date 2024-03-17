import 'authentication_exception.dart';

class AuthenticateOperationException extends AuthenticationException {
  const AuthenticateOperationException({super.cause, super.stackTrace});
}
