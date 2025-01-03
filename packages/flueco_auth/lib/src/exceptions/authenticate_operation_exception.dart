import 'authentication_exception.dart';

/// Exception thrown when an authentication operation fails.
class AuthenticateOperationException extends AuthenticationException {
  /// Creates a new [AuthenticateOperationException].
  const AuthenticateOperationException({super.cause, super.stackTrace});
}
