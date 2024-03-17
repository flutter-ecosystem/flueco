import 'package:flutter/foundation.dart';

import '../core/di/service_injector.dart';
import '../core/di/service_provider.dart';
import '../core/di/service_resolver.dart';
import 'event_handler.dart';

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
