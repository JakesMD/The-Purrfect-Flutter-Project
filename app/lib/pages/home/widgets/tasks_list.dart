import 'package:flutter/material.dart';
import 'package:ptasks_repository/ptasks_repository.dart';
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
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return PTaskItem(
          task: PTask(
            id: BigInt.from(index),
            instruction: 'Task $index',
            isCompleted: false,
          ),
          onPressed: onTaskPressed,
        );
      },
    );
  }
}
