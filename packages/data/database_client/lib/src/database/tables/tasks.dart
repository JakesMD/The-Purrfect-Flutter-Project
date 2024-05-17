// coverage:ignore-file

import 'package:drift/drift.dart';

/// The table storing tasks.
class PTasksTable extends Table {
  /// The primary key for the table.
  IntColumn get id => integer().autoIncrement()();

  /// The instruction of the task.
  TextColumn get instruction => text().withLength(min: 1, max: 200)();

  /// The flag indicating whether the task is completed.
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
}