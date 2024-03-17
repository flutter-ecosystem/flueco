// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'base_dialog.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.data,
  });

  final BaseConfirmDialogData data;

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      data: CommonDialogData(
        title: data.title,
        content: data.content,
        actions: data is ConfirmActionsDialogData
            ? (data as ConfirmActionsDialogData)
                .actions
                .map((e) => CommonDialogAction(
                    label: e.label,
                    onTap: () {
                      e.onTap();
                      Navigator.pop(context);
                    }))
                .toList()
            : data is ConfirmDialogData
                ? <CommonDialogAction>[
                    CommonDialogAction(
                      label: (data as ConfirmDialogData).yesLabel ?? 'Yes',
                      onTap: () {
                        Navigator.pop<bool>(context, true);
                      },
                    ),
                    CommonDialogAction(
                      label: (data as ConfirmDialogData).noLabel ?? 'No',
                      onTap: () {
                        Navigator.pop<bool>(context, false);
                      },
                    ),
                  ]
                : <CommonDialogAction>[],
      ),
    );
  }
}

class BaseConfirmDialogData {
  final String title;
  final String content;
  BaseConfirmDialogData({
    required this.title,
    required this.content,
  });
}

class ConfirmDialogData extends BaseConfirmDialogData {
  final String? yesLabel;
  final String? noLabel;
  ConfirmDialogData({
    required super.title,
    required super.content,
    this.yesLabel,
    this.noLabel,
  });
}

class ConfirmAction {
  final String label;
  final VoidCallback onTap;

  ConfirmAction({
    required this.label,
    required this.onTap,
  });
}

class ConfirmActionsDialogData extends BaseConfirmDialogData {
  final List<ConfirmAction> actions;
  ConfirmActionsDialogData({
    required super.title,
    required super.content,
    required this.actions,
  });
}
