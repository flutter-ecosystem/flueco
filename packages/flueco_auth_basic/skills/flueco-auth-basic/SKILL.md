---
name: flueco-auth-basic
description: Configure the flueco_auth HTTP Basic strategy with secure storage and an application handler factory. Use when an API explicitly requires Basic authentication.
---

# Use the Basic authentication strategy

`BasicAuthenticationProvider` is a strategy for `flueco_auth`; it is not a login screen or identity service.

## Workflow

1. Add both `flueco_auth` and `flueco_auth_basic` to the app.
2. Provide a core `SecureStorage` implementation and a `BasicAuthenticationHandlerFactory`.
3. Construct `BasicAuthenticationProvider` and supply it to `FluecoAuthProvider` with the required auth orchestration services.
4. Collect credentials through the app's own UI and invoke authentication through the auth processor.
5. Send Basic credentials only to the intended server over TLS, and define how saved credentials are invalidated.

## Guardrails

- Use this strategy only when the server protocol requires HTTP Basic authentication.
- Base64-encoding `username:password` is not encryption; TLS is required in transit.
- Protect credentials at rest and prevent them from appearing in logs, crash reports, or diagnostics.
- The supplied provider does not support refresh.

## Validate

Test successful and rejected credentials, persistence and invalidation, and confirm outgoing requests use TLS and target only the intended host.
