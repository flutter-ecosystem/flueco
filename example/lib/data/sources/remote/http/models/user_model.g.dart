// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['i'] as num).toInt(),
      uuid: json['ui'] as String,
      login: json['l'] as String?,
      profile: json['pr'] == null
          ? null
          : UserProfileModel.fromJson(json['pr'] as Map<String, dynamic>),
      status: $enumDecodeNullable(_$UserStatusEnumMap, json['s']),
      createdAt:
          json['c_a'] == null ? null : DateTime.parse(json['c_a'] as String),
      updatedAt:
          json['u_a'] == null ? null : DateTime.parse(json['u_a'] as String),
    );

const _$UserStatusEnumMap = {
  UserStatus.created: 0,
  UserStatus.activated: 1,
  UserStatus.blocked: 2,
  UserStatus.deleted: 3,
};
