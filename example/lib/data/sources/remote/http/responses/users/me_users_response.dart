import 'package:json_annotation/json_annotation.dart';

import '../../json_keys.dart';
import '../../models/user_model.dart';

part 'me_users_response.g.dart';

/// Login response data
@JsonSerializable(
  createToJson: false,
  createFactory: true,
  ignoreUnannotated: true,
  fieldRename: FieldRename.snake,
)
final class MeUsersResponse {
  /// Login field
  @JsonKey(
    name: JsonKeys.data,
  )
  final UserModel data;

  /// Creates an instance of [MeUsersResponse]
  const MeUsersResponse({
    required this.data,
  });

  /// Creates an instance from [json]
  factory MeUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$MeUsersResponseFromJson(json);
}
