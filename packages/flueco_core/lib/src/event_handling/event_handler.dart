import 'dart:async';

import 'package:flueco_core/src/core/un_implemented_component.dart';

import 'event.dart';
import 'event_subscriber.dart';

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
abstract class EventHandler {
  /// Add [event] to the queue. It will be process at its time.
  ///
  /// You can emit the same event multiple times
  void emit(Event event);

  /// Emit an [event] directly
  ///
  /// All subscribers will be called directly. If `throwInternalError` is true
  /// and one of the subscriber throws an error it will be re thrown.
  Future<void> emitNow(Event event, {bool throwInternalError = false});

  /// Subscribe [subscriber] to [event]
  void subscribe(Type event, EventSubscriber subscriber);

  /// Subscribe [subscriber] to all [event]
  void subscribeAll(Iterable<Type> events, EventSubscriber subscriber);

  /// Unsubscribe [subscriber] to [event]
  void unsubscribe(Type event, EventSubscriber subscriber);

  /// Unsubscribe [subscriber] to all events
  void unsubscribeAll(EventSubscriber subscriber);
}

/// Implementation of [EventHandler]
class UnImplementedEventHandler
    implements EventHandler, UnImplementedComponent {
  @override
  void emit(Event event) {
    throw UnimplementedError();
  }

  @override
  Future<void> emitNow(Event event, {bool throwInternalError = false}) {
    throw UnimplementedError();
  }

  @override
  void subscribe(Type event, EventSubscriber subscriber) {
    throw UnimplementedError();
  }

  @override
  void subscribeAll(Iterable<Type> events, EventSubscriber subscriber) {
    throw UnimplementedError();
  }

  @override
  void unsubscribe(Type event, EventSubscriber subscriber) {
    throw UnimplementedError();
  }

  @override
  void unsubscribeAll(EventSubscriber subscriber) {
    throw UnimplementedError();
  }
}
