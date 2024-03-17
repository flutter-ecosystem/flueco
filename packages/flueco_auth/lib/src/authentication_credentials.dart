import 'package:flueco_auth/src/exceptions/authentication_exception.dart';

/// Base credentials
abstract class Credentials {}

/// Credentials send to authenticate.
abstract class AuthenticationCredentials extends Credentials {}

/// Credentials used to refresh authentication
abstract class RefreshCredentials extends Credentials {}

class InvalidAuthenticationCredentialsException
    extends AuthenticationException {}

class InvalidRefreshCredentialsException extends AuthenticationException {}
