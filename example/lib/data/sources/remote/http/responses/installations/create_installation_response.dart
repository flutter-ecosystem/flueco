import 'package:json_annotation/json_annotation.dart';

part 'create_installation_response.g.dart';

/// Login response data
@JsonSerializable(
  createToJson: false,
  createFactory: true,
  ignoreUnannotated: true,
  fieldRename: FieldRename.snake,
)
final class CreateInstallationResponse {
  /// Login field
  @JsonKey(
    name: 'd',
  )
  final CreateInstallationData data;

  /// Creates an instance of [CreateInstallationResponse]
  const CreateInstallationResponse({
    required this.data,
  });

  /// Creates an instance from [json]
  factory CreateInstallationResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateInstallationResponseFromJson(json);
}

/// Login response data
@JsonSerializable(
  createToJson: false,
  createFactory: true,
  ignoreUnannotated: true,
  fieldRename: FieldRename.snake,
)
final class CreateInstallationData {
  /// Login field
  @JsonKey(
    name: 'ui',
  )
  final String uuid;

  /// Creates an instance of [CreateInstallationData]
  const CreateInstallationData({
    required this.uuid,
  });

  /// Creates an instance from [json]
  factory CreateInstallationData.fromJson(Map<String, dynamic> json) =>
      _$CreateInstallationDataFromJson(json);
}
