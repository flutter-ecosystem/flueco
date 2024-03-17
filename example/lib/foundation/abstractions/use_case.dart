/// A use case
abstract interface class UseCase<R> {
  /// Put in action the scenarios described in the
  /// use case.
  Future<R> execute();
}
