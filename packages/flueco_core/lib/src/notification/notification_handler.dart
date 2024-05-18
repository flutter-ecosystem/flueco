import '../foundation/registry/channel_handler.dart';
import 'messages/ask_message.dart';
import 'messages/inform_message.dart';

/// Base channel handler class for notifications
abstract class NotificationHandler extends ChannelHandler {
  /// Inform
  Future<void> inform(InformMessage message);

  /// Ask
  Future<void> ask(AskMessage message);

  /// Confirm
  Future<bool> confirm(InformMessage message);
}
