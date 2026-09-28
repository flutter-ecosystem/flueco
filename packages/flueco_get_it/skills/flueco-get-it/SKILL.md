---
name: flueco-get-it
description: Configure GetItServiceContainer as the service container for a Flueco kernel. Use when wiring provider registrations, existing GetIt instances, or dependency resolution.
---

# Use GetIt with Flueco

`flueco_get_it` implements Flueco's service-container contract with GetIt. It adapts provider factory, singleton, and lazy-singleton registrations and tracks registered service types for core resolvability checks.

## Workflow

1. Create a `GetItServiceContainer` and pass it as the kernel's container.
2. By default, the adapter creates a new GetIt instance. Supply an existing instance only when intentionally sharing its registrations and lifecycle.
3. Register adapter prerequisites/configuration before providers that depend on them.
4. Declare each provider's dependencies and registrations to match the types it actually consumes and installs.
5. Resolve Flueco services through the container/resolver contract where possible. Use GetIt-specific scopes or readiness APIs only when the app deliberately depends on those semantics.

## Guardrails

- Do not assume that using GetIt's process-wide singleton is automatic; the default container is isolated.
- Do not let GetIt-specific lookups leak through feature code without a clear reason.
- Keep manual registrations and Flueco provider registrations from conflicting or duplicating the same service.

## Validate

Test the kernel with the chosen container instance. Verify both that expected services resolve and that a fresh default container does not accidentally depend on unrelated global registrations.
