// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'package:flueco_core/flueco_core.dart';

/// Log utility
class LoggerService {
  final Logger _logger;

  /// Log is enable
  bool _enable;

  /// Constructor
  LoggerService({
    required bool? enable,
  })  : _enable = enable ?? kDebugMode,
        _logger = Logger(
          printer: PrefixPrinter(
            PrettyPrinter(
              printEmojis: true,
              errorMethodCount: 10,
              lineLength: 80,
              methodCount: 20,
            ),
          ),
        );

  /// Enable log
  void enable() {
    _enable = true;
  }

  /// Disable log
  void disable() {
    _enable = false;
  }

  void debug(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!_enable) return;
    _logger.d(message, error, stackTrace);
  }

  void error(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!_enable) return;
    _logger.e(message, error, stackTrace);
  }

  void info(dynamic message) {
    if (!_enable) return;
    _logger.i(
      message,
      null,
      StackTrace.empty,
    );
  }

  void verbose(dynamic message) {
    if (!_enable) return;
    _logger.v(
      message,
      null,
      StackTrace.empty,
    );
  }

  void warning(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!_enable) return;
    _logger.w(message, error, stackTrace);
  }
}

class LoggerLogHandler implements LogHandler {
  static const String handlerKey = r'FluecoLoggerLogHandler';

  final LoggerService _loggerService;

  LoggerLogHandler({required LoggerService loggerService})
      : _loggerService = loggerService;

  @override
  void critical(LogMessage message) {
    final Object? error = message is ErrorLogMessage ? message.error : null;
    final StackTrace? stackTrace =
        message is ErrorLogMessage ? message.stackTrace : null;
    _loggerService.error(
      '[CRITICAL] ${message.content}',
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void debug(LogMessage message) {
    final Object? error = message is ErrorLogMessage ? message.error : null;
    final StackTrace? stackTrace =
        message is ErrorLogMessage ? message.stackTrace : null;
    _loggerService.debug(
      message.content,
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void error(LogMessage message) {
    final Object? error = message is ErrorLogMessage ? message.error : null;
    final StackTrace? stackTrace =
        message is ErrorLogMessage ? message.stackTrace : null;
    _loggerService.error(
      message.content,
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void info(LogMessage message) {
    _loggerService.info(
      message.content,
    );
  }

  @override
  void log(LogMessage message) {
    final Object? error = message is ErrorLogMessage ? message.error : null;
    final StackTrace? stackTrace =
        message is ErrorLogMessage ? message.stackTrace : null;
    _loggerService.debug(
      message.content,
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void warning(LogMessage message) {
    final Object? error = message is ErrorLogMessage ? message.error : null;
    final StackTrace? stackTrace =
        message is ErrorLogMessage ? message.stackTrace : null;
    _loggerService.warning(
      message.content,
      error: error,
      stackTrace: stackTrace,
    );
  }
}

class ErrorLogMessage extends LogMessage {
  final Object? error;
  final StackTrace? stackTrace;
  ErrorLogMessage({
    this.error,
    this.stackTrace,
    String? message,
  }) : super(content: message ?? error?.toString() ?? 'Unknown error');
}
