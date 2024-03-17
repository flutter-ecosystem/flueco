// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../services/dialog_service.dart';
import 'base_dialog.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    super.key,
  });

  static Future<void> show(DialogService dialogService) {
    return dialogService.show(
      builder: (_) {
        return const LoadingDialog();
      },
      barrierDismissible: false,
    );
  }

  static Future<void> hide(DialogService dialogService) async {
    try {
      return dialogService.hide();
    } catch (e) {
      //
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
