// ignore_for_file: public_member_api_docs

import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../foundation/helpers/typedefs.dart';

part 'user_profile_model.g.dart';

@HiveType(typeId: 1, adapterName: 'UserProfileDBAdapter')
final class UserProfileDBModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String uuid;

  @HiveField(2)
  final String? name;

  @HiveField(3)
  final DateTime? birthDate;

  @HiveField(4)
  final double? height;

  @HiveField(5)
  final double? weight;

  @HiveField(6)
  final String? description;

  @HiveField(7)
  final int? gender;

  @HiveField(8)
  final int? position;

  @HiveField(9)
  final int? relationshipStatus;

  @HiveField(10)
  final int? researchType;

  @HiveField(11)
  final bool? isActive;

  @HiveField(12)
  final Location? location;

  @HiveField(13)
  final int? sexuality;

  /// Date of creation
  @HiveField(14)
  final DateTime? createdAt;

  /// Date of update
  @HiveField(15)
  final DateTime? updatedAt;

  UserProfileDBModel({
    required this.id,
    required this.uuid,
    this.name,
    this.birthDate,
    this.height,
    this.weight,
    this.description,
    this.gender,
    this.sexuality,
    this.createdAt,
    this.isActive,
    this.location,
    this.position,
    this.relationshipStatus,
    this.researchType,
    this.updatedAt,
  });
}
