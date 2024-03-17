import 'package:flueco_core/flueco_core.dart';
import 'package:flueco_messaging/flueco_messaging.dart';
import 'package:meta/meta.dart';

/// Event emitted when the app widget is built for the first time
@sealed
class AppFirstBuildEvent extends Message implements Event {
  /// constructor
  const AppFirstBuildEvent() : super(priority: 9999);
}
