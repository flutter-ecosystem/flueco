---
name: flueco-messaging
description: Adapt a messaging instance to Flueco's core EventHandler API. Use when wiring events, the MessagingServiceProvider, or Flueco root-widget lifecycle.
---

# Connect messaging to Flueco events

`MessagingServiceProvider` adapts an existing `Messaging` instance to the core `EventHandler` contract.

## Workflow

1. Construct and configure the underlying `Messaging` bus in the application composition root.
2. Register that instance in the service container before registering `MessagingServiceProvider`.
3. Add the provider to the kernel and use the core event API in code that should remain independent of the messaging implementation.
4. If the app uses the `Flueco` root widget, ensure the same messaging service can be resolved; the widget uses a messaging scope for lifecycle handling.
5. Define event ownership, subscription lifetime, and cleanup according to the underlying messaging package's behavior.

## Guardrails

- The Flueco adapter does not construct or configure the message bus.
- Avoid creating multiple bus instances that split events between the root widget and providers.
- Do not leave subscriptions alive beyond their owning feature or app lifecycle.

## Validate

Test publishing and receiving a representative event through the core API. Verify subscriptions are removed or otherwise safely scoped when their owner is disposed.
