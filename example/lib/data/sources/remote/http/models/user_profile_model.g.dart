// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      id: json['i'] as int,
      uuid: json['ui'] as String,
      name: json['n'] as String?,
      height: (json['h'] as num?)?.toDouble(),
      weight: (json['w'] as num?)?.toDouble(),
      description: json['dscr'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['g']),
      sexuality: $enumDecodeNullable(_$SexualOrientationEnumMap, json['sx']),
      position: $enumDecodeNullable(_$SexualPositionEnumMap, json['pos']),
      relationshipStatus:
          $enumDecodeNullable(_$RelationshipStatusEnumMap, json['r_s']),
      researchType: $enumDecodeNullable(_$ResearchTypeEnumMap, json['r_t']),
      birthDate:
          json['bd'] == null ? null : DateTime.parse(json['bd'] as String),
      isActive: json['i_a'] as bool?,
      location: _$recordConvertNullable(
        json['loc'],
        ($jsonValue) => (
          latitude: ($jsonValue['latitude'] as num).toDouble(),
          longitude: ($jsonValue['longitude'] as num).toDouble(),
        ),
      ),
      createdAt:
          json['c_a'] == null ? null : DateTime.parse(json['c_a'] as String),
      updatedAt:
          json['u_a'] == null ? null : DateTime.parse(json['u_a'] as String),
    );

const _$GenderEnumMap = {
  Gender.male: 0,
  Gender.female: 1,
  Gender.other: 2,
};

const _$SexualOrientationEnumMap = {
  SexualOrientation.heterosexual: 0,
  SexualOrientation.homosexual: 1,
  SexualOrientation.bisexual: 2,
};

const _$SexualPositionEnumMap = {
  SexualPosition.bottom: 0,
  SexualPosition.top: 1,
  SexualPosition.vers: 2,
  SexualPosition.versBottom: 3,
  SexualPosition.versTop: 4,
  SexualPosition.nosex: 5,
};

const _$RelationshipStatusEnumMap = {
  RelationshipStatus.single: 0,
  RelationshipStatus.openRelationship: 1,
  RelationshipStatus.closedRelationship: 2,
};

const _$ResearchTypeEnumMap = {
  ResearchType.friend: 0,
  ResearchType.companion: 1,
  ResearchType.sex: 2,
  ResearchType.talk: 2,
};

$Rec? _$recordConvertNullable<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    value == null ? null : convert(value as Map<String, dynamic>);
