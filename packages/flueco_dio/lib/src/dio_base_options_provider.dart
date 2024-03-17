import 'package:dio/dio.dart';

/// Abstract class that provides a Dio [BaseOptions].
abstract class DioBaseOptionsProvider {
  /// Returns the instance of Dio.
  BaseOptions getBaseOptions();
}

/// Implementation of [DefaultDioBaseOptionsProvider] of basic usage
class DefaultDioBaseOptionsProvider implements DioBaseOptionsProvider {
  /// Base Url
  final String baseUrl;

  /// Constructor
  const DefaultDioBaseOptionsProvider(this.baseUrl);

  @override
  BaseOptions getBaseOptions() {
    return BaseOptions(
      baseUrl: baseUrl,
      sendTimeout: const Duration(seconds: 30),
      connectTimeout: const Duration(seconds: 5),
      maxRedirects: 4,
      validateStatus: (int? status) =>
          status != null && status >= 200 && status < 303,
    );
  }
}
