import 'package:flueco/flueco.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late LoggerService loggerService;

  setUp(() {
    loggerService = LoggerService(enable: true);
  });

  group('LoggerService', () {
    test(
        'should log messages at different levels when called with valid parameters',
        () {
      // Arrange
      final testError = Exception('Test error');
      final stackTrace = StackTrace.current;

      // Act & Assert - These should not throw
      expect(() => loggerService.debug('Debug message'), returnsNormally);
      expect(() => loggerService.info('Info message'), returnsNormally);
      expect(() => loggerService.warning('Warning message'), returnsNormally);
      expect(() => loggerService.error('Error message'), returnsNormally);
      expect(() => loggerService.verbose('Verbose message'), returnsNormally);

      // Test with error and stack trace
      expect(
          () => loggerService.debug('Debug with error',
              error: testError, stackTrace: stackTrace),
          returnsNormally);
      expect(
          () => loggerService.error('Error with details',
              error: testError, stackTrace: stackTrace),
          returnsNormally);
      expect(
          () => loggerService.warning('Warning with details',
              error: testError, stackTrace: stackTrace),
          returnsNormally);
    });

    test(
        'should format log messages correctly when custom formatter is provided',
        () {
      // Arrange
      final loggerService = LoggerService(enable: true);

      // Act & Assert
      expect(() => loggerService.debug('Test message'), returnsNormally);
      expect(() => loggerService.info('Formatted info'), returnsNormally);
      expect(() => loggerService.warning('Formatted warning'), returnsNormally);
    });

    test('should register custom log handler when valid handler is provided',
        () {
      // Arrange
      final loggerService = LoggerService(enable: true);
      final logHandler = loggerService.logHandler;

      // Act & Assert
      expect(logHandler, isNotNull);
      expect(logHandler, isA<LogHandler>());
    });

    test('should enable and disable logging correctly', () {
      // Arrange
      final loggerService = LoggerService(enable: true);

      // Act
      loggerService.disable();

      // Assert - These should still not throw, just not log
      expect(() => loggerService.debug('Should not log'), returnsNormally);
      expect(() => loggerService.info('Should not log'), returnsNormally);

      // Act
      loggerService.enable();

      // Assert
      expect(() => loggerService.debug('Should log again'), returnsNormally);
      expect(() => loggerService.info('Should log again'), returnsNormally);
    });

    test('should handle different log levels appropriately in debug mode', () {
      // Arrange
      debugDefaultTargetPlatformOverride =
          TargetPlatform.android; // Set to debug mode

      final loggerService =
          LoggerService(enable: null); // Should default to kDebugMode

      // Act & Assert
      expect(() => loggerService.debug('Debug in debug mode'), returnsNormally);
      expect(() => loggerService.info('Info in debug mode'), returnsNormally);
      expect(() => loggerService.warning('Warning in debug mode'),
          returnsNormally);
      expect(() => loggerService.error('Error in debug mode'), returnsNormally);

      debugDefaultTargetPlatformOverride = null; // Reset
    });

    test('should handle different log levels appropriately in release mode',
        () {
      // Arrange
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      final loggerService = LoggerService(enable: false); // Explicitly disabled

      // Act & Assert - Should not throw but also not log
      expect(
          () => loggerService.debug('Debug in release mode'), returnsNormally);
      expect(() => loggerService.info('Info in release mode'), returnsNormally);
      expect(() => loggerService.warning('Warning in release mode'),
          returnsNormally);
      expect(
          () => loggerService.error('Error in release mode'), returnsNormally);

      debugDefaultTargetPlatformOverride = null; // Reset
    });

    test('should log handler route messages correctly', () {
      // Arrange
      final loggerService = LoggerService(enable: true);
      final logHandler = loggerService.logHandler;

      final debugMessage = LogMessage(content: 'Debug test');
      final infoMessage = LogMessage(content: 'Info test');
      final errorMessage = ErrorLogMessage(
        error: Exception('Test error'),
        message: 'Error test',
      );

      // Act & Assert
      expect(() => logHandler.debug(debugMessage), returnsNormally);
      expect(() => logHandler.info(infoMessage), returnsNormally);
      expect(() => logHandler.error(errorMessage), returnsNormally);
      expect(() => logHandler.warning(LogMessage(content: 'Warning test')),
          returnsNormally);
      expect(() => logHandler.critical(LogMessage(content: 'Critical test')),
          returnsNormally);
      expect(() => logHandler.log(LogMessage(content: 'Log test')),
          returnsNormally);
    });

    test('should handle ErrorLogMessage with error details', () {
      // Arrange
      final loggerService = LoggerService(enable: true);
      final logHandler = loggerService.logHandler;

      final testError = Exception('Test exception');
      final errorMessage = ErrorLogMessage(
        error: testError,
        stackTrace: StackTrace.current,
        message: 'Error with details',
      );

      // Act & Assert
      expect(() => logHandler.error(errorMessage), returnsNormally);
      expect(errorMessage.error, equals(testError));
      expect(errorMessage.stackTrace, isNotNull);
    });

    test('should create ErrorLogMessage with error information', () {
      // Arrange
      final testError = Exception('Test error message');

      // Act
      final errorMessage = ErrorLogMessage(error: testError);

      // Assert
      expect(errorMessage.error, equals(testError));
      expect(errorMessage.content, equals(testError.toString()));
      expect(errorMessage, isA<LogMessage>());
    });

    test('should create ErrorLogMessage with custom message', () {
      // Arrange
      final testError = Exception('Test error');
      final customMessage = 'Custom error message';

      // Act
      final errorMessage = ErrorLogMessage(
        error: testError,
        message: customMessage,
      );

      // Assert
      expect(errorMessage.error, equals(testError));
      expect(errorMessage.content, equals(customMessage));
    });
  });
}
