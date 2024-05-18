import '../flueco_app.dart';
import 'service_injector.dart';

/// Service provider for each plugin.
///
/// It allows to register and initialize services for each plugin
///
/// It is used to make sure that all services are registered before they are initialized
///
/// It also allows to register services that depends on other services
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
