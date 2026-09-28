# `flueco_auth_token`

Token-authentication strategy for `flueco_auth`. Its public library exports token authentication and credential types, `TokenAuthenticationProvider`, and token-related store and authenticator APIs.

`TokenAuthenticationProvider` requires both `SecureStorage` and `LocalStorage`, a `TokenAuthenticationHandlerFactory`, and `TokenKeys`. The token authentication can carry an optional expiry time and creates a Bearer `Authorization` header. Its current `supportsRefresh` value is false and its `refreshAgent` is null; `TokenRefreshAgent` itself throws until a concrete implementation is supplied.

Add this package alongside `flueco_auth` when using the package's token strategy. The application remains responsible for the server protocol, expiration policy, secure token lifecycle, and refresh design. Never assume that an optional expiration field or a Bearer header automatically refreshes credentials.

See the [Authentication guide](../../guides/authentication.md), [`flueco_auth`](flueco_auth.md), and the package [README](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_auth_token/README.md).
