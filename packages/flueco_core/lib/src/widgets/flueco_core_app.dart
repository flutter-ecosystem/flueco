import 'package:flutter/widgets.dart';

import '../core/flueco_app.dart';
import '../core/flueco_kernel.dart';
import 'service_injector.dart';
import 'service_resolver.dart';

class FluecoCoreApp extends InheritedWidget {
  final FluecoKernel kernel;

  FluecoCoreApp({
    super.key,
    required this.kernel,
    required Widget child,
  }) : super(
          child: FluecoSR(
            resolver: kernel.container,
            child: FluecoSI(
              injector: kernel.container,
              child: child,
            ),
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
