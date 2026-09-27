# Authentication

Authentication is an optional package family, separate from the `flueco` bundle. `flueco_auth` defines credentials, authentication providers/stores, an `Authenticator`, lifecycle events, refresh agents, and authentication interceptors. The authenticator exposes three useful roles: `AuthenticationProcessor` for authenticate/populate/refresh operations, `AuthenticationStateProvider` for current state, and `AuthenticationInvalidator` for clearing it.

## Compose a strategy

Choose an authentication strategy and construct its provider with the required storage and handler factory. For example, `BasicAuthenticationProvider` needs `SecureStorage` and a `BasicAuthenticationHandlerFactory`; `TokenAuthenticationProvider` needs both `SecureStorage` and `LocalStorage`, a `TokenAuthenticationHandlerFactory`, and `TokenKeys`. Pass the configured providers to `FluecoAuthProvider`.

`FluecoAuthProvider` itself depends on `EventHandler`, `AuthenticationInterceptors`, and `AuthenticationProvidersFactory`. Register those dependencies along with the selected strategy's prerequisites. Set `populateOnInitialization` according to whether the app should load saved authentication during bootstrap. The authenticator emits start/end events and persists successful authentication through its provider's store.

The supplied basic and token providers currently report `supportsRefresh == false` and return no refresh agent. `TokenRefreshAgent` is a base implementation that throws until a concrete refresh flow is supplied. Do not assume that choosing token auth automatically implements refresh-token exchange.

## Connect Dio

`flueco_auth_dio_interceptor` provides `FluecoAuthDioInterceptor` and an application-defined `FluecoAuthDioController`. The controller decides which headers to attach for the current authentications and how to react to Dio errors. Add the interceptor to the Dio instance used by the HTTP client, and register the same interceptor with `AuthenticationInterceptors` so authentication lifecycle events update its state. Keep this wiring in the composition root to avoid using different interceptor instances.

Treat credential persistence, token lifecycle, refresh, request scoping, and error handling as security-sensitive application decisions. Avoid logging credentials/tokens and ensure credentials are not attached to unintended hosts or requests. Review actual strategy behavior before shipping.

See the package references for [`flueco_auth`](../reference/packages/flueco_auth.md), [basic auth](../reference/packages/flueco_auth_basic.md), [token auth](../reference/packages/flueco_auth_token.md), and the [Dio interceptor](../reference/packages/flueco_auth_dio_interceptor.md).
