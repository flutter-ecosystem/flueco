import 'package:flueco_core/src/core/un_implemented_component.dart';

/// HttpClient
abstract class HttpClient {
  /// Perform a DELETE request
  Future<HttpResponse<T>> delete<T>(String path,
      {Map<String, dynamic>? queryParameters});

  /// Perform a GET request
  Future<HttpResponse<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters});

  /// Perform a PATCH request
  Future<HttpResponse<T>> patch<T>(String path,
      {dynamic data, Map<String, dynamic>? queryParameters});

  /// Perform a POST request
  Future<HttpResponse<T>> post<T>(String path,
      {dynamic data, Map<String, dynamic>? queryParameters});

  /// Perform a PUT request
  Future<HttpResponse<T>> put<T>(String path,
      {dynamic data, Map<String, dynamic>? queryParameters});
}

/// HttpResponse
abstract class HttpResponse<T> {
  /// Response data
  T? get data;

  /// Response status code
  int? get statusCode;

  /// Response status message
  String? get statusMessage;

  /// Get response header by name
  String? getHeader(String headerName);
}

/// Implementation of [HttpClient]
class UnImplementedHttpClient implements HttpClient, UnImplementedComponent {
  @override
  Future<HttpResponse<T>> delete<T>(String path,
      {Map<String, dynamic>? queryParameters}) {
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters}) {
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<T>> patch<T>(String path,
      {data, Map<String, dynamic>? queryParameters}) {
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<T>> post<T>(String path,
      {data, Map<String, dynamic>? queryParameters}) {
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<T>> put<T>(String path,
      {data, Map<String, dynamic>? queryParameters}) {
    throw UnimplementedError();
  }
}
