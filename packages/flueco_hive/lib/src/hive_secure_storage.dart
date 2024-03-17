import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:flueco_core/flueco_core.dart';

/// A Factory class that create Hive box
abstract class HiveBoxFactory {
  /// Create and open secured Hive box
  Future<Box<T>> createSecureBox<T>(String boxName);

  /// Create and open secured Hive box
  Future<Box<T>> createUnsecureBox<T>(String boxName);
}

/// Implementation of [HiveBoxFactory]
class BasicHiveBoxFactory implements HiveBoxFactory {
  final HiveCipher _encryptionCipher;

  /// Constructor
  const BasicHiveBoxFactory(HiveCipher encryptionCipher)
      : _encryptionCipher = encryptionCipher;

  /// factory to create an instance from encryption key
  factory BasicHiveBoxFactory.fromEncryptionKey(String encryptionKey) {
    return BasicHiveBoxFactory(aesCipherFromString(encryptionKey));
  }

  /// Create and open secured Hive box
  @override
  Future<Box<T>> createSecureBox<T>(String boxName) async {
    return await Hive.openBox<T>(
      boxName,
      encryptionCipher: _encryptionCipher,
      crashRecovery: true,
    );
  }

  /// Create and open an unsecured Hive box
  @override
  Future<Box<T>> createUnsecureBox<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
  }

  /// [HiveAesCipher] implementation of [HiveCipher]
  static HiveCipher aesCipher(List<int> encryptionKey) {
    return HiveAesCipher(encryptionKey);
  }

  /// [HiveAesCipher] implementation of [HiveCipher]
  static HiveCipher aesCipherFromString(String encryptionKey) {
    return HiveAesCipher(keyFromString(encryptionKey));
  }

  /// Get list of int from [encryptionKey]
  static List<int> keyFromString(String encryptionKey) {
    String key = encryptionKey;
    if (key.length > 32) {
      key = key.substring(0, 32);
    } else if (key.length < 32) {
      key = key + key.substring(0, 32 - key.length);
    }
    return utf8.encode(key);
  }
}

/// Config required by getInstance if [HiveSecureStorage]
class HiveSecureStorageGetInstanceConfig {
  /// Box factory
  final HiveBoxFactory hiveBoxFactory;

  /// Box name
  final String boxName;

  const HiveSecureStorageGetInstanceConfig({
    required this.hiveBoxFactory,
    this.boxName = 'secure_storage',
  });
}

/// Implementation of [SecureStorage] that uses Hive box
class HiveSecureStorage implements SecureStorage {
  final HiveSecureStorageGetInstanceConfig config;
  late final Box<String> _box;

  HiveSecureStorage._(this.config);

  /// Static method to create a new instance of [HiveSecureStorage]
  static HiveSecureStorage getInstance(
      HiveSecureStorageGetInstanceConfig config) {
    return HiveSecureStorage._(config);
  }

  Future<void> init() async {
    _box = await config.hiveBoxFactory.createSecureBox(config.boxName);
  }

  @override
  Future<String?> get(String key) async {
    return _box.get(key);
  }

  @override
  Future<void> set(String key, String value) async {
    _box.put(key, value);
  }

  @override
  Future<void> remove(String key) async {
    _box.delete(key);
  }

  @override
  Future<bool> contains(String key) async {
    return _box.containsKey(key);
  }
}
