import 'authentication_credentials.dart';

/// Authentication.
abstract base class Authentication {
  /// Creates an instance of [Authentication]
  ///
  /// The [uniqueClassId] is used to identify the type of authentication.
  /// It should be unique for each implementation of [Authentication].
  const Authentication(this.uniqueClassId);

  final String uniqueClassId;
}

/// An authentication that can be refreshed
abstract base class RefreshableAuthentication extends Authentication {
  /// Creates an instance of [RefreshableAuthentication]
  const RefreshableAuthentication(super.uniqueClassId);

  /// Credentials used to refresh the authentication.
  RefreshCredentials get refreshCredentials;
}
