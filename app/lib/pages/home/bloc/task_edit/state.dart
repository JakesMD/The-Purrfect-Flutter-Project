part of 'bloc.dart';

/// Defines the different states for the PTaskEditBloc.
sealed class PTaskEditState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

/// Indicates an edit has not been triggered.
final class PTaskEditInitial extends PTaskEditState {}

/// Indicates a task edit is in progress.
final class PTaskEditInProgress extends PTaskEditState {}

/// Indicates the task was edited successfully.

final class PTaskEditSuccess extends PTaskEditState {}

/// {@template PTaskEditFailure}
///
/// Indicates the task was not edited successfully. Contains the exception.
///
/// {@endtemplate}
final class PTaskEditFailure extends PTaskEditState {
  /// {@macro PTaskEditFailure}
  PTaskEditFailure({required this.exception});

  /// The exception that occurred.
  final PTaskUpdateException exception;

  @override
  List<Object?> get props => [exception];
}
