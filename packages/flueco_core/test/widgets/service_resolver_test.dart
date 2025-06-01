import 'package:flutter_test/flutter_test.dart';
import 'package:flueco_core/flueco_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/widgets.dart';

void main() {
  group(
    'FluecoSR',
    () {
      setUpAll(() {
        // Register fallback values for mock types
        registerFallbackValue(String);
      });

      testWidgets(
        'provides ServiceResolver to descendants',
        (tester) async {
          // Arrange
          final resolver = _MockServiceResolver();
          when(() => resolver.isResolvable(any())).thenReturn(true);
          when(() => resolver.isResolvableByName<String>(any()))
              .thenReturn(true);
          when(() => resolver.resolve<String>(name: any(named: 'name')))
              .thenReturn('test');

          // Act
          late FluecoSR sr;
          await tester.pumpWidget(
            FluecoSR(
              resolver: resolver,
              child: Builder(
                builder: (context) {
                  sr = FluecoSR.of(context);
                  return const Placeholder();
                },
              ),
            ),
          );

          // Assert
          expect(sr, isA<FluecoSR>());
          expect(sr.isResolvable(String), isTrue);
          expect(sr.isResolvableByName<String>('foo'), isTrue);
          expect(sr.resolve<String>(name: 'bar'), 'test');
        },
      );

      testWidgets(
        'throws if FluecoSR is not in context',
        (tester) async {
          // Arrange & Act
          await tester.pumpWidget(const Placeholder());

          // Assert
          expect(() => FluecoSR.of(tester.element(find.byType(Placeholder))),
              throwsStateError);
        },
      );
    },
  );
}

class _MockServiceResolver extends Mock implements ServiceResolver {}
