import 'package:flutter/foundation.dart';

import 'channel_handler.dart';

/// Type of action of the handler
abstract class ChannelHandlerAction {}

/// Provider of the default channel
abstract class DefaultChannelProvider<A extends ChannelHandlerAction> {
  /// Get default channel handler name for each action
  Set<String> getChannelHandler(A action, ChannelRegistry registry);
}

/// Base class for registry
abstract class ChannelRegistry<H extends ChannelHandler,
    P extends DefaultChannelProvider<ChannelHandlerAction>> {
  final Map<String, H> _registry;
  final P defaultChannelProvider;

  ChannelRegistry({
    required this.defaultChannelProvider,
    Map<String, H> registry = const {},
  }) : _registry = Map<String, H>.from(registry);

  /// Register a [handler]
  @mustCallSuper
  void register(String channel, H handler) {
    if (!_registry.containsKey(channel)) {
      _registry[channel] = handler;
    }
  }

  /// Get default channel [R] registered
  ///
  /// It could throw a StateError if the handler is not registered yet.
  @mustCallSuper
  Iterable<R> getDefaults<R extends H>(ChannelHandlerAction action) {
    final Set<String> defaultChannel =
        defaultChannelProvider.getChannelHandler(action, this);
    if (!_registry.containsKey(defaultChannel)) {
      throw StateError(
          'You try to get a ChannelHandler "[$R]" registered with name "$defaultChannel" but it is not registered yet.');
    }
    return defaultChannel
        .where((e) => _registry.containsKey(e))
        .map((e) => _registry[e]! as R);
  }

  /// Get a [R] registered with [channel]
  ///
  /// It could throw a StateError if the handler is not registered yet.
  @mustCallSuper
  R get<R extends H>(String channel) {
    if (!_registry.containsKey(channel)) {
      throw StateError(
          'You try to get a ChannelHandler "[$R]" registered with name "$channel" but it is not registered yet.');
    }

    return _registry[channel]! as R;
  }

  /// Get a [R] registered with [channel]
  ///
  /// Returns null if the channel handler is not found
  @nonVirtual
  R? getOrNull<R extends H>(String channel) {
    try {
      return get<R>(channel);
    } catch (e) {
      //
    }
    return null;
  }
}
