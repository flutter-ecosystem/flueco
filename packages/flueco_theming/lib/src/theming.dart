// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flueco_core/flueco_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'events/appearance_changed_event.dart';
import 'events/platform_brightness_changed_event.dart';
import 'events/theme_mode_changed_event.dart';
import 'interfaces/appearance_provider.dart';
import 'interfaces/theming_provider.dart';
import 'models/appearance.dart';

const String _saveKey = r'flueco_theming_theme_mode';

class ThemingConfig {
  final ThemeMode? initialThemeMode;
  final String selectedAppearanceKey;
  final Set<Appearance> appearances;
  final ThemingThemeModeInitStrategy initStrategy;

  ThemingConfig({
    this.initialThemeMode,
    required this.selectedAppearanceKey,
    required this.appearances,
    this.initStrategy =
        ThemingThemeModeInitStrategy.preferSavedThemeModeWhenInitialNull,
  }) : assert(appearances.isNotEmpty, 'The appearances should not be empty');
}

class Theming
    with WidgetsBindingObserver
    implements ThemingProvider, AppearanceProvider {
  late Brightness _platformBrightness;
  ThemeMode? _selectedThemeMode;

  final EventHandler _eventHandler;
  final LocalStorage _localStorage;
  final ThemingThemeModeInitStrategy initStrategy;

  late Appearance _currentAppearance;
  final Set<Appearance> _appearances;

  Theming({
    required ThemingConfig config,
    required LocalStorage localStorage,
    required EventHandler eventHandler,
  })  : _currentAppearance = config.appearances.firstWhere(
            (element) => element.key == config.selectedAppearanceKey),
        _selectedThemeMode = config.initialThemeMode,
        _appearances = config.appearances,
        initStrategy = config.initStrategy,
        _eventHandler = eventHandler,
        _localStorage = localStorage;

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    final brightness = PlatformDispatcher.instance.platformBrightness;
    if (brightness != platformBrightness) {
      _changePlatformBrightness(brightness);
    }
  }

  @override
  Iterable<Appearance> get appearances => Iterable.generate(
      _appearances.length, (index) => _appearances.elementAt(index));

  @override
  Brightness get brightness {
    if (_selectedThemeMode != null && _selectedThemeMode != ThemeMode.system) {
      return _selectedThemeMode != ThemeMode.dark
          ? Brightness.light
          : Brightness.dark;
    }
    return platformBrightness;
  }

  @override
  Appearance get current => _currentAppearance;

  @override
  ThemeData get darkTheme => current.darkTheme;

  @override
  ThemeData get lightTheme => current.lightTheme;

  @override
  Brightness get platformBrightness => _platformBrightness;

  @override
  ThemeData get theme => brightness == Brightness.dark ? darkTheme : lightTheme;

  @override
  ThemeMode get themeMode => _selectedThemeMode ?? ThemeMode.system;

  @override
  void add(Appearance appearance) {
    _appearances.add(appearance);
  }

  /// Change the platform brightness
  void _changePlatformBrightness(Brightness brightness) {
    final PlatformBrightnessChangedEvent event = PlatformBrightnessChangedEvent(
      newBrightness: brightness,
      oldBrightness: _platformBrightness,
    );
    _platformBrightness = brightness;
    _eventHandler.emit(event);
  }

  @override
  void changeThemeMode(ThemeMode mode) {
    final ThemeModeChangedEvent event = ThemeModeChangedEvent(
      newThemeMode: mode,
      oldThemeMode: _selectedThemeMode,
    );
    _selectedThemeMode = mode;
    _localStorage.set(_saveKey, mode.name);
    _eventHandler.emit(event);
  }

  /// Initialize
  Future<void> initialize() async {
    _platformBrightness = PlatformDispatcher.instance.platformBrightness;
    WidgetsBinding.instance.addObserver(this);

    if (initStrategy == ThemingThemeModeInitStrategy.preferSavedThemeMode ||
        (_selectedThemeMode == null &&
            initStrategy ==
                ThemingThemeModeInitStrategy
                    .preferSavedThemeModeWhenInitialNull)) {
      final String? savedThemeMode = await _localStorage.get(_saveKey);
      final Iterable<ThemeMode> modes =
          ThemeMode.values.where((element) => element.name == savedThemeMode);
      if (modes.isNotEmpty) {
        _selectedThemeMode = modes.first;
      }
    }
  }

  @override
  void remove(Appearance appearance) {
    _appearances.remove(appearance);
  }

  @override
  void removeByKey(String key) {
    _appearances.removeWhere((element) => element.key == key);
  }

  @override
  bool select(String key) {
    final selectableAppearances =
        _appearances.where((element) => element.key == key);
    if (selectableAppearances.isNotEmpty) {
      final AppearanceChangedEvent event = AppearanceChangedEvent(
        oldAppearance: _currentAppearance,
        newAppearance: selectableAppearances.first,
      );
      _currentAppearance = selectableAppearances.first;
      _eventHandler.emit(event);
      return true;
    }
    return false;
  }
}

enum ThemingThemeModeInitStrategy {
  preferSavedThemeMode,
  preferSavedThemeModeWhenInitialNull,
  preferInitialThemeMode,
}
