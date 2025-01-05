// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'base_dialog.dart';

/// Widget to show an alert dialog to the user.
class AlertDialog extends StatelessWidget {
  /// Create a new instance of [AlertDialog].
  const AlertDialog({
    super.key,
    required this.data,
  });

  /// Data for the alert dialog
  final AlertDialogData data;

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      data: CommonDialogData(
        title: data.title,
        content: data.content,
        actions: <CommonDialogAction>[
          CommonDialogAction(
            label: data.okLabel ?? 'OK',
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}

/// Data for the alert dialog
class AlertDialogData {
  /// Title of the alert dialog
  final String title;

  /// Content of the alert dialog
  final String content;

  /// Label for the OK button
  final String? okLabel;

  /// Create a new instance of [AlertDialogData]
  AlertDialogData({
    required this.title,
    required this.content,
    this.okLabel,
  });
}
