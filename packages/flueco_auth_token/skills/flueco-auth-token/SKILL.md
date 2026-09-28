---
name: flueco-auth-token
description: Configure Flueco's token authentication strategy, storage, token keys, and expiry behavior. Use when integrating an API that uses Bearer tokens.
---

# Use the token authentication strategy

`TokenAuthenticationProvider` is a strategy for `flueco_auth`. It creates Bearer authorization values and can represent an optional expiry time, but it does not implement a working refresh flow by itself.

## Workflow

1. Add both `flueco_auth` and `flueco_auth_token` to the app.
2. Provide `SecureStorage`, `LocalStorage`, a `TokenAuthenticationHandlerFactory`, and `TokenKeys`.
3. Construct `TokenAuthenticationProvider`, supply it to `FluecoAuthProvider`, and register the shared authentication dependencies.
4. Implement the app/server-specific login protocol and define how access-token expiry is detected and handled.
5. If refresh is required, provide and test a concrete refresh strategy rather than relying on the package's placeholder `TokenRefreshAgent`.
6. Persist and invalidate token material through the selected stores and auth lifecycle.

## Guardrails

- The current token provider reports `supportsRefresh == false` and has no refresh agent; the base `TokenRefreshAgent` throws until implemented.
- An optional expiry value does not schedule refresh or guarantee server-side validity.
- Never log tokens or attach them to unintended requests. Protect token storage and define logout/invalidation behavior.

## Validate

Test successful and failed authentication, expiry handling, persistence and invalidation, and any custom refresh flow independently. Verify Bearer headers are sent only to approved hosts over TLS.
