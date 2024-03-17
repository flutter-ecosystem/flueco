import 'package:flutter/widgets.dart';

import '../log/log_registry.dart';
import '../notification/notification_registry.dart';
import 'di/service_container.dart';
import 'di/service_provider.dart';
import 'flueco_app.dart';

/// Kernel
class FluecoKernel {
  final Set<ServiceProvider> _serviceProviders;
  final ServiceContainer container;
  final LogRegistry logRegistry;
  final NotificationRegistry notificationRegistry;
  final bool ensureInitialized;

  late final FluecoApp app;

  /// Constructor
  FluecoKernel({
    required this.container,
    required this.logRegistry,
    required this.notificationRegistry,
    this.ensureInitialized = true,
    required Set<ServiceProvider> serviceProviders,
  }) : _serviceProviders = serviceProviders {
    app = FluecoApp(resolver: container, injector: container);
  }

  /// Bootstrap the kernel and the services
  Future<void> bootstrap() async {
    if (ensureInitialized) {
      WidgetsFlutterBinding.ensureInitialized();
    }
    await _registerServices();
    await _initializeServices();
  }

  Future<void> _initializeServices() async {
    final List<ServiceProvider> providers = <ServiceProvider>[
      ..._serviceProviders
    ];

    final Set<Type> initializedProviders = <Type>{};

    final int maxIteration = _serviceProviders.length;
    int currentIteration = 1;
    while (providers.isNotEmpty) {
      final provider = providers.first;
      final dependsOn = provider.dependsOn();
      if (currentIteration >= maxIteration ||
          dependsOn.isEmpty ||
          dependsOn
              .every((element) => initializedProviders.contains(element))) {
        await provider.initialize(app);
        initializedProviders.addAll(provider.registered());
        providers.remove(provider);
      }
      currentIteration++;
    }
  }

  Future<void> _registerServices() async {
    container.singleton<FluecoApp>((_) => app);
    container.singleton<LogRegistry>((_) => logRegistry);
    container.singleton<NotificationRegistry>((_) => notificationRegistry);

    final List<ServiceProvider> providers = <ServiceProvider>[
      ..._serviceProviders
    ];
    final int maxIteration = _serviceProviders.length;
    int currentIteration = 1;
    while (providers.isNotEmpty) {
      final provider = providers.first;
      final dependsOn = provider.dependsOn();
      if (currentIteration >= maxIteration ||
          dependsOn.isEmpty ||
          dependsOn.every((element) => container.isResolvable(element))) {
        await provider.register(container);
        providers.remove(provider);
      }
      currentIteration++;
    }
  }
}
