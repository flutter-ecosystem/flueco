import 'package:flueco_auth/flueco_auth.dart';

class TokenRefreshAgent extends RefreshAgent {
  @override
  Future<Authentication> refresh(RefreshCredentials credentials) {
    throw RefreshOperationException();
  }
}
