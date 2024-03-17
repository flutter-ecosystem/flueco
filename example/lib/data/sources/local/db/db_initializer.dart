import 'package:example/data/sources/local/db/models/user_profile_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flueco/flueco.dart' show Box, HiveBoxFactory, Hive;

import 'models/user_model.dart';

/// Initializer of the databases
class DBInitializer {
  ///
  static const String usersBoxName = 'users';
  final Map<String, Box<HiveObject>> _boxes = <String, Box<HiveObject>>{};

  /// Creates an instance of [DBInitializer]
  DBInitializer._();

  /// Initialize the database
  static Future<DBInitializer> fromBoxFactory({
    required HiveBoxFactory boxFactory,
  }) async {
    final DBInitializer initializer = DBInitializer._();
    Hive
      ..registerAdapter(UserDBAdapter())
      ..registerAdapter(UserProfileDBAdapter());

    initializer._boxes[DBInitializer.usersBoxName] = await boxFactory
        .createUnsecureBox<UserDBModel>(DBInitializer.usersBoxName);

    return initializer;
  }

  /// Get a [Box] created for [name]
  Box<T>? box<T extends HiveObject>(String name) {
    final Box<HiveObject>? box = _boxes[name];
    if (box is Box<T>) {
      return box;
    }

    return null;
  }
}
