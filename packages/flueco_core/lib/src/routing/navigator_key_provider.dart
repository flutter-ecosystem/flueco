import 'package:flutter/widgets.dart';

import '../core/un_implemented_component.dart';

/// Provider of the navigatorKey
abstract class NavigatorKeyProvider {
  /// Key of the navigator
  GlobalKey<NavigatorState> get navigatorKey;
}

/// Provider of the navigatorKey
class UnImplementedNavigatorKeyProvider
    implements NavigatorKeyProvider, UnImplementedComponent {
  @override
  GlobalKey<NavigatorState> get navigatorKey => throw UnimplementedError();
}
