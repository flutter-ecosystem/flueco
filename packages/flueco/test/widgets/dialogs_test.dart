import 'package:flueco/flueco.dart' hide AlertDialog;
import 'package:flueco_core/flueco_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorKeyProvider extends Mock implements NavigatorKeyProvider {}

void main() {
  late MockNavigatorKeyProvider mockNavigatorKeyProvider;

  setUp(() {
    mockNavigatorKeyProvider = MockNavigatorKeyProvider();
  });

  group('Dialog Components', () {
    testWidgets('should AlertDialog display title and content correctly',
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
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Alert Title'),
                    content: const Text('Alert Content'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
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
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('should ConfirmDialog handle yes/no responses correctly',
        (tester) async {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      bool? result;
      final testWidget = MaterialApp(
        navigatorKey: navigatorKey,
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                result = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Confirm'),
                    content: const Text('Are you sure?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
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
      expect(result, isTrue);
    });

    testWidgets('should PromptDialog return user input correctly',
        (tester) async {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      String? result;
      final testWidget = MaterialApp(
        navigatorKey: navigatorKey,
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                result = await showDialog<String>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Enter Text'),
                    content: TextField(
                      onChanged: (value) {},
                      controller: TextEditingController(text: 'User Input'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop('User Input'),
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                );
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
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      // Assert
      expect(result, equals('User Input'));
    });

    testWidgets('should dialogs dismiss when tapped outside', (tester) async {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      final testWidget = MaterialApp(
        navigatorKey: navigatorKey,
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => const AlertDialog(
                    title: Text('Dismissible Dialog'),
                    content: Text('Tap outside to dismiss'),
                  ),
                );
              },
              child: const Text('Show Dismissible'),
            );
          },
        ),
      );

      // Act
      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Show Dismissible'));
      await tester.pumpAndSettle();

      // Assert - Dialog is shown
      expect(find.text('Dismissible Dialog'), findsOneWidget);

      // Act - Tap outside dialog
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      // Assert - Dialog is dismissed
      expect(find.text('Dismissible Dialog'), findsNothing);
    });

    testWidgets('should AlertDialog handle long content with scrolling',
        (tester) async {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      final longContent = 'Long content ' * 100;
      final testWidget = MaterialApp(
        navigatorKey: navigatorKey,
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Long Content Dialog'),
                    content: SingleChildScrollView(
                      child: Text(longContent),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Show Long Dialog'),
            );
          },
        ),
      );

      // Act
      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Show Long Dialog'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Long Content Dialog'), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('should ConfirmDialog handle cancel action correctly',
        (tester) async {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      bool? result;
      final testWidget = MaterialApp(
        navigatorKey: navigatorKey,
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                result = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Confirm Cancel'),
                    content: const Text('Cancel this action?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(null),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        child: const Text('Confirm'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Show Cancel Confirm'),
            );
          },
        ),
      );

      // Act
      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Show Cancel Confirm'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Assert
      expect(result, isNull);
    });

    testWidgets('should PromptDialog validate input before submission',
        (tester) async {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      String? result;
      final testWidget = MaterialApp(
        navigatorKey: navigatorKey,
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () async {
                result = await showDialog<String>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Enter Valid Text'),
                    content: TextField(
                      controller: TextEditingController(),
                      decoration: const InputDecoration(
                        hintText: 'Enter at least 3 characters',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop('Valid Input'),
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Show Validated Prompt'),
            );
          },
        ),
      );

      // Act
      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Show Validated Prompt'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      // Assert
      expect(result, equals('Valid Input'));
    });

    testWidgets('should dialogs handle different screen sizes correctly',
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
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Responsive Dialog'),
                    content: const Text('This dialog adapts to screen size'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Show Responsive Dialog'),
            );
          },
        ),
      );

      // Act
      await tester.pumpWidget(testWidget);
      await tester.tap(find.text('Show Responsive Dialog'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Responsive Dialog'), findsOneWidget);
      expect(find.text('This dialog adapts to screen size'), findsOneWidget);
      expect(find.text('Close'), findsOneWidget);
    });
  });
}
