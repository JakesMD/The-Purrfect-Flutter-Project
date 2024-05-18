part of 'bloc.dart';

/// Events for the PTasksStreamBloc.
sealed class PTasksStreamEvent {}

final class _PTasksStreamStarted extends PTasksStreamEvent {}

final class _PTasksStreamUpdated extends PTasksStreamEvent {
  _PTasksStreamUpdated({required this.result});

  final Either<PTasksStreamException, List<PTask>> result;
}
