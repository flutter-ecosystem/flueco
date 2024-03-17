import 'package:flueco/flueco.dart';
import 'package:flutter/material.dart';

import '../../foundation/config/app_config.dart';
import '../../foundation/localizations/localizations.dart';
import '../routing/app_router.dart';

///
class App extends StatefulWidget {
  ///
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

/// AppState
class AppState extends State<App> {
  bool _firstBuildEmitted = false;

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = FluecoSR.of(context).resolve<AppRouter>();
    final AppConfig appConfig = FluecoSR.of(context).resolve<AppConfig>();
    final ThemingProvider themingProvider =
        FluecoSR.of(context).resolve<ThemingProvider>();
    final AppearanceProvider appearanceProvider =
        FluecoSR.of(context).resolve<AppearanceProvider>();
    final EventHandler eventHandler =
        FluecoSR.of(context).resolve<EventHandler>();

    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<AppConfig>.value(value: appConfig),
      ],
      builder: (BuildContext context, Widget? child) {
        return child!;
      },
      child: ThemingProviderBuilder(
        appearanceProvider: appearanceProvider,
        eventHandler: eventHandler,
        themingProvider: themingProvider,
        builder: (
          BuildContext context,
          Appearance appearance,
          Brightness? platformBrightness,
          ThemeMode themeMode,
        ) {
          return MaterialApp.router(
            routerConfig: appRouter.config(
              includePrefixMatches: true,
            ),
            builder: (_, Widget? child) {
              _emitFirstBuild();

              return Overlay(
                initialEntries: <OverlayEntry>[
                  OverlayEntry(
                    builder: (BuildContext context) {
                      ToastContext().init(context);

                      return child ?? const SizedBox();
                    },
                  ),
                ],
              );
            },
            title: appConfig.appName,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: appearance.lightTheme,
            darkTheme: appearance.darkTheme,
            themeMode: themeMode,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  // coverage:ignore-start
  void _emitFirstBuild() {
    if (!_firstBuildEmitted) {
      _firstBuildEmitted = true;
      FluecoSR.of(context)
          .resolve<EventHandler>()
          .emit(const AppFirstBuildEvent());
    }
  }
  // coverage:ignore-end

  void _initialize() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FluecoSR.of(context)
          .resolve<EventHandler>()
          .emit(const AppLaunchEvent(false, true));
    });
    if (mounted) {
      // ignore: no-empty-block
      setState(() {});
    }
  }
}
