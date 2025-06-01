import 'package:flutter_test/flutter_test.dart';
import 'package:flueco_core/flueco_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/widgets.dart';

void main() {
  group(
    'FluecoSI',
    () {
      testWidgets(
        'provides ServiceInjector to descendants',
        (tester) async {
          // Arrange
          final injector = _MockServiceInjector();

          // Act
          late FluecoSI? si;
          await tester.pumpWidget(
            FluecoSI(
              injector: injector,
              child: Builder(
                builder: (context) {
                  si = FluecoSI.of(context);
                  return const Placeholder();
                },
              ),
            ),
          );

          // Assert
          expect(si, isA<FluecoSI>());
        },
      );

      testWidgets(
        'throws if FluecoSI is not in context',
        (tester) async {
          // Arrange & Act
          await tester.pumpWidget(const Placeholder());

          // Assert
          expect(
            () => FluecoSI.of(
              tester.element(
                find.byType(Placeholder),
              ),
            ),
            throwsStateError,
          );
        },
      );

      test(
        'delegates factory, lazySingleton, singleton, singletonAsync, unlink',
        () async {
          // Arrange
          final injector = _MockServiceInjector();
          final si = FluecoSI(injector: injector, child: Container());
          factoryFn(ServiceResolver r) => 'factory';
          when(() => injector.factory<String>(any(),
              name: any(named: 'name'),
              force: any(named: 'force'))).thenReturn(null);
          when(() => injector.lazySingleton<String>(any(),
              name: any(named: 'name'),
              force: any(named: 'force'))).thenReturn(null);
          when(() => injector.singleton<String>(any(),
              name: any(named: 'name'),
              force: any(named: 'force'))).thenReturn(null);
          when(() => injector.singletonAsync<String>(any(),
              name: any(named: 'name'),
              force: any(named: 'force'))).thenAnswer((_) async {});
          when(() => injector.unlink<String>(name: any(named: 'name')))
              .thenReturn(null);

          // Act
          si.factory<String>(factoryFn, name: 'n', force: true);
          si.lazySingleton<String>(factoryFn, name: 'n', force: true);
          si.singleton<String>(factoryFn, name: 'n', force: true);
          await si.singletonAsync<String>((r) async => 'async',
              name: 'n', force: true);
          si.unlink<String>(name: 'n');

          // Assert
          verify(() => injector.factory<String>(any(), name: 'n', force: true))
              .called(1);
          verify(() =>
                  injector.lazySingleton<String>(any(), name: 'n', force: true))
              .called(1);
          verify(() =>
                  injector.singleton<String>(any(), name: 'n', force: true))
              .called(1);
          verify(() => injector.singletonAsync<String>(any(),
              name: 'n', force: true)).called(1);
          verify(() => injector.unlink<String>(name: 'n')).called(1);
        },
      );
    },
  );
}

class _MockServiceInjector extends Mock implements ServiceInjector {}
