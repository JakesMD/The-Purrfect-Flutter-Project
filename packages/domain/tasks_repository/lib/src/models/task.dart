/// {@template PTask}
///
/// Represents a task that the user can complete.
///
/// {@endtemplate}
class PTask {
  /// {@macro PTask}
  PTask({
    required this.id,
    required this.instruction,
    required this.isCompleted,
  });

  /// The unique identifier for the task.
  final BigInt id;

  /// The instruction for the task.
  final String instruction;

  /// Whether the task has been completed.
  final bool isCompleted;
}
