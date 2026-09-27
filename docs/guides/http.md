# HTTP

`flueco_core` defines the `HttpClient` contract and `IOHttpServiceProvider`. It exposes `get`, `post`, `put`, `patch`, and `delete` operations, returning an `HttpResponse<T>` with data, status, and header access. `flueco_dio` supplies the Dio-backed implementation through `DioServiceProvider`, `DioHttpClient`, and `DioInstanceProvider`.

## Configure the adapter

`DioServiceProvider` declares a dependency on `DioBaseOptionsProvider`. The built-in `DefaultDioBaseOptionsProvider` accepts a base URL and configures 5-second connection and 30-second send timeouts, up to four redirects, and a success status range from 200 up to (but not including) 303. Supply your own implementation when those defaults do not fit.

Register the options provider before bootstrap and include the adapter provider:

```dart
final container = GetItServiceContainer();
container.singleton<DioBaseOptionsProvider>(
 (_) => const DefaultDioBaseOptionsProvider('https://api.example.com'),
);

final providers = <ServiceProvider>{DioServiceProvider()};
```

This is a composition fragment; add it to the app's complete kernel setup. Consumers should resolve the core `HttpClient` contract. Resolve `DioInstanceProvider` only when a feature intentionally needs Dio-specific configuration or interceptors.

## Use the client

The common API keeps request code independent of Dio:

```dart
final response = await httpClient.get<Map<String, dynamic>>('/profile');
final profileJson = response.data;
```

The adapter maps request paths, query parameters, headers, and optional request bodies to Dio. Parsing and domain-level error translation remain application responsibilities; choose response types and error policies deliberately.

For authenticated requests, see [Authentication](authentication.md) and the [`flueco_auth_dio_interceptor` reference](../reference/packages/flueco_auth_dio_interceptor.md). For exact exports, see [`flueco_dio`](../reference/packages/flueco_dio.md).

For authenticated requests, see [Authentication](authentication.md) and the [`flueco_auth_dio_interceptor` reference](../reference/packages/flueco_auth_dio_interceptor.md). For exact exported types, see [`flueco_dio`](../reference/packages/flueco_dio.md).
