// coverage:ignore-file

import 'package:drift/drift.dart';
import 'package:pdatabase_client/src/database/connection/connection.dart'
    as connection;
import 'package:pdatabase_client/src/database/tables/_tables.dart';

part 'database.g.dart';

/// {@template PDatabase}
///
/// The main database for the application.
///
/// {@endtemplate}
@DriftDatabase(tables: [PTasksTable])
class PDatabase extends _$PDatabase {
  /// {@macro PDatabase}
  PDatabase() : super(connection.connect());

  @override
  int get schemaVersion => 1;
}
