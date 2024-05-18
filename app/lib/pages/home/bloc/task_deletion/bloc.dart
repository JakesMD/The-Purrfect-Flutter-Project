import 'dart:async';

import 'package:ppub/bloc.dart';
import 'package:ppub/bloc_concurrency.dart';
import 'package:ppub/dartz.dart';
import 'package:ppub/equatable.dart';
import 'package:ptasks_repository/ptasks_repository.dart';

part 'event.dart';
part 'state.dart';

/// {@template PTaskDeletionBloc}
///
/// A [Bloc] that manages the deletion of tasks.
///
/// {@endtemplate}
class PTaskDeletionBloc extends Bloc<PTaskDeletionEvent, PTaskDeletionState> {
  /// {@macro PTaskDeletionBloc}
  PTaskDeletionBloc({
    required this.tasksRepository,
  }) : super(PTaskDeletionInitial()) {
    on<PTaskDeletionTriggered>(_onTriggered, transformer: droppable());
    on<_PTaskDeletionCompleted>(_onCompleted);
  }

  /// The repository for interacting with tasks.
  final PTasksRepository tasksRepository;

  Future<void> _onTriggered(
    PTaskDeletionTriggered event,
    Emitter<PTaskDeletionState> emit,
  ) async {
    emit(PTaskDeletionInProgress());

    final result = await tasksRepository.deleteTask(taskID: event.taskID);

    add(_PTaskDeletionCompleted(result: result));
  }

  void _onCompleted(
    _PTaskDeletionCompleted event,
    Emitter<PTaskDeletionState> emit,
  ) {
    emit(
      event.result.fold(
        (exception) => PTaskDeletionFailure(exception: exception),
        (unit) => PTaskDeletionSuccess(),
      ),
    );
  }
}
