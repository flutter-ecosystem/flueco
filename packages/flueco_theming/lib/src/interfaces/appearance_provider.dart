import '../models/appearance.dart';

abstract class AppearanceProvider {
  /// Get the current [Appearance]
  Appearance get current;

  /// Get the list of appearances available
  Iterable<Appearance> get appearances;

  /// Add [appearance] to the list of appearances available
  void add(Appearance appearance);

  /// Remove [appearance] from the list of appearances available
  void remove(Appearance appearance);

  /// Remove appearance from the list of appearances available
  /// by its [key].
  void removeByKey(String key);

  /// Select the appearance that has `key` equals to [key].
  ///
  /// It returns `true` if the appearance was found and selected.
  bool select(String key);
}
