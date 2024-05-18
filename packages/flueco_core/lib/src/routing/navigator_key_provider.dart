import 'package:flutter/widgets.dart';

import '../core/unimplemented_component.dart';

/// Provider of the navigatorKey
abstract class NavigatorKeyProvider {
  /// Key of the navigator
  GlobalKey<NavigatorState> get navigatorKey;
}

/// Provider of the navigatorKey
class UnImplementedNavigatorKeyProvider
    implements NavigatorKeyProvider, UnimplementedFeature {
  @override
  GlobalKey<NavigatorState> get navigatorKey => throw UnimplementedError();
}
