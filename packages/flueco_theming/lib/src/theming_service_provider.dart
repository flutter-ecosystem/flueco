import 'package:flueco_core/flueco_core.dart';

import 'interfaces/appearance_provider.dart';
import 'interfaces/theming_provider.dart';
import 'theming.dart';

class ThemingServiceProvider extends ServiceProvider {
  final ThemingConfig config;
  ThemingServiceProvider({
    required this.config,
  });
  @override
  Set<Type> dependsOn() {
    return <Type>{
      LocalStorage,
      EventHandler,
    };
  }

  @override
  Future<void> initialize(FluecoApp app) async {
    await app.resolver.resolve<Theming>().initialize();
  }

  @override
  Future<void> register(ServiceInjector injector) async {
    injector.singleton<Theming>(
      (resolver) => Theming(
        config: config,
        localStorage: resolver.resolve<LocalStorage>(),
        eventHandler: resolver.resolve<EventHandler>(),
      ),
    );

    injector
        .factory<ThemingProvider>((resolver) => resolver.resolve<Theming>());
    injector
        .factory<AppearanceProvider>((resolver) => resolver.resolve<Theming>());
  }

  @override
  Set<Type> registered() {
    return <Type>{
      Theming,
      ThemingProvider,
      AppearanceProvider,
    };
  }
}
