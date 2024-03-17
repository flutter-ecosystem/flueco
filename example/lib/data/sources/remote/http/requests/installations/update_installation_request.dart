import 'package:json_annotation/json_annotation.dart';

part 'update_installation_request.g.dart';

/// Activate request data
@JsonSerializable(
  createToJson: true,
  createFactory: false,
  ignoreUnannotated: true,
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
final class UpdateInstallationRequest {
  /// Version of application field
  @JsonKey(
    name: 'app_version',
  )
  final String? appVersion;

  /// OS field
  @JsonKey(
    name: 'device_os',
  )
  final String? deviceOS;

  /// Updates an instance of [UpdateInstallationRequest]
  const UpdateInstallationRequest({
    required this.appVersion,
    required this.deviceOS,
  });

  /// Parse to json map
  Map<String, dynamic> toJson() => _$UpdateInstallationRequestToJson(this);
}
