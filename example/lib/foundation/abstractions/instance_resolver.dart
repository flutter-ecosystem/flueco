/// Helper used to get an instance of [T]
abstract interface class InstanceResolver<T> {
  /// Resolve an instance of [T]
  T resolveInstance();
}

/// Helper function to get an instance of [T]
typedef ResolverOf<T> = T Function();
