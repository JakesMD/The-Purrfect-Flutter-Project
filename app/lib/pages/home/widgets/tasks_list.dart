import 'package:flutter/material.dart';
import 'package:ppub/flutter_bloc.dart';
import 'package:ptasks_repository/ptasks_repository.dart';
import 'package:purrfect/pages/home/bloc/tasks_stream/bloc.dart';
import 'package:purrfect/pages/home/widgets/_widgets.dart';

/// {@template PTasksList}
///
/// A widget that displays a list of tasks.
///
/// {@endtemplate}
class PTasksList extends StatelessWidget {
  /// {@macro PTasksList}
  const PTasksList({
    required this.onTaskPressed,
    super.key,
  });

  /// The callback to call when a task is tapped.
  /// This will allow the user to edit the task.
  final void Function(PTask task) onTaskPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PTasksStreamBloc, PTasksStreamState>(
      builder: (context, state) => switch (state) {
        PTasksStreamInitial() => const Align(
            alignment: Alignment.topCenter,
            child: LinearProgressIndicator(),
          ),
        PTasksStreamFailure() => const SizedBox(),
        PTasksStreamSuccess(tasks: final tasks) => ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return PTaskItem(task: tasks[index], onPressed: onTaskPressed);
            },
          ),
      },
    );
  }
}
