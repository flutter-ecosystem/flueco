/// Mixin to run code in safety zone (try catch)
mixin SafeZoneResultMixin {
  /// Run code in safety zone (try catch)
  Future<SafeZoneResult<R>> runOnSafeZone<R>(
    Future<R> Function() callback,
  ) async {
    try {
      return SafeZoneResult<R>(result: await callback());
    } catch (e, s) {
      return SafeZoneResult<R>(error: e, stackTrace: s);
    }
  }
}

/// Result after execution
class SafeZoneResult<T> {
  /// Error occurred in the safe zone
  final Object? error;

  /// Stacktrace of the error
  final StackTrace? stackTrace;

  /// Result
  final T? result;

  /// Constructor
  const SafeZoneResult({
    this.error,
    this.result,
    this.stackTrace,
  });

  /// If the result has no error
  bool get succeed => error == null;
}
