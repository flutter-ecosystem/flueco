import 'package:flutter/widgets.dart';

import '../foundation/flueco_app.dart';
import '../foundation/flueco_kernel.dart';
import 'service_injector.dart';
import 'service_resolver.dart';

class FluecoCoreApp extends InheritedWidget {
  final FluecoKernel kernel;

  FluecoCoreApp({
    super.key,
    required this.kernel,
    required Widget child,
  }) : super(
          child: _FluecoCoreApp(
            kernel: kernel,
            child: child,
          ),
        );

  static FluecoApp of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<FluecoCoreApp>();
    if (provider == null) {
      throw StateError(
          'Flueco is not accessible through this context. Make sure you add it on top of the tree');
    }
    return provider.kernel.app;
  }

  @override
  bool updateShouldNotify(FluecoCoreApp oldWidget) {
    return false;
  }
}

class _FluecoCoreApp extends StatelessWidget {
  const _FluecoCoreApp({
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
