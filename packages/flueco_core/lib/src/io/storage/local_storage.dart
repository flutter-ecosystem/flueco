import '../../core/unimplemented_component.dart';

/// Storage to manage data locally
abstract class LocalStorage {
  /// Get a string value from local storage
  Future<String?> get(String key);

  /// Set a string value in local storage
  Future<void> set(String key, String value);

  /// Remove a string value from local storage
  Future<void> remove(String key);

  /// Check if the storage contains [key]
  Future<bool> contains(String key);
}

/// Implementation of [LocalStorage]
class UnImplementedLocalStorage implements LocalStorage, UnimplementedFeature {
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
