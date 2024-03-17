import 'package:flueco_core/src/core/di/service_resolver.dart';
import 'package:flutter/widgets.dart';

import '../core/di/service_injector.dart';

class FluecoSI extends InheritedWidget implements ServiceInjector {
  final ServiceInjector _injector;

  const FluecoSI({
    super.key,
    required super.child,
    required ServiceInjector injector,
  }) : _injector = injector;

  static FluecoSI? of(BuildContext context) {
    final si = context.dependOnInheritedWidgetOfExactType<FluecoSI>();
    if (si == null) {
      throw StateError(
          'FluecoSI is not accessible through this context. Make sure you add it or Flueco widget on top of the tree');
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
}
