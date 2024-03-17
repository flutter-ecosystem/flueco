import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'
    show Color, Icon, IconData, Text, TextAlign, TextStyle, Widget;

/// Extension to add [hint] method
extension HintDotsOnString on String {
  /// Get string with `...` at the end
  String hint() {
    if (endsWith('.')) {
      return this;
    }

    return '$this...';
  }
}

/// Extension to add [text] method
extension TextWidgetOnString on String {
  /// Get the [Text] widget for this string
  Widget text({
    TextStyle? style,
    TextAlign? textAlign,
  }) {
    return Text(
      this,
      style: style,
      textAlign: textAlign,
    );
  }
}

/// Extension to add [icon] method
extension IconWidgetOnString on IconData {
  /// Get the [Text] widget for this string
  Widget icon({
    double size = 20,
    Color? color,
  }) {
    return Icon(
      this,
      size: size,
      color: color,
    );
  }
}
