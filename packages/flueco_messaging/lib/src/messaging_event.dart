// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flueco_core/flueco_core.dart';
import 'package:messaging/messaging.dart';

/// Base class for event.
class MessagingEvent extends Message {
  final Event event;

  /// Constructor
  MessagingEvent(this.event)
      : super(
          priority:
              event is PriorityEvent ? event.priority : Message.minPriority,
        );

  @override
  Type get runtimeType => event.runtimeType;

  @override
  String toString() => 'MessagingEvent(event: ${event.runtimeType})';
}
