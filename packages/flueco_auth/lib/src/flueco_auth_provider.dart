import 'package:flueco_auth/src/interceptors.dart';
import 'package:flueco_core/flueco_core.dart';

import 'authentication_provider.dart';
import 'authenticator.dart';

/// [ServiceProvider] for the authentication system.
class FluecoAuthProvider extends ServiceProvider {
  final bool populateOnInitialization;
  final List<AuthenticationProvider> _providers;

  /// Creates a new [FluecoAuthProvider].
  FluecoAuthProvider({
    required this.populateOnInitialization,
    List<AuthenticationProvider> providers = const <AuthenticationProvider>[],
  }) : _providers = providers;

  @override
  Set<Type> dependsOn() {
    return <Type>{
      EventHandler,
      AuthenticationInterceptors,
      AuthenticationProvidersFactory,
    };
  }

  @override
  Future<void> initialize(FluecoApp app) async {
    if (populateOnInitialization) {
      app.resolver.resolve<Authenticator>().populate();
    }
  }

  @override
  Future<void> register(ServiceInjector injector) async {
    injector.singleton<Authenticator>(
      (resolver) => Authenticator(
        providers: _providers,
        eventHandler: resolver.resolve<EventHandler>(),
        interceptors: resolver.resolve<AuthenticationInterceptors>(),
        authenticationProvidersFactory:
            resolver.resolve<AuthenticationProvidersFactory>(),
      ),
    );

    injector.factory<AuthenticationInvalidator>(
      (resolver) => resolver.resolve<Authenticator>(),
    );

    injector.factory<AuthenticationProcessor>(
      (resolver) => resolver.resolve<Authenticator>(),
    );

    injector.factory<AuthenticationStateProvider>(
      (resolver) => resolver.resolve<Authenticator>(),
    );
  }

  @override
  Set<Type> registered() {
    return <Type>{
      Authenticator,
    };
  }
}
