import 'package:flueco_core/flueco_core.dart';

class PopulateStartEvent extends Event {}

class PopulateEndEvent extends Event {
  final Object? error;

  PopulateEndEvent({this.error});

  bool get hasError => error != null;
}
