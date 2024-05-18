part of 'bloc.dart';

/// Defines the different states for the PTaskStatusUpdateBloc.
sealed class PTaskStatusUpdateState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

/// Indicates the task update has not yet been triggered.
final class PTaskStatusUpdateInitial extends PTaskStatusUpdateState {}

/// Indicates a task update is in progress.
final class PTaskStatusUpdateInProgress extends PTaskStatusUpdateState {}

/// {@template PTaskStatusUpdateSuccess}
///
/// Indicates the task was updated successfully.
///
/// {@endtemplate}

final class PTaskStatusUpdateSuccess extends PTaskStatusUpdateState {
  /// {@macro PTaskStatusUpdateSuccess}
  PTaskStatusUpdateSuccess({required this.isCompleted});

  /// The new status of the task.
  final bool isCompleted;

  @override
  List<Object?> get props => [isCompleted];
}

/// {@template PTaskStatusUpdateFailure}
///
/// Indicates the task was not updated successfully. Contains the exception.
///
/// {@endtemplate}
final class PTaskStatusUpdateFailure extends PTaskStatusUpdateState {
  /// {@macro PTaskStatusUpdateFailure}
  PTaskStatusUpdateFailure({required this.exception});

  /// The exception that occurred.
  final PTaskUpdateException exception;

  @override
  List<Object?> get props => [exception];
}
