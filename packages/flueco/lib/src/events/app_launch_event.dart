import 'package:flueco_core/flueco_core.dart';
import 'package:flueco_messaging/flueco_messaging.dart';
import 'package:meta/meta.dart';

/// Event emitted when the app launch (it is built for the first time).
///
/// This event has a high priority to ensure it is handled as soon as possible.
@sealed
class AppLaunchEvent extends Message implements Event {
  /// Indicates if the app is launching
  final bool launching;

  /// Indicates if the app was launched
  final bool launched;

  /// Create a new instance of [AppLaunchEvent]
  const AppLaunchEvent(this.launching, this.launched) : super(priority: 9999);
}
