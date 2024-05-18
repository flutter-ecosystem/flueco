// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'di/service_injector.dart';
import 'di/service_resolver.dart';

/// Class that represents a Flueco application.
class FluecoApp {
  /// The property used to resolve any services that
  /// were injected.
  final ServiceResolver resolver;

  /// The property used to inject any services.
  final ServiceInjector injector;

  /// Creates a new instance of [FluecoApp].
  FluecoApp({
    required this.resolver,
    required this.injector,
  });
}
