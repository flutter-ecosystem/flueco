import 'package:flueco_core/flueco_core.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ToastService {
  final NavigatorKeyProvider _navigatorKeyProvider;

  late final LogHandler logHandler = ToastLogHandler(toastService: this);

  ToastService({
    required NavigatorKeyProvider navigatorKeyProvider,
  }) : _navigatorKeyProvider = navigatorKeyProvider;

  /// Show a toast message
  Future<void> show(String message) async {
    final BuildContext? context =
        _navigatorKeyProvider.navigatorKey.currentContext;

    final ColorScheme? colorScheme =
        context == null ? null : Theme.of(context).colorScheme;
    final TextStyle? textStyle =
        context == null ? null : Theme.of(context).textTheme.bodyMedium;
    Toast.show(
      message,
      duration: 5,
      rootNavigator: true,
      backgroundColor: colorScheme?.inverseSurface ?? const Color(0xAA000000),
      textStyle: textStyle?.copyWith(color: colorScheme?.onInverseSurface) ??
          const TextStyle(fontSize: 15, color: Colors.white),
    );
  }
}

class ToastLogHandler implements LogHandler {
  static const String handlerKey = r'FluecoToastLogHandler';

  final ToastService _toastService;

  ToastLogHandler({required ToastService toastService})
      : _toastService = toastService;

  @override
  void critical(LogMessage message) {
    _toastService.show('[CRITICAL] ${message.content}');
  }

  @override
  void debug(LogMessage message) {
    _toastService.show('[DEBUG] ${message.content}');
  }

  @override
  void error(LogMessage message) {
    _toastService.show('[ERROR] ${message.content}');
  }

  @override
  void info(LogMessage message) {
    _toastService.show('[INFO] ${message.content}');
  }

  @override
  void log(LogMessage message) {
    _toastService.show('[LOG] ${message.content}');
  }

  @override
  void warning(LogMessage message) {
    _toastService.show('[WARNING] ${message.content}');
  }
}
