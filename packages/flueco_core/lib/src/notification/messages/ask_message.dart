import 'notification_message.dart';

/// Message for ask action
class AskMessage extends NotificationMessage {
  /// Title of the message
  final String? title;

  /// Actions
  final List<AskMessageAction> actions;

  const AskMessage({
    required super.content,
    required this.actions,
    this.title,
  });
}

/// Action
class AskMessageAction {
  /// Label of the action
  final String label;

  /// Callback
  final void Function() callback;

  const AskMessageAction({
    required this.label,
    required this.callback,
  });
}
