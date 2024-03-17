import 'package:flutter/foundation.dart';

/// Base class for event.
@immutable
abstract class Event {
  /// Constructor
  const Event();
}

abstract class PriorityEvent extends Event {
  /// Priority of the event
  int get priority;

  const PriorityEvent();
}
