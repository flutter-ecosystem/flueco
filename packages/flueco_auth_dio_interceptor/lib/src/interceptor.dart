import 'package:flueco_auth/flueco_auth.dart';
import 'package:flueco_dio/flueco_dio.dart';

class FluecoAuthDioInterceptor extends QueuedInterceptor
    implements AuthenticationInterceptor {
  final FluecoAuthDioController controller;
  final Map<AuthenticationProvider, Authentication> _authentications =
      <AuthenticationProvider, Authentication>{};

  FluecoAuthDioInterceptor({required this.controller});

  @override
  void onDone(
      {required DoneAuthenticationContext context,
      required NextHandler handler}) {
    final provider = context.provider;
    if (provider != null) {
      final authentication = context.authentication;
      if (authentication == null) {
        _authentications.removeWhere((key, value) => key == provider);
      } else {
        _authentications[provider] = authentication;
      }
    }
    handler.next();
  }

  @override
  void onFailed(
      {required FailedAuthenticationContext context,
      required NextHandler handler}) {
    if ([AuthenticationContextType.refresh, AuthenticationContextType.populate]
        .contains(context.type)) {
      final provider = context.provider;
      if (provider != null) {
        _authentications.removeWhere((key, value) => key == provider);
      }
    }
    handler.next();
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    controller.onDioException(_authentications.values, err);
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final authentications = _authentications.values;
    if (authentications.isNotEmpty) {
      final headers = controller.headers(authentications, options);
      options.headers.addAll(headers);
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onStart({
    required StartAuthenticationContext context,
    required NextHandler handler,
  }) {
    handler.next();
  }
}

abstract class FluecoAuthDioController {
  Map<String, dynamic> headers(
      Iterable<Authentication> authentications, RequestOptions options);

  void onDioException(
      Iterable<Authentication> authentications, DioException exception);
}
