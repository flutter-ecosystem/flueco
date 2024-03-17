import 'package:flueco_core/src/notification/messages/inform_message.dart';
import 'package:flueco_core/src/notification/messages/ask_message.dart';
import 'package:flutter/widgets.dart';

import '../core/registry/channel_registry.dart';
import '../widgets/service_resolver.dart';
import 'notification_handler.dart';

/// Type of action of the handler
abstract class NotificationHandlerAction extends ChannelHandlerAction {}

/// Action when a critical message must be log
class AskNotificationHandlerAction extends NotificationHandlerAction {
  final AskMessage message;
  AskNotificationHandlerAction({
    required this.message,
  });
}

/// Action when a critical message must be log
class ConfirmNotificationHandlerAction extends NotificationHandlerAction {
  final InformMessage message;
  ConfirmNotificationHandlerAction({
    required this.message,
  });
}

/// Action when a critical message must be log
class InformNotificationHandlerAction extends NotificationHandlerAction {
  final InformMessage message;
  InformNotificationHandlerAction({
    required this.message,
  });
}

/// Provider of the default channel
abstract class NotificationDefaultChannelProvider
    extends DefaultChannelProvider<NotificationHandlerAction> {}

/// Registry for notifications
class NotificationRegistry extends ChannelRegistry<NotificationHandler,
    NotificationDefaultChannelProvider> implements NotificationHandler {
  NotificationRegistry({required super.defaultChannelProvider});

  static NotificationHandler of(BuildContext context, {String? channel}) {
    final NotificationRegistry registry =
        FluecoSR.of(context).resolve<NotificationRegistry>();
    return channel == null ? registry : registry.get(channel);
  }

  @override
  Future<void> ask(AskMessage message) async {
    final Iterable<NotificationHandler> handlers =
        getDefaults(AskNotificationHandlerAction(message: message));
    await Future.any(handlers.map((e) => e.ask(message)));
  }

  @override
  Future<bool> confirm(InformMessage message) async {
    final Iterable<NotificationHandler> handlers =
        getDefaults(ConfirmNotificationHandlerAction(message: message));
    return await Future.any(handlers.map((e) => e.confirm(message)));
  }

  @override
  Future<void> inform(InformMessage message) async {
    final Iterable<NotificationHandler> handlers =
        getDefaults(InformNotificationHandlerAction(message: message));
    await Future.any(handlers.map((e) => e.inform(message)));
  }
}
