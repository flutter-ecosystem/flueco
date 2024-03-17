// ignore_for_file: public_member_api_docs

import 'user_profile_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0, adapterName: 'UserDBAdapter')
final class UserDBModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String uuid;

  @HiveField(2)
  final String? login;

  @HiveField(3)
  final int? status;

  @HiveField(4)
  final DateTime? createdAt;

  @HiveField(5)
  final DateTime? updatedAt;

  @HiveField(6)
  final UserProfileDBModel? profile;

  UserDBModel({
    required this.id,
    required this.uuid,
    this.login,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.profile,
  });
}
