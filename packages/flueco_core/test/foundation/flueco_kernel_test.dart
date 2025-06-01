import 'package:flutter_test/flutter_test.dart';
import 'package:flueco_core/flueco_core.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(_MockServiceContainer());
    registerFallbackValue(_MockServiceInjector());
    registerFallbackValue(_MockServiceProvider());
    registerFallbackValue(_MockServiceResolver());
    registerFallbackValue(_MockLogRegistry());
    registerFallbackValue(_MockNotificationRegistry());
    registerFallbackValue(_FakeFluecoApp());
    // fallback for `Type`
    registerFallbackValue(_FakeFluecoApp);
  });

  test(
    'FluecoKernel bootstraps and initializes services',
    () async {
      // Arrange
      final container = _MockServiceContainer();
      final logRegistry = _MockLogRegistry();
      final notificationRegistry = _MockNotificationRegistry();
      final provider = _MockServiceProvider();
      when(() => provider.dependsOn()).thenReturn({});
      when(() => provider.registered()).thenReturn({_MockServiceProvider});
      when(() => provider.register(any())).thenAnswer((_) async {});
      when(() => provider.initialize(any())).thenAnswer((_) async {});
      when(() => logRegistry.registerHandlers(any())).thenReturn(null);
      when(() => notificationRegistry.registerHandlers(any())).thenReturn(null);
      when(() => container.singleton<FluecoApp>(any())).thenReturn(null);
      when(() => container.singleton<LogRegistry>(any())).thenReturn(null);
      when(() => container.singleton<NotificationRegistry>(any()))
          .thenReturn(null);
      when(() => container.isResolvable(any())).thenReturn(true);

      final kernel = FluecoKernel(
        container: container,
        logRegistry: logRegistry,
        notificationRegistry: notificationRegistry,
        serviceProviders: {provider},
      );

      // Act
      await kernel.bootstrap();

      // Assert
      verify(() => provider.register(any())).called(1);
      verify(() => provider.initialize(any())).called(1);
      verify(() => logRegistry.registerHandlers(any())).called(1);
      verify(() => notificationRegistry.registerHandlers(any())).called(1);
      verify(() => container.singleton<FluecoApp>(any())).called(1);
      verify(() => container.singleton<LogRegistry>(any())).called(1);
      verify(() => container.singleton<NotificationRegistry>(any())).called(1);
    },
  );
}

class _MockServiceContainer extends Mock implements ServiceContainer {}

class _MockServiceInjector extends Mock implements ServiceInjector {}

class _MockServiceProvider extends Mock implements ServiceProvider {}

class _MockServiceResolver extends Mock implements ServiceResolver {}

class _MockLogRegistry extends Mock implements LogRegistry {}

class _MockNotificationRegistry extends Mock implements NotificationRegistry {}

class _FakeFluecoApp extends Fake implements FluecoApp {}
