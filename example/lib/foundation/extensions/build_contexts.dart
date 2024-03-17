import 'package:flutter/material.dart';

/// Extension to get [ThemeData] on [BuildContext]
extension ThemeDataOnBuildContext on BuildContext {
  /// Get the [ThemeData] on this context
  ThemeData get theme => Theme.of(this);
}

/// Extension to get texts from TextTheme on [BuildContext]
extension TextHeadingOnBuildContext on ThemeData {
  /// Get the [Text] widget for this string
  Widget textBody(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
  }) {
    return Text(
      text,
      style: textTheme.bodyMedium?.merge(style),
      textAlign: textAlign,
    );
  }

  ///
  Widget textDisplay(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
  }) {
    return Text(
      text,
      style: textTheme.displayMedium?.merge(style),
      textAlign: textAlign,
    );
  }
}
