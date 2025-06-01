import 'package:flutter_test/flutter_test.dart';
import 'package:flueco_core/flueco_core.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group(
    'IoLocalStorageServiceProvider',
    () {
      test(
        'can be extended and register/registered called',
        () async {
          // Arrange
          final provider = _FakeIOLocalStorageServiceProvider();
          final injector = _MockServiceInjector();
          when(() => injector.lazySingleton<LocalStorage>(any()))
              .thenReturn(null);

          // Act
          await provider.register(injector);

          // Assert
          verify(() => injector.lazySingleton<LocalStorage>(any())).called(1);
          expect(provider.registered(), contains(LocalStorage));
        },
      );
    },
  );
}

class _MockServiceInjector extends Mock implements ServiceInjector {}

class _FakeIOLocalStorageServiceProvider extends IOLocalStorageServiceProvider {
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
  LocalStorage localStorageFactory(ServiceResolver resolver) {
    return _MockLocalStorage();
  }
}

class _MockLocalStorage extends Mock implements LocalStorage {}
