import 'package:example/data/sources/remote/http/json_keys.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_auth_response.g.dart';

/// Auth response data
@JsonSerializable(
  createToJson: false,
  createFactory: true,
  ignoreUnannotated: true,
  fieldRename: FieldRename.snake,
)
final class AuthAuthResponse {
  /// Auth field
  @JsonKey(
    name: JsonKeys.data,
  )
  final AuthAuthData data;

  /// Creates an instance of [AuthAuthResponse]
  const AuthAuthResponse({
    required this.data,
  });

  /// Creates an instance from [json]
  factory AuthAuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthAuthResponseFromJson(json);
}

/// Auth response data
@JsonSerializable(
  createToJson: false,
  createFactory: true,
  ignoreUnannotated: true,
  fieldRename: FieldRename.snake,
)
final class AuthAuthData {
  /// Auth field
  @JsonKey(
    name: JsonKeys.codeLength,
  )
  final int codeLength;

  /// Creates an instance of [AuthAuthData]
  const AuthAuthData({
    required this.codeLength,
  });

  /// Creates an instance from [json]
  factory AuthAuthData.fromJson(Map<String, dynamic> json) =>
      _$AuthAuthDataFromJson(json);
}
