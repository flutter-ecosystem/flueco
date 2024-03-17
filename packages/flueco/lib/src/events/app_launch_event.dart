import 'package:flueco_core/flueco_core.dart';
import 'package:flueco_messaging/flueco_messaging.dart';
import 'package:meta/meta.dart';

/// Event emitted when the app launch (it is built for the first time)
@sealed
class AppLaunchEvent extends Message implements Event {
  // ignore: public_member_api_docs
  final bool launching;
  // ignore: public_member_api_docs
  final bool launched;

  /// constructor
  const AppLaunchEvent(this.launching, this.launched) : super(priority: 9999);
}
