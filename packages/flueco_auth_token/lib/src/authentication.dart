import 'package:flueco_auth/flueco_auth.dart';

class TokenAuthentication extends Authentication {
  final String token;
  final DateTime? expiresAt;

  /// Creates an instance of [TokenAuthentication]
  TokenAuthentication({required this.token, this.expiresAt});

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
