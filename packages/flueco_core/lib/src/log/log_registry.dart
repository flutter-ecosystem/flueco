// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';

import 'package:flueco_core/src/log/log_message.dart';

import '../foundation/di/service_resolver.dart';
import '../foundation/registry/channel_registry.dart';
import '../widgets/service_resolver.dart';
import 'log_handler.dart';

/// Type of action of the handler
abstract class LogHandlerAction extends ChannelHandlerAction {}

/// Action when a critical message must be log
class CriticalLogHandlerAction extends LogHandlerAction {
  final LogMessage message;
  CriticalLogHandlerAction({
    required this.message,
  });
}

/// Action when a critical message must be log
class DebugLogHandlerAction extends LogHandlerAction {
  final LogMessage message;
  DebugLogHandlerAction({
    required this.message,
  });
}

/// Action when a critical message must be log
class ErrorLogHandlerAction extends LogHandlerAction {
  final LogMessage message;
  ErrorLogHandlerAction({
    required this.message,
  });
}

/// Action when a critical message must be log
class InfoLogHandlerAction extends LogHandlerAction {
  final LogMessage message;
  InfoLogHandlerAction({
    required this.message,
  });
}

/// Action when a critical message must be log
class LogLogHandlerAction extends LogHandlerAction {
  final LogMessage message;
  LogLogHandlerAction({
    required this.message,
  });
}

/// Action when a critical message must be log
class WarningLogHandlerAction extends LogHandlerAction {
  final LogMessage message;
  WarningLogHandlerAction({
    required this.message,
  });
}

/// Provider of the default channel
abstract class LogDefaultChannelProvider
    extends DefaultChannelProvider<LogHandlerAction> {}

/// Registry for logs
abstract class LogRegistry
    extends ChannelRegistry<LogHandler, LogDefaultChannelProvider>
    implements LogHandler {
  LogRegistry({required super.defaultChannelProvider});

  /// Register handlers
  void registerHandlers(ServiceResolver resolver);

  @override
  void critical(LogMessage message) {
    getDefaults(CriticalLogHandlerAction(message: message)).forEach((element) {
      element.critical(message);
    });
  }

  @override
  void debug(LogMessage message) {
    getDefaults(DebugLogHandlerAction(message: message)).forEach((element) {
      element.critical(message);
    });
  }

  @override
  void error(LogMessage message) {
    getDefaults(ErrorLogHandlerAction(message: message)).forEach((element) {
      element.critical(message);
    });
  }

  @override
  void info(LogMessage message) {
    getDefaults(InfoLogHandlerAction(message: message)).forEach((element) {
      element.critical(message);
    });
  }

  @override
  void log(LogMessage message) {
    getDefaults(LogLogHandlerAction(message: message)).forEach((element) {
      element.critical(message);
    });
  }

  @override
  void warning(LogMessage message) {
    getDefaults(WarningLogHandlerAction(message: message)).forEach((element) {
      element.critical(message);
    });
  }
}

/// FluecoLog helper class
class FluecoLog {
  /// Get LogHandler from the context
  static LogHandler of(BuildContext context, {String? channel}) {
    final LogRegistry registry = FluecoSR.of(context).resolve<LogRegistry>();
    return channel == null ? registry : registry.get(channel);
  }
}
