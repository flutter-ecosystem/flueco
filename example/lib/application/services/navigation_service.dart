import 'package:example/domain/contracts/navigation_contracts.dart';
import 'package:example/presentation/routing/app_router.dart';
import 'package:flueco/flueco.dart';

/// Service for navigation
final class NavigationService
    implements NavigateToAuthContract, NavigateToHomeContract {
  final AppRouter _appRouter;

  /// Creates an instance of [NavigationService]
  NavigationService({required AppRouter appRouter}) : _appRouter = appRouter;

  @override
  Future<void> navigateToAuth({
    RouteReplacementStrategy replacementStrategy =
        RouteReplacementStrategy.none,
  }) async {
    return _navigateTo(
      const AuthRoute(),
      replacementStrategy: replacementStrategy,
    );
  }

  @override
  Future<void> navigateToHome({
    RouteReplacementStrategy replacementStrategy =
        RouteReplacementStrategy.none,
  }) {
    return _navigateTo(
      const HomeRoute(),
      replacementStrategy: replacementStrategy,
    );
  }

  Future<T?> _navigateTo<T>(
    PageRouteInfo<dynamic> route, {
    RouteReplacementStrategy replacementStrategy =
        RouteReplacementStrategy.none,
  }) async {
    switch (replacementStrategy) {
      case RouteReplacementStrategy.all:
        return _appRouter.pushAndPopUntil<T>(
          route,
          predicate: (_) => false,
        );
      case RouteReplacementStrategy.current:
        return _appRouter.replace<T>(
          route,
        );
      default:
        await _appRouter.navigate(route);
        return null;
    }
  }
}
