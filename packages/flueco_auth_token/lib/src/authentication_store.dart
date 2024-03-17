import 'package:flueco_auth/flueco_auth.dart';
import 'package:flueco_auth_token/src/authentication.dart';
import 'package:flueco_core/flueco_core.dart';

const _tokenKey = '__auth_token';
const _tokenExpirationKey = '__auth_token_exp';

/// Keys used to store [TokenAuthentication]
class TokenKeys {
  /// Key used to store the token
  final String token;

  /// Key used to store the expiration
  final String expiration;

  const TokenKeys({required this.token, required this.expiration});
}

class DefaultTokenKeys extends TokenKeys {
  const DefaultTokenKeys()
      : super(
          expiration: _tokenExpirationKey,
          token: _tokenKey,
        );
}

class TokenAuthenticationStore extends AuthenticationStore {
  final SecureStorage _secureStorage;
  final LocalStorage _localStorage;
  final TokenKeys tokenKeys;

  TokenAuthenticationStore({
    required SecureStorage secureStorage,
    required LocalStorage localStorage,
    this.tokenKeys = const DefaultTokenKeys(),
  })  : _secureStorage = secureStorage,
        _localStorage = localStorage;

  @override
  Future<void> clear() async {
    try {
      await Future.wait([
        _secureStorage.remove(tokenKeys.token),
        _localStorage.remove(tokenKeys.expiration),
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
      final token = await _secureStorage.get(tokenKeys.token);
      if (token == null) {
        return null;
      }
      final expiration = await _localStorage.get(tokenKeys.expiration);

      DateTime? expiresAt;
      if (expiration != null) {
        expiresAt = DateTime.fromMillisecondsSinceEpoch(int.parse(expiration),
            isUtc: true);
      }

      return TokenAuthentication(
        token: token,
        expiresAt: expiresAt,
      );
    } catch (e) {
      throw AuthenticationStoreException(
        cause: e,
        action: AuthenticationStoreAction.get,
      );
    }
  }

  @override
  Future<void> save(Authentication authentication) async {
    if (authentication is! TokenAuthentication) return;

    try {
      await _secureStorage.set(tokenKeys.token, authentication.token);
      final expiresAt = authentication.expiresAt?.toUtc();
      if (expiresAt != null) {
        await _localStorage.set(
          tokenKeys.expiration,
          expiresAt.millisecondsSinceEpoch.toString(),
        );
      }
    } catch (e) {
      throw AuthenticationStoreException(
        cause: e,
        action: AuthenticationStoreAction.save,
      );
    }
  }
}
