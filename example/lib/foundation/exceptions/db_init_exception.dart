import 'package:universal_io/io.dart';

/// Exception thrown when initialization of a
/// local database failed.
class DbInitException implements IOException {
  /// Name of the database that fails to be
  /// initialized
  final String dbName;

  /// Creates an instance of [DbInitException]
  const DbInitException({required this.dbName});

  @override
  String toString() => 'DbInitException(dbName: $dbName)';
}
