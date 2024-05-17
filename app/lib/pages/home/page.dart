import 'package:flutter/material.dart';
import 'package:ppub/auto_route.dart';
import 'package:ptasks_repository/ptasks_repository.dart';
import 'package:purrfect/pages/home/dialogs/_dialogs.dart';
import 'package:purrfect/pages/home/widgets/_widgets.dart';

/// {@template PHomePage}
///
/// The home page for the Purrfect app.
///
/// This page is the first page that the user sees when they open the app. It
/// contains the list of tasks the user can complete.
///
/// {@endtemplate}
@RoutePage()
class PHomePage extends StatelessWidget {
  /// {@macro PHomePage}
  const PHomePage({super.key});

  void _onTaskPressed(BuildContext context, PTask task) {
    showDialog(
      context: context,
      builder: (context) => PEditTaskDialog(task: task),
    );
  }

  void _onAddTaskPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PAddTaskDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PHomeView(
      onTaskPressed: (task) => _onTaskPressed(context, task),
      onAddTaskPressed: () => _onAddTaskPressed(context),
    );
  }
}

/// {@template PHomeView}
///
/// The view for the home page.
///
/// This widget is responsible for displaying the home page.
///
/// {@endtemplate}
class PHomeView extends StatelessWidget {
  /// {@macro PHomeView}
  const PHomeView({
    required this.onTaskPressed,
    required this.onAddTaskPressed,
    super.key,
  });

  /// The callback to call when a task is tapped.
  /// This will allow the user to edit the task.
  final void Function(PTask task) onTaskPressed;

  /// The callback to call when the add task button is pressed.
  /// This will allow the user to add a new task.
  final void Function() onAddTaskPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purrfect'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned.fill(child: PConfetti()),
          PTasksList(onTaskPressed: onTaskPressed),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddTaskPressed,
        child: const Icon(Icons.add),
      ),
    );
  }
}
