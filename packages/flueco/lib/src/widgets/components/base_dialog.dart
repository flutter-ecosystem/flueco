import 'package:flutter/material.dart';

/// Widget to show a dialog to the user.
class BaseDialog extends StatelessWidget {
  /// Create a new instance of [BaseDialog]
  const BaseDialog({
    super.key,
    required this.child,
    this.margin,
    this.padding,
  });

  /// The child widget of the dialog
  final Widget child;

  /// The margin of the dialog
  final EdgeInsetsGeometry? margin;

  /// The padding of the dialog
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

/// Common dialog widget to show a dialog to the user.
class CommonDialog extends StatelessWidget {
  /// Create a new instance of [CommonDialog]
  const CommonDialog({
    super.key,
    required this.data,
    this.footer,
  });

  /// Data for the common dialog
  final CommonDialogData data;

  /// The footer widget of the dialog
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

/// Data for the common dialog
class CommonDialogData {
  /// Title of the common dialog
  final String title;

  /// Content of the common dialog
  final String? content;

  /// Actions of the common dialog
  final List<CommonDialogAction> actions;

  /// Create a new instance of [CommonDialogData]
  CommonDialogData({
    required this.title,
    this.content,
    required this.actions,
  });
}

/// Action for the common dialog
class CommonDialogAction {
  /// Label of the action
  final String label;

  /// Callback when the action is tapped
  final VoidCallback onTap;

  /// Create a new instance of [CommonDialogAction]
  CommonDialogAction({
    required this.label,
    required this.onTap,
  });
}
