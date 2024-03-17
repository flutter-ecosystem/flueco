// ignore_for_file: public_member_api_docs
import 'package:example/foundation/helpers/typedefs.dart';
import 'package:json_annotation/json_annotation.dart';

import '../json_keys.dart';

part 'user_profile_model.g.dart';

///User's profile model from HTTP source.
@JsonSerializable(
  createToJson: false,
  createFactory: true,
  ignoreUnannotated: true,
  fieldRename: FieldRename.snake,
)
final class UserProfileModel {
  @JsonKey(
    name: JsonKeys.id,
  )
  final int id;

  @JsonKey(
    name: JsonKeys.uuid,
  )
  final String uuid;

  @JsonKey(
    name: JsonKeys.name,
  )
  final String? name;

  @JsonKey(
    name: JsonKeys.birthDate,
  )
  final DateTime? birthDate;

  /// Height in centimeter
  @JsonKey(
    name: JsonKeys.height,
  )
  final double? height;

  /// Weight in gram
  @JsonKey(
    name: JsonKeys.weight,
  )
  final double? weight;

  @JsonKey(
    name: JsonKeys.description,
  )
  final String? description;

  @JsonKey(
    name: JsonKeys.gender,
  )
  final Gender? gender;

  @JsonKey(
    name: JsonKeys.sexuality,
  )
  final SexualOrientation? sexuality;

  @JsonKey(
    name: JsonKeys.position,
  )
  final SexualPosition? position;

  @JsonKey(
    name: JsonKeys.relationshipStatus,
  )
  final RelationshipStatus? relationshipStatus;

  @JsonKey(
    name: JsonKeys.researchType,
  )
  final ResearchType? researchType;

  @JsonKey(
    name: JsonKeys.isActive,
  )
  final bool? isActive;

  @JsonKey(
    name: JsonKeys.location,
  )
  final Location? location;

  @JsonKey(
    name: JsonKeys.createdAt,
  )
  final DateTime? createdAt;

  @JsonKey(
    name: JsonKeys.updateAt,
  )
  final DateTime? updatedAt;

  /// Creates an instance from [json]
  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  UserProfileModel({
    required this.id,
    required this.uuid,
    this.name,
    this.height,
    this.weight,
    this.description,
    this.gender,
    this.sexuality,
    this.position,
    this.relationshipStatus,
    this.researchType,
    this.birthDate,
    this.isActive,
    this.location,
    this.createdAt,
    this.updatedAt,
  });
}

@JsonEnum()
enum SexualOrientation {
  @JsonValue(0)
  heterosexual(value: 0),
  @JsonValue(1)
  homosexual(value: 1),
  @JsonValue(2)
  bisexual(value: 2);

  final int value;

  const SexualOrientation({required this.value});
}

extension IntToSexualOrientation on int {
  SexualOrientation? toSexualOrientation() {
    return SexualOrientation.values
        .where((SexualOrientation element) => element.value == this)
        .firstOrNull;
  }
}

@JsonEnum()
enum Gender {
  @JsonValue(0)
  male(value: 0),
  @JsonValue(1)
  female(value: 1),
  @JsonValue(2)
  other(value: 2);

  final int value;

  const Gender({required this.value});
}

extension IntToGender on int {
  Gender? toGender() {
    return Gender.values
        .where((Gender element) => element.value == this)
        .firstOrNull;
  }
}

@JsonEnum()
enum SexualPosition {
  @JsonValue(0)
  bottom(value: 0),
  @JsonValue(1)
  top(value: 01),
  @JsonValue(2)
  vers(value: 2),
  @JsonValue(3)
  versBottom(value: 3),
  @JsonValue(4)
  versTop(value: 4),
  @JsonValue(5)
  nosex(value: 5);

  final int value;

  const SexualPosition({required this.value});
}

extension IntToSexualPosition on int {
  SexualPosition? toSexualPosition() {
    return SexualPosition.values
        .where((SexualPosition element) => element.value == this)
        .firstOrNull;
  }
}

@JsonEnum()
enum RelationshipStatus {
  @JsonValue(0)
  single(value: 0),
  @JsonValue(1)
  openRelationship(value: 1),
  @JsonValue(2)
  closedRelationship(value: 2);

  final int value;

  const RelationshipStatus({required this.value});
}

extension IntToRelationshipStatus on int {
  RelationshipStatus? toRelationshipStatus() {
    return RelationshipStatus.values
        .where((RelationshipStatus element) => element.value == this)
        .firstOrNull;
  }
}

@JsonEnum()
enum ResearchType {
  @JsonValue(0)
  friend(value: 0),
  @JsonValue(1)
  companion(value: 1), // lover
  @JsonValue(2)
  sex(value: 2),
  @JsonValue(2)
  talk(value: 2);

  final int value;

  const ResearchType({required this.value});
}

extension IntToResearchType on int {
  ResearchType? toResearchType() {
    return ResearchType.values
        .where((ResearchType element) => element.value == this)
        .firstOrNull;
  }
}
