import 'package:flueco_core/flueco_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation of [LocalStorage] that uses [SharedPreferences]
class SharedPreferencesStorage implements LocalStorage {
  final SharedPreferences _prefs;

  /// Constructor
  SharedPreferencesStorage(SharedPreferences prefs) : _prefs = prefs;

  @override
  Future<String?> get(String key) async {
    return _prefs.getString(key);
  }

  @override
  Future<void> set(String key, String value) async {
    _prefs.setString(key, value);
  }

  @override
  Future<void> remove(String key) async {
    _prefs.remove(key);
  }

  @override
  Future<bool> contains(String key) async {
    return _prefs.containsKey(key);
  }
}
