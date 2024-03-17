import 'package:flueco_core/flueco_core.dart';
import 'package:flutter/foundation.dart';

class PlatformBrightnessChangedEvent extends Event {
  final Brightness oldBrightness;
  final Brightness newBrightness;

  const PlatformBrightnessChangedEvent({
    required this.oldBrightness,
    required this.newBrightness,
  });
}
