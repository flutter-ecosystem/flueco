import 'package:flueco_core/flueco_core.dart';
import 'package:flutter/material.dart';

import '../events/appearance_changed_event.dart';
import '../events/platform_brightness_changed_event.dart';
import '../events/theme_mode_changed_event.dart';
import '../interfaces/appearance_provider.dart';
import '../interfaces/theming_provider.dart';
import '../models/appearance.dart';

enum ThemingAspect { platformBrightness, appearance, themeMode }

class Theming extends InheritedModel<ThemingAspect> {
  const Theming({
    super.key,
    this.platformBrightness,
    required this.appearance,
    required this.themeMode,
    required super.child,
  });

  final Brightness? platformBrightness;
  final Appearance appearance;
  final ThemeMode themeMode;

  /// Get [Theming] from context
  static Theming? maybeOf(BuildContext context, [ThemingAspect? aspect]) {
    return InheritedModel.inheritFrom<Theming>(context, aspect: aspect);
  }

  /// Get [Theming] from context.
  static Theming of(BuildContext context, [ThemingAspect? aspect]) {
    final Theming? result = maybeOf(context, aspect);
    assert(result != null, 'Unable to find an instance of Theming');
    return result!;
  }

  static Brightness? platformBrightnessOf(BuildContext context) {
    return of(context, ThemingAspect.platformBrightness).platformBrightness;
  }

  static Appearance appearanceOf(BuildContext context) {
    return of(context, ThemingAspect.appearance).appearance;
  }

  static ThemeMode themeModeOf(BuildContext context) {
    return of(context, ThemingAspect.themeMode).themeMode;
  }

  @override
  bool isSupportedAspect(Object aspect) =>
      ThemingAspect.values.contains(aspect);

  @override
  bool updateShouldNotify(Theming oldWidget) {
    return appearance != oldWidget.appearance ||
        themeMode != oldWidget.themeMode ||
        platformBrightness != oldWidget.platformBrightness;
  }

  @override
  bool updateShouldNotifyDependent(
      Theming oldWidget, Set<ThemingAspect> dependencies) {
    if (appearance != oldWidget.appearance &&
        dependencies.contains(ThemingAspect.appearance)) {
      return true;
    }
    if (platformBrightness != oldWidget.platformBrightness &&
        dependencies.contains(ThemingAspect.platformBrightness)) {
      return true;
    }
    if (themeMode != oldWidget.themeMode &&
        dependencies.contains(ThemingAspect.themeMode)) {
      return true;
    }
    return false;
  }
}

typedef ThemingProviderWidgetBuilder = Widget Function(BuildContext context,
    Appearance appearance, Brightness? platformBrightness, ThemeMode themeMode);

class ThemingProviderBuilder extends StatefulWidget {
  const ThemingProviderBuilder({
    super.key,
    required this.themingProvider,
    required this.builder,
    required this.appearanceProvider,
    required this.eventHandler,
  });

  final ThemingProvider themingProvider;
  final EventHandler eventHandler;
  final AppearanceProvider appearanceProvider;
  final ThemingProviderWidgetBuilder builder;

  @override
  State<ThemingProviderBuilder> createState() => _ThemingProviderBuilderState();
}

class _ThemingProviderBuilderState extends State<ThemingProviderBuilder>
    implements EventSubscriber {
  Brightness? platformBrightness;
  late Appearance appearance;
  late ThemeMode themeMode;

  @override
  void initState() {
    super.initState();

    platformBrightness = widget.themingProvider.platformBrightness;
    themeMode = widget.themingProvider.themeMode;
    appearance = widget.appearanceProvider.current;

    widget.eventHandler.subscribe(PlatformBrightnessChangedEvent, this);
    widget.eventHandler.subscribe(AppearanceChangedEvent, this);
    widget.eventHandler.subscribe(ThemeModeChangedEvent, this);
  }

  @override
  void dispose() {
    widget.eventHandler.unsubscribeAll(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theming(
      appearance: appearance,
      themeMode: themeMode,
      platformBrightness: platformBrightness,
      child: widget.builder(
        context,
        appearance,
        platformBrightness,
        themeMode,
      ),
    );
  }

  @override
  Future<void> onEvent(Event event) async {
    if (event is PlatformBrightnessChangedEvent) {
      platformBrightness = event.newBrightness;
      if (context.mounted) setState(() {});
    }
    if (event is AppearanceChangedEvent) {
      appearance = event.newAppearance;
      if (context.mounted) setState(() {});
    }
    if (event is ThemeModeChangedEvent) {
      themeMode = event.newThemeMode;
      if (context.mounted) setState(() {});
    }
  }
}
