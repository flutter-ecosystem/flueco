/// ServiceResolver
abstract class ServiceResolver {
  /// Resolve an instance of [T]
  T resolve<T extends Object>({String? name});

  /// Check if an instance is resolvable by name
  bool isResolvableByName<T extends Object>(String name);

  /// Check if an instance is resolvable by type
  bool isResolvable(Type type);
}
