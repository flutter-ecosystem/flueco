import 'package:json_annotation/json_annotation.dart';

part 'create_installation_request.g.dart';

/// Activate request data
@JsonSerializable(
  createToJson: true,
  createFactory: false,
  ignoreUnannotated: true,
  fieldRename: FieldRename.snake,
)
final class CreateInstallationRequest {
  /// Version of application field
  @JsonKey(
    name: 'app_version',
  )
  final String appVersion;

  /// OS field
  @JsonKey(
    name: 'device_os',
  )
  final String deviceOS;

  /// OS Version field
  @JsonKey(
    name: 'device_os_version',
  )
  final String deviceOSVersion;

  /// Creates an instance of [CreateInstallationRequest]
  const CreateInstallationRequest({
    required this.appVersion,
    required this.deviceOS,
    required this.deviceOSVersion,
  });

  /// Parse to json map
  Map<String, dynamic> toJson() => _$CreateInstallationRequestToJson(this);
}
