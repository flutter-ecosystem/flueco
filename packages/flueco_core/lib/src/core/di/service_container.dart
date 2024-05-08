import 'service_injector.dart';
import 'service_resolver.dart';

/// Container of services
///
/// It allows to resolve and inject services
///
/// This class is a combination of [ServiceResolver] and [ServiceInjector]
abstract class ServiceContainer implements ServiceResolver, ServiceInjector {}
