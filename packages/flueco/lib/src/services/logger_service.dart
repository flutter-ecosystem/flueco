// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'package:flueco_core/flueco_core.dart';
import 'package:meta/meta.dart';

/// Service to log messages to the console
///
/// This class provides methods to log messages to the console. It provides
/// logging levels for debugging, info, warning, error and critical messages.
///
/// To use this service, you need to provide a [LoggerService] instance
/// or get an instance through the service locator system using
/// `FluecoSR.of<LoggerService>(context)` or dependency injection system by having
/// the `LoggerService` as a dependency in your class.
///
/// ```dart
/// final loggerService = LoggerService(
///   enable: true,
/// );
/// ```
///
/// To log a message, you can use the [debug], [info], [warning], [error] and
/// [critical] methods:
///
/// ```dart
/// loggerService.debug('Hello, World!');
/// loggerService.info('Hello, World!');
/// loggerService.warning('Hello, World!');
/// loggerService.error('Hello, World!');
/// loggerService.critical('Hello, World!');
/// ```
///
/// To enable or disable logging, you can use the [enable] and [disable] methods:
///
/// ```dart
/// loggerService.enable();
/// loggerService.disable();
/// ```
class LoggerService {
  final Logger _logger;

  late final LogHandler logHandler = LoggerLogHandler(loggerService: this);

  /// Log is enable
  bool _enable;

  /// Create a new instance of [LoggerService].
  /// The [enable] parameter is used to enable or disable logging.
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

  /// Log a debug message
  ///
  /// The [message] parameter is the message to log.
  /// The [error] parameter is the error to log.
  /// The [stackTrace] parameter is the stack trace to log.
  void debug(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!_enable) return;
    _logger.d(message, error, stackTrace);
  }

  /// Log a error message
  ///
  /// The [message] parameter is the message to log.
  /// The [error] parameter is the error to log.
  /// The [stackTrace] parameter is the stack trace to log.
  void error(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!_enable) return;
    _logger.e(message, error, stackTrace);
  }

  /// Log a info message
  void info(dynamic message) {
    if (!_enable) return;
    _logger.i(
      message,
      null,
      StackTrace.empty,
    );
  }

  /// Log a verbose message
  void verbose(dynamic message) {
    if (!_enable) return;
    _logger.v(
      message,
      null,
      StackTrace.empty,
    );
  }

  /// Log a warning message
  ///
  /// The [message] parameter is the message to log.
  /// The [error] parameter is the error to log.
  /// The [stackTrace] parameter is the stack trace to log.
  void warning(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!_enable) return;
    _logger.w(message, error, stackTrace);
  }
}

/// Log handler for the [LoggerService]
@internal
class LoggerLogHandler implements LogHandler {
  /// Key to identify this handler.
  static const String handlerKey = r'FluecoLoggerLogHandler';

  final LoggerService _loggerService;

  /// Create a new instance of [LoggerLogHandler].
  @internal
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

/// Log message for error.
class ErrorLogMessage extends LogMessage {
  final Object? error;
  final StackTrace? stackTrace;
  ErrorLogMessage({
    this.error,
    this.stackTrace,
    String? message,
  }) : super(content: message ?? error?.toString() ?? 'Unknown error');
}
