import 'dart:async';

import 'package:example/application/managers/auth/auth.manager.dart'
    show AuthUserProvider;
import 'package:example/data/sources/local/db/auth_db.dart';
import 'package:example/data/sources/local/db/models/user_model.dart';
import 'package:example/data/sources/local/db/users_db.dart';
import 'package:example/data/sources/remote/http/clients/users_http_client.dart';
import 'package:example/data/sources/remote/http/models/user_model.dart';
import 'package:example/domain/entities/user.dart';

/// Implementation of [AuthUserProvider] that uses
/// local database and remote api.
final class ExampleAuthUserProvider implements AuthUserProvider {
  final UsersDB _usersDB;
  final AuthDB _authDB;
  final UsersHttpClient _usersHttpClient;

  /// Creates an instance of [ExampleAuthUserProvider]
  ExampleAuthUserProvider({
    required UsersDB usersDB,
    required AuthDB authDB,
    required UsersHttpClient usersHttpClient,
  })  : _usersDB = usersDB,
        _authDB = authDB,
        _usersHttpClient = usersHttpClient;

  @override
  Future<User> getAuthUser() async {
    final User? user = await _fromDB();

    if (user != null) {
      unawaited(_refresh());

      return user;
    }

    return _refresh();
  }

  Future<User> _refresh() async {
    final User user = await _fromHttp();

    unawaited(_usersDB.save(user: user.toUserDBModel()));

    return user;
  }

  Future<User> _fromHttp() async {
    final UserModel model = (await _usersHttpClient.me()).data;

    return User.fromModel(model: model);
  }

  Future<User?> _fromDB() async {
    final String? uuid = await _authDB.getUserUuid();

    if (uuid != null) {
      final UserDBModel? model = await _usersDB.get(uuid: uuid);
      if (model != null) {
        return User.fromUserDBModel(model: model);
      }
    }

    return null;
  }
}
