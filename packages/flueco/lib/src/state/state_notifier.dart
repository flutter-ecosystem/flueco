import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../helpers/computation.dart';
import '../helpers/provider_helpers.dart';

class StateNotifier<T> extends ChangeNotifier implements ValueListenable<T> {
  static bool _isMock = false;
  static Map<Type, Object> _mocked = <Type, Object>{};

  static void mock<T extends Object>(T value) {
    _isMock = true;
    _mocked[T] = value;
  }

  static void resetMock() {
    _isMock = false;
    _mocked = <Type, Object>{};
  }

  /// Read a viewmodel in context
  static T read<T extends ChangeNotifier>(BuildContext context) {
    if (_isMock && _mocked.containsKey(T)) {
      return _mocked[T]! as T;
    }
    return readOn<T>(context);
  }

  /// Watch a viewmodel property in context
  static R select<T extends ChangeNotifier, R>(
      BuildContext context, R Function(T value) selector) {
    if (_isMock && _mocked.containsKey(T)) {
      return selector(_mocked[T]! as T);
    }
    return selectOn<T, R>(context, selector);
  }

  /// Watch a viewmodel in context
  static T watch<T extends ChangeNotifier>(BuildContext context) {
    if (_isMock && _mocked.containsKey(T)) {
      return _mocked[T]! as T;
    }
    return watchOn<T>(context);
  }

  /// Creates a [ChangeNotifier] that wraps this value.
  StateNotifier(this._state);

  /// The current value stored in this notifier.
  ///
  /// When the value is replaced with something that is not equal to the old
  /// value as evaluated by the equality operator ==, this class notifies its
  /// listeners.
  @override
  T get value => _state;
  T _state;

  /// State
  @nonVirtual
  T get state => _state;

  @protected
  @mustCallSuper
  setState(T newValue) {
    if (_state == newValue) {
      return;
    }
    _state = newValue;
    _recalculateComputed();
    notifyListeners();
  }

  @mustCallSuper
  @override
  void dispose() {
    computed.whereType<String>().forEach((element) {
      ComputedValue.evict(element);
    });
    super.dispose();
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';

  List<Object> get computed => <Object>[];

  void _recalculateComputed() {
    for (final comp in computed) {
      if (comp is ComputedValue) {
        comp.recalculate();
      } else if (comp is String) {
        ComputedValue.get(comp)?.recalculate();
      }
    }
  }
}
