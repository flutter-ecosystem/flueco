import 'package:example/data/sources/remote/http/requests/installations/create_installation_request.dart';
import 'package:example/data/sources/remote/http/requests/installations/update_installation_request.dart';
import 'package:example/data/sources/remote/http/responses/installations/create_installation_response.dart';
import 'package:flueco/flueco.dart'
    show Dio, RequestOptions, Options, ResponseType;
import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';

part 'installation_http_client.g.dart';

/// Http client for installationentication requests
@RestApi(
  parser: Parser.JsonSerializable,
  baseUrl: '/v1/installations',
)
abstract class InstallationHttpClient {
  /// Creates the default instance of [InstallationHttpClient]
  factory InstallationHttpClient(Dio dio) = _InstallationHttpClient;

  /// Login request
  @POST('')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<CreateInstallationResponse> create(
    @Body() CreateInstallationRequest request,
  );

  /// Activate request
  @POST('/{id}')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<void> update(
    @Path('id') String id,
    @Body() UpdateInstallationRequest request,
  );
}
