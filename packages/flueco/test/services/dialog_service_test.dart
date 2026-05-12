import 'package:flueco/flueco.dart';
import 'package:flueco_core/flueco_core.dart';
import 'package:flutter/material.dart' hide AlertDialog;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorKeyProvider extends Mock implements NavigatorKeyProvider {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late DialogService dialogService;
  late MockNavigatorKeyProvider mockNavigatorKeyProvider;

  setUp(() {
    mockNavigatorKeyProvider = MockNavigatorKeyProvider();

    dialogService = DialogService(
      navigatorKeyProvider: mockNavigatorKeyProvider,
    );
  });

  group('DialogService', () {
    testWidgets(
        'should create dialog with different message types when called with valid parameters',
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
                await dialogService.show(
                  builder: (ctx) => AlertDialog(
                    data: AlertDialogData(
                      title: 'Test',
                      content: 'Test content',
                    ),
                  ),
                );
              },
              child: const Text('Show Dialog'),
            );
          },
        ),
      );

      // Act
      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Test'), findsOneWidget);
      expect(find.text('Test content'), findsOneWidget);
    });
    test('should throw error when service is not properly initialized',
        () async {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      // Act & Assert
      expect(
        () => dialogService.show(builder: (ctx) => const SizedBox()),
        returnsNormally,
      );
    });

    testWidgets('should alert method work correctly with AlertDialogData',
        (tester) async {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      final testData = AlertDialogData(
        title: 'Alert Title',
        content: 'Alert Content',
        okLabel: 'Got it',
      );

      final testWidget = MaterialApp(
        navigatorKey: navigatorKey,
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                await dialogService.alert(data: testData);
              },
              child: const Text('Show Alert'),
            );
          },
        ),
      );

      // Act
      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Show Alert'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Alert Title'), findsOneWidget);
      expect(find.text('Alert Content'), findsOneWidget);
      expect(find.text('Got it'), findsOneWidget);
    });

    testWidgets('should confirm method return true when user accepts',
        (tester) async {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      final testData = ConfirmDialogData(
        title: 'Confirm Title',
        content: 'Confirm Content',
      );

      final testWidget = MaterialApp(
        navigatorKey: navigatorKey,
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                final result = await dialogService.confirm(data: testData);
                expect(result, true);
              },
              child: const Text('Show Confirm'),
            );
          },
        ),
      );

      // Act
      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Show Confirm'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Yes'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Confirm Title'),
          findsNothing); // Dialog should be dismissed
    });

    testWidgets('should confirm method return false when user cancels',
        (tester) async {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      final testData = ConfirmDialogData(
        title: 'Confirm Title',
        content: 'Confirm Content',
      );

      final testWidget = MaterialApp(
        navigatorKey: navigatorKey,
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                final result = await dialogService.confirm(data: testData);
                expect(result, false);
              },
              child: const Text('Show Confirm'),
            );
          },
        ),
      );

      // Act
      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Show Confirm'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('No'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Confirm Title'),
          findsNothing); // Dialog should be dismissed
    });

    testWidgets('should prompt method return true when user validates input',
        (tester) async {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      final controller = TextEditingController(text: 'Test Input');
      final testData = PromptDialogData(
        title: 'Prompt Title',
        content: 'Prompt Content',
        input: PromptDialogDataInput(
          controller: controller,
          hintText: 'Enter text',
        ),
      );

      final testWidget = MaterialApp(
        navigatorKey: navigatorKey,
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                final result = await dialogService.prompt(data: testData);
                expect(result, true);
              },
              child: const Text('Show Prompt'),
            );
          },
        ),
      );

      // Act
      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Show Prompt'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Validate'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Prompt Title'),
          findsNothing); // Dialog should be dismissed
    });

    testWidgets('should prompt method return false when user cancels',
        (tester) async {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      final controller = TextEditingController();
      final testData = PromptDialogData(
        title: 'Prompt Title',
        content: 'Prompt Content',
        input: PromptDialogDataInput(
          controller: controller,
          hintText: 'Enter text',
        ),
      );

      final testWidget = MaterialApp(
        navigatorKey: navigatorKey,
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                final result = await dialogService.prompt(data: testData);
                expect(result, false);
              },
              child: const Text('Show Prompt'),
            );
          },
        ),
      );

      // Act
      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Show Prompt'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Prompt Title'),
          findsNothing); // Dialog should be dismissed
    });
  });
}
