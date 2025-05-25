import 'package:flutter/widgets.dart' show BuildContext;
import 'package:provider/provider.dart';

/// A function type that takes a value of type T and returns a value of type R.
typedef SelectorFunction<T, R> = R Function(T value);

/// An abstract class that defines methods for reading, selecting, and watching state data in a Flutter context.
abstract class StateDataProvider {
  /// Global instance of the default state data provider.
  ///
  /// Override this value only if you need a custom implementation.
  static var instance = DefaultStateDataProvider();

  /// Reads a value of type T from the context without listening for changes.
  T readOn<T>(BuildContext context);

  /// Selects a value of type R from a value of type T in the context, allowing for efficient updates.
  R selectOn<T, R>(BuildContext context, SelectorFunction<T, R> selector);

  /// Watches a value of type T in the context, listening for changes and rebuilding when necessary.
  T watchOn<T>(BuildContext context);
}

class DefaultStateDataProvider implements StateDataProvider {
  @override
  T readOn<T>(BuildContext context) {
    return context.read<T>();
  }

  @override
  R selectOn<T, R>(BuildContext context, SelectorFunction<T, R> selector) {
    return context.select<T, R>(selector);
  }

  @override
  T watchOn<T>(BuildContext context) {
    return context.watch<T>();
  }
}
