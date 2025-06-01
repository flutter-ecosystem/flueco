import 'package:flutter_test/flutter_test.dart';
import 'package:flueco_core/flueco_core.dart';

void main() {
  test(
    'ChannelRegistry can register and get handlers',
    () {
      // Arrange
      final provider = _DummyProvider({'channel1'});
      final registry = _DummyRegistry(provider: provider);
      final handler = _DummyHandler();

      // Act
      registry.register('channel1', handler);

      // Assert
      expect(registry.get<_DummyHandler>('channel1'), handler);
      expect(registry.getOrNull<_DummyHandler>('channel1'), handler);
      expect(() => registry.get<_DummyHandler>('channel2'), throwsStateError);
      expect(registry.getOrNull<_DummyHandler>('channel2'), isNull);
    },
  );

  test(
    'ChannelRegistry getDefaults throws if not registered',
    () {
      // Arrange
      final provider = _DummyProvider({'channel1'});
      final registry = _DummyRegistry(provider: provider);

      // Act & Assert
      expect(
          () => registry.getDefaults<_DummyHandler>(
                _DummyAction(),
              ),
          throwsStateError);
    },
  );

  test(
    'ChannelRegistry getDefaults returns registered handler',
    () {
      // Arrange
      final provider = _DummyProvider({'channel1'});
      final registry = _DummyRegistry(provider: provider);
      final handler = _DummyHandler();

      // Act
      registry.register('channel1', handler);

      // Assert
      final defaults = registry.getDefaults<_DummyHandler>(_DummyAction());
      expect(defaults, contains(handler));
    },
  );
}

class _DummyAction extends ChannelHandlerAction {}

class _DummyHandler implements ChannelHandler {}

class _DummyProvider extends DefaultChannelProvider<_DummyAction> {
  final Set<String> channels;
  _DummyProvider(this.channels);
  @override
  Set<String> getChannelHandler(
          _DummyAction action, ChannelRegistry registry) =>
      channels;
}

class _DummyRegistry extends ChannelRegistry<_DummyHandler, _DummyProvider> {
  _DummyRegistry({required _DummyProvider provider})
      : super(defaultChannelProvider: provider);
}
