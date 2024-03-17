import 'package:flueco_core/flueco_core.dart';

class InvalidateStartEvent extends Event {}

class InvalidateEndEvent extends Event {
  final Object? error;

  InvalidateEndEvent({this.error});

  bool get hasError => error != null;
}
