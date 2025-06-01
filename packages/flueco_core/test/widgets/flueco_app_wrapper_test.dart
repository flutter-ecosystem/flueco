import 'package:flutter_test/flutter_test.dart';
import 'package:flueco_core/flueco_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/widgets.dart';

void main() {
  group(
    'FluecoAppWrapper',
    () {
      late FluecoKernel kernel;
      late FluecoApp app;
      late _MockContainer container;

      setUp(() {
        container = _MockContainer();
        app = FluecoApp(resolver: container, injector: container);
        kernel = _MockKernel(app: app, container: container);
      });

      testWidgets(
        'provides FluecoKernel to descendants and delegates to _FluecoApp',
        (tester) async {
          // Arrange
          await tester.pumpWidget(
            FluecoAppWrapper(
              kernel: kernel,
              child: const Placeholder(),
            ),
          );
          // Act
          final context = tester.element(find.byType(Placeholder));

          // Assert
          expect(FluecoAppWrapper.of(context), equals(app));
        },
      );

      testWidgets(
        'throws if FluecoAppWrapper is not in context',
        (tester) async {
          // Arrange & Act
          await tester.pumpWidget(const Placeholder());
          final context = tester.element(find.byType(Placeholder));

          // Assert
          expect(() => FluecoAppWrapper.of(context), throwsStateError);
        },
      );

      test(
        'updateShouldNotify always returns false',
        () {
          // Arrange
          final wrapper1 = FluecoAppWrapper(kernel: kernel, child: Container());
          final wrapper2 = FluecoAppWrapper(kernel: kernel, child: Container());

          // Act & Assert
          expect(wrapper1.updateShouldNotify(wrapper2), isFalse);
        },
      );

      testWidgets(
        'FluecoSR and FluecoSI are present in the widget tree',
        (tester) async {
          // Arrange & Act
          await tester.pumpWidget(
            FluecoAppWrapper(
              kernel: kernel,
              child: const Placeholder(),
            ),
          );

          // Assert
          expect(find.byType(FluecoSR), findsOneWidget);
          expect(find.byType(FluecoSI), findsOneWidget);
        },
      );
    },
  );
}

class _MockKernel extends Mock implements FluecoKernel {
  @override
  final FluecoApp app;
  @override
  final ServiceContainer container;
  _MockKernel({required this.app, required this.container});
}

class _MockContainer extends Mock
    implements ServiceContainer, ServiceResolver, ServiceInjector {}
