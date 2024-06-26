import 'package:flutter/foundation.dart';

import '../foundation/di/service_injector.dart';
import '../foundation/di/service_provider.dart';
import '../foundation/di/service_resolver.dart';
import 'navigator_key_provider.dart';
import 'router.dart';

/// Service provider for routing.
///
/// It allows to register the [Router] and [NavigatorKeyProvider]
abstract class RouterServiceProvider extends ServiceProvider {
  /// Factory method of [Router].
  Router routerFactory(ServiceResolver resolver);

  /// Factory method of [NavigatorKeyProvider].
  NavigatorKeyProvider navigatorKeyProviderFactory(ServiceResolver resolver);

  @override
  @mustCallSuper
  Future<void> register(ServiceInjector injector) async {
    injector.lazySingleton<Router>(routerFactory);
    injector.lazySingleton<NavigatorKeyProvider>(navigatorKeyProviderFactory);
  }

  @override
  @mustCallSuper
  Set<Type> registered() {
    return <Type>{
      Router,
      NavigatorKeyProvider,
    };
  }
}
