import 'package:json_annotation/json_annotation.dart';

part 'auth_request.g.dart';

/// Activate request data
@JsonSerializable(
  createToJson: true,
  createFactory: false,
  ignoreUnannotated: true,
  fieldRename: FieldRename.snake,
)
final class AuthRequest {
  /// Email field
  @JsonKey(
    name: 'email',
  )
  final String email;

  /// Creates an instance of [AuthRequest]
  const AuthRequest({
    required this.email,
  });

  /// Parse to json map
  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}
