import 'package:auto_route/auto_route.dart';
import 'package:flueco_core/flueco_core.dart';

import 'auto_route_root_router_provider.dart';
import 'auto_route_router.dart';

class AutoRouteServiceProvider extends RouterServiceProvider {
  @override
  Set<Type> dependsOn() {
    return <Type>{
      RootStackRouter,
    };
  }

  @override
  Future<void> initialize(FluecoApp app) async {}

  @override
  NavigatorKeyProvider navigatorKeyProviderFactory(ServiceResolver resolver) {
    return resolver.resolve<AutoRouteRouter>();
  }

  @override
  Router routerFactory(ServiceResolver resolver) {
    return resolver.resolve<AutoRouteRouter>();
  }

  @override
  Future<void> register(ServiceInjector injector) async {
    injector.lazySingleton<AutoRouteRouter>(
      (resolver) => AutoRouteRouter(
        resolver.resolve<RootStackRouter>(),
      ),
    );

    await super.register(injector);

    injector.factory<AutoRouteRootRouterProvider>(
        (resolver) => resolver.resolve<AutoRouteRouter>());
  }

  @override
  Set<Type> registered() {
    return <Type>{
      ...super.registered(),
      AutoRouteRouter,
      AutoRouteRootRouterProvider,
    };
  }
}
