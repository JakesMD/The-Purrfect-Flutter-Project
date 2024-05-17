import 'package:flutter/material.dart';
import 'package:ptasks_repository/ptasks_repository.dart';

/// {@template PTaskItem}
///
/// A widget that displays a task. I contains the task's instruction and a
/// checkbox to mark the task as completed.
///
/// Tapping the task will allow the user to edit the task.
/// Swiping the widget to the left will delete the task.
///
/// {@endtemplate}
class PTaskItem extends StatelessWidget {
  /// {@macro PTaskItem}
  PTaskItem({
    required this.task,
    required this.onPressed,
  }) : super(key: ValueKey(task.id));

  /// The task to display.
  final PTask task;

  /// The callback to call when the task is tapped.
  /// This will allow the user to edit the task.
  final void Function(PTask task) onPressed;

  void _onCheckboxChanged(BuildContext context, bool? value) {}

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(task.id),
      background: Container(
        color: Theme.of(context).colorScheme.errorContainer,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
            Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
          ],
        ),
      ),
      child: ListTile(
        title: Text(task.instruction),
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (value) => _onCheckboxChanged(context, value),
        ),
        onTap: () => onPressed(task),
      ),
    );
  }
}
