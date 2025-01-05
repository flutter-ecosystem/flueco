import 'package:flutter/material.dart';

import 'base_dialog.dart';

/// Widget to show a prompt dialog to the user.
class PromptDialog extends StatelessWidget {
  /// Create a new instance of [PromptDialog].
  const PromptDialog({
    super.key,
    required this.data,
  });

  /// Data for the prompt dialog
  final PromptDialogData data;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>(debugLabel: 'PromptDialogForm');
    return CommonDialog(
      data: CommonDialogData(
        title: data.title,
        content: data.content,
        actions: <CommonDialogAction>[
          CommonDialogAction(
            label: data.validateLabel ?? 'Validate',
            onTap: () {
              if (formKey.currentState?.validate() != false) {
                Navigator.pop(context);
              }
            },
          ),
          CommonDialogAction(
            label: data.cancelLabel ?? 'Cancel',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      footer: Form(
        key: formKey,
        child: TextFormField(
          validator: data.input.validator,
          obscureText: data.input.obscureText,
          controller: data.input.controller,
          decoration: data.input.decoration ??
              InputDecoration(
                hintText: data.input.hintText,
              ),
        ),
      ),
    );
  }
}

/// Data for the prompt dialog
class PromptDialogData {
  /// Title of the prompt dialog
  final String title;

  /// Content of the prompt dialog
  final String? content;

  /// Input for the prompt dialog
  final PromptDialogDataInput input;

  /// Label for the validate button
  final String? validateLabel;

  /// Label for the cancel button
  final String? cancelLabel;

  /// Create a new instance of [PromptDialogData]
  PromptDialogData({
    required this.title,
    this.content,
    required this.input,
    this.validateLabel,
    this.cancelLabel,
  });
}

/// Input for the prompt dialog
class PromptDialogDataInput {
  /// Hint text for the input
  final String? hintText;

  /// Controller for the input
  final TextEditingController controller;

  /// Validator for the input
  final String? Function(String? data)? validator;

  /// Whether the input is obscured
  final bool obscureText;

  /// Decoration for the input
  final InputDecoration? decoration;

  /// Create a new instance of [PromptDialogDataInput]
  PromptDialogDataInput({
    this.hintText,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.decoration,
  }) : assert(hintText != null || decoration != null);
}
