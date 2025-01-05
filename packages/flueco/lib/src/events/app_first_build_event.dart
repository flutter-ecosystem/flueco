import 'package:flueco_core/flueco_core.dart';
import 'package:flueco_messaging/flueco_messaging.dart';
import 'package:meta/meta.dart';

/// Event emitted when the app widget is built for the first time.
///
/// This event has a high priority to ensure it is handled as soon as possible.
@sealed
class AppFirstBuildEvent extends Message implements Event {
  /// Create a new instance of [AppFirstBuildEvent]
  const AppFirstBuildEvent() : super(priority: 9999);
}
