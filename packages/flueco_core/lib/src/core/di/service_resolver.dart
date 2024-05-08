/// The service locator that allows to resolve instances of services
/// by type or by name.
///
/// These services need to be injected first.
abstract class ServiceResolver {
  /// Resolve an instance of [T]
  T resolve<T extends Object>({String? name});

  /// Check if an instance is resolvable by name
  bool isResolvableByName<T extends Object>(String name);

  /// Check if an instance is resolvable by type
  bool isResolvable(Type type);
}
