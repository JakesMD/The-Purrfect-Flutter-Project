import 'package:pdatabase_client/pdatabase_client.dart';
import 'package:ppub/equatable.dart';

/// {@template PTask}
///
/// Represents a task that the user can complete.
///
/// {@endtemplate}
class PTask with EquatableMixin {
  /// {@macro PTask}
  const PTask({
    required this.id,
    required this.instruction,
    required this.isCompleted,
  });

  /// Creates a [PTask] from a [PTasksTableData].
  PTask.fromTableRow(PTasksTableData row)
      : id = row.id,
        instruction = row.instruction,
        isCompleted = row.isCompleted;

  /// The unique identifier for the task.
  final int id;

  /// The instruction for the task.
  final String instruction;

  /// Whether the task has been completed.
  final bool isCompleted;

  @override
  List<Object?> get props => [id, instruction, isCompleted];
}
