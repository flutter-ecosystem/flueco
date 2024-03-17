import 'authentication_credentials.dart';

/// Authentication.
abstract class Authentication {}

/// An authentication that can be refreshed
abstract class RefreshableAuthentication {
  /// Credentials used to refresh the authentication.
  RefreshCredentials get refreshCredentials;
}
