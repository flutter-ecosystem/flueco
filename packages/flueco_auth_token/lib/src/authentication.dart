import 'package:flueco_auth/flueco_auth.dart';

/// Authentication using a token.
class TokenAuthentication extends Authentication {
  /// Token used for authentication.
  final String token;

  /// Expiration date of the token.
  final DateTime? expiresAt;

  /// Creates an instance of [TokenAuthentication]
  TokenAuthentication({required this.token, this.expiresAt});

  /// Check if the token is valid.
  bool get isValid {
    if (expiresAt != null && DateTime.now().isAfter(expiresAt!)) {
      return false;
    }

    return true;
  }

  /// Get request header.
  Map<String, dynamic> toHeader({String headerName = 'Authorization'}) {
    return <String, dynamic>{headerName: 'Bearer $token'};
  }
}
