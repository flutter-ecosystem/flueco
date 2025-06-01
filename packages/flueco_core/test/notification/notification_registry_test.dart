import 'package:flutter_test/flutter_test.dart';
import 'package:flueco_core/flueco_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/widgets.dart';

void main() {
  group(
    'NotificationRegistry',
    () {
      setUpAll(() {
        registerFallbackValue(_MockNotificationHandler());
        registerFallbackValue(_MockNotificationDefaultChannelProvider());
        registerFallbackValue(_MockServiceResolver());
        registerFallbackValue(_MockAskMessage());
        registerFallbackValue(_MockInformMessage());
        registerFallbackValue(
          AskNotificationHandlerAction(message: _MockAskMessage()),
        );
      });

      late _TestNotificationRegistry registry;
      late _MockNotificationDefaultChannelProvider provider;
      late _MockNotificationHandler handler;
      late _MockAskMessage askMessage;
      late _MockInformMessage informMessage;

      setUp(() {
        provider = _MockNotificationDefaultChannelProvider();
        registry = _TestNotificationRegistry(defaultChannelProvider: provider);
        handler = _MockNotificationHandler();
        askMessage = _MockAskMessage();
        informMessage = _MockInformMessage();

        when(() => provider.getChannelHandler(any(), registry))
            .thenReturn({'default'});
        registry.register('default', handler);
      });

      test(
        'ask calls ask on all default handlers',
        () async {
          when(() => handler.ask(askMessage)).thenAnswer((_) async {});
          await registry.ask(askMessage);
          verify(() => handler.ask(askMessage)).called(1);
        },
      );

      test(
        'confirm calls confirm on all default handlers',
        () async {
          when(() => handler.confirm(informMessage))
              .thenAnswer((_) async => true);
          final result = await registry.confirm(informMessage);
          expect(result, isTrue);
          verify(() => handler.confirm(informMessage)).called(1);
        },
      );

      test(
        'inform calls inform on all default handlers',
        () async {
          when(() => handler.inform(informMessage)).thenAnswer((_) async {});
          await registry.inform(informMessage);
          verify(() => handler.inform(informMessage)).called(1);
        },
      );
    },
  );

  group(
    'FluecoNotification',
    () {
      testWidgets(
        'of returns NotificationHandler from context',
        (tester) async {
          // Arrange
          final registry = _TestNotificationRegistry(
            defaultChannelProvider: _MockNotificationDefaultChannelProvider(),
          );
          final sr = _MockServiceResolver();
          when(() => sr.resolve<NotificationRegistry>()).thenReturn(registry);

          // Act
          late NotificationHandler notificationHandler;
          await tester.pumpWidget(
            FluecoSR(
              resolver: sr,
              child: Builder(
                builder: (context) {
                  notificationHandler = FluecoNotification.of(context);
                  return const Placeholder();
                },
              ),
            ),
          );

          // Assert
          expect(notificationHandler, registry);
        },
      );
    },
  );
}

class _MockNotificationHandler extends Mock implements NotificationHandler {}

class _MockNotificationDefaultChannelProvider extends Mock
    implements NotificationDefaultChannelProvider {}

class _MockServiceResolver extends Mock implements ServiceResolver {}

class _MockAskMessage extends Mock implements AskMessage {}

class _MockInformMessage extends Mock implements InformMessage {}

class _TestNotificationRegistry extends NotificationRegistry {
  _TestNotificationRegistry({required super.defaultChannelProvider});
  @override
  void registerHandlers(ServiceResolver resolver) {}
}
