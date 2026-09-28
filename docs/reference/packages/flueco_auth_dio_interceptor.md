# `flueco_auth_dio_interceptor`

Connects `flueco_auth` to Dio requests. The public library exports the authentication interceptor implementation.

`FluecoAuthDioInterceptor` is a queued Dio interceptor and an `AuthenticationInterceptor`. It caches authentication objects as authentication completes, removes them on invalidation or selected failures, asks a `FluecoAuthDioController` to create request headers, and delegates Dio errors to that controller.

The application must implement the controller and wire the same interceptor into both sides: the Dio client's interceptor chain and the `AuthenticationInterceptors` list used by `FluecoAuthProvider`. Use the same Dio instance that the Flueco HTTP adapter exposes. Controller header logic should restrict credentials to intended requests/hosts; error handling should avoid exposing tokens or sensitive response data.

See [HTTP](../../guides/http.md), [Authentication](../../guides/authentication.md), [`flueco_auth`](flueco_auth.md), and the package [README](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_auth_dio_interceptor/README.md).
