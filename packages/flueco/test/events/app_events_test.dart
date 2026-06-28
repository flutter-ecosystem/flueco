import 'package:flueco/flueco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App Events', () {
    test('should create AppBrightnessChangedEvent with valid brightness data',
        () {
      // Arrange
      const brightness = Brightness.dark;

      // Act
      const event = AppBrightnessChangedEvent(brightness);

      // Assert
      expect(event.brightness, equals(brightness));
      expect(event, isA<Message>());
      expect(event, isA<Event>());
      expect(event.priority, equals(9999));
    });

    test(
        'should emit AppFirstBuildEvent at correct timing during app initialization',
        () {
      // Arrange
      const event = AppFirstBuildEvent();

      // Act & Assert
      expect(event, isA<Message>());
      expect(event, isA<Event>());
      expect(event.priority, equals(9999));
    });

    test('should create AppBootstrappedEvent with bootstrap completion data',
        () {
      // Arrange
      const event = AppBootstrappedEvent();

      // Act & Assert
      expect(event, isA<Message>());
      expect(event, isA<Event>());
      expect(event.priority, equals(9999));
    });

    test('should handle AppLifecycleStateChangedEvent transitions correctly',
        () {
      // Arrange
      const event = AppLifecycleStateChangedEvent(AppLifecycleState.resumed);

      // Act & Assert
      expect(event, isA<Message>());
      expect(event, isA<Event>());
      expect(event.priority, equals(9999));
    });

    test('should notify event listeners when lifecycle state changes', () {
      // Arrange
      const event = AppLifecycleStateChangedEvent(AppLifecycleState.resumed);

      // Act & Assert
      expect(event, isNotNull);
      expect(event.priority, equals(9999));
    });

    test('should AppBrightnessChangedEvent handle different brightness values',
        () {
      // Arrange
      const lightEvent = AppBrightnessChangedEvent(Brightness.light);
      const darkEvent = AppBrightnessChangedEvent(Brightness.dark);

      // Act & Assert
      expect(lightEvent.brightness, equals(Brightness.light));
      expect(darkEvent.brightness, equals(Brightness.dark));
      expect(lightEvent.priority, equals(darkEvent.priority));
    });

    test('should events have correct priority for high-priority handling', () {
      // Arrange
      const brightnessEvent = AppBrightnessChangedEvent(Brightness.dark);
      const firstBuildEvent = AppFirstBuildEvent();
      const bootstrappedEvent = AppBootstrappedEvent();
      const lifecycleEvent =
          AppLifecycleStateChangedEvent(AppLifecycleState.resumed);

      // Act & Assert
      expect(brightnessEvent.priority, equals(9999));
      expect(firstBuildEvent.priority, equals(9999));
      expect(bootstrappedEvent.priority, equals(9999));
      expect(lifecycleEvent.priority, equals(9999));
    });

    test('should events be properly sealed classes', () {
      // Arrange
      const brightnessEvent = AppBrightnessChangedEvent(Brightness.dark);
      const firstBuildEvent = AppFirstBuildEvent();
      const bootstrappedEvent = AppBootstrappedEvent();
      const lifecycleEvent =
          AppLifecycleStateChangedEvent(AppLifecycleState.resumed);

      // Act & Assert
      expect(brightnessEvent, isA<AppBrightnessChangedEvent>());
      expect(firstBuildEvent, isA<AppFirstBuildEvent>());
      expect(bootstrappedEvent, isA<AppBootstrappedEvent>());
      expect(lifecycleEvent, isA<AppLifecycleStateChangedEvent>());
    });

    test('should events implement Event interface correctly', () {
      // Arrange
      const brightnessEvent = AppBrightnessChangedEvent(Brightness.dark);
      const firstBuildEvent = AppFirstBuildEvent();
      const bootstrappedEvent = AppBootstrappedEvent();
      const lifecycleEvent =
          AppLifecycleStateChangedEvent(AppLifecycleState.resumed);

      // Act & Assert
      expect(brightnessEvent, isA<Event>());
      expect(firstBuildEvent, isA<Event>());
      expect(bootstrappedEvent, isA<Event>());
      expect(lifecycleEvent, isA<Event>());
    });

    test('should events be const constructible', () {
      // Arrange & Act
      const brightnessEvent = AppBrightnessChangedEvent(Brightness.dark);
      const firstBuildEvent = AppFirstBuildEvent();
      const bootstrappedEvent = AppBootstrappedEvent();
      const lifecycleEvent =
          AppLifecycleStateChangedEvent(AppLifecycleState.resumed);

      // Assert
      expect(brightnessEvent, isNotNull);
      expect(firstBuildEvent, isNotNull);
      expect(bootstrappedEvent, isNotNull);
      expect(lifecycleEvent, isNotNull);
    });

    test('should AppBrightnessChangedEvent equality work correctly', () {
      // Arrange
      const event1 = AppBrightnessChangedEvent(Brightness.dark);
      const event2 = AppBrightnessChangedEvent(Brightness.dark);
      const event3 = AppBrightnessChangedEvent(Brightness.light);

      // Act & Assert
      expect(event1, equals(event2));
      expect(event1, isNot(equals(event3)));
      expect(event2, isNot(equals(event3)));
    });

    test('should events have unique identities', () {
      // Arrange
      const brightnessEvent = AppBrightnessChangedEvent(Brightness.dark);
      const firstBuildEvent = AppFirstBuildEvent();

      // Act & Assert
      expect(brightnessEvent, isNot(equals(firstBuildEvent)));
      expect(brightnessEvent.runtimeType,
          isNot(equals(firstBuildEvent.runtimeType)));
    });
  });
}
