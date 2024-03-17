// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'base_dialog.dart';

class AlertDialog extends StatelessWidget {
  const AlertDialog({
    super.key,
    required this.data,
  });

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

class AlertDialogData {
  final String title;
  final String content;
  final String? okLabel;
  AlertDialogData({
    required this.title,
    required this.content,
    this.okLabel,
  });
}
