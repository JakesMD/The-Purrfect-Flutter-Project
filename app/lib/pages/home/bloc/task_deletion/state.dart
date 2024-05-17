part of 'bloc.dart';

/// Defines the different states for the PTaskDeletionBloc.
sealed class PTaskDeletionState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

/// Indicates a deletion has not been triggered.
final class PTaskDeletionInitial extends PTaskDeletionState {}

/// Indicates a task deletion is in progress.
final class PTaskDeletionInProgress extends PTaskDeletionState {}

/// Indicates the task was deleted successfully.

final class PTaskDeletionSuccess extends PTaskDeletionState {}

/// {@template PTaskDeletionFailure}
///
/// Indicates the task was not deleted successfully. Contains the exception.
///
/// {@endtemplate}
final class PTaskDeletionFailure extends PTaskDeletionState {
  /// {@macro PTaskDeletionFailure}
  PTaskDeletionFailure({required this.exception});

  /// The exception that occurred.
  final PTaskDeletionException exception;

  @override
  List<Object?> get props => [exception];
}
