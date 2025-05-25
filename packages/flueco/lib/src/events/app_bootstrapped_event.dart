import 'package:flueco_core/flueco_core.dart';
import 'package:flueco_messaging/flueco_messaging.dart';
import 'package:meta/meta.dart';

/// Event emitted when the kernel finishes bootstrapping.
///
/// At this point, all services are initialized and ready to use.
@sealed
class AppBootstrappedEvent extends Message implements Event {
  /// Create a new instance of [AppBootstrappedEvent]
  const AppBootstrappedEvent() : super(priority: 9999);
}
