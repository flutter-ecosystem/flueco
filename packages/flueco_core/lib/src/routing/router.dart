import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../core/un_implemented_component.dart';

/// Router
abstract class Router {
  /// Push a widget onto the navigation stack
  Future<T?> pushWidget<T>(Widget page);

  /// Push a named route onto the navigation stack
  Future<T?> pushPage<T>(PageRoute<T> page);

  /// Pop the top-most widget off the navigation stack
  void pop<T>([T? result]);
}

/// Implementation for [Router]
class UnImplementedRouter implements Router, UnImplementedComponent {
  @override
  void pop<T>([T? result]) {
    throw UnimplementedError();
  }

  @override
  Future<T?> pushWidget<T>(Widget page) {
    throw UnimplementedError();
  }

  @override
  Future<T?> pushPage<T>(PageRoute<T> page) {
    throw UnimplementedError();
  }
}
