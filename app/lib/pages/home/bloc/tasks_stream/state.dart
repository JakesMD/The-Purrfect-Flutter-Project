part of 'bloc.dart';

/// Defines the different states for the PTasksStreamBloc.
sealed class PTasksStreamState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

/// Indicates the tasks stream has not yet been loaded.
final class PTasksStreamInitial extends PTasksStreamState {}

/// Indicates the tasks stream is loading.
final class PTasksStreamLoading extends PTasksStreamState {}

/// {@template PTasksStreamSuccess}
///
/// Indicates the tasks have been successfully streamed. Contains the tasks.
///
/// {@endtemplate}
final class PTasksStreamSuccess extends PTasksStreamState {
  /// {@macro PTasksStreamSuccess}
  PTasksStreamSuccess({required this.tasks});

  /// The tasks that were streamed.
  final List<PTask> tasks;

  @override
  List<Object?> get props => [tasks];
}

/// {@template PTasksStreamFailure}
///
/// Indicates a failure occurred while streaming tasks. Contains the failure
/// exception.
///
/// {@endtemplate}
final class PTasksStreamFailure extends PTasksStreamState {
  /// {@macro PTasksStreamFailure}
  PTasksStreamFailure({required this.exception});

  /// The exception that occurred.
  final PTasksStreamException exception;

  @override
  List<Object?> get props => [exception];
}
