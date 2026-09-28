---
name: flueco-create-feature
description: Implement a vertical feature slice in the Flueco example across data, domain, application, presentation, routing, and Injectable wiring. Use when adding a user-facing capability end to end.
---

# Create a feature

Build the smallest complete slice that serves the requested behavior. A feature may need a repository, use case, application service, view model, view, and route, but do not create every layer by default. The example currently has data sources and use cases but no repository layer.

## Workflow

1. Trace the nearest existing feature from its view through its view model, use case/service, data sources, and registration modules. Confirm current router and package versions before editing.
2. Define the behavior and data flow. Add a domain repository contract and data implementation only if the feature needs a stable data boundary, combines sources, or owns data mapping/policy.
3. Add a use case when the behavior is an action or business workflow that should be reusable/testable outside the view. Follow the `UseCase<R>` contract and keep concrete routing types out of domain code.
4. Add an application service only for cross-feature coordination or a reusable application capability that does not belong in a use case or repository.
5. Add immutable view state and a `ViewModel` for presentation behavior, then a view that renders it through the existing Provider pattern.
6. Add a route using the router already configured in the app. The current app uses AutoRoute, but inspect the active configuration rather than assuming it; regenerate route files if required.
7. Register dependencies in the owning Injectable modules: data bindings in `DataModule`, use cases in `DomainModule`, application services in `ApplicationModule`, and presentation bindings only when the existing pattern requires them.
8. Add focused tests at the behavior boundaries and regenerate generated files with the configured build_runner command. Never hand-edit generated `.g.dart`, `.gr.dart`, or Injectable config files.

## Guardrails

- Avoid layers that only forward calls without adding a useful boundary or behavior.
- Keep transport/plugin models and concrete router classes out of domain contracts.
- Keep UI concerns in presentation; keep platform setup and Flueco provider composition in bootstrap.
- Follow existing local naming and directory conventions. Do not refactor unrelated features as part of the slice.

## Validate

From `example/`, run the focused tests and `flutter analyze`. Regenerate code after annotations, routes, or module registrations change, then verify the generated output and exercise the feature through its real route and dependency graph.
