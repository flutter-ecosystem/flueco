import 'package:dio/dio.dart';
import 'package:flueco_core/flueco_core.dart';

import 'dio_base_options_provider.dart';
import 'dio_instance_provider.dart';

/// HttpClient
class DioHttpClient implements DioInstanceProvider, HttpClient {
  /// Instance of Dio
  @override
  late final Dio dio;

  /// Constructor
  DioHttpClient(DioBaseOptionsProvider dioBaseOptionsProvider) {
    dio = Dio(dioBaseOptionsProvider.getBaseOptions());
  }

  /// Perform a DELETE request
  @override
  Future<HttpResponse<T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return dio
        .delete<T>(
          path,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        )
        .then((Response<T> value) => DioHttpResponse<T>.fromDioResponse(value));
  }

  /// Perform a GET request
  @override
  Future<HttpResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return dio
        .get<T>(
          path,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        )
        .then((Response<T> value) => DioHttpResponse<T>.fromDioResponse(value));
  }

  /// Perform a PATCH request
  @override
  Future<HttpResponse<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return dio
        .patch<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        )
        .then((Response<T> value) => DioHttpResponse<T>.fromDioResponse(value));
  }

  /// Perform a POST request
  @override
  Future<HttpResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return dio
        .post<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        )
        .then((Response<T> value) => DioHttpResponse<T>.fromDioResponse(value));
  }

  /// Perform a PUT request
  @override
  Future<HttpResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return dio
        .put<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        )
        .then((Response<T> value) => DioHttpResponse<T>.fromDioResponse(value));
  }
}

/// Constructor to create HttpResponse from Dio Response
class DioHttpResponse<T> extends Response<T> implements HttpResponse<T> {
  /// Constructor to create HttpResponse from Dio Response
  DioHttpResponse.fromDioResponse(Response<T> response)
      : super(
          data: response.data,
          headers: response.headers,
          requestOptions: response.requestOptions,
          isRedirect: response.isRedirect,
          redirects: response.redirects,
          statusCode: response.statusCode,
          statusMessage: response.statusMessage,
          extra: response.extra,
        );

  @override
  String? getHeader(String headerName) {
    return headers.value(headerName);
  }
}
