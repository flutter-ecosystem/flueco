import 'package:flutter_test/flutter_test.dart';
import 'package:flueco_core/flueco_core.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  test(
    'FluecoApp can be instantiated with resolver and injector',
    () {
      // Arrange & Act
      final resolver = _MockServiceResolver();
      final injector = _MockServiceInjector();
      final app = FluecoApp(resolver: resolver, injector: injector);

      // Assert
      expect(app.resolver, resolver);
      expect(app.injector, injector);
    },
  );
}

class _MockServiceResolver extends Mock implements ServiceResolver {}

class _MockServiceInjector extends Mock implements ServiceInjector {}
