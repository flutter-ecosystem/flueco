import 'package:flueco/flueco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockFluecoKernel extends Mock implements FluecoKernel {}

class _MockServiceContainer extends Mock implements ServiceContainer {}

class _MockMessaging extends Mock implements Messaging {}

class _MockFluecoApp extends Mock implements FluecoApp {}

void main() {
  late _MockFluecoKernel mockFluecoKernel;
  late _MockServiceContainer mockServiceContainer;
  late _MockMessaging mockMessaging;
  late _MockFluecoApp mockFluecoApp;

  setUp(() {
    mockFluecoKernel = _MockFluecoKernel();
    mockServiceContainer = _MockServiceContainer();
    mockMessaging = _MockMessaging();
    mockFluecoApp = _MockFluecoApp();

    when(() => mockFluecoKernel.container).thenReturn(mockServiceContainer);
    when(() => mockServiceContainer.resolve<Messaging>())
        .thenReturn(mockMessaging);
    when(() => mockFluecoKernel.app).thenReturn(mockFluecoApp);

    when(() => mockMessaging.start()).thenAnswer((_) async {});
    when(() => mockMessaging.stop()).thenAnswer((_) async {});
  });

  group('Flueco Widget', () {
    testWidgets('should render child widget correctly when kernel is provided',
        (tester) async {
      // Arrange
      const childWidget = Text('Test Child');
      final fluecoWidget = Flueco(
        kernel: mockFluecoKernel,
        child: childWidget,
      );

      // Act
      await tester.pumpWidget(MaterialApp(home: fluecoWidget));

      // Assert
      expect(find.text('Test Child'), findsOneWidget);
    });

    testWidgets('should provide FluecoApp to descendants via InheritedWidget',
        (tester) async {
      // Arrange
      const childWidget = Text('Test Child');
      final fluecoWidget = Flueco(
        kernel: mockFluecoKernel,
        child: childWidget,
      );

      // Act
      await tester.pumpWidget(MaterialApp(home: fluecoWidget));

      // Assert
      final context = tester.element(find.text('Test Child'));
      final app = Flueco.of(context);
      expect(app, equals(mockFluecoApp));
    });

    testWidgets('should handle complex widget tree correctly', (tester) async {
      // Arrange
      final complexWidget = Column(
        children: [
          const Text('Header'),
          const Text('Content'),
          const Text('Footer'),
        ],
      );

      final fluecoWidget = Flueco(
        kernel: mockFluecoKernel,
        child: complexWidget,
      );

      // Act
      await tester.pumpWidget(MaterialApp(home: fluecoWidget));

      // Assert
      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
      expect(find.text('Footer'), findsOneWidget);

      final context = tester.element(find.text('Content'));
      final app = Flueco.of(context);
      expect(app, equals(mockFluecoApp));
    });

    testWidgets('should work with different material themes', (tester) async {
      // Arrange
      const childWidget = Text('Themed Child');
      final fluecoWidget = Flueco(
        kernel: mockFluecoKernel,
        child: childWidget,
      );

      final themedApp = MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.blue,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black),
          ),
        ),
        home: fluecoWidget,
      );

      // Act
      await tester.pumpWidget(themedApp);

      // Assert
      expect(find.text('Themed Child'), findsOneWidget);
      final context = tester.element(find.text('Themed Child'));
      final app = Flueco.of(context);
      expect(app, equals(mockFluecoApp));
    });

    testWidgets(
        'should return null when Flueco.of is called outside Flueco widget tree',
        (tester) async {
      // Arrange
      const childWidget = Text('Orphan Child');

      // Act
      await tester.pumpWidget(MaterialApp(home: childWidget));

      // Assert
      final context = tester.element(find.text('Orphan Child'));
      expect(() => Flueco.of(context), throwsStateError);
    });

    testWidgets('should handle empty child widget', (tester) async {
      // Arrange
      const childWidget = SizedBox.shrink();
      final fluecoWidget = Flueco(
        kernel: mockFluecoKernel,
        child: childWidget,
      );

      // Act
      await tester.pumpWidget(MaterialApp(home: fluecoWidget));

      // Assert
      final context = tester.element(find.byType(SizedBox));
      final app = Flueco.of(context);
      expect(app, equals(mockFluecoApp));
    });

    testWidgets('should work with Scaffold and other material widgets',
        (tester) async {
      // Arrange
      final scaffoldWidget = Scaffold(
        appBar: AppBar(title: const Text('Test App')),
        body: const Text('Body Content'),
      );

      final fluecoWidget = Flueco(
        kernel: mockFluecoKernel,
        child: scaffoldWidget,
      );

      // Act
      await tester.pumpWidget(MaterialApp(home: fluecoWidget));

      // Assert
      expect(find.text('Test App'), findsOneWidget);
      expect(find.text('Body Content'), findsOneWidget);

      final context = tester.element(find.text('Body Content'));
      final app = Flueco.of(context);
      expect(app, equals(mockFluecoApp));
    });
  });
}

class _TestStatefulWidget extends StatefulWidget {
  @override
  State<_TestStatefulWidget> createState() => _TestStatefulWidgetState();
}

class _TestStatefulWidgetState extends State<_TestStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text('Initial State');
  }
}
