part of 'bloc.dart';

/// Defines the different states for the PTaskCreationBloc.
sealed class PTaskCreationState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

/// Indicates a creation has not been triggered.
final class PTaskCreationInitial extends PTaskCreationState {}

/// Indicates a task creation is in progress.
final class PTaskCreationInProgress extends PTaskCreationState {}

/// {@template PTaskCreationSuccess}
///
/// Indicates the task was created successfully.
///
/// {@endtemplate}
final class PTaskCreationSuccess extends PTaskCreationState {
  /// {@macro PTaskCreationSuccess}
  PTaskCreationSuccess({required this.task});

  /// The tasks that were streamed.
  final PTask task;

  @override
  List<Object?> get props => [task];
}

/// {@template PTaskCreationFailure}
///
/// Indicates the task was not created successfully. Contains the exception.
///
/// {@endtemplate}
final class PTaskCreationFailure extends PTaskCreationState {
  /// {@macro PTaskCreationFailure}
  PTaskCreationFailure({required this.exception});

  /// The exception that occurred.
  final PTaskCreationException exception;

  @override
  List<Object?> get props => [exception];
}
