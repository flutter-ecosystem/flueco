import 'package:json_annotation/json_annotation.dart';

import '../../json_keys.dart';

part 'login_auth_response.g.dart';

/// Login response data
@JsonSerializable(
  createToJson: false,
  createFactory: true,
  ignoreUnannotated: true,
  fieldRename: FieldRename.snake,
)
final class LoginAuthResponse {
  /// Login field
  @JsonKey(
    name: JsonKeys.data,
  )
  final LoginAuthData data;

  /// Creates an instance of [LoginAuthResponse]
  const LoginAuthResponse({
    required this.data,
  });

  /// Creates an instance from [json]
  factory LoginAuthResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginAuthResponseFromJson(json);
}

/// Login response data
@JsonSerializable(
  createToJson: false,
  createFactory: true,
  ignoreUnannotated: true,
  fieldRename: FieldRename.snake,
)
final class LoginAuthData {
  /// Login field
  @JsonKey(
    name: JsonKeys.token,
  )
  final String token;

  /// Creates an instance of [LoginAuthData]
  const LoginAuthData({
    required this.token,
  });

  /// Creates an instance from [json]
  factory LoginAuthData.fromJson(Map<String, dynamic> json) =>
      _$LoginAuthDataFromJson(json);
}
