import 'package:flueco_core/flueco_core.dart' as core;
import 'package:flueco_messaging/flueco_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:messaging_flutter/messaging_flutter.dart';

import '../flueco_kernel.dart';

class Flueco extends InheritedWidget {
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
            child: core.FluecoCoreApp(
              kernel: kernel,
              child: child,
            ),
          ),
        );

  static core.FluecoApp of(BuildContext context) {
    return core.FluecoCoreApp.of(context);
  }

  @override
  bool updateShouldNotify(Flueco oldWidget) {
    return false;
  }
}
