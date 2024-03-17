import 'package:flueco/flueco.dart' show Box;

import '../../../../foundation/exceptions/db_init_exception.dart';
import 'db_initializer.dart';
import 'models/user_model.dart';

/// Database for Users
final class UsersDB {
  final Box<UserDBModel> _box;

  /// Creates an instance of [UsersDB]
  const UsersDB({
    required Box<UserDBModel> box,
  }) : _box = box;

  /// Creates asynchronously an instance of [UsersDB].
  static UsersDB from({
    required DBInitializer dBInitializer,
  }) {
    final Box<UserDBModel>? box =
        dBInitializer.box<UserDBModel>(DBInitializer.usersBoxName);

    if (box == null) {
      throw const DbInitException(
        dbName: DBInitializer.usersBoxName,
      );
    }

    return UsersDB(box: box);
  }

  /// Save [user]
  Future<void> save({required UserDBModel user}) {
    return _box.put(user.uuid, user);
  }

  /// Get a user by its [uuid]
  Future<UserDBModel?> get({required String uuid}) async {
    return _box.get(uuid);
  }
}
