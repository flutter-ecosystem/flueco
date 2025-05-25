import 'package:flueco/flueco.dart';
import 'package:flueco_state_management/flueco_state_management.dart';
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
  }
}
