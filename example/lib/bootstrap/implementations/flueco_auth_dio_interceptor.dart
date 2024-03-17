import 'package:example/foundation/abstractions/instance_resolver.dart';
import 'package:flueco/flueco.dart' show RequestOptions, DioException, Dio;
import 'package:flueco_auth/flueco_auth.dart';
import 'package:flueco_auth_dio_interceptor/flueco_auth_dio_interceptor.dart';
import 'package:flueco_auth_token/flueco_auth_token.dart';

/// Extension of [FluecoAuthDioInterceptor]
final class ExampleFluecoAuthDioInterceptor extends FluecoAuthDioInterceptor {
  final Dio _dio;

  /// Creates an instance of [ExampleFluecoAuthDioInterceptor]
  ExampleFluecoAuthDioInterceptor({
    required Dio dio,
    required ResolverOf<Authenticator> authenticator,
  })  : _dio = dio,
        super(
          controller:
              _ExampleFluecoAuthDioController(authenticator: authenticator),
        );

  /// Initialize this interceptor
  Future<void> initialize() {
    _dio.interceptors.add(this);

    return Future<void>.value();
  }
}

class _ExampleFluecoAuthDioController implements FluecoAuthDioController {
  final ResolverOf<Authenticator> _authenticator;

  _ExampleFluecoAuthDioController({
    required ResolverOf<Authenticator> authenticator,
  }) : _authenticator = authenticator;

  @override
  Map<String, dynamic> headers(
    Iterable<Authentication> authentications,
    RequestOptions options,
  ) {
    final TokenAuthentication? tokenAuthentication =
        authentications.whereType<TokenAuthentication>().singleOrNull;
    if (tokenAuthentication != null) {
      return tokenAuthentication.toHeader();
    }

    return <String, dynamic>{};
  }

  @override
  void onDioException(
    Iterable<Authentication> authentications,
    DioException exception,
  ) {
    if (exception.response?.statusCode == 401) {
      final TokenAuthentication? tokenAuthentication =
          authentications.whereType<TokenAuthentication>().singleOrNull;
      if (tokenAuthentication != null) {
        _authenticator().invalidate(tokenAuthentication);
      }
    }
  }
}
