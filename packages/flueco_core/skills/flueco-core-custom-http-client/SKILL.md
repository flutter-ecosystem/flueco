---
name: flueco-core-custom-http-client
description: Implement Flueco's HttpClient contract and register it through a custom IOHttpServiceProvider. Use when adapting an HTTP library or app-specific transport.
---

# Create a custom HTTP client service

Create a separate internal Dart package in the consuming project, such as `my_app_flueco_http`, containing the concrete client and its provider. The package should depend on `flueco_core`, export the provider publicly, and be added as a dependency of the Flutter app. Keep the adapter out of the published `flueco_core` package.

## Workflow

1. Review `HttpClient` and `HttpResponse<T>` from `flueco_core`. Implement all five request methods and map transport responses to the core response contract.
2. Keep the chosen HTTP library's types behind the adapter. Define how generic response data is decoded and how status, headers, and transport errors are represented.
3. Extend `IOHttpServiceProvider` in the internal package and implement `httpClientFactory(ServiceResolver resolver)`.
4. Implement `dependsOn()` for any registered transport client, base options, or configuration the factory resolves. Implement `initialize(FluecoApp app)` only when the integration needs post-registration setup.
5. If overriding `register` or `registered`, call the base implementation so the core `HttpClient` registration is preserved. Otherwise use the base lazy-singleton registration.
6. Add the provider to the consuming kernel and configure environment-specific base URLs, timeouts, interceptors, and credentials outside `flueco_core`.

## Guardrails

- Preserve the core method signatures and avoid exposing library-specific response/request types to core consumers.
- Define consistent timeout, cancellation, status/error, serialization, and header behavior; do not silently swallow transport failures.
- Never log credentials or sensitive request/response payloads. Scope authorization to intended hosts.

## Validate

Test each HTTP verb, query/header/body forwarding, response mapping, error mapping, and configured timeouts using a fake transport where possible. Verify that the consuming kernel resolves the core `HttpClient` from the internal package provider.
