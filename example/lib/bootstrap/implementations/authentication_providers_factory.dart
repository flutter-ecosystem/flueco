import 'package:example/foundation/abstractions/instance_resolver.dart';
import 'package:flueco/flueco.dart';
import 'package:flueco_auth/flueco_auth.dart';
import 'package:flueco_auth_token/flueco_auth_token.dart';

/// Implementation of [AuthenticationProvidersFactory]
class ExampleAuthenticationProvidersFactory
    implements AuthenticationProvidersFactory {
  final ResolverOf<LocalStorage> _localStorageResolver;
  final ResolverOf<SecureStorage> _secureStorageResolver;
  final ResolverOf<TokenAuthenticationHandlerFactory>
      _tokenAuthenticationHandlerFactoryResolver;

  /// Creates an instance of [ExampleAuthenticationProvidersFactory]
  ExampleAuthenticationProvidersFactory({
    required ResolverOf<LocalStorage> localStorageResolver,
    required ResolverOf<SecureStorage> secureStorageResolver,
    required ResolverOf<TokenAuthenticationHandlerFactory>
        tokenAuthenticationHandlerFactoryResolver,
  })  : _localStorageResolver = localStorageResolver,
        _secureStorageResolver = secureStorageResolver,
        _tokenAuthenticationHandlerFactoryResolver =
            tokenAuthenticationHandlerFactoryResolver;

  @override
  Iterable<AuthenticationProvider> getProviders() {
    return <AuthenticationProvider>[
      TokenAuthenticationProvider(
        secureStorage: _secureStorageResolver(),
        localStorage: _localStorageResolver(),
        tokenAuthenticationHandlerFactory:
            _tokenAuthenticationHandlerFactoryResolver(),
        tokenKeys: const DefaultTokenKeys(),
      ),
    ];
  }
}
