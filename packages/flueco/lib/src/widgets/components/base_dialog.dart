// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BaseDialog extends StatelessWidget {
  const BaseDialog({
    super.key,
    required this.child,
    this.margin,
    this.padding,
  });

  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final dialogTheme = Theme.of(context).dialogTheme;
    return Center(
      child: Padding(
        padding: margin ?? const EdgeInsets.all(48),
        child: Material(
          shape: dialogTheme.shape,
          shadowColor: dialogTheme.shadowColor,
          elevation: dialogTheme.elevation ?? 0,
          surfaceTintColor: dialogTheme.surfaceTintColor,
          color: dialogTheme.backgroundColor,
          textStyle: dialogTheme.contentTextStyle,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(24),
            child: child,
          ),
        ),
      ),
    );
  }
}

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    super.key,
    required this.data,
    this.footer,
  });

  final CommonDialogData data;

  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return BaseDialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            data.title,
            style:
                textTheme.headlineSmall?.copyWith(color: colorScheme.onSurface),
          ),
          if (data.content != null)
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
              ),
              child: Text(
                data.content!,
                style: textTheme.bodyMedium
                    ?.copyWith(color: colorScheme.onSurface),
              ),
            ),
          if (footer != null)
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
              ),
              child: footer,
            ),
          if (data.actions.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                top: 24,
              ),
              child: Wrap(
                alignment: WrapAlignment.end,
                runAlignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 8,
                spacing: 8,
                children: List<Widget>.generate(data.actions.length, (index) {
                  final action = data.actions.elementAt(index);
                  return TextButton(
                    autofocus: footer == null && index == 0,
                    style: TextButton.styleFrom(
                      minimumSize: const Size(48, 40),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      foregroundColor: colorScheme.inversePrimary,
                      iconColor: colorScheme.inversePrimary,
                      surfaceTintColor: colorScheme.surfaceTint,
                      textStyle: textTheme.labelLarge
                          ?.copyWith(color: colorScheme.inversePrimary),
                    ),
                    onPressed: action.onTap,
                    child: Text(action.label),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}

class CommonDialogData {
  final String title;
  final String? content;
  final List<CommonDialogAction> actions;
  CommonDialogData({
    required this.title,
    this.content,
    required this.actions,
  });
}

class CommonDialogAction {
  final String label;
  final VoidCallback onTap;
  CommonDialogAction({
    required this.label,
    required this.onTap,
  });
}
