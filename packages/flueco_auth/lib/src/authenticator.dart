import 'package:flueco_auth/src/authentication.dart';
import 'package:flueco_auth/src/authentication_credentials.dart';
import 'package:flueco_auth/src/authentication_provider.dart';
import 'package:flueco_auth/src/interceptors.dart';
import 'package:flueco_core/flueco_core.dart';

import 'events/authentication.dart';
import 'events/invalidate.dart';
import 'events/populate.dart';
import 'events/refresh.dart';
import 'exceptions/authentication_provider_not_found_exception.dart';

/// Handles the authentication invalidation.
abstract interface class AuthenticationInvalidator {
  /// Invalidate the current authentication.
  Future<void> invalidate(Authentication authentication);
}

/// Process the authentication.
abstract interface class AuthenticationProcessor {
  /// Authenticate using the given [credentials].
  Future<Authentication> authenticate(AuthenticationCredentials credentials);

  /// Populate the saved authentication.
  Future<void> populate();

  /// Refresh the current authentication.
  Future<void> refresh();
}

/// Provides the current authentication state.
abstract interface class AuthenticationStateProvider {
  /// Returns true if the user is authenticated.
  bool get authenticated;

  /// Returns the current [Authentication] if any.
  Authentication? get authentication;

  /// Check if the current authentication is valid.
  Future<bool> isAuthenticationValid();
}

