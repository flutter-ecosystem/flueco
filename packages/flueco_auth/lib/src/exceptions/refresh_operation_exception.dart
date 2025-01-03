import 'authentication_exception.dart';

/// Exception thrown when a refresh operation fails.
class RefreshOperationException extends AuthenticationException {
  /// Creates a new [RefreshOperationException].
  const RefreshOperationException({super.cause});
}
