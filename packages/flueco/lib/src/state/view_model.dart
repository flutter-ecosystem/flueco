import 'package:flutter/widgets.dart';

import '../helpers/safe_zone_result.mixin.dart';
import 'state_notifier.dart';
import 'view_state.dart';

/// Base class for viewmodel.
abstract class ViewModel<S extends ViewState> extends StateNotifier<S>
    with SafeZoneResultMixin {
  ViewModel(super.state);

  static void resetMock() {
    StateNotifier.resetMock();
  }

  /// Read a viewmodel in context
  static T read<T extends ViewModel>(BuildContext context) {
    return StateNotifier.read<T>(context);
  }

  /// Watch a viewmodel property in context
  static R select<T extends ViewModel, R>(
      BuildContext context, R Function(T value) selector) {
    return StateNotifier.select<T, R>(context, selector);
  }

  /// Watch a viewmodel in context
  static T watch<T extends ChangeNotifier>(BuildContext context) {
    return StateNotifier.watch<T>(context);
  }

  bool _isDisposed = false;

  @override
  @mustCallSuper
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  @mustCallSuper
  void notifyListeners() {
    if (_isDisposed) return;
    super.notifyListeners();
  }
}
