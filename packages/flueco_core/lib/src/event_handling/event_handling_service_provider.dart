import 'package:flutter/foundation.dart';

import '../foundation/di/service_injector.dart';
import '../foundation/di/service_provider.dart';
import '../foundation/di/service_resolver.dart';
import 'event_handler.dart';

/// Service provider for event handling
///
/// It allows to register the [EventHandler]
abstract class EventHandlingServiceProvider extends ServiceProvider {
  /// Factory method of [EventHandler]
  EventHandler eventHandlerFactory(ServiceResolver resolver);

  @override
  @mustCallSuper
  Future<void> register(ServiceInjector injector) async {
    injector.lazySingleton<EventHandler>(eventHandlerFactory);
  }

  @override
  @mustCallSuper
  Set<Type> registered() {
    return <Type>{
      EventHandler,
    };
  }
}