/// Authenticator class that handles the authentication process.
///
/// See also [AuthenticationProcessor], [AuthenticationStateProvider], [AuthenticationInvalidator]
class Authenticator
    implements
        AuthenticationProcessor,
        AuthenticationStateProvider,
        AuthenticationInvalidator {
  final List<AuthenticationProvider> _providers;
  final EventHandler _eventHandler;
  final AuthenticationInterceptionHandler _authenticationInterceptionHandler;
  final AuthenticationProvidersFactory _authenticationProvidersFactory;

  Authentication? _authentication;

  /// Creates a new [Authenticator].
  Authenticator({
    List<AuthenticationProvider> providers = const <AuthenticationProvider>[],
    required EventHandler eventHandler,
    required AuthenticationInterceptors interceptors,
    required AuthenticationProvidersFactory authenticationProvidersFactory,
  })  : _eventHandler = eventHandler,
        _authenticationInterceptionHandler = AuthenticationInterceptionHandler(
          interceptors: interceptors,
        ),
        _providers = providers,
        _authenticationProvidersFactory = authenticationProvidersFactory;

  @override
  bool get authenticated => _authentication != null;

  @override
  Authentication? get authentication {
    return _authentication;
  }

  /// Returns the list of providers.
  List<AuthenticationProvider> get providers {
    return <AuthenticationProvider>[
      ..._providers,
      ..._authenticationProvidersFactory.getProviders(),
    ];
  }

  /// Could throw [AuthenticationProviderNotFoundByCredentialsException]
  @override
  Future<Authentication> authenticate(
      AuthenticationCredentials credentials) async {
    final type = AuthenticationContextType.authenticate;
    AuthenticationProvider? provider;
    try {
      _eventHandler.emit(AuthenticateStartEvent());
      provider = _providerOfCredentials(credentials.uniqueClassId);

      await _notifyStart(
        type: type,
        provider: provider,
        credentials: credentials,
      );

      final authentication =
          await provider.authenticatorAgent.authenticate(credentials);
      _authentication = authentication;

      await _notifyDone(
        type: type,
        provider: provider,
        authentication: authentication,
      );

      await provider.store.save(authentication);

      _eventHandler.emit(AuthenticateEndEvent(authentication: authentication));
      return _authentication!;
    } catch (e) {
      _eventHandler.emit(AuthenticateEndEvent(error: e));

      await _notifyFailed(
        type: type,
        provider: provider,
        failure: e,
      );
      rethrow;
    }
  }

  /// Could throw [AuthenticationProviderNotFoundByAuthenticationException]
  @override
  Future<void> invalidate(Authentication authentication) async {
    final type = AuthenticationContextType.invalidate;
    AuthenticationProvider? provider;
    try {
      _eventHandler.emit(InvalidateStartEvent());
      if (_authentication != null) {
        provider = _providerOfAuthentication(_authentication!);
        _authentication = null;

        await _notifyStart(
          type: type,
          provider: provider,
        );

        await provider.store.clear();
        await _notifyDone(
          type: type,
          provider: provider,
          authentication: null,
        );
      }
      _eventHandler.emit(InvalidateEndEvent());
    } catch (e) {
      _eventHandler.emit(InvalidateEndEvent(error: e));

      await _notifyFailed(
        type: type,
        provider: provider,
        failure: e,
      );
      rethrow;
    }
  }

  /// Could throw [AuthenticationProviderNotFoundByAuthenticationException]
  @override
  Future<bool> isAuthenticationValid() async {
    final authentication = _authentication;
    if (authentication != null) {
      final provider = _providerOfAuthentication(authentication);
      return await provider.authenticatorAgent.verify(_authentication!);
    }
    return false;
  }

  /// Populate the providers with the previous authentications.
  ///
  /// If the authentications are not valid anymore. It'll try to refresh
  /// them if possible.
  @override
  Future<void> populate() async {
    final type = AuthenticationContextType.populate;
    try {
      _eventHandler.emit(PopulateStartEvent());
      for (final provider in providers) {
        await _notifyStart(
          type: type,
          provider: provider,
        );

        if (await _populateWithProvider(provider)) {
          if (_authentication != null) {
            await _notifyDone(
              type: type,
              provider: provider,
              authentication: _authentication!,
            );
          }
          break;
        }
      }
      _eventHandler.emit(PopulateEndEvent());
    } catch (e) {
      _eventHandler.emit(PopulateEndEvent(error: e));

      await _notifyFailed(
        type: type,
        failure: e,
      );
      rethrow;
    }
  }

  /// Could throw [AuthenticationProviderNotFoundByAuthenticationException]
  @override
  Future<void> refresh() async {
    if (_authentication != null) {
      final type = AuthenticationContextType.refresh;
      AuthenticationProvider? provider;
      try {
        _eventHandler.emit(RefreshStartEvent());
        provider = _providerOfAuthentication(_authentication!);
        if (provider.supportsRefresh &&
            _authentication is RefreshableAuthentication) {
          final credentials =
              (_authentication as RefreshableAuthentication).refreshCredentials;

          await _notifyStart(
            type: type,
            provider: provider,
            credentials: credentials,
          );

          final newAuthentication =
              await provider.refreshAgent?.refresh(credentials);
          _authentication = newAuthentication;

          if (newAuthentication != null) {
            await _notifyDone(
              type: type,
              provider: provider,
              authentication: newAuthentication,
            );
            _eventHandler
                .emit(RefreshEndEvent(authentication: newAuthentication));
          }
        }
      } catch (e) {
        _eventHandler.emit(RefreshEndEvent(error: e));

        await _notifyFailed(
          type: type,
          provider: provider,
          failure: e,
        );
        rethrow;
      }
    }
  }

  Future<void> _notifyDone({
    required AuthenticationContextType type,
    required AuthenticationProvider provider,
    Authentication? authentication,
  }) {
    return _authenticationInterceptionHandler.handleDone(
      DoneAuthenticationContext(
        type: type,
        provider: provider,
        authentication: authentication,
      ),
    );
  }

  Future<void> _notifyFailed(
      {required AuthenticationContextType type,
      AuthenticationProvider? provider,
      required Object failure}) {
    return _authenticationInterceptionHandler.handleFailed(
      FailedAuthenticationContext(
        type: type,
        provider: provider,
        failure: failure,
      ),
    );
  }

  Future<void> _notifyStart({
    required AuthenticationContextType type,
    required AuthenticationProvider provider,
    Credentials? credentials,
  }) {
    return _authenticationInterceptionHandler.handleStart(
      StartAuthenticationContext(
        type: type,
        provider: provider,
        credentials: credentials,
      ),
    );
  }

  Future<bool> _populateWithProvider(AuthenticationProvider provider) async {
    final authentication = await provider.store.get();
    if (authentication != null) {
      final isAuthenticationValid =
          await provider.authenticatorAgent.verify(authentication);
      if (isAuthenticationValid) {
        _authentication = authentication;
      } else if (provider.supportsRefresh &&
          authentication is RefreshableAuthentication) {
        final newAuthentication = await provider.refreshAgent
            ?.refresh(authentication.refreshCredentials);
        _authentication = newAuthentication;
      }

      return _authentication != null;
    }
    return false;
  }

  AuthenticationProvider _providerOf(String uniqueClassId) {
    try {
      return providers.firstWhere(
        (provider) =>
            provider.supportedAuthenticationClassIds.contains(uniqueClassId),
      );
    } catch (e) {
      throw AuthenticationProviderNotFoundByAuthenticationException(
        authenticationClassId: uniqueClassId,
        cause: e,
      );
    }
  }

  AuthenticationProvider _providerOfAuthentication(
      Authentication authentication) {
    return _providerOf(authentication.uniqueClassId);
  }

  AuthenticationProvider _providerOfCredentials(String uniqueClassId) {
    try {
      return providers.firstWhere((provider) =>
          provider.supportedAuthenticationClassIds.contains(uniqueClassId));
    } catch (e) {
      throw AuthenticationProviderNotFoundByCredentialsException(
        credentialClassId: uniqueClassId,
        cause: e,
      );
    }
  }
}
