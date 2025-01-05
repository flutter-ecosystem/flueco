import 'package:flueco_core/flueco_core.dart';
import 'package:flueco_messaging/flueco_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// Event emitted when the app lifecycle state changed.
///
/// This event has a high priority to ensure it is handled as soon as possible.
@sealed
class AppLifecycleStateChangedEvent extends Message implements Event {
  /// The current app lifecycle state
  final AppLifecycleState state;

  /// Create a new instance of [AppLifecycleStateChangedEvent]
  const AppLifecycleStateChangedEvent(this.state) : super(priority: 9999);
}
