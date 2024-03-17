import 'package:example/foundation/abstractions/instance_resolver.dart';
import 'package:example/presentation/routing/app_router.dart';
import 'package:flueco/flueco.dart';
import 'package:flueco_auth/flueco_auth.dart';

/// Resolver of [Authenticator]
typedef ResolverOfAuthenticator = ResolverOf<Authenticator>;

/// Guard of authentication
class AuthGuard extends AutoRouteGuard {
  final ResolverOfAuthenticator _resolverOfAuthenticator;

  /// Creates an instance of [AuthGuard]
  AuthGuard({required ResolverOfAuthenticator resolverOfAuthenticator})
      : _resolverOfAuthenticator = resolverOfAuthenticator;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final Authenticator authenticator = _resolverOfAuthenticator();

    if (authenticator.authenticated) {
      resolver.next();
    } else {
      resolver.redirect(
        const AuthRoute(),
        replace: true,
      );
    }
  }
}
