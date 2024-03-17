/// Storage to manage data in memory
abstract class MemoryStorage {
  /// Get a value of type [T] from memory storage
  T? get<T extends Object>(String key);

  /// Set a value of type [T] in memory storage
  void set<T extends Object>(String key, T value);

  /// Remove a value from memory storage
  void remove(String key);

  /// Check if the storage contains [key]
  bool contains(String key);

  /// Get all items in storage
  Map<String, Object> getAll();
}

/// Implementation of [MemoryStorage]
class BasicMemoryStorage implements MemoryStorage {
  final Map<String, Object> storage;

  BasicMemoryStorage({
    Map<String, dynamic> initialStorageValue = const <String, Object>{},
  }) : storage = Map<String, Object>.from(initialStorageValue);

  const BasicMemoryStorage.empty() : storage = const <String, Object>{};

  @override
  T? get<T extends Object>(String key) {
    if (storage.containsKey(key)) {
      return storage[key] is T ? storage[key] as T : null;
    }

    return null;
  }

  @override
  void remove(String key) {
    storage.remove(key);
  }

  @override
  void set<T extends Object>(String key, T value) {
    storage[key] = value;
  }

  @override
  bool contains(String key) {
    return storage.containsKey(key);
  }

  @override
  Map<String, Object> getAll() {
    return Map<String, Object>.unmodifiable(storage);
  }
}
