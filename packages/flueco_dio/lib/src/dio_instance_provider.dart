import 'package:dio/dio.dart';

/// Abstract class that provides a Dio instance.
abstract class DioInstanceProvider {
  /// Returns the instance of Dio.
  Dio get dio;
}
