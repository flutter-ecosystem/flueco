import 'package:flutter_test/flutter_test.dart';
import 'package:flueco_core/flueco_core.dart';
import 'package:mocktail/mocktail.dart';

class MockEventHandler extends Mock implements EventHandler {}

class MockServiceResolver extends Mock implements ServiceResolver {}

class MockServiceInjector extends Mock implements ServiceInjector {}

class _EventHandlingServiceProvider extends EventHandlingServiceProvider {
  @override
  EventHandler eventHandlerFactory(ServiceResolver resolver) =>
      MockEventHandler();

  @override
  Set<Type> dependsOn() {
    return {};
  }

  @override
  Future<void> initialize(FluecoApp app) {
    return Future.value();
  }
}

void main() {
  setUpAll(() {
    registerFallbackValue(MockEventHandler());
    registerFallbackValue(MockServiceResolver());
    registerFallbackValue(MockServiceInjector());
  });

  test(
    'EventHandlingServiceProvider always registers EventHandler',
    () async {
      // Arrange
      final provider = _EventHandlingServiceProvider();
      final injector = MockServiceInjector();
      when(() => injector.lazySingleton<EventHandler>(any())).thenReturn(null);

      // Act
      await provider.register(injector);

      // Assert
      verify(() => injector.lazySingleton<EventHandler>(any())).called(1);
      expect(provider.registered(), contains(EventHandler));
    },
  );
}
