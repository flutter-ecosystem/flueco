import 'package:flutter/material.dart';

import 'base_dialog.dart';

/// Widget to show a confirm dialog to the user.
class ConfirmDialog extends StatelessWidget {
  /// Create a new instance of [ConfirmDialog].
  const ConfirmDialog({
    super.key,
    required this.data,
  });

  /// Data for the confirm dialog
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

/// Data for the confirm dialog
class BaseConfirmDialogData {
  /// Title of the confirm dialog
  final String title;

  /// Content of the confirm dialog
  final String content;

  /// Create a new instance of [BaseConfirmDialogData]
  BaseConfirmDialogData({
    required this.title,
    required this.content,
  });
}

/// Data for the confirm dialog
class ConfirmDialogData extends BaseConfirmDialogData {
  /// Label for the Yes button
  final String? yesLabel;

  /// Label for the No button
  final String? noLabel;

  /// Create a new instance of [ConfirmDialogData]
  ConfirmDialogData({
    required super.title,
    required super.content,
    this.yesLabel,
    this.noLabel,
  });
}

/// Action for the confirm dialog
class ConfirmAction {
  /// Label of the action
  final String label;

  /// Callback when the action is tapped
  final VoidCallback onTap;

  /// Create a new instance of [ConfirmAction]
  ConfirmAction({
    required this.label,
    required this.onTap,
  });
}

/// Data for the confirm dialog with actions
class ConfirmActionsDialogData extends BaseConfirmDialogData {
  /// Actions of the confirm dialog
  final List<ConfirmAction> actions;

  /// Create a new instance of [ConfirmActionsDialogData]
  ConfirmActionsDialogData({
    required super.title,
    required super.content,
    required this.actions,
  });
}
