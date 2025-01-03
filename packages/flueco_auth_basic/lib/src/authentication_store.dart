import 'package:flueco_auth/flueco_auth.dart';
import 'package:flueco_core/flueco_core.dart';

import 'authentication.dart';

const _usernameKey = '__basic_auth_username';
const _passwordKey = '__basic_auth_password';

/// Keys used to store [TokenAuthentication]
class BasicAuthKeys {
  /// Key used to store the username
  final String username;

  /// Key used to store the password
  final String password;

  /// Creates a new [BasicAuthKeys]
  const BasicAuthKeys({required this.username, required this.password});
}

/// Default [BasicAuthKeys]
class DefaultBasicAuthKeys extends BasicAuthKeys {
  /// Creates a new [DefaultBasicAuthKeys]
  const DefaultBasicAuthKeys()
      : super(
          password: _passwordKey,
          username: _usernameKey,
        );
}

/// Store to save and retrieve [TokenAuthentication]
class BasicAuthenticationStore extends AuthenticationStore {
  final SecureStorage _secureStorage;

  /// Keys used to store the token
  final BasicAuthKeys basicAuthKeys;

  /// Creates a new [BasicAuthenticationStore]
  BasicAuthenticationStore({
    required SecureStorage secureStorage,
    this.basicAuthKeys = const DefaultBasicAuthKeys(),
  }) : _secureStorage = secureStorage;

  @override
  Future<void> clear() async {
    try {
      await Future.wait([
        _secureStorage.remove(basicAuthKeys.password),
        _secureStorage.remove(basicAuthKeys.username),
      ]);
    } catch (e) {
      throw AuthenticationStoreException(
        cause: e,
        action: AuthenticationStoreAction.clear,
      );
    }
  }

  @override
  Future<Authentication?> get() async {
    try {
      final tokens = await Future.wait([
        _secureStorage.get(basicAuthKeys.username),
        _secureStorage.get(basicAuthKeys.password),
      ]);
      if (tokens.isEmpty) {
        return null;
      }

      final username = tokens[0];
      final password = tokens[1];
      if (username == null || password == null) {
        return null;
      }

      return BasicAuthentication(username: username, password: password);
    } catch (e) {
      throw AuthenticationStoreException(
        cause: e,
        action: AuthenticationStoreAction.get,
      );
    }
  }

  @override
  Future<void> save(Authentication authentication) async {
    if (authentication is! BasicAuthentication) return;

    try {
      await Future.wait([
        _secureStorage.set(basicAuthKeys.username, authentication.username),
        _secureStorage.set(basicAuthKeys.password, authentication.password),
      ]);
    } catch (e) {
      throw AuthenticationStoreException(
        cause: e,
        action: AuthenticationStoreAction.save,
      );
    }
  }
}
