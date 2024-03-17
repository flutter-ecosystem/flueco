import 'package:json_annotation/json_annotation.dart';

part 'login_auth_request.g.dart';

/// Login request data
@JsonSerializable(
  createToJson: true,
  createFactory: false,
  ignoreUnannotated: true,
  fieldRename: FieldRename.snake,
)
final class LoginAuthRequest {
  /// Login field
  @JsonKey(
    name: 'login',
  )
  final String login;

  /// Password field
  @JsonKey(
    name: 'password',
  )
  final String password;

  /// Creates an instance of [LoginAuthRequest]
  const LoginAuthRequest({required this.login, required this.password});

  /// Parse to json map
  Map<String, dynamic> toJson() => _$LoginAuthRequestToJson(this);
}
