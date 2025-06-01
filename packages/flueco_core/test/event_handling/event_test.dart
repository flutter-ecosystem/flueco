import 'package:flutter_test/flutter_test.dart';
import 'package:flueco_core/flueco_core.dart';

void main() {
  group(
    'PriorityEvent',
    () {
      test(
        'can instantiate PriorityEvent subclass and get priority',
        () {
          // Arrange & Act
          const event = TestPriorityEvent(5);

          // Assert
          expect(event.priority, 5);
        },
      );
    },
  );
}

class TestPriorityEvent extends PriorityEvent {
  @override
  final int priority;
  const TestPriorityEvent(this.priority);
}
