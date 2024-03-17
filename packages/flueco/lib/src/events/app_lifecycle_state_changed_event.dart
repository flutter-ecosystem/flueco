import 'package:flueco_core/flueco_core.dart';
import 'package:flueco_messaging/flueco_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// Event emitted when the app lifecycle state changed
@sealed
class AppLifecycleStateChangedEvent extends Message implements Event {
  // ignore: public_member_api_docs
  final AppLifecycleState state;

  /// constructor
  const AppLifecycleStateChangedEvent(this.state) : super(priority: 9999);
}
