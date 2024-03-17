import 'package:flueco_core/flueco_core.dart';

import '../authentication.dart';

class AuthenticateStartEvent extends Event {}

class AuthenticateEndEvent extends Event {
  final Authentication? authentication;
  final Object? error;

  AuthenticateEndEvent({this.authentication, this.error});

  bool get hasAuthentication => authentication != null;

  bool get hasError => error != null;
}
