import 'package:flueco_auth/src/exceptions/authentication_exception.dart';

/// Base credentials
abstract class Credentials {}

/// Credentials send to authenticate.
abstract class AuthenticationCredentials extends Credentials {}

/// Credentials used to refresh authentication
abstract class RefreshCredentials extends Credentials {}

/// Exception thrown when invalid credentials are provided.
class InvalidAuthenticationCredentialsException
    extends AuthenticationException {}

/// Exception thrown when invalid refresh credentials are provided.
class InvalidRefreshCredentialsException extends AuthenticationException {}
