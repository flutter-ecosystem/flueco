# Events and Registries

This page covers two related but different tools: application events and channel registries. Events notify subscribers that something happened. Registries route a known action to one or more handlers selected by channel. Flueco core provides both patterns for different jobs.

## Events: announce a fact

The core API defines `Event`, `EventHandler`, and `EventSubscriber`. An event carries a fact; the publisher does not need to know which subscribers respond. This is useful when several independent features react to the same occurrence, such as a profile being saved and audit/history or UI refresh behavior needing notification.

```dart
class ProfileSaved extends Event {
 final String profileId;

 const ProfileSaved(this.profileId);
}

class ProfileAuditSubscriber extends EventSubscriber {
 final EventHandler _events;

 ProfileAuditSubscriber(this._events);

 void start() {
  _events.subscribe(ProfileSaved, this);
 }

 @override
 Future<void> onEvent(Event event) async {
  if (event case ProfileSaved(:final profileId)) {
   await recordProfileChange(profileId);
  }
 }

 void dispose() {
  _events.unsubscribe(ProfileSaved, this);
 }
}

// The publisher only needs the EventHandler contract.
await events.emitNow(const ProfileSaved('profile-42'));
```

`recordProfileChange` represents application-owned work. Subscribe when the subscriber's lifecycle begins and unsubscribe when it ends; otherwise stale listeners can continue reacting. `subscribeAll` and `unsubscribeAll` are available when one subscriber handles multiple event types.

### Use events from a widget

With `flueco_messaging` registered, a widget can resolve the core `EventHandler` from the Flueco widget tree. The event type is the same `ProfileSaved` defined above:

```dart
import 'package:flueco/flueco.dart';
import 'package:flutter/material.dart';

class ProfileActivity extends StatefulWidget {
    const ProfileActivity({super.key});

    @override
    State<ProfileActivity> createState() => _ProfileActivityState();
}

class _ProfileActivityState extends State<ProfileActivity>
        implements EventSubscriber {
    EventHandler? _events;
    String? _savedProfileId;

    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        if (_events != null) return;

        _events = FluecoSR.of(context).resolve<EventHandler>();
        _events!.subscribe(ProfileSaved, this);
    }

    @override
    Future<void> onEvent(Event event) async {
        if (event is! ProfileSaved || !mounted) return;
        setState(() => _savedProfileId = event.profileId);
    }

    void _publishSampleEvent() {
        FluecoSR.of(context)
                .resolve<EventHandler>()
                .emit(const ProfileSaved('profile-42'));
    }

    @override
    void dispose() {
        _events?.unsubscribe(ProfileSaved, this);
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Column(
            children: <Widget>[
                Text(_savedProfileId ?? 'No profile saved yet'),
                TextButton(
                    onPressed: _publishSampleEvent,
                    child: const Text('Simulate profile save'),
                ),
            ],
        );
    }
}
```

**Note:** You can also use the `MessagingSubscriberBuilder` of `messaging_flutter` package like [here](https://github.com/mcssym/messaging_flutter/blob/main/example/lib/main.dart).

The button publishes a sample event through the same messaging-backed handler the widget subscribed to. In a real application, publish `ProfileSaved` from the feature that completes the save, and only after persistence succeeds; the widget should usually react rather than own the business operation. `didChangeDependencies()` obtains the resolver below the Flueco root, and `dispose()` removes the subscription to prevent this state object receiving later events.

To wire the adapter, register a `Messaging` instance in the container and include `MessagingServiceProvider()` in the kernel's provider set. The bundle's `Flueco` root also expects that `Messaging` instance for lifecycle handling. The repository example performs this registration in [`DependenciesServiceProvider`](https://github.com/flutter-ecosystem/flueco/blob/main/example/lib/bootstrap/providers/dependencies_service_provider.dart) and adds the provider in its [custom kernel](https://github.com/flutter-ecosystem/flueco/blob/main/example/lib/bootstrap/kernel.dart). See [Manual installation](../getting-started/installation.md) for that composition.

### Choose an emit method

- `emit(event)` publishes through the event implementation's normal queue/dispatch path and returns immediately.
- `emitNow(event)` returns a `Future` that completes after direct dispatch. Set `throwInternalError: true` when subscriber errors should be rethrown; by default the messaging adapter continues dispatch when a subscriber fails.

Use `emitNow` when the caller must await subscriber work or observe its failure. Use `emit` for notifications where the publisher should not wait. Do not use an event if the caller needs a result to continue; use a direct method call/return value instead. Events are not automatically durable across app restarts, and sensitive credentials should not be broadcast casually.

`flueco_messaging` adapts the external `messaging` package to `EventHandler`. Its provider requires a `Messaging` instance; the application creates/configures that bus and registers it before the provider. The `flueco` root widget also expects a resolvable `Messaging` instance for lifecycle handling.

## Registries: route an action

Core's `ChannelRegistry` stores handlers under string channel keys. A `DefaultChannelProvider` maps an action to the channel keys that should handle it. `LogRegistry` and `NotificationRegistry` specialize this pattern for logging and user notifications.

Use a registry when the producer knows the kind of action but should not know the destinations: route errors to console and telemetry handlers, or route notification actions to a dialog implementation. The producer invokes the registry; the default-channel provider chooses the registered handlers. A handler can also be selected directly by channel when a particular destination is required:

```dart
logRegistry.register('audit', auditLogHandler);
final LogHandler audit = logRegistry.get<LogHandler>('audit');
audit.info(const LogMessage(content: 'Profile settings changed'));
```

For default routing, implement a `LogDefaultChannelProvider` that returns registered channel keys for each `LogHandlerAction`, then register matching handlers in your `LogRegistry.registerHandlers()` implementation. A key returned by the default provider must have a registered handler; otherwise `getDefaults()` throws `StateError`. Default routing can return more than one handler key to fan an action out to multiple channels.

The `flueco` bundle installs default log handlers backed by `LoggerService`, `ToastService`, and `DialogService`, plus a notification handler backed by dialogs. With `flueco_core` alone, supply registries and handlers yourself. Prefer the higher-level app services for routine user-facing logs/dialogs; customize registries when you need alternate channels or integration-specific routing.

## Keep the boundary clear

Use constructor injection for a required collaborator or a call that needs a return value. Use an event for an app fact with optional independent subscribers. Use a registry when a typed action should route to named handler channels. These mechanisms can coexist, but should not be layered without a clear ownership reason.

Read [Dependency injection](dependency-injection.md), [Logging and notifications](../guides/logging-and-notifications.md), [Theming](../guides/theming.md), and [Authentication](../guides/authentication.md) for related patterns. The [architecture guide](../overview/architecture.md) locates them in the package dependency graph.
