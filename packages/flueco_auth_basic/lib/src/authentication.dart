import 'dart:convert';

import 'package:flueco_auth/flueco_auth.dart';

/// Basic authentication.
base class BasicAuthentication extends Authentication {
  static const String classId = 'auth_basic:authentication';

  /// Username used for authentication.
  final String username;

  /// Password used for authentication.
  final String password;

  /// Creates an instance of [BasicAuthentication]
  const BasicAuthentication({required this.password, required this.username})
      : super(classId);

  /// Check if the authentication is valid.
  bool get isValid {
    return true;
  }

  /// Get request header.
  Map<String, dynamic> toHeader({String headerName = 'Authorization'}) {
    final token = base64Encode(utf8.encode('$username:$password'));

    return <String, dynamic>{headerName: 'Basic $token'};
  }
}
