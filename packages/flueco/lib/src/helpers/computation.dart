import 'dart:collection';

import 'package:flueco/src/helpers/utils.helper.dart';

/// A function that computes a value.
typedef ComputeFunction<T> = T Function();

/// A class that represents a computed value.
class ComputedValue<T> {
  static final Map<String, ComputedValue> _computedValues =
      HashMap<String, ComputedValue>();

  ComputedValue({required this.computeFunction, Iterable<Object>? dependencies})
      : _dependencies = dependencies {
    recalculate();
  }

  /// Create a new instance of [ComputedValue] or get an existing instance.
  ///
  /// The [key] parameter is used to identify the computed value.
  /// The [computeFunction] parameter is the function that computes the value.
  /// The [dependencies] parameter is the list of dependencies for the computed value.
  factory ComputedValue.of({
    required String key,
    required ComputeFunction<T> computeFunction,
    List<Object>? dependencies,
  }) {
    var computedValue = _computedValues[key];
    assert(
        computedValue == null || computedValue is! T,
        'The compute function for the computed value $key is different from the existing one. '
        'Try using the `get` method instead or evict the computed value.');

    if (computedValue == null) {
      computedValue = ComputedValue<T>(
        computeFunction: computeFunction,
        dependencies: dependencies,
      );
      _computedValues[key] = computedValue;
    } else {
      computedValue.recalculate();
    }
    return (computedValue as ComputedValue<T>);
  }

  /// The function that computes the value.
  final ComputeFunction<T> computeFunction;
  final Iterable<Object>? _dependencies;
  int? _prevDependenciesHash;
  T? _computedValue;

  /// Get the current value.
  T get value {
    _computedValue ??= computeFunction();
    return _computedValue!;
  }

  /// Recalculate the computed value.
  void recalculate() {
    final dependencies = _dependencies;
    if (dependencies != null) {
      final dependenciesHash = Utils.deepHashAll(dependencies);
      if (_prevDependenciesHash == dependenciesHash) {
        return;
      }
      _prevDependenciesHash = dependenciesHash;
    }
    _computedValue = computeFunction();
  }

  /// Evict a computed value.
  ///
  /// If [key] is not provided, all computed values will be evicted.
  static void evict<T>([String? key]) {
    if (key != null) {
      _computedValues.remove(key);
    } else {
      _computedValues.clear();
    }
  }

  /// Get a computed value by [key].
  ///
  /// This [ComputedValue] must have be created using the [ComputedValue.of] method.
  static ComputedValue<T>? get<T>(key) {
    return _computedValues[key] as ComputedValue<T>?;
  }
}
