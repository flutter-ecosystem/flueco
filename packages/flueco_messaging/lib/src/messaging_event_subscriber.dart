import 'package:flueco_core/flueco_core.dart';
import 'package:messaging/messaging.dart';

import 'messaging_event.dart';

/// Base class for event subscribers.
class MessagingEventSubscriber implements MessagingSubscriber {
  final EventSubscriber _eventSubscriber;

  MessagingEventSubscriber(this._eventSubscriber);

  @override
  Future<void> onMessage(Message message) async {
    if (message is MessagingEvent) {
      return _eventSubscriber.onEvent(message.event);
    }
  }

  @override
  String get subscriberKey =>
      'MessagingEventSubscriber::${_eventSubscriber.runtimeType}';

  @override
  Type get runtimeType => _eventSubscriber.runtimeType;
}
