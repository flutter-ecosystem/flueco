import 'package:flutter_test/flutter_test.dart';
import 'package:flueco_core/flueco_core.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group(
    'IoSecureStorageServiceProvider',
    () {
      test(
        'can be extended and register/registered called',
        () async {
          // Arrange
          final provider = _FakeIOSecureStorageServiceProvider();
          final injector = _MockServiceInjector();
          when(() => injector.lazySingleton<SecureStorage>(any()))
              .thenReturn(null);

          // Act
          await provider.register(injector);

          // Assert
          verify(() => injector.lazySingleton<SecureStorage>(any())).called(1);
          expect(provider.registered(), contains(SecureStorage));
        },
      );
    },
  );
}

class _MockServiceInjector extends Mock implements ServiceInjector {}

class _FakeIOSecureStorageServiceProvider
    extends IOSecureStorageServiceProvider {
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
  SecureStorage secureStorageFactory(ServiceResolver resolver) {
    return _MockSecureStorage();
  }
}

class _MockSecureStorage extends Mock implements SecureStorage {}
