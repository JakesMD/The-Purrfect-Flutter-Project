import 'package:pdatabase_client/pdatabase_client.dart';
import 'package:ppub/dartz.dart';
import 'package:ptasks_repository/ptasks_repository.dart';

/// {@template PTasksRepository}
///
/// The repository for interacting with tasks.
///
/// {@endtemplate}
class PTasksRepository {
  /// {@macro PTasksRepository}
  const PTasksRepository({required this.databaseClient});

  /// The client for interacting with the database.
  final PDatabaseClient databaseClient;

  /// A stream of all the tasks from the data client.
  Stream<Either<PTasksStreamException, List<PTask>>> tasksStream() async* {
    final stream = databaseClient.tasksTableStream();

    await for (final rows in stream) {
      yield rows.fold(
        (exception) => left(
          switch (exception) {
            PTableStreamException.unknown => PTasksStreamException.unknown,
          },
        ),
        (rows) => right([for (final row in rows) PTask.fromTableRow(row)]),
      );
    }
  }

  /// Creates a new task with the given [instruction].
  Future<Either<PTaskCreationException, PTask>> createTask({
    required String instruction,
  }) async {
    final result = await databaseClient.insertTask(
      PTasksTableCompanion.insert(instruction: instruction),
    );

    return result.fold(
      (exception) => left(
        switch (exception) {
          PTableInsertException.unknown => PTaskCreationException.unknown,
        },
      ),
      (row) => right(PTask.fromTableRow(row)),
    );
  }

  /// Edits the task with the given [taskID] to have the given [instruction].
  Future<Either<PTaskUpdateException, Unit>> editTask({
    required int taskID,
    required String instruction,
  }) async {
    final result = await databaseClient.updateTask(
      PTasksTableCompanion(
        id: Value(taskID),
        instruction: Value(instruction),
      ),
    );

    return result.fold(
      (exception) => left(
        switch (exception) {
          PTableUpdateException.unknown => PTaskUpdateException.unknown,
        },
      ),
      right,
    );
  }

  /// Deletes the task with the given [taskID].
  Future<Either<PTaskDeletionException, Unit>> deleteTask({
    required int taskID,
  }) async {
    final result = await databaseClient.deleteTask(
      PTasksTableCompanion(id: Value(taskID)),
    );

    return result.fold(
      (exception) => left(
        switch (exception) {
          PTableDeletionException.unknown => PTaskDeletionException.unknown,
        },
      ),
      right,
    );
  }
}
