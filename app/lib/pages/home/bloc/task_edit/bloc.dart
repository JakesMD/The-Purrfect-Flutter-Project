import 'dart:async';

import 'package:ppub/bloc.dart';
import 'package:ppub/bloc_concurrency.dart';
import 'package:ppub/dartz.dart';
import 'package:ppub/equatable.dart';
import 'package:ptasks_repository/ptasks_repository.dart';

part 'event.dart';
part 'state.dart';

/// {@template PTaskEditBloc}
///
/// A [Bloc] that manages the editing of tasks.
///
/// {@endtemplate}
class PTaskEditBloc extends Bloc<PTaskEditEvent, PTaskEditState> {
  /// {@macro PTaskEditBloc}
  PTaskEditBloc({
    required this.tasksRepository,
  }) : super(PTaskEditInitial()) {
    on<PTaskEditTriggered>(_onTriggered, transformer: droppable());
    on<_PTaskEditCompleted>(_onCompleted);
  }

  /// The repository for interacting with tasks.
  final PTasksRepository tasksRepository;

  Future<void> _onTriggered(
    PTaskEditTriggered event,
    Emitter<PTaskEditState> emit,
  ) async {
    emit(PTaskEditInProgress());

    final result = await tasksRepository.editTask(
      taskID: event.taskID,
      instruction: event.instruction,
    );

    add(_PTaskEditCompleted(result: result));
  }

  void _onCompleted(
    _PTaskEditCompleted event,
    Emitter<PTaskEditState> emit,
  ) {
    emit(
      event.result.fold(
        (exception) => PTaskEditFailure(exception: exception),
        (unit) => PTaskEditSuccess(),
      ),
    );
  }
}
