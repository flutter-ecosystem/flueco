import 'package:flutter_test/flutter_test.dart';
import 'package:flueco_core/flueco_core.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('RouterServiceProvider', () {
    test('can be extended and register/registered called', () async {
      // Arrange
      final provider = _FakeRouterServiceProvider();
      final injector = _MockServiceInjector();
      when(() => injector.lazySingleton<Router>(any())).thenReturn(null);
      when(() => injector.lazySingleton<NavigatorKeyProvider>(any()))
          .thenReturn(null);

      // Act
      await provider.register(injector);

      // Assert
      verify(() => injector.lazySingleton<Router>(any())).called(1);
      verify(() => injector.lazySingleton<NavigatorKeyProvider>(any()))
          .called(1);
      expect(provider.registered(), contains(Router));
      expect(provider.registered(), contains(NavigatorKeyProvider));
    });
  });
}

class _MockServiceInjector extends Mock implements ServiceInjector {}

class _FakeRouterServiceProvider extends RouterServiceProvider {
  @override
  Set<Type> dependsOn() {
    return {};
  }

  @override
  Future<void> initialize(FluecoApp app) {
    // Initialization logic if needed
    return Future.value();
  }

  @override
  Router routerFactory(ServiceResolver resolver) {
    return _MockRouter();
  }

  @override
  NavigatorKeyProvider navigatorKeyProviderFactory(ServiceResolver resolver) {
    return _MockNavigatorKeyProvider();
  }
}

class _MockRouter extends Mock implements Router {}

class _MockNavigatorKeyProvider extends Mock implements NavigatorKeyProvider {}
