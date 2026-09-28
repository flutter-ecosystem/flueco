---
name: flueco-core-custom-service-provider
description: Create an application-owned Flueco ServiceProvider for registering and initializing custom services. Use when an app needs a reusable provider beyond the adapters already available.
---

# Create a custom service provider

Put app-specific service implementations and their Flueco provider in a separate internal Dart package in the consuming project, for example `my_app_flueco_services`. Make that package depend on `flueco_core`, export the provider through its public library, and add the internal package as a dependency of the Flutter app. Do not add application-specific providers to the published `flueco_core` package.

## Workflow

1. Identify the services this integration owns and the prerequisites it needs. Reuse existing core contracts where possible; define a new contract only when the capability is genuinely app-specific.
2. Implement the service classes in the internal package and make them available from its public library.
3. Implement a `ServiceProvider` in that package. Define all four lifecycle methods:
   - `register(ServiceInjector injector)` registers the owned services.
   - `initialize(FluecoApp app)` performs async setup only after provider registration is complete.
   - `dependsOn()` returns the service types that must already be registered.
   - `registered()` returns the service types this provider supplies.
4. Resolve prerequisites through the `ServiceResolver` provided to injector factories rather than using a global service locator.
5. Add the provider to the consuming app's `FluecoKernel` provider set and await bootstrap before using its services.
6. Keep the provider reusable and free of app UI or environment-specific secrets; pass configuration through constructor dependencies or registered configuration services.

## Guardrails

- Keep service implementations and provider in the same internal integration package so consumers can add or replace that dependency without forking Flueco core.
- Declare dependencies and registrations accurately; bootstrap uses them to validate ordering and resolvability.
- Complete all registrations before relying on services during initialization.
- Do not put business workflows in a provider; providers compose service instances, while application behavior belongs in use cases/services.

## Validate

Test registration, dependency resolution, and initialization. Include a test for a missing prerequisite and confirm the app can select the internal package by adding its dependency and provider without modifying `flueco_core`.
