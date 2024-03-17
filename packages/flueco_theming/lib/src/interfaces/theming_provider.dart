import 'package:flutter/material.dart';

abstract class ThemingProvider {
  /// Get the current [ThemeData]
  ThemeData get theme;

  /// Get the current light [ThemeData]
  ThemeData get lightTheme;

  /// Get the current dark [ThemeData]
  ThemeData get darkTheme;

  /// Get the current [ThemeMode]
  ThemeMode get themeMode;

  /// Change the current theme mode.
  void changeThemeMode(ThemeMode mode);

  /// Get the current [Brightness].
  ///
  /// If there's a selected [ThemeMode]
  /// different from [ThemeMode.system] then it'll return the brightness
  /// related to this mode otherwise it will return the [platformBrightness].
  Brightness get brightness;

  /// Get the [Brightness] of the platform.
  Brightness get platformBrightness;
}
