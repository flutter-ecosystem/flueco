import 'package:flutter/material.dart';

import '../../services/dialog_service.dart';
import 'base_dialog.dart';

/// Widget to show a loading dialog to the user.
class LoadingDialog extends StatelessWidget {
  /// Create a new instance of [LoadingDialog]
  const LoadingDialog({
    super.key,
  });

  /// Show the loading dialog.
  static Future<void> show(DialogService dialogService) {
    return dialogService.show(
      builder: (_) {
        return const LoadingDialog();
      },
      barrierDismissible: false,
    );
  }

  /// Hide the loading dialog.
  static Future<void> hide(DialogService dialogService) async {
    try {
      return dialogService.hide();
    } catch (e) {
      debugPrint('Error hiding loading dialog: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: BaseDialog(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
