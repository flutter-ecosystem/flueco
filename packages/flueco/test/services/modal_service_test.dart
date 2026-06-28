import 'package:flueco/flueco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorKeyProvider extends Mock implements NavigatorKeyProvider {}

void main() {
  late ModalService modalService;
  late MockNavigatorKeyProvider mockNavigatorKeyProvider;

  setUp(() {
    mockNavigatorKeyProvider = MockNavigatorKeyProvider();
    modalService = ModalService(
      navigatorKeyProvider: mockNavigatorKeyProvider,
    );
  });

  group('ModalService', () {
    testWidgets(
        'should open modal with different content when called with valid parameters',
        (tester) async {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      final testWidget = MaterialApp(
        navigatorKey: navigatorKey,
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                await modalService.showModal(
                  (ctx) => Container(
                    color: Colors.white,
                    child: const Text('Modal Content'),
                  ),
                );
              },
              child: const Text('Show Modal'),
            );
          },
        ),
      );

      // Act
      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Show Modal'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Modal Content'), findsOneWidget);
    });

    testWidgets('should dismiss modal when user interacts with dismiss action',
        (tester) async {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      final testWidget = MaterialApp(
        navigatorKey: navigatorKey,
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                final result = await modalService.showModal(
                  (ctx) => Container(
                    color: Colors.white,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(ctx).pop('dismissed'),
                      child: const Text('Dismiss'),
                    ),
                  ),
                );
                expect(result, 'dismissed');
              },
              child: const Text('Show Modal'),
            );
          },
        ),
      );

      // Act
      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Show Modal'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dismiss'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Modal Content'), findsNothing);
    });

    testWidgets('should return modal result when user completes interaction',
        (tester) async {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      final testWidget = MaterialApp(
        navigatorKey: navigatorKey,
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                final result = await modalService.showModal<String>(
                  (ctx) => Container(
                    color: Colors.white,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(ctx).pop('completed'),
                      child: const Text('Complete'),
                    ),
                  ),
                );
                expect(result, 'completed');
              },
              child: const Text('Show Modal'),
            );
          },
        ),
      );

      // Act
      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Show Modal'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Complete'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Complete'), findsNothing); // Modal should be dismissed
    });

    testWidgets('should handle modal with complex content', (tester) async {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      final testWidget = MaterialApp(
        navigatorKey: navigatorKey,
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                await modalService.showModal(
                  (ctx) => Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Title'),
                        const Text('Description'),
                        ElevatedButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Show Complex Modal'),
            );
          },
        ),
      );

      // Act
      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Show Complex Modal'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find.text('Close'), findsOneWidget);
    });
  });
}
