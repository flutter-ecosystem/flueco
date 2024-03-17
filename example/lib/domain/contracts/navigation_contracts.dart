/// Strategy to replace
enum RouteReplacementStrategy {
  /// Replace all route
  /// It will push and pop until root
  all(replaces: true),

  /// Replace only the current route
  current(replaces: true),

  /// It will not replace and just navigate
  none(replaces: false);

  /// Wether we should replace the route
  final bool replaces;

  const RouteReplacementStrategy({required this.replaces});
}

/// Contract to navigate to Auth page
abstract interface class NavigateToAuthContract {
  /// Navigate to auth
  Future<void> navigateToAuth({
    RouteReplacementStrategy replacementStrategy =
        RouteReplacementStrategy.none,
  });
}

/// Contract to navigate to Home page
abstract interface class NavigateToHomeContract {
  /// Navigate to home
  Future<void> navigateToHome({
    RouteReplacementStrategy replacementStrategy =
        RouteReplacementStrategy.none,
  });
}

/// Contract to navigate to Complete Profile page
abstract interface class NavigateToCompleteProfileContract {
  /// Navigate to complete profile
  Future<void> navigateToCompleteProfile({
    RouteReplacementStrategy replacementStrategy =
        RouteReplacementStrategy.none,
  });
}
