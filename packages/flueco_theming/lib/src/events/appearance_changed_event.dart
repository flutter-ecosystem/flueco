import 'package:flueco_core/flueco_core.dart';

import '../models/appearance.dart';

class AppearanceChangedEvent extends PriorityEvent {
  final Appearance oldAppearance;
  final Appearance newAppearance;

  const AppearanceChangedEvent({
    required this.oldAppearance,
    required this.newAppearance,
  });

  @override
  int get priority => 9999;
}
