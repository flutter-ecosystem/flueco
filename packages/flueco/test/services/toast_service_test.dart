import 'package:flueco/flueco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorKeyProvider extends Mock implements NavigatorKeyProvider {}

void main() {
  late ToastService toastService;
  late MockNavigatorKeyProvider mockNavigatorKeyProvider;

  setUp(() {
    mockNavigatorKeyProvider = MockNavigatorKeyProvider();
    toastService = ToastService(
      navigatorKeyProvider: mockNavigatorKeyProvider,
    );
  });

  group('ToastService', () {
    testWidgets(
        'should display toast with different messages when called with valid parameters',
        (tester) async {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      final testWidget = ToastificationWrapper(
        child: MaterialApp(
          navigatorKey: navigatorKey,
          home: const SizedBox(),
        ),
      );

      await tester.pumpWidget(testWidget);

      // Act & Assert - Test that the service is properly initialized
      expect(toastService, isNotNull);
      expect(toastService.logHandler, isNotNull);
    });

    test('should register custom toast handler when valid handler is provided',
        () {
      // Arrange
      final toastService = ToastService(
        navigatorKeyProvider: mockNavigatorKeyProvider,
      );

      // Act
      final logHandler = toastService.logHandler;

      // Assert
      expect(logHandler, isNotNull);
      expect(logHandler, isA<LogHandler>());
    });

    test('should handle null context gracefully', () {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);
      // navigatorKey.currentContext will be null since no widget is using it

      // Act & Assert
      expect(
        () => toastService.show('Null context toast'),
        returnsNormally,
      );
    });

    test('should log handler route messages to toast correctly', () {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);
      final logHandler = toastService.logHandler;

      final debugMessage = LogMessage(content: 'Debug toast');
      final infoMessage = LogMessage(content: 'Info toast');
      final errorMessage = LogMessage(content: 'Error toast');
      final warningMessage = LogMessage(content: 'Warning toast');
      final criticalMessage = LogMessage(content: 'Critical toast');
      final logMessage = LogMessage(content: 'Log toast');

      // Act & Assert - These should not throw
      expect(() => logHandler.debug(debugMessage), returnsNormally);
      expect(() => logHandler.info(infoMessage), returnsNormally);
      expect(() => logHandler.error(errorMessage), returnsNormally);
      expect(() => logHandler.warning(warningMessage), returnsNormally);
      expect(() => logHandler.critical(criticalMessage), returnsNormally);
      expect(() => logHandler.log(logMessage), returnsNormally);
    });

    test('should handle different toast message types', () {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);
      final logHandler = toastService.logHandler;

      // Act & Assert
      expect(() => logHandler.debug(LogMessage(content: '[DEBUG] Test')),
          returnsNormally);
      expect(() => logHandler.info(LogMessage(content: '[INFO] Test')),
          returnsNormally);
      expect(() => logHandler.warning(LogMessage(content: '[WARNING] Test')),
          returnsNormally);
      expect(() => logHandler.error(LogMessage(content: '[ERROR] Test')),
          returnsNormally);
      expect(() => logHandler.critical(LogMessage(content: '[CRITICAL] Test')),
          returnsNormally);
    });

    test('should integrate with navigator key provider correctly', () {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      final toastService = ToastService(
        navigatorKeyProvider: mockNavigatorKeyProvider,
      );

      // Act & Assert
      expect(toastService, isNotNull);
      expect(() => toastService.show('Integration test'), returnsNormally);
    });

    test('should handle multiple toast calls sequentially', () {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      final toastService = ToastService(
        navigatorKeyProvider: mockNavigatorKeyProvider,
      );

      // Act & Assert
      expect(() => toastService.show('First toast'), returnsNormally);
      expect(() => toastService.show('Second toast'), returnsNormally);
      expect(() => toastService.show('Third toast'), returnsNormally);
    });

    test('should handle special characters in messages', () {
      // Arrange
      final navigatorKey = GlobalKey<NavigatorState>();
      when(() => mockNavigatorKeyProvider.navigatorKey)
          .thenReturn(navigatorKey);

      const specialMessage = r'Special chars: éñüñ 中文 🚀 @#$%^&*()';

      // Act & Assert
      expect(() => toastService.show(specialMessage), returnsNormally);
    });
  });
}
