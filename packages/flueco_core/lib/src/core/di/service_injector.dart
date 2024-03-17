import 'service_resolver.dart';

/// ServiceInjector
abstract class ServiceInjector {
  /// Inject [instance] as singleton
  void singleton<T extends Object>(
    T Function(ServiceResolver resolver) factory, {
    bool force = false,
    String? name,
  });

  /// Inject [instance] as singleton
  Future<void> singletonAsync<T extends Object>(
    Future<T> Function(ServiceResolver resolver) factory, {
    bool force = false,
    String? name,
  });

  /// Inject [instance] as lazy singleton
  void lazySingleton<T extends Object>(
    T Function(ServiceResolver resolver) factory, {
    bool force = false,
    String? name,
  });

  /// Inject [instance]
  void factory<T extends Object>(
    T Function(ServiceResolver resolver) factory, {
    bool force = false,
    String? name,
  });
}
