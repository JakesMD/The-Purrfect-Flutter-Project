part of 'bloc.dart';

/// Events for the PTaskCreationBloc.
sealed class PTaskCreationEvent {}

/// {@template PTaskCreationTriggered}
///
/// A trigger to create a new task.
///
/// {@endtemplate}
class PTaskCreationTriggered extends PTaskCreationEvent {
  /// {@macro PTaskCreationTriggered}
  PTaskCreationTriggered({required this.instruction});

  /// The instruction for the new task.
  final String instruction;
}

final class _PTaskCreationCompleted extends PTaskCreationEvent {
  _PTaskCreationCompleted({required this.result});

  final Either<PTaskCreationException, PTask> result;
}
