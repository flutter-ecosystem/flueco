---
name: flueco-create-application-service
description: Add an application-layer service to the Flueco example and wire it through Injectable. Use for cross-feature coordination, infrastructure orchestration, or reusable application capabilities.
---

# Create an application service

Choose between a focused service and a component manager from the responsibility the user describes. A simple service owns one cohesive capability, such as reading the current device location or retrieving a push-notification token. A manager owns a component-level workflow, shared state, or lifecycle that coordinates several related operations and collaborators, such as authentication state across login, logout, refresh, and user notifications.

## Workflow

1. Clarify the requested responsibility, its state, lifecycle, and related operations. Search both `lib/application/services/` and `lib/application/managers/` plus the Injectable modules for existing owners.
2. Create a **simple service** when there is one cohesive capability with a small API and no need to coordinate a component-wide state or lifecycle. Put it under `lib/application/services/` and use a capability-focused name, such as `LocationService` or `PushTokenProvider`.
3. Create a **manager** when one component needs a cohesive facade for multiple related operations, shared state, or event/subscription lifecycle. Put it under `lib/application/managers/<component>/`. For example, an `AuthManager` may coordinate login, logout, refresh, authentication events, current-user loading, and notifications by delegating to focused services/use cases.
4. Keep the chosen class focused on its stated boundary. A manager coordinates related collaborators; it should not absorb unrelated application capabilities. A simple service should not grow into a multi-operation component coordinator merely to avoid creating a manager.
5. Inject collaborators through the constructor. Keep external plugin/client access at the integration boundary and depend on narrow contracts when that allows domain or presentation code to avoid concrete infrastructure types.
6. If the object exposes observable state, follow the existing `AuthManager` pattern with the state-management APIs; otherwise use a regular class. Give subscriptions, streams, controllers, and other resources a clear owner and disposal lifecycle.
7. Choose the Injectable scope (`injectable`, `lazySingleton`, or `singleton`) based on state, sharing, and resource lifetime. Register the class in the module that owns its layer, normally `ApplicationModule` for application services and managers.
8. Regenerate Injectable output rather than modifying generated config manually. Add focused tests for the capability or coordinated workflows, state transitions, failures, and lifecycle cleanup.

## Examples in this app

- `AuthManager` under `lib/application/managers/auth/` is a manager: it observes authentication events, maintains authentication/user state, and coordinates user loading and logout behavior.
- `DeviceInfoProvider` under `lib/application/services/` is a focused service: it provides device and app-version information.
- `AppInstallationHandler` is a more involved application service because it owns the cohesive installation-ID lifecycle and request-interceptor integration. Use a manager when responsibilities span multiple related operations or shared component state, not just because a class has several dependencies.

## Guardrails

- Do not use a service locator inside a service or manager; inject required dependencies explicitly.
- Do not create a manager solely as a naming preference, or let a manager become a catch-all for unrelated features.
- Do not place widget construction or widget-owned lifecycle in an application service/manager. Observable application state is appropriate only when it represents the component's state, not transient widget state.
- Do not confuse an application service or manager with `ServiceProvider`, which registers services during Flueco kernel bootstrap.
- Keep simple capabilities independently testable so a manager can coordinate them without duplicating their implementation.

## Validate

Test simple services at their capability boundary. For managers, test the related operation flows, state/event updates, delegation, and disposal. Run focused tests and `flutter analyze` from `example/`; after registration changes, run the configured build_runner command and verify the generated dependency graph uses the intended scope.
