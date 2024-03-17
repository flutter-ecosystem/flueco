import 'package:example/data/sources/remote/http/requests/auth/auth_request.dart';
import 'package:example/data/sources/remote/http/requests/auth/login_auth_request.dart';
import 'package:example/data/sources/remote/http/responses/auth/login_auth_response.dart';
import 'package:flueco/flueco.dart'
    show Dio, RequestOptions, Options, ResponseType;
import 'package:retrofit/http.dart';

import '../responses/auth/auth_auth_response.dart';

part 'auth_http_client.g.dart';

/// Http client for authentication requests
@RestApi(
  parser: Parser.JsonSerializable,
  baseUrl: '/v1/auth',
)
abstract class AuthHttpClient {
  /// Creates the default instance of [AuthHttpClient]
  factory AuthHttpClient(Dio dio) = _AuthHttpClient;

  /// Login request
  @POST('/login')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<LoginAuthResponse> login(@Body() LoginAuthRequest request);

  /// Activate request
  @POST('')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<AuthAuthResponse> auth(@Body() AuthRequest request);
}
