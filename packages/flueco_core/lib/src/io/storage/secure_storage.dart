import '../../core/un_implemented_component.dart';

/// Storage to manage secret data securely locally
abstract class SecureStorage {
  /// Get a string value from secure storage
  Future<String?> get(String key);

  /// Set a string value in secure storage
  Future<void> set(String key, String value);

  /// Remove a string value from secure storage
  Future<void> remove(String key);

  /// Check if the storage contains [key]
  Future<bool> contains(String key);
}

/// Implementation of [SecureStorage]
class UnImplementedSecureStorage
    implements SecureStorage, UnImplementedComponent {
  @override
  Future<String?> get(String key) {
    throw UnimplementedError();
  }

  @override
  Future<void> remove(String key) {
    throw UnimplementedError();
  }

  @override
  Future<void> set(String key, String value) {
    throw UnimplementedError();
  }

  @override
  Future<bool> contains(String key) {
    throw UnimplementedError();
  }
}
