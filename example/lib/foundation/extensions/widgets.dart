import 'package:flutter/material.dart';

/// Extension to position a widget to another
extension PositionWidgetOnWidget on Widget {
  /// Get a [Row] that contains [of] at the left
  Widget atRight({
    required Widget of,
    double? spacing,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        of,
        if (spacing != null)
          SizedBox(
            width: spacing,
          ),
        this,
      ],
    );
  }

  /// Get a [Row] that contains [of] at the right
  Widget atLeft({
    required Widget of,
    double? spacing,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        this,
        if (spacing != null)
          SizedBox(
            width: spacing,
          ),
        of,
      ],
    );
  }
}
