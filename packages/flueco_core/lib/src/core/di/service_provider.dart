import '../flueco_app.dart';
import 'service_injector.dart';

/// Service provider for each plugin
abstract class ServiceProvider {
  /// Register any application services
  Future<void> register(ServiceInjector injector);

  /// Initialize all your services
  ///
  /// It will be called when all services will be registered
  Future<void> initialize(FluecoApp app);

  /// List of external services that services of this application depends on.
  ///
  /// It is used to make sure that they are all registered before yours.
  Set<Type> dependsOn();

  /// List of services that will be registered by this provider.
  Set<Type> registered();
}
