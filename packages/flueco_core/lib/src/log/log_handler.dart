// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';

import '../core/registry/channel_handler.dart';
import 'log_message.dart';

/// Base channel handler class for logs
abstract class LogHandler extends ChannelHandler {
  /// Log [message]
  void log(LogMessage message);

  /// Log info [message]
  void info(LogMessage message);

  /// Log warning [message]
  void warning(LogMessage message);

  /// Log debug [message]
  void debug(LogMessage message);

  /// Log error [message]
  void error(LogMessage message);

  /// Log critical [message]
  void critical(LogMessage message);
}

class ConsoleLogHandler extends LogHandler {
  /// Default channel of the handler
  static const String channel = r'ConsoleLogHandler::channel';

  /// If log is enable
  final bool enable;

  /// Constructor
  ConsoleLogHandler({
    required this.enable,
  });

  @override
  void critical(LogMessage message) {
    if (!enable) return;
    debugPrint('[CRITICAL] ${message.content}');
  }

  @override
  void debug(LogMessage message) {
    if (!enable) return;
    debugPrint('[DEBUG] ${message.content}');
  }

  @override
  void error(LogMessage message) {
    if (!enable) return;
    debugPrint('[ERROR] ${message.content}');
  }

  @override
  void info(LogMessage message) {
    if (!enable) return;
    debugPrint('[INFO] ${message.content}');
  }

  @override
  void log(LogMessage message) {
    if (!enable) return;
    debugPrint(message.content);
  }

  @override
  void warning(LogMessage message) {
    if (!enable) return;
    debugPrint('[WARNING] ${message.content}');
  }
}
