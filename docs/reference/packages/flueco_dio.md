# `flueco_dio`

Dio-backed implementation of the core `HttpClient` contract. Public exports include Dio APIs, `DioHttpClient`, `DioServiceProvider`, and the base-options and Dio-instance provider interfaces.

`DioServiceProvider` requires a `DioBaseOptionsProvider`. Register the configured options provider and include the service provider in the kernel's provider set. The built-in `DefaultDioBaseOptionsProvider` accepts a base URL, sets 5-second connect and 30-second send timeouts, caps redirects at four, and accepts status codes in the range 200-302.

`DioHttpClient` implements the core verbs and maps Dio responses to `HttpResponse`. `DioInstanceProvider` exposes the underlying `Dio` for adapter-specific interceptors and options; direct use of that instance couples the consuming code to Dio. `DioHttpClient.fromDio` can wrap an existing Dio instance when composition requires it.

Review timeout, status-validation, serialization, logging, and interceptor policies for the backend. The defaults are package defaults, not universal API recommendations.

See the [HTTP guide](../../guides/http.md), [core reference](flueco_core.md), and package [README](https://github.com/flutter-ecosystem/flueco/blob/main/packages/flueco_dio/README.md).
