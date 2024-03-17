import 'service_injector.dart';
import 'service_resolver.dart';

/// Service container
abstract class ServiceContainer implements ServiceResolver, ServiceInjector {}
