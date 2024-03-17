import 'notification_message.dart';

/// Message for inform action
class InformMessage extends NotificationMessage {
  /// Title of the message
  final String? title;

  const InformMessage({
    required super.content,
    this.title,
  });
}
