import 'package:flutter/widgets.dart';

import '../foundation/flueco_app.dart';
import '../foundation/flueco_kernel.dart';
import 'service_injector.dart';
import 'service_resolver.dart';

/// A widget that provides the [FluecoKernel] to its descendants.
///
/// This widget should be placed at the root of the widget tree.
class FluecoAppWrapper extends InheritedWidget {
  /// The [FluecoKernel] instance
  final FluecoKernel kernel;

  /// Create a new instance of [FluecoAppWrapper]
  FluecoAppWrapper({
    super.key,
    required this.kernel,
    required Widget child,
  }) : super(
          child: _FluecoApp(
            kernel: kernel,
            child: child,
          ),
        );

  /// Get the [FluecoApp] from the [BuildContext].
  static FluecoApp of(BuildContext context) {
    final provider = context.getInheritedWidgetOfExactType<FluecoAppWrapper>();
    if (provider == null) {
      throw StateError(
          'Flueco is not accessible through this context [$context].'
          'Make sure you add it on top of the tree '
          'or the context is still mounted.');
    }
    return provider.kernel.app;
  }

  @override
  bool updateShouldNotify(FluecoAppWrapper oldWidget) {
    return false;
  }
}

class _FluecoApp extends StatelessWidget {
  const _FluecoApp({
    required this.child,
    required this.kernel,
  });

  final Widget child;
  final FluecoKernel kernel;

  @override
  Widget build(BuildContext context) {
    return FluecoSR(
      resolver: kernel.container,
      child: FluecoSI(
        injector: kernel.container,
        child: child,
      ),
    );
  }
}
