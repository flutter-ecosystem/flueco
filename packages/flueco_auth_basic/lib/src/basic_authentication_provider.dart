import 'package:flueco_auth/flueco_auth.dart';

/// Implementation of [AuthenticationProvider] for basic authentication
/// through header.
final class BasicAuthenticationProvider extends AuthenticationProvider {
  @override
  // TODO: implement authenticationSupported
  Set<Type> get authenticationSupported => throw UnimplementedError();

  @override
  // TODO: implement authenticatorAgent
  AuthenticatorAgent get authenticatorAgent => throw UnimplementedError();

  @override
  // TODO: implement credentialsSupported
  Set<Type> get credentialsSupported => throw UnimplementedError();

  @override
  // TODO: implement refreshAgent
  RefreshAgent? get refreshAgent => throw UnimplementedError();

  @override
  // TODO: implement store
  AuthenticationStore get store => throw UnimplementedError();

  @override
  // TODO: implement supportsRefresh
  bool get supportsRefresh => throw UnimplementedError();
}
