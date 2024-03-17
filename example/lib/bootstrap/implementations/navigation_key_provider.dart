import 'package:flueco/flueco.dart';
import 'package:flutter/widgets.dart';

/// Implementation of [NavigatorKeyProvider]
final class ExampleNavigationKeyProvider implements NavigatorKeyProvider {
  final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey(debugLabel: 'NavigationKey');
  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}
