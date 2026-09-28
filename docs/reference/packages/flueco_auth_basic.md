# `flueco_auth_basic`

Basic-authentication strategy for `flueco_auth`. The public library exports its authentication and credential types plus `BasicAuthenticationProvider`.

`BasicAuthenticationProvider` requires a `SecureStorage` implementation and a `BasicAuthenticationHandlerFactory`. It provides a store and authenticator agent for the basic strategy. The authentication object creates an HTTP Basic `Authorization` value by Base64-encoding `username:password`; Base64 is encoding, not encryption. Use TLS for transport and protect credentials at rest and in diagnostics.

The supplied provider currently does not support refresh. Add this package alongside `flueco_auth` only if HTTP Basic matches the server protocol; it does not provide a login UI or server-side identity management.

See the [Authentication guide](../../guides/authentication.md), [`flueco_auth`](flueco_auth.md), and the package [README](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_auth_basic/README.md).
