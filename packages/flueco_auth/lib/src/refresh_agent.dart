import 'package:flueco_auth/src/authentication.dart';
import 'package:flueco_auth/src/authentication_credentials.dart';

/// Agent used to refresh the authentication.
abstract class RefreshAgent {
  /// Process the refresh of the authentication.
  Future<Authentication> refresh(RefreshCredentials credentials);
}
