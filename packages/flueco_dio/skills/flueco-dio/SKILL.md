---
name: flueco-dio
description: Configure Dio as the implementation of Flueco's HttpClient contract. Use when registering the Dio provider, customizing request policy, or sharing the Dio instance with interceptors.
---

# Configure Flueco HTTP with Dio

Use `DioServiceProvider` to expose a Dio-backed implementation of core `HttpClient`.

## Workflow

1. Provide a `DioBaseOptionsProvider` and register it before adding `DioServiceProvider` to the kernel.
2. Configure the base URL, timeouts, redirects, and status validation for the target API. The built-in defaults are 5-second connect and 30-second send timeouts, a redirect limit of four, and accepted status codes from 200 through 302; review these for the app rather than treating them as universal policy.
3. Resolve and use the core `HttpClient` contract in app services when vendor-specific Dio features are unnecessary.
4. For Dio-specific features, resolve the provided Dio instance or wrap an existing one with `DioHttpClient.fromDio` where composition requires it.
5. Attach interceptors to the same Dio instance used by `DioHttpClient`.

## Guardrails

- Register the base-options prerequisite; importing the package does not configure the provider.
- Review serialization, status validation, timeout, redirect, and logging policies for the backend.
- Avoid logging authorization headers, tokens, or sensitive request/response bodies.
- Direct access to Dio couples that code to the adapter; keep it at integration boundaries.

## Validate

Test provider registration and a representative request, including non-success status behavior and timeout configuration. Confirm required interceptors are attached to the instance exposed by the provider.
