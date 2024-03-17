import 'package:flueco_auth/src/authentication.dart';
import 'package:flueco_auth/src/exceptions/authentication_exception.dart';

/// Storage class to save and retrieve [Authentication]
abstract class AuthenticationStore {
  /// Save authentication
  Future<void> save(Authentication authentication);

  /// Get saved authentication
  Future<Authentication?> get();

  /// Clear authentication
  Future<void> clear();
}

enum AuthenticationStoreAction {
  clear,
  save,
  get,
}

class AuthenticationStoreException extends AuthenticationException {
  final AuthenticationStoreAction action;

  const AuthenticationStoreException({
    required super.cause,
    required this.action,
  });
}
