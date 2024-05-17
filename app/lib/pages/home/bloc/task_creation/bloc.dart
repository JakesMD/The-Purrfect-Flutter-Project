import 'dart:async';

import 'package:ppub/bloc.dart';
import 'package:ppub/bloc_concurrency.dart';
import 'package:ppub/dartz.dart';
import 'package:ppub/equatable.dart';
import 'package:ptasks_repository/ptasks_repository.dart';

part 'event.dart';
part 'state.dart';

/// {@template PTaskCreationBloc}
///
/// A [Bloc] that manages the creation of tasks.
///
/// {@endtemplate}
class PTaskCreationBloc extends Bloc<PTaskCreationEvent, PTaskCreationState> {
  /// {@macro PTaskCreationBloc}
  PTaskCreationBloc({
    required this.tasksRepository,
  }) : super(PTaskCreationInitial()) {
    on<PTaskCreationTriggered>(_onTriggered, transformer: droppable());
    on<_PTaskCreationCompleted>(_onCompleted);
  }

  /// The repository for interacting with tasks.
  final PTasksRepository tasksRepository;

  Future<void> _onTriggered(
    PTaskCreationTriggered event,
    Emitter<PTaskCreationState> emit,
  ) async {
    emit(PTaskCreationInProgress());

    final result = await tasksRepository.createTask(
      instruction: event.instruction,
    );

    add(_PTaskCreationCompleted(result: result));
  }

  void _onCompleted(
    _PTaskCreationCompleted event,
    Emitter<PTaskCreationState> emit,
  ) {
    emit(
      event.result.fold(
        (exception) => PTaskCreationFailure(exception: exception),
        (task) => PTaskCreationSuccess(task: task),
      ),
    );
  }
}
