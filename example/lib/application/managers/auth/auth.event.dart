import 'package:example/domain/entities/user.dart';
import 'package:flueco/flueco.dart' show Message, Event;

/// Event sent when the authenticated user
/// is refreshed from api.
final class AuthUserRefreshEvent extends Message implements Event {
  /// Authenticated user
  final User user;

  /// Creates an instance of [AuthUserRefreshEvent]
  const AuthUserRefreshEvent({required this.user})
      : super(priority: Message.maxPriority);
}
