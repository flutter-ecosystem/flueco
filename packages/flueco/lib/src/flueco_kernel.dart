import 'package:flueco_core/flueco_core.dart' as core;
import 'package:flueco_core/flueco_core.dart';
import 'package:flutter/foundation.dart';

import 'services/dialog_service.dart';
import 'services/logger_service.dart';
import 'services/toast_service.dart';

class FluecoKernel extends core.FluecoKernel {
  FluecoKernel({
    required super.container,
    required super.serviceProviders,
    super.ensureInitialized,
    core.LogRegistry? logRegistry,
    core.NotificationRegistry? notificationRegistry,
  }) : super(
          logRegistry: logRegistry ?? _LogRegistry(),
          notificationRegistry: notificationRegistry ?? _NotificationRegistry(),
        );
}

class _LogRegistry extends core.LogRegistry {
  _LogRegistry() : super(defaultChannelProvider: _LogDefaultChannelProvider());

  @override
  void registerHandlers(core.ServiceResolver resolver) {
    final logHandler = resolver.resolve<LoggerService>().logHandler;
    final toastHandler = resolver.resolve<ToastService>().logHandler;
    final dialogHandler = resolver.resolve<DialogService>().logHandler;

    register(LoggerLogHandler.handlerKey, logHandler);
    register(ToastLogHandler.handlerKey, toastHandler);
    register(DialogLogHandler.handlerKey, dialogHandler);
  }
}

class _LogDefaultChannelProvider extends LogDefaultChannelProvider {
  @override
  Set<String> getChannelHandler(
      LogHandlerAction action,
      ChannelRegistry<ChannelHandler,
              DefaultChannelProvider<ChannelHandlerAction>>
          registry) {
    if (action is CriticalLogHandlerAction) {
      return const <String>{
        LoggerLogHandler.handlerKey,
      };
    } else if (action is ErrorLogHandlerAction) {
      return const <String>{
        LoggerLogHandler.handlerKey,
      };
    } else if (action is WarningLogHandlerAction) {
      return const <String>{
        LoggerLogHandler.handlerKey,
      };
    } else if (action is InfoLogHandlerAction) {
      return const <String>{
        ToastLogHandler.handlerKey,
        LoggerLogHandler.handlerKey,
      };
    } else if (action is DebugLogHandlerAction) {
      return <String>{
        if (kDebugMode) ToastLogHandler.handlerKey,
        LoggerLogHandler.handlerKey,
      };
    } else if (action is LogLogHandlerAction) {
      return const <String>{
        LoggerLogHandler.handlerKey,
      };
    } else {
      return const <String>{
        LoggerLogHandler.handlerKey,
      };
    }
  }
}

class _NotificationRegistry extends NotificationRegistry {
  _NotificationRegistry()
      : super(defaultChannelProvider: _NotificationDefaultChannelProvider());

  @override
  void registerHandlers(core.ServiceResolver resolver) {
    final dialogHandler = resolver.resolve<DialogService>().notificationHandler;

    register(DialogNotificationHandler.handlerKey, dialogHandler);
  }
}

class _NotificationDefaultChannelProvider
    extends NotificationDefaultChannelProvider {
  @override
  Set<String> getChannelHandler(
      NotificationHandlerAction action,
      ChannelRegistry<ChannelHandler,
              DefaultChannelProvider<ChannelHandlerAction>>
          registry) {
    if (action is AskNotificationHandlerAction) {
      return const <String>{
        DialogNotificationHandler.handlerKey,
      };
    } else if (action is ConfirmNotificationHandlerAction) {
      return const <String>{
        DialogNotificationHandler.handlerKey,
      };
    } else if (action is InformNotificationHandlerAction) {
      return const <String>{
        DialogNotificationHandler.handlerKey,
      };
    } else {
      return <String>{};
    }
  }
}
