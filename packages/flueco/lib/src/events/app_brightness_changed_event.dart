import 'package:flueco_core/flueco_core.dart';
import 'package:flueco_messaging/flueco_messaging.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Event emitted when the app brightness changes
@sealed
class AppBrightnessChangedEvent extends Message implements Event {
  /// New platform brightness
  final Brightness brightness;

  /// constructor
  const AppBrightnessChangedEvent(this.brightness)
      : super(
          priority: 9999,
        );
}
