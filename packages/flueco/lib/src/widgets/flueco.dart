import 'package:flueco_core/flueco_core.dart' as core;
import 'package:flueco_messaging/flueco_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:messaging_flutter/messaging_flutter.dart';

import '../flueco_kernel.dart';

/// A widget that provides the [FluecoKernel] to its descendants.
///
/// This widget should be placed at the root of the widget tree. It will add the
/// [MessagingScopeProvider] to the widget tree to handle the lifecycle events and
/// the [core.FluecoAppWrapper] to provide the [FluecoKernel] to its descendants.
class Flueco extends InheritedWidget {
  /// Create a new instance of [Flueco].
  Flueco({
    super.key,
    required FluecoKernel kernel,
    required Widget child,
  }) : super(
          child: MessagingScopeProvider(
            lifecycleHandling: const MessagingLifecycleHandling(
              handleStop: true,
              handleStart: true,
              handlePauseAndResume: true,
            ),
            messaging: kernel.container.resolve<Messaging>(),
            child: core.FluecoAppWrapper(
              kernel: kernel,
              child: child,
            ),
          ),
        );

  /// Get the [FluecoApp] from the [BuildContext].
  static core.FluecoApp of(BuildContext context) {
    return core.FluecoAppWrapper.of(context);
  }

  @override
  bool updateShouldNotify(Flueco oldWidget) {
    return false;
  }
}
