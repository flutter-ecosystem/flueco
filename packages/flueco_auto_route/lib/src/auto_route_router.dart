import 'package:auto_route/auto_route.dart';
import 'package:flueco_core/flueco_core.dart';
import 'package:flutter/widgets.dart' hide Router;

import 'auto_route_root_router_provider.dart';

/// Implementation of [Router] using auto_route
class AutoRouteRouter
    implements Router, AutoRouteRootRouterProvider, NavigatorKeyProvider {
  final RootStackRouter _rootRouter;

  /// Constructor
  AutoRouteRouter(RootStackRouter rootRouter) : _rootRouter = rootRouter;

  @override
  Future<T?> pushWidget<T>(Widget page) {
    return _rootRouter.pushWidget<T>(page);
  }

  @override
  Future<T?> pushPage<T>(PageRoute<T> page) {
    return _rootRouter.pushNativeRoute<T>(page);
  }

  @override
  void pop<T>([T? result]) {
    _rootRouter.pop<T>(result);
  }

  @override
  RootStackRouter get rootRouter => _rootRouter;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _rootRouter.navigatorKey;
}
