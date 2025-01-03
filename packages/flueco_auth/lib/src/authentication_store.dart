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

/// Actions that can be performed on the [AuthenticationStore]
enum AuthenticationStoreAction {
  /// Clear the store
  clear,

  /// Save the authentication
  save,

  /// Get the authentication
  get,
}

/// Exception thrown when an operation on the [AuthenticationStore] fails.
class AuthenticationStoreException extends AuthenticationException {
  /// Creates a new [AuthenticationStoreException].
  final AuthenticationStoreAction action;

  /// Creates a new [AuthenticationStoreException].
  const AuthenticationStoreException({
    required super.cause,
    required this.action,
  });
}
