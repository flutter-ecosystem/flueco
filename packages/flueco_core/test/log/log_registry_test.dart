import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flueco_core/flueco_core.dart';
import 'package:mocktail/mocktail.dart';

class _MockLogHandler extends Mock implements LogHandler {}

class _MockLogDefaultChannelProvider extends Mock
    implements LogDefaultChannelProvider {}

class _MockServiceResolver extends Mock implements ServiceResolver {}

class _MockLogMessage extends Mock implements LogMessage {}

class _TestLogRegistry extends LogRegistry {
  _TestLogRegistry({required super.defaultChannelProvider});
  @override
  void registerHandlers(ServiceResolver resolver) {}
}

void main() {
  group(
    'LogRegistry',
    () {
      setUpAll(
        () {
          registerFallbackValue(_MockLogHandler());
          registerFallbackValue(_MockLogDefaultChannelProvider());
          registerFallbackValue(_MockServiceResolver());
          registerFallbackValue(_MockLogMessage());
          registerFallbackValue(CriticalLogHandlerAction(
            message: _MockLogMessage(),
          ));
        },
      );

      late LogRegistry registry;
      late _MockLogDefaultChannelProvider provider;
      late _MockLogHandler handler;
      late _MockLogMessage message;

      setUp(
        () {
          provider = _MockLogDefaultChannelProvider();
          handler = _MockLogHandler();
          message = _MockLogMessage();

          registry = _TestLogRegistry(defaultChannelProvider: provider);
          when(() => provider.getChannelHandler(any(), registry))
              .thenReturn({'default'});
          registry.register('default', handler);
        },
      );

      test(
        'critical calls critical on all default handlers',
        () {
          when(() => handler.critical(message)).thenReturn(null);
          registry.critical(message);
          verify(() => handler.critical(message)).called(1);
        },
      );

      test(
        'debug calls critical on all default handlers',
        () {
          when(() => handler.critical(message)).thenReturn(null);
          registry.debug(message);
          verify(() => handler.critical(message)).called(1);
        },
      );

      test(
        'error calls critical on all default handlers',
        () {
          when(() => handler.critical(message)).thenReturn(null);
          registry.error(message);
          verify(() => handler.critical(message)).called(1);
        },
      );

      test(
        'info calls critical on all default handlers',
        () {
          when(() => handler.critical(message)).thenReturn(null);
          registry.info(message);
          verify(() => handler.critical(message)).called(1);
        },
      );

      test(
        'log calls critical on all default handlers',
        () {
          when(() => handler.critical(message)).thenReturn(null);
          registry.log(message);
          verify(() => handler.critical(message)).called(1);
        },
      );

      test(
        'warning calls critical on all default handlers',
        () {
          when(() => handler.critical(message)).thenReturn(null);
          registry.warning(message);
          verify(() => handler.critical(message)).called(1);
        },
      );
    },
  );

  group(
    'FluecoLog',
    () {
      testWidgets(
        'of returns LogHandler from context',
        (tester) async {
          // Arrange
          final registry = _TestLogRegistry(
            defaultChannelProvider: _MockLogDefaultChannelProvider(),
          );
          final sr = _MockServiceResolver();
          when(() => sr.resolve<LogRegistry>()).thenReturn(registry);

          // Act
          late LogHandler logHandler;
          await tester.pumpWidget(
            FluecoSR(
              resolver: sr,
              child: Builder(
                builder: (context) {
                  logHandler = FluecoLog.of(context);
                  return const Placeholder();
                },
              ),
            ),
          );

          // Assert
          expect(logHandler, registry);
        },
      );
    },
  );
}
