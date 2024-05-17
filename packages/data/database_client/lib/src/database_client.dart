import 'dart:developer';

import 'package:pdatabase_client/pdatabase_client.dart';
import 'package:ppub/dartz.dart';

/// {@template PDatabaseClient}
///
/// A client for interacting with the [PDatabase].
///
/// {@endtemplate}
class PDatabaseClient {
  /// Creates a new [PDatabaseClient] instance.
  PDatabaseClient({required this.database});

  /// The database to interact with.
  final PDatabase database;

  /// A stream of [PTasksTableData] from the tasks table in the database.
  Stream<Either<PTableStreamException, List<PTasksTableData>>>
      tasksTableStream() async* {
    try {
      final stream = database.select(database.pTasksTable).watch();

      await for (final data in stream) {
        yield right(data);
      }
    } catch (e, s) {
      log(e.toString(), error: e, stackTrace: s, name: 'PDatabaseClient');
      yield left(PTableStreamException.unknown);
    }
  }
}
