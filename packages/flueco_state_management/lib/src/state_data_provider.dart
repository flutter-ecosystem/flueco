import 'package:flutter/widgets.dart' show BuildContext;

/// A function type that takes a value of type T and returns a value of type R.
typedef SelectorFunction<T, R> = R Function(T value);

/// An abstract class that defines methods for reading, selecting, and watching state data in a Flutter context.
abstract class StateDataProvider {
  /// Reads a value of type T from the context without listening for changes.
  T readOn<T>(BuildContext context);

  /// Selects a value of type R from a value of type T in the context, allowing for efficient updates.
  R selectOn<T, R>(BuildContext context, SelectorFunction<T, R> selector);

  /// Watches a value of type T in the context, listening for changes and rebuilding when necessary.
  T watchOn<T>(BuildContext context);
}
