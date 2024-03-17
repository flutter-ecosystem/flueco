// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthenticationException implements Exception {
  final Object? cause;
  final StackTrace? stackTrace;

  const AuthenticationException({
    this.cause,
    this.stackTrace,
  });

  @override
  String toString() =>
      '$runtimeType(cause: $cause) \n stackTrace: \n$stackTrace';
}
