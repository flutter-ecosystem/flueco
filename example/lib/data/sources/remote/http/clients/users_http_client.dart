import 'package:flueco/flueco.dart'
    show Dio, RequestOptions, Options, ResponseType;
import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';

import '../responses/users/me_users_response.dart';

part 'users_http_client.g.dart';

/// Http client for users requests
@RestApi(
  parser: Parser.JsonSerializable,
  baseUrl: '/v1/users',
)
abstract class UsersHttpClient {
  /// Creates the default instance of [UsersHttpClient]
  factory UsersHttpClient(Dio dio) = _UsersHttpClient;

  /// Get authenticated user request
  @GET('/me')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<MeUsersResponse> me();
}
