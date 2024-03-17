import 'package:flutter/material.dart';

class Appearance {
  final String key;
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  const Appearance({
    required this.key,
    required this.lightTheme,
    required this.darkTheme,
  });

  @override
  bool operator ==(covariant Appearance other) {
    if (identical(this, other)) return true;

    return other.key == key &&
        other.lightTheme == lightTheme &&
        other.darkTheme == darkTheme;
  }

  @override
  int get hashCode => key.hashCode ^ lightTheme.hashCode ^ darkTheme.hashCode;
}
