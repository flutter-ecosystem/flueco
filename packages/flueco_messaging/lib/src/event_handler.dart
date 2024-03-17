import 'dart:async';

import 'package:flueco_core/flueco_core.dart';
import 'package:flueco_messaging/src/messaging_event_subscriber.dart';
import 'package:messaging/messaging.dart';

import 'messaging_event.dart';

/// Handler that is used to emit an [Event] subtype or subscribe to it.
///
/// It should be used to emit a subtype of [Event] with the [emit] method
/// and all subscribers of this event will be execute.
///
/// To subscribe to an event you should call the [subscribe] method
/// passing a Type and the subscriber that should be a subtype of [EventSubscriber]. It's same to
/// unsubscribe.
///
/// An [EventSubscriber] can subscribe to different events.
///
/// Example:
///
/// ```dart
/// class ExampleEvent implements Event {
///   final String userName;
///
///   const ExampleEvent(this.userName);
/// }
///
/// class OtherExampleEvent implements Event {
///   final String userEmail;
///
///   const OtherExampleEvent(this.userEmail);
/// }
///
/// ...
///
/// class RandomSubscriber implement EventSubscriber {
///
///   final EventHandler _eventhandler;
///
///   RandomSubscriber(this.eventhandler);
///
///   void randomMethod() {
///     eventhandler.subscribe(ExampleEvent, this);
///     eventhandler.subscribe(OtherExampleEvent, this);
///   }
///
///   @override
///   void onEvent(Event event) {
///     if (event is ExampleEvent) {
///       // Handle ExampleEvent event
///     } else if (event is OtherExampleEvent) {
///       // Handle OtherExampleEvent event
///     }
///   }
///
///   void dispose() {
///     eventhandler.unsubscribe(ExampleEvent, this);
///     eventhandler.unsubscribe(OtherExampleEvent, this);
///
///     // OR eventhandler.unsubscribeAll(this);
///   }
/// }
///
/// ...
///
/// class EmitterClassSomewhereInYourCode {
///
///   final EventHandler _eventhandler;
///
///   EmitterClassSomewhereInYourCode(this.eventhandler);
///
///   emittingMethod() {
///     eventhandler.emit(ExampleEvent('maxime'));
///     eventhandler.emit(OtherExampleEvent('maxime@example.fr'));
///   }
/// }
/// ```
///
class MessagingEventHandler implements EventHandler {
  final Messaging _messaging;

  /// constructor
  MessagingEventHandler({required Messaging messaging})
      : _messaging = messaging;

  /// Add [event] to the queue. It will be process at its time.
  ///
  /// You can emit the same event multiple times
  @override
  void emit(Event event) {
    _messaging
        .publish(event is Message ? event as Message : MessagingEvent(event));
  }

  /// Emit an [event] directly
  ///
  /// All subscribers will be called directly. If `throwInternalError` is true
  /// and one of the subscriber throws an error it will be re thrown.
  @override
  Future<void> emitNow(Event event, {bool throwInternalError = false}) async {
    await _messaging.publishNow(
      event is Message ? event as Message : MessagingEvent(event),
      strategy: throwInternalError
          ? PublishNowErrorHandlingStrategy.breakDispatch
          : PublishNowErrorHandlingStrategy.continueDispatch,
    );
  }

  /// Subscribe [subscriber] to [event]
  @override
  void subscribe(Type event, EventSubscriber subscriber) {
    _messaging.subscribe(
        subscriber is MessagingSubscriber
            ? (subscriber as MessagingSubscriber)
            : MessagingEventSubscriber(subscriber),
        to: event);
  }

  /// Subscribe [subscriber] to all [event]
  @override
  void subscribeAll(Iterable<Type> events, EventSubscriber subscriber) {
    _messaging.subscribeAll(
        subscriber is MessagingSubscriber
            ? (subscriber as MessagingSubscriber)
            : MessagingEventSubscriber(subscriber),
        to: events);
  }

  /// Unsubscribe [subscriber] to [event]
  @override
  void unsubscribe(Type event, EventSubscriber subscriber) {
    _messaging.unsubscribe(
        subscriber is MessagingSubscriber
            ? (subscriber as MessagingSubscriber)
            : MessagingEventSubscriber(subscriber),
        to: event);
  }

  /// Unsubscribe [subscriber] to all events
  @override
  void unsubscribeAll(EventSubscriber subscriber) {
    _messaging.unsubscribeAll(subscriber is MessagingSubscriber
        ? (subscriber as MessagingSubscriber)
        : MessagingEventSubscriber(subscriber));
  }
}
