// ignore_for_file: public_member_api_docs

import '../../data/sources/local/db/models/user_profile_model.dart';
import '../../data/sources/remote/http/models/user_profile_model.dart';
import '../../foundation/helpers/typedefs.dart';

/// User profile
class UserProfile {
  /// Identifier
  final int id;

  /// Universal identifier
  final String uuid;

  final String? name;

  final DateTime? birthDate;

  /// Height in centimeter
  final double? height;

  /// Weight in gram
  final double? weight;

  final String? description;

  final Gender? gender;

  final SexualOrientation? sexuality;

  final SexualPosition? position;

  final RelationshipStatus? relationshipStatus;

  final ResearchType? researchType;

  final bool? isActive;

  final Location? location;

  /// Date of creation
  final DateTime? createdAt;

  /// Date of update
  final DateTime? updatedAt;

  /// Default constructor
  UserProfile({
    required this.id,
    required this.uuid,
    required this.name,
    required this.birthDate,
    required this.height,
    required this.weight,
    required this.description,
    required this.gender,
    required this.sexuality,
    required this.position,
    required this.relationshipStatus,
    required this.researchType,
    required this.isActive,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates an instance from [model]
  UserProfile.fromModel({required UserProfileModel model})
      : id = model.id,
        uuid = model.uuid,
        name = model.name,
        birthDate = model.birthDate,
        description = model.description,
        gender = model.gender,
        sexuality = model.sexuality,
        position = model.position,
        relationshipStatus = model.relationshipStatus,
        researchType = model.researchType,
        isActive = model.isActive,
        location = model.location,
        height = model.height,
        weight = model.weight,
        createdAt = model.createdAt,
        updatedAt = model.updatedAt;

  /// Creates an instance from [model]
  UserProfile.fromUserProfileDBModel({required UserProfileDBModel model})
      : id = model.id,
        uuid = model.uuid,
        name = model.name,
        birthDate = model.birthDate,
        description = model.description,
        gender = model.gender?.toGender(),
        sexuality = model.sexuality?.toSexualOrientation(),
        position = model.position?.toSexualPosition(),
        relationshipStatus = model.relationshipStatus?.toRelationshipStatus(),
        researchType = model.researchType?.toResearchType(),
        isActive = model.isActive,
        location = model.location,
        height = model.height,
        weight = model.weight,
        createdAt = model.createdAt,
        updatedAt = model.updatedAt;

  UserProfileDBModel toUserProfileDBModel() {
    return UserProfileDBModel(
      id: id,
      uuid: uuid,
      birthDate: birthDate,
      description: description,
      gender: gender?.value,
      height: height,
      name: name,
      sexuality: sexuality?.value,
      weight: weight,
      createdAt: createdAt,
      isActive: isActive,
      location: location,
      position: position?.value,
      relationshipStatus: relationshipStatus?.value,
      researchType: researchType?.value,
      updatedAt: updatedAt,
    );
  }
}
