// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'di/service_injector.dart';
import 'di/service_resolver.dart';

/// Flueco entity class
class FluecoApp {
  /// Service resolver
  final ServiceResolver resolver;

  /// Service Injector
  final ServiceInjector injector;

  FluecoApp({
    required this.resolver,
    required this.injector,
  });
}
