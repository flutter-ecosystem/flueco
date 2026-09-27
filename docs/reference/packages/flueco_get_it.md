# `flueco_get_it`

Implements the core service-container contract with GetIt. The public library exports GetIt plus `GetItServiceContainer` and its instance-provider API.

Use `GetItServiceContainer` as the `container` passed to the kernel. By default, each container creates a new GetIt instance, avoiding implicit use of GetIt's process-wide singleton; an existing GetIt instance can be supplied when needed.

The adapter maps Flueco factory, singleton, and lazy-singleton registrations into GetIt and tracks registered service types for the core resolvability checks. The package also exposes GetIt's own scope/readiness APIs. Use those only when the app intentionally relies on GetIt-specific behavior, and keep Flueco provider `dependsOn()`/`registered()` declarations consistent with the actual registrations.

This package implements the container boundary only; it does not choose or install feature providers. See [Dependency injection](../../concepts/dependency-injection.md) and [Kernel and bootstrap](../../concepts/kernel-and-bootstrap.md).

See [Dependency injection](../../concepts/dependency-injection.md), [Bootstrap](../../concepts/kernel-and-bootstrap.md), and the package [README](../../../packages/flueco_get_it/README.md).
