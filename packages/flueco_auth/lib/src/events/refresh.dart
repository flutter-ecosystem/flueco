import 'package:flueco_core/flueco_core.dart';

import '../authentication.dart';

class RefreshStartEvent extends Event {}

class RefreshEndEvent extends Event {
  final Authentication? authentication;
  final Object? error;

  RefreshEndEvent({this.authentication, this.error});

  bool get hasAuthentication => authentication != null;

  bool get hasError => error != null;
}
