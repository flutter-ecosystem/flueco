import 'package:flueco_core/src/foundation/di/service_resolver.dart';
import 'package:flutter/widgets.dart';

import '../foundation/di/service_injector.dart';

/// A widget that provides the [ServiceInjector] to its descendants.
///
/// This widget will be added to the widget tree by the [FluecoAppWrapper].
class FluecoSI extends InheritedWidget implements ServiceInjector {
  final ServiceInjector _injector;

  /// Create a new instance of [FluecoSI].
  const FluecoSI({
    super.key,
    required super.child,
    required ServiceInjector injector,
  }) : _injector = injector;

  /// Get the [FluecoSI] from the [BuildContext].
  static FluecoSI? of(BuildContext context) {
    final si = context.getInheritedWidgetOfExactType<FluecoSI>();
    if (si == null) {
      throw StateError(
          'Flueco is not accessible through this context [$context].'
          'Make sure you add it on top of the tree '
          'or the context is still mounted.');
    }
    return si;
  }

  @override
  bool updateShouldNotify(FluecoSI oldWidget) {
    return false;
  }

  @override
  void factory<T extends Object>(
    T Function(ServiceResolver resolver) factory, {
    bool force = false,
    String? name,
  }) {
    _injector.factory<T>(
      factory,
      name: name,
      force: force,
    );
  }

  @override
  void lazySingleton<T extends Object>(
    T Function(ServiceResolver resolver) factory, {
    bool force = false,
    String? name,
  }) {
    _injector.lazySingleton<T>(
      factory,
      name: name,
      force: force,
    );
  }

  @override
  void singleton<T extends Object>(
    T Function(ServiceResolver resolver) factory, {
    bool force = false,
    String? name,
  }) {
    _injector.singleton<T>(
      factory,
      name: name,
      force: force,
    );
  }

  @override
  Future<void> singletonAsync<T extends Object>(
    Future<T> Function(ServiceResolver resolver) factory, {
    bool force = false,
    String? name,
  }) {
    return _injector.singletonAsync<T>(
      factory,
      name: name,
      force: force,
    );
  }

  @override
  void unlink<T extends Object>({String? name}) {
    _injector.unlink<T>(name: name);
  }
}
