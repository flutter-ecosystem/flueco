import 'package:flueco_core/flueco_core.dart';
import 'package:flutter/material.dart';

class ThemeModeChangedEvent extends Event {
  final ThemeMode? oldThemeMode;
  final ThemeMode newThemeMode;

  const ThemeModeChangedEvent({
    this.oldThemeMode,
    required this.newThemeMode,
  });
}
