import 'dart:async';

import 'package:ppub/bloc.dart';
import 'package:ppub/bloc_concurrency.dart';
import 'package:ppub/dartz.dart';
import 'package:ppub/equatable.dart';
import 'package:ptasks_repository/ptasks_repository.dart';

part 'event.dart';
part 'state.dart';

/// {@template PTasksStreamBloc}
///
/// A [Bloc] that manages the streaming of tasks.
///
/// {@endtemplate}
class PTasksStreamBloc extends Bloc<PTasksStreamEvent, PTasksStreamState> {
  /// {@macro PTasksStreamBloc}
  PTasksStreamBloc({
    required this.tasksRepository,
  }) : super(PTasksStreamInitial()) {
    on<_PTasksStreamUpdated>(_onTasksStreamUpdate, transformer: droppable());
    on<_PTasksStreamStarted>(_onStarted);
    add(_PTasksStreamStarted());
  }

  /// The repository for interacting with tasks.
  final PTasksRepository tasksRepository;

  late final StreamSubscription<Either<PTasksStreamException, List<PTask>>>
      _tasksSubscription;

  void _onStarted(
    _PTasksStreamStarted event,
    Emitter<PTasksStreamState> emit,
  ) {
    emit(PTasksStreamLoading());

    _tasksSubscription = tasksRepository.tasksStream().listen((result) {
      add(_PTasksStreamUpdated(result: result));
    });
  }

  void _onTasksStreamUpdate(
    _PTasksStreamUpdated event,
    Emitter<PTasksStreamState> emit,
  ) {
    emit(
      event.result.fold(
        (exception) => PTasksStreamFailure(exception: exception),
        (tasks) => PTasksStreamSuccess(tasks: tasks),
      ),
    );
  }

  @override
  Future<void> close() {
    _tasksSubscription.cancel();
    return super.close();
  }
}
