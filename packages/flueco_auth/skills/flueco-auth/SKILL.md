---
name: flueco-auth
description: Compose Flueco authentication providers, stores, events, interceptors, and authentication lifecycle. Use when adding or debugging an authentication flow.
---

# Compose Flueco authentication

`flueco_auth` provides authentication contracts and orchestration; the app supplies a concrete strategy, credential collection, server protocol, storage decisions, and error presentation.

## Workflow

1. Choose a concrete `AuthenticationProvider` strategy and construct it with its handler factory and storage requirements.
2. Register the required `EventHandler`, `AuthenticationInterceptors`, and `AuthenticationProvidersFactory` services, plus strategy-specific prerequisites.
3. Pass the configured providers to `FluecoAuthProvider` and add it to the kernel.
4. Set `populateOnInitialization` based on whether saved authentication should be loaded during bootstrap.
5. Use `Authenticator` or its processor/state/invalidation interfaces for authenticate, populate, refresh, state queries, and logout. Handle lifecycle events and exceptions at the application boundary.
6. Implement refresh only for strategies that provide a refresh agent; otherwise keep the app's expiry behavior explicit.

## Guardrails

- Authentication orchestration is not a login UI or a complete identity system.
- Do not assume the supplied basic or token strategies support refresh; both currently report refresh as unsupported.
- Never log credentials, tokens, or sensitive authentication responses.
- Treat persistence, expiration, request scope, and invalidation as security-sensitive decisions.

## Validate

Test success, failure, saved-state population, invalidation, and interceptor notifications. Confirm persisted credentials are protected and unsupported refresh paths are not invoked.
