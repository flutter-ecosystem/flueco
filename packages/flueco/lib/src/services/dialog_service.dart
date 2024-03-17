import 'package:flueco_core/flueco_core.dart';
import 'package:flutter/material.dart' hide AlertDialog;

import '../widgets/components/alert_dialog.dart';
import '../widgets/components/confirm_dialog.dart';
import '../widgets/components/prompt_dialog.dart';

/// Dialog service
class DialogService {
  static const String logHandlerKey = 'FluecoDialogService';

  final NavigatorKeyProvider _navigatorKeyProvider;

  DialogService({
    required NavigatorKeyProvider navigatorKeyProvider,
  }) : _navigatorKeyProvider = navigatorKeyProvider;

  Future<T?> show<T>(
      {required WidgetBuilder builder, bool barrierDismissible = false}) async {
    final BuildContext? context =
        _navigatorKeyProvider.navigatorKey.currentContext;
    if (context == null) {
      return null;
    }
    final result = await showDialog<T>(
      context: context,
      builder: builder,
      barrierDismissible: barrierDismissible,
    );
    return result;
  }

  Future<void> hide<T>([T? result]) async {
    final currentState = _navigatorKeyProvider.navigatorKey.currentState;
    if (currentState == null) {
      return;
    }
    return currentState.pop(result);
  }

  /// Show alert dialog to the user using [AlertDialog] widget.
  Future<void> alert({required AlertDialogData data}) async {
    await show(
      builder: (context) {
        return AlertDialog(
          data: data,
        );
      },
      barrierDismissible: false,
    );
  }

  /// Show confirm dialog to the user using [ConfirmDialog] widget.
  ///
  /// It will return `true` if the user accepts, `false` if not and `null`
  /// if navigator context is not found or the user closes the dialog by other
  /// means.
  Future<bool?> confirm({required BaseConfirmDialogData data}) async {
    return await show<bool>(
      builder: (context) {
        return ConfirmDialog(
          data: data,
        );
      },
      barrierDismissible: false,
    );
  }

  /// Show prompt dialog to the user using [PromptDialog] widget.
  Future<void> prompt({required PromptDialogData data}) async {
    return await show(
      builder: (context) {
        return PromptDialog(
          data: data,
        );
      },
      barrierDismissible: false,
    );
  }
}

class DialogNotificationHandler implements NotificationHandler {
  static const String handlerKey = r'FluecoDialogNotificationHandler';

  final DialogService _dialogService;

  DialogNotificationHandler({required DialogService dialogService})
      : _dialogService = dialogService;
  @override
  Future<void> ask(AskMessage message) async {
    await _dialogService.confirm(
      data: ConfirmActionsDialogData(
        title: message.title ?? 'Ask',
        content: message.content,
        actions: message.actions
            .map((e) => ConfirmAction(label: e.label, onTap: e.callback))
            .toList(),
      ),
    );
  }

  @override
  Future<bool> confirm(InformMessage message) async {
    return await _dialogService.confirm(
          data: ConfirmDialogData(
            title: message.title ?? 'Ask',
            content: message.content,
          ),
        ) ??
        false;
  }

  @override
  Future<void> inform(InformMessage message) async {
    await _dialogService.alert(
      data: AlertDialogData(
        title: message.title ?? 'Ask',
        content: message.content,
      ),
    );
  }
}

class DialogLogHandler implements LogHandler {
  static const String handlerKey = r'FluecoDialogLogHandler';

  final DialogService _dialogService;

  DialogLogHandler({required DialogService dialogService})
      : _dialogService = dialogService;

  @override
  void critical(LogMessage message) {
    _dialogService.alert(
      data: AlertDialogData(
        title: 'Critical',
        content: message.content,
      ),
    );
  }

  @override
  void debug(LogMessage message) {
    _dialogService.alert(
      data: AlertDialogData(
        title: 'Debug',
        content: message.content,
      ),
    );
  }

  @override
  void error(LogMessage message) {
    _dialogService.alert(
      data: AlertDialogData(
        title: 'Error',
        content: message.content,
      ),
    );
  }

  @override
  void info(LogMessage message) {
    _dialogService.alert(
      data: AlertDialogData(
        title: 'Info',
        content: message.content,
      ),
    );
  }

  @override
  void log(LogMessage message) {
    _dialogService.alert(
      data: AlertDialogData(
        title: 'Info',
        content: message.content,
      ),
    );
  }

  @override
  void warning(LogMessage message) {
    _dialogService.alert(
      data: AlertDialogData(
        title: 'Warning',
        content: message.content,
      ),
    );
  }
}
