import 'package:flueco_core/flueco_core.dart';
import 'package:flutter/material.dart' hide AlertDialog;
import 'package:meta/meta.dart';

import '../widgets/components/alert_dialog.dart';
import '../widgets/components/confirm_dialog.dart';
import '../widgets/components/prompt_dialog.dart';

/// Service to show dialogs to the user.
///
/// This class provides methods to show alert, confirm and prompt dialogs to
/// the user.
///
/// To use this service, you need to provide a [NavigatorKeyProvider]
/// or get an instance through the service locator system using
/// `FluecoSR.of<DialogService>(context)` or dependency injection system by having
/// the `DialogService` as a dependency in your class.
///
/// ```dart
/// final dialogService = DialogService(
///   navigatorKeyProvider: navigatorKeyProvider,
/// );
/// ```
///
/// To show a dialog, you can use the [show] method:
///
/// ```dart
/// await dialogService.show(
///   builder: (context) {
///     return AlertDialog(
///       title: const Text('Hello'),
///       content: const Text('Hello, World!'),
///     );
///   },
/// );
/// ```
///
/// To show an alert dialog, you can use the [alert] method:
///
/// ```dart
/// await dialogService.alert(
///   data: AlertDialogData(
///     title: 'Hello',
///     content: 'Hello, World!',
///   ),
/// );
/// ```
///
/// To show a confirm dialog, you can use the [confirm] method:
///
/// ```dart
/// final result = await dialogService.confirm(
///   data: ConfirmDialogData(
///     title: 'Hello',
///     content: 'Hello, World!',
///   ),
/// );
/// ```
///
/// To show a prompt dialog, you can use the [prompt] method:
///
/// ```dart
/// await dialogService.prompt(
///   data: PromptDialogData(
///     title: 'Hello',
///     content: 'What is your name?',
///     initialValue: 'World',
///   ),
/// );
/// ```
class DialogService {
  final NavigatorKeyProvider _navigatorKeyProvider;

  /// Handler for logs.
  ///
  /// Do not use this directly.
  @internal
  late final LogHandler logHandler = DialogLogHandler(dialogService: this);

  /// Handler for notifications.
  ///
  /// Do not use this directly.
  @internal
  late final NotificationHandler notificationHandler =
      DialogNotificationHandler(dialogService: this);

  DialogService({
    required NavigatorKeyProvider navigatorKeyProvider,
  }) : _navigatorKeyProvider = navigatorKeyProvider;

  /// Show dialog to the user using [showDialog] method.
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

  /// Hide dialog using [Navigator.pop] method.
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
  ///
  /// It will return `true` if the user validates the input, `false` if
  /// the user cancels the dialog, and `null` if the dialog is closed
  /// by other means.
  Future<bool?> prompt({required PromptDialogData data}) async {
    return await show<bool?>(
      builder: (context) {
        return PromptDialog(
          data: data,
        );
      },
      barrierDismissible: false,
    );
  }
}

/// Handler for notifications.
@internal
class DialogNotificationHandler implements NotificationHandler {
  /// Key to identify this handler.
  static const String handlerKey = r'FluecoDialogNotificationHandler';

  final DialogService _dialogService;

  /// Create a new instance of [DialogNotificationHandler].
  @internal
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

/// Handler for logs.
@internal
class DialogLogHandler implements LogHandler {
  /// Key to identify this handler.
  static const String handlerKey = r'FluecoDialogLogHandler';

  final DialogService _dialogService;

  /// Create a new instance of [DialogLogHandler].
  @internal
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
