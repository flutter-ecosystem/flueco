# `flueco_auth`

Authentication abstractions and orchestration. Public exports include authentication/provider/store and credential types, `Authenticator`, agents, authentication events, refresh APIs, exceptions, and `FluecoAuthProvider`.

## Orchestration model

`Authenticator` implements processing, state-query, and invalidation roles. It selects a provider using the credentials/authentication class identifier, runs the provider's agent, emits lifecycle events, invokes configured `AuthenticationInterceptor`s, and delegates persistence to the provider's store. `populate()` checks configured providers for saved state; `refresh()` only works when the selected provider supports it and supplies a refresh agent.

`FluecoAuthProvider` accepts a list of `AuthenticationProvider`s and a `populateOnInitialization` setting. It declares dependencies on an `EventHandler`, `AuthenticationInterceptors`, and `AuthenticationProvidersFactory`; register the supporting services before using it. Strategy providers and their storage/handler factories must also be constructed and supplied by the application.

Authentication is not a complete identity system by itself: the app supplies credential collection, server protocol, refresh policy, error presentation, and secure persistence choices. The supplied basic/token strategies currently do not implement refresh; see their package pages. Review event and interceptor handling before sending secrets to plugins or logs.

See the [Authentication guide](../../guides/authentication.md), the [basic strategy](flueco_auth_basic.md), [token strategy](flueco_auth_token.md), and [Dio integration](flueco_auth_dio_interceptor.md). See the package [README](../../../packages/flueco_auth/README.md).
