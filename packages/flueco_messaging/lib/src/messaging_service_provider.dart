import 'package:flueco_core/flueco_core.dart';
import 'package:messaging/messaging.dart';

import 'event_handler.dart';

/// Service provider of messaging
class MessagingServiceProvider extends EventHandlingServiceProvider {
  @override
  Set<Type> dependsOn() {
    return <Type>{
      Messaging,
    };
  }

  @override
  EventHandler eventHandlerFactory(ServiceResolver resolver) {
    return resolver.resolve<MessagingEventHandler>();
  }

  @override
  Future<void> register(ServiceInjector injector) {
    injector.singleton<MessagingEventHandler>(
      (resolver) => MessagingEventHandler(
        messaging: resolver.resolve<Messaging>(),
      ),
    );
    return super.register(injector);
  }

  @override
  Future<void> initialize(FluecoApp app) async {}

  @override
  Set<Type> registered() {
    return <Type>{
      ...super.registered(),
      MessagingEventHandler,
    };
  }
}
