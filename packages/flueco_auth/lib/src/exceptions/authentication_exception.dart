/// Exception thrown when an authentication error occurs.
class AuthenticationException implements Exception {
  /// The cause of the exception.
  final Object? cause;

  /// The root stack trace of the exception.
  final StackTrace? stackTrace;

  /// Creates a new [AuthenticationException].
  const AuthenticationException({
    this.cause,
    this.stackTrace,
  });

  @override
  String toString() =>
      '$runtimeType(cause: $cause) \n stackTrace: \n$stackTrace';
}
