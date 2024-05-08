import 'package:flutter/foundation.dart';

/// Base class for event.
@immutable
abstract class Event {
  /// Create an instance of the event
  const Event();
}

abstract class PriorityEvent extends Event {
  /// Priority of the event
  int get priority;

  const PriorityEvent();
}
