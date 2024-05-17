part of 'bloc.dart';

/// Events for the PTaskDeletionBloc.
sealed class PTaskDeletionEvent {}

/// {@template PTaskDeletionTriggered}
///
/// A trigger to delete a task.
///
/// {@endtemplate}
class PTaskDeletionTriggered extends PTaskDeletionEvent {
  /// {@macro PTaskDeletionTriggered}
  PTaskDeletionTriggered({required this.taskID});

  /// The ID of the task to delete.
  final int taskID;
}

final class _PTaskDeletionCompleted extends PTaskDeletionEvent {
  _PTaskDeletionCompleted({required this.result});

  final Either<PTaskDeletionException, Unit> result;
}
