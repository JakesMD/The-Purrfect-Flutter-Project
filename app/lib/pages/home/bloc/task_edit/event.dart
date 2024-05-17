part of 'bloc.dart';

/// Events for the PTaskEditBloc.
sealed class PTaskEditEvent {}

/// {@template PTaskEditTriggered}
///
/// A trigger to edit a task.
///
/// {@endtemplate}
class PTaskEditTriggered extends PTaskEditEvent {
  /// {@macro PTaskEditTriggered}
  PTaskEditTriggered({
    required this.taskID,
    required this.instruction,
  });

  /// The ID of the task to edit.
  final int taskID;

  /// The new instruction for the task.
  final String instruction;
}

final class _PTaskEditCompleted extends PTaskEditEvent {
  _PTaskEditCompleted({required this.result});

  final Either<PTaskUpdateException, Unit> result;
}
