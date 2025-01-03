import 'package:flueco_auth/flueco_auth.dart';

/// Base class for refreshing authentication.
class TokenRefreshAgent extends RefreshAgent {
  @override
  Future<Authentication> refresh(RefreshCredentials credentials) {
    throw RefreshOperationException();
  }
}
