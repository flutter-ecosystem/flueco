import 'package:flueco/flueco.dart';

import '../ui/screens/pages/home/home.view.dart';
import '../ui/screens/pages/auth/auth/auth.view.dart';
import '../ui/screens/pages/auth/index.view.dart';
import 'guards.dart';

part 'app_router.gr.dart';

///
@AutoRouterConfig(generateForDir: <String>['lib/presentation/ui'])
class AppRouter extends RootStackRouter {
  final ResolverOfAuthenticator _resolverOfAuthenticator;

  /// Creates an instance of [AppRouter]
  AppRouter({
    super.navigatorKey,
    required ResolverOfAuthenticator resolverOfAuthenticator,
  }) : _resolverOfAuthenticator = resolverOfAuthenticator;

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          path: '/',
          page: HomeRoute.page,
          guards: <AutoRouteGuard>[
            AuthGuard(
              resolverOfAuthenticator: _resolverOfAuthenticator,
            ),
          ],
        ),
        AutoRoute(
          path: '/auth',
          page: AuthIndexRoute.page,
          children: <AutoRoute>[
            AutoRoute(
              path: '',
              page: AuthRoute.page,
            ),
          ],
        ),
      ];
}
