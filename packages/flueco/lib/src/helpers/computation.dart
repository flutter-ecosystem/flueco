import 'dart:collection';

import 'utils.helper.dart';

typedef ComputeFunction<T> = T Function();

class ComputedValue<T> {
  static final Map<String, ComputedValue> _computedValues =
      HashMap<String, ComputedValue>();
  static final Map<String, List<Object>> _computedValuesDependencies =
      HashMap<String, List<Object>>();

  ComputedValue({required this.computeFunction});

  factory ComputedValue.of({
    required String key,
    required ComputeFunction<T> computeFunction,
    List<Object>? dependencies,
  }) {
    if (!_computedValues.containsKey(key)) {
      _computedValues[key] = ComputedValue<T>(computeFunction: computeFunction);
      if (dependencies != null) {
        _computedValuesDependencies[key] = dependencies;
      }
    } else if (dependencies != null &&
        _computedValuesDependencies.containsKey(key) &&
        !Utils.deepEquals(dependencies, _computedValuesDependencies[key])) {
      _computedValues[key]?.recalculate();
    }
    return (_computedValues[key] as ComputedValue<T>);
  }

  final ComputeFunction<T> computeFunction;
  T? _computedValue;

  T get value {
    _computedValue ??= computeFunction();
    return _computedValue!;
  }

  void recalculate() {
    _computedValue = computeFunction();
  }

  static void evict<T>([String? key]) {
    if (key != null) {
      _computedValues.remove(key);
    } else {
      _computedValues.clear();
    }
  }

  static ComputedValue<T>? get<T>(key) {
    return _computedValues[key] as ComputedValue<T>?;
  }
}
