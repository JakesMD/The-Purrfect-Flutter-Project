part of 'bloc.dart';

/// Events for the PTaskStatusUpdateBloc.
sealed class PTaskStatusUpdateEvent {}

/// {@template PTaskStatusUpdateTriggered}
///
/// An event that triggers the completion status of a task to be set.
///
/// {@endtemplate}
class PTaskStatusUpdateTriggered extends PTaskStatusUpdateEvent {
  /// {@macro PTaskStatusUpdateTriggered}
  PTaskStatusUpdateTriggered({
    required this.taskID,
    required this.isCompleted,
  });

  /// The ID of the task to update.
  final int taskID;

  /// The new completion status of the task.
  final bool isCompleted;
}

final class _PTaskStatusUpdateCompleted extends PTaskStatusUpdateEvent {
  _PTaskStatusUpdateCompleted({
    required this.result,
    required this.isCompleted,
  });

  final Either<PTaskUpdateException, Unit> result;

  final bool isCompleted;
}
