import 'package:flueco/flueco.dart' show SecureStorage;

/// Authentication database
final class AuthDB {
  static const String _tokenKey = 'token';
  static const String _userIdKey = 'user_uuid';

  final SecureStorage _storage;

  /// Creates an instance of [AuthDB]
  AuthDB({required SecureStorage storage}) : _storage = storage;

  /// Save the authentication [token]
  Future<void> saveToken({required String token}) {
    return _storage.set(_tokenKey, token);
  }

  /// Get the authentication token
  ///
  /// It will return `null` if no token were saved
  Future<String?> getToken() {
    return _storage.get(_tokenKey);
  }

  /// Save the authentication [userUuid]
  Future<void> saveUserUuid({required String userUuid}) {
    return _storage.set(_userIdKey, userUuid);
  }

  /// Get the authentication user uuid
  ///
  /// It will return `null` if no token were saved
  Future<String?> getUserUuid() {
    return _storage.get(_userIdKey);
  }
}
