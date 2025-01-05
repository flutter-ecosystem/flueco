/// Utils class with helper methods.
class Utils {
  /// Check if two objects are deeply equal.
  static bool deepEquals(dynamic obj1, dynamic obj2) {
    if (obj1 == obj2) {
      return true;
    }

    if (obj1 is Iterable && obj2 is Iterable) {
      if (obj1.length != obj2.length) {
        return false;
      }
      for (int i = 0; i < obj1.length; i++) {
        if (!deepEquals(obj1.elementAt(i), obj2.elementAt(i))) {
          return false;
        }
      }
      return true;
    }

    if (obj1 is Map && obj2 is Map) {
      if (obj1.length != obj2.length) {
        return false;
      }
      for (var key in obj1.keys) {
        if (!obj2.containsKey(key) || !deepEquals(obj1[key], obj2[key])) {
          return false;
        }
      }
      return true;
    }

    return false;
  }

  /// Deep hash of an object.
  ///
  /// The [object] parameter is the object to hash.
  static int deepHashAll(Iterable<Object> objects) {
    return Object.hashAll(objects.expand((e) => e is Iterable ? e : [e]));
  }
}
