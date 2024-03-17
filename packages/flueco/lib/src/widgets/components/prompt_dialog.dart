// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'base_dialog.dart';

class PromptDialog extends StatelessWidget {
  const PromptDialog({
    super.key,
    required this.data,
  });

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
          decoration: InputDecoration(
            hintText: data.input.hintText,
          ),
        ),
      ),
    );
  }
}

class PromptDialogData {
  final String title;
  final String? content;
  final PromptDialogDataInput input;
  final String? validateLabel;
  final String? cancelLabel;
  PromptDialogData({
    required this.title,
    this.content,
    required this.input,
    this.validateLabel,
    this.cancelLabel,
  });
}

class PromptDialogDataInput {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String? data)? validator;
  final bool obscureText;
  PromptDialogDataInput({
    required this.hintText,
    required this.controller,
    this.validator,
    this.obscureText = false,
  });
}
