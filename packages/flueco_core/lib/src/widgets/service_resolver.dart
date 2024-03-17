import 'package:flutter/widgets.dart';

import '../core/di/service_resolver.dart';

class FluecoSR extends InheritedWidget implements ServiceResolver {
  final ServiceResolver _resolver;

  const FluecoSR({
    super.key,
    required super.child,
    required ServiceResolver resolver,
  }) : _resolver = resolver;

  static FluecoSR of(BuildContext context) {
    final sr = context.dependOnInheritedWidgetOfExactType<FluecoSR>();
    if (sr == null) {
      throw StateError(
          'FluecoSR is not accessible through this context. Make sure you add it or Flueco widget on top of the tree');
    }
    return sr;
  }

  @override
  bool updateShouldNotify(FluecoSR oldWidget) {
    return false;
  }

  @override
  bool isResolvable(Type type) {
    return _resolver.isResolvable(type);
  }

  @override
  bool isResolvableByName<T extends Object>(String name) {
    return _resolver.isResolvableByName<T>(name);
  }

  @override
  T resolve<T extends Object>({String? name}) {
    return _resolver.resolve<T>(name: name);
  }
}
