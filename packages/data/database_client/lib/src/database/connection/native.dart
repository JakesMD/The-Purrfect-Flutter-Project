// coverage:ignore-file

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_dev/api/migrations.dart';
import 'package:flutter/foundation.dart';
import 'package:ppub/path.dart' as path;
import 'package:ppub/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

/// Returns the file that should be used as the database file.
Future<File> get databaseFile async {
  // We use `path_provider` to find a suitable path to store our data in.
  final appDir = await getApplicationDocumentsDirectory();
  final dbPath = path.join(appDir.path, 'purrfect.db');
  return File(dbPath);
}

/// Obtains a database connection for running drift in a Dart VM.
DatabaseConnection connect() {
  return DatabaseConnection.delayed(
    Future(() async {
      if (Platform.isAndroid) {
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();

        final cachebase = (await getTemporaryDirectory()).path;

        // We can't access /tmp on Android, which sqlite3 would try by default.
        // Explicitly tell it about the correct temporary directory.
        sqlite3.tempDirectory = cachebase;
      }

      return NativeDatabase.createBackgroundConnection(
        await databaseFile,
      );
    }),
  );
}

/// This method validates that the actual schema of the opened database matches
/// the tables, views, triggers and indices for which drift_dev has generated
/// code.
/// Validating the database's schema after opening it is generally a good idea,
/// since it allows us to get an early warning if we change a table definition
/// without writing a schema migration for it.
///
/// For details, see: https://drift.simonbinder.eu/docs/advanced-features/migrations/#verifying-a-database-schema-at-runtime
Future<void> validateDatabaseSchema(GeneratedDatabase database) async {
  if (kDebugMode) {
    await VerifySelf(database).validateDatabaseSchema();
  }
}