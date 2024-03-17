import 'event.dart';

/// {@category Core}
/// {@subCategory Infrastructure}
///
/// Base class for event subscribers.
abstract class EventSubscriber {
  /// Call when a subscribed [event] is emitted
  Future<void> onEvent(Event event);
}
