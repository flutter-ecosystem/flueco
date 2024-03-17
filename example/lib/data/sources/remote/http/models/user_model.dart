// ignore_for_file: public_member_api_docs

import 'user_profile_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../json_keys.dart';

part 'user_model.g.dart';

///User model from HTTP source.
@JsonSerializable(
  createToJson: false,
  createFactory: true,
  ignoreUnannotated: true,
  fieldRename: FieldRename.snake,
)
final class UserModel {
  @JsonKey(
    name: JsonKeys.id,
  )
  final int id;

  @JsonKey(
    name: JsonKeys.uuid,
  )
  final String uuid;

  @JsonKey(
    name: JsonKeys.login,
  )
  final String? login;

  @JsonKey(
    name: JsonKeys.status,
  )
  final UserStatus? status;

  @JsonKey(
    name: JsonKeys.profile,
  )
  final UserProfileModel? profile;

  @JsonKey(
    name: JsonKeys.createdAt,
  )
  final DateTime? createdAt;

  @JsonKey(
    name: JsonKeys.updateAt,
  )
  final DateTime? updatedAt;

  /// Default constructor of [UserModel]
  const UserModel({
    required this.id,
    required this.uuid,
    this.login,
    this.profile,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  /// Creates an instance from [json]
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@JsonEnum()
enum UserStatus {
  @JsonValue(0)
  created(value: 0),
  @JsonValue(1)
  activated(value: 1),
  @JsonValue(2)
  blocked(value: 2),
  @JsonValue(3)
  deleted(value: 3);

  final int value;

  const UserStatus({required this.value});
}
