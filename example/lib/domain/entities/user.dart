import 'package:example/data/sources/local/db/models/user_model.dart';
import 'package:example/data/sources/local/db/models/user_profile_model.dart';
import 'package:example/data/sources/remote/http/models/user_profile_model.dart';
import 'package:example/domain/entities/user_profile.dart';
import 'package:example/foundation/helpers/helpers.dart';

import '../../data/sources/remote/http/models/user_model.dart';

/// User entity
final class User {
  /// User ID
  final int id;

  /// User universal identifier
  final String uuid;

  /// Login (username or email)
  final String? login;

  /// Status of the user
  final UserStatus? status;

  /// Profile of the user
  final UserProfile? profile;

  /// Date of creation
  final DateTime? createdAt;

  /// Date of update
  final DateTime? updatedAt;

  /// Creates an instance of [User]
  User({
    required this.id,
    required this.uuid,
    required this.login,
    required this.status,
    required this.profile,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates an instance from [model]
  User.fromModel({required UserModel model})
      : id = model.id,
        uuid = model.uuid,
        login = model.login,
        status = model.status,
        profile = orNull(
          data: model.profile,
          map: (UserProfileModel data) => UserProfile.fromModel(model: data),
        ),
        createdAt = model.createdAt,
        updatedAt = model.updatedAt;

  /// Creates an instance from [model]
  User.fromUserDBModel({required UserDBModel model})
      : id = model.id,
        uuid = model.uuid,
        login = model.login,
        status = UserStatus.values
            .where((UserStatus element) => element.value == model.status)
            .firstOrNull,
        profile = orNull(
          data: model.profile,
          map: (UserProfileDBModel data) =>
              UserProfile.fromUserProfileDBModel(model: data),
        ),
        createdAt = model.createdAt,
        updatedAt = model.updatedAt;

  /// Creates an instance of [UserDBModel]
  /// from this user.
  UserDBModel toUserDBModel() {
    return UserDBModel(
      id: id,
      uuid: uuid,
      login: login,
      status: status?.value,
      createdAt: createdAt,
      updatedAt: updatedAt,
      profile: profile?.toUserProfileDBModel(),
    );
  }
}
