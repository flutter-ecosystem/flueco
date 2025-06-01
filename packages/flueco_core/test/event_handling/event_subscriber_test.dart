import 'package:flutter_test/flutter_test.dart';
import 'package:flueco_core/flueco_core.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  test(
    'EventSubscriber can be implemented and onEvent called',
    () async {
      // Arrange
      final sub = _MockEventSubscriber();
      final event = _MockEvent();
      when(() => sub.onEvent(event)).thenAnswer((_) async {});

      // Act
      await sub.onEvent(event);

      // Assert
      verify(() => sub.onEvent(event)).called(1);
    },
  );
}

class _MockEvent extends Mock implements Event {}

class _MockEventSubscriber extends Mock implements EventSubscriber {}
