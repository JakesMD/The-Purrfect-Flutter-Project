import 'dart:async';

import 'package:ppub/bloc.dart';
import 'package:ppub/bloc_concurrency.dart';
import 'package:ppub/dartz.dart';
import 'package:ppub/equatable.dart';
import 'package:ptasks_repository/ptasks_repository.dart';

part 'event.dart';
part 'state.dart';

/// {@template PTaskStatusUpdateBloc}
///
/// A [Bloc] that manages the status of tasks.
///
/// {@endtemplate}
class PTaskStatusUpdateBloc
    extends Bloc<PTaskStatusUpdateEvent, PTaskStatusUpdateState> {
  /// {@macro PTaskStatusUpdateBloc}
  PTaskStatusUpdateBloc({
    required this.tasksRepository,
  }) : super(PTaskStatusUpdateInitial()) {
    on<PTaskStatusUpdateTriggered>(_onTriggered, transformer: droppable());
    on<_PTaskStatusUpdateCompleted>(_onCompleted);
  }

  /// The repository for interacting with tasks.
  final PTasksRepository tasksRepository;

  Future<void> _onTriggered(
    PTaskStatusUpdateTriggered event,
    Emitter<PTaskStatusUpdateState> emit,
  ) async {
    emit(PTaskStatusUpdateInProgress());

    final result = await tasksRepository.updateTaskStatus(
      taskID: event.taskID,
      isCompleted: event.isCompleted,
    );

    add(
      _PTaskStatusUpdateCompleted(
        result: result,
        isCompleted: event.isCompleted,
      ),
    );
  }

  void _onCompleted(
    _PTaskStatusUpdateCompleted event,
    Emitter<PTaskStatusUpdateState> emit,
  ) {
    emit(
      event.result.fold(
        (exception) => PTaskStatusUpdateFailure(exception: exception),
        (unit) => PTaskStatusUpdateSuccess(isCompleted: event.isCompleted),
      ),
    );
  }
}
