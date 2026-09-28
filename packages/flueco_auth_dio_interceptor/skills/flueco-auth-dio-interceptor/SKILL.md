---
name: flueco-auth-dio-interceptor
description: Connect Flueco authentication lifecycle to Dio requests with FluecoAuthDioInterceptor and an application controller. Use when attaching auth headers or handling authenticated Dio errors.
---

# Wire authentication into Dio

`FluecoAuthDioInterceptor` connects `flueco_auth` to Dio. The application implements `FluecoAuthDioController` to decide which headers to attach and how Dio errors affect authentication.

## Workflow

1. Implement a controller that selects applicable authentications for a request, creates headers, and handles Dio errors.
2. Create one `FluecoAuthDioInterceptor` using that controller.
3. Add that exact interceptor instance to the Dio client used by `DioHttpClient`.
4. Register the same instance in the `AuthenticationInterceptors` list used by `FluecoAuthProvider` so auth lifecycle events update its cached state.
5. Restrict credentials by request, scheme, and host. Keep controller behavior explicit for unauthenticated endpoints and error responses.

## Guardrails

- Do not create separate interceptor instances for Dio and Flueco auth; their state and lifecycle notifications would diverge.
- Do not attach credentials to arbitrary URLs or forward them across redirects without policy review.
- Avoid logging authorization headers, tokens, or sensitive response data.
- Keep the interceptor on the same Dio instance exposed by the Flueco HTTP adapter.

## Validate

Test authenticated and unauthenticated endpoints, auth invalidation, rejected requests, and cross-host/redirect behavior. Assert that secrets never appear in logs or error messages.
