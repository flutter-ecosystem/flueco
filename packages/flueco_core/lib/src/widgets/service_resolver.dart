import 'package:flutter/widgets.dart';

import '../foundation/di/service_resolver.dart';

class FluecoSR extends InheritedWidget implements ServiceResolver {
  final ServiceResolver _resolver;

  const FluecoSR({
    super.key,
    required super.child,
    required ServiceResolver resolver,
  }) : _resolver = resolver;

  static FluecoSR of(BuildContext context) {
    final sr = context.getInheritedWidgetOfExactType<FluecoSR>();
    if (sr == null) {
      throw StateError(
          'Flueco is not accessible through this context [$context].'
          'Make sure you add it on top of the tree '
          'or the context is still mounted.');
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
