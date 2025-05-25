/// Utils class with helper methods.
class Utils {
  /// Deep hash of an object.
  ///
  /// The [object] parameter is the object to hash.
  static int deepHashAll(Iterable<Object> objects) {
    return Object.hashAll(objects.expand((e) => e is Iterable ? e : [e]));
  }
}
