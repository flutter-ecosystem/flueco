import 'package:example/data/sources/local/db/auth_db.dart';
import 'package:example/data/sources/local/db/db_initializer.dart';
import 'package:example/data/sources/local/db/users_db.dart';
import 'package:example/data/sources/remote/http/clients/auth_http_client.dart';
import 'package:example/data/sources/remote/http/clients/installation_http_client.dart';
import 'package:example/data/sources/remote/http/clients/users_http_client.dart';
import 'package:flueco/flueco.dart'
    show DioInstanceProvider, SecureStorage, HiveBoxFactory;
import 'package:injectable/injectable.dart';

/// Module to inject dependencies
@module
abstract class DataModule {
  /// Creates [AuthHttpClient]
  @injectable
  AuthHttpClient authHttpClient(DioInstanceProvider dioInstanceProvider) =>
      AuthHttpClient(dioInstanceProvider.dio);

  /// Creates [UsersHttpClient]
  @injectable
  UsersHttpClient usersHttpClient(DioInstanceProvider dioInstanceProvider) =>
      UsersHttpClient(dioInstanceProvider.dio);

  /// Creates [InstallationHttpClient]
  @injectable
  InstallationHttpClient installationHttpClient(
    DioInstanceProvider dioInstanceProvider,
  ) =>
      InstallationHttpClient(dioInstanceProvider.dio);

  /// Creates [AuthDB]
  @injectable
  AuthDB authDB(SecureStorage secureStorage) => AuthDB(storage: secureStorage);

  /// Creates [UsersDB]
  @preResolve
  @singleton
  Future<DBInitializer> dBInitializer(HiveBoxFactory boxFactory) =>
      DBInitializer.fromBoxFactory(boxFactory: boxFactory);

  /// Creates [UsersDB]
  @injectable
  UsersDB usersDB(DBInitializer dbInitializer) =>
      UsersDB.from(dBInitializer: dbInitializer);
}
