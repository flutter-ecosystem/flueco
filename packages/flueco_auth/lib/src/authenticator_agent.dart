
import 'authentication_credentials.dart';
import 'authentication.dart';

/// Used to authenticate using [AuthenticationCredentials]
abstract class AuthenticatorAgent {
  /// Authenticate and save
  Future<Authentication> authenticate(AuthenticationCredentials credentials);

  /// Verify if the authentication is still valid.
  Future<bool> verify(Authentication authentication);
}
