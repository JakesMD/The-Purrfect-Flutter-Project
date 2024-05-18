import 'package:flutter/material.dart';
import 'package:pdatabase_client/pdatabase_client.dart';
import 'package:ppub/auto_route.dart';
import 'package:ppub/flutter_bloc.dart';
import 'package:ptasks_repository/ptasks_repository.dart';
import 'package:purrfect/pages/home/bloc/_bloc.dart';
import 'package:purrfect/pages/home/dialogs/_dialogs.dart';
import 'package:purrfect/pages/home/widgets/_widgets.dart';
import 'package:purrfect/shared/widgets/_widgets.dart';

/// {@template PHomePage}
///
/// The home page for the Purrfect app.
///
/// This page is the first page that the user sees when they open the app. It
/// contains the list of tasks the user can complete.
///
/// {@endtemplate}
@RoutePage()
class PHomePage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro PHomePage}
  const PHomePage({super.key});

  void _onTaskPressed(BuildContext context, PTask task) {
    showDialog(
      context: context,
      builder: (_) => PEditTaskDialog(
        bloc: context.read<PTaskEditBloc>(),
        task: task,
      ),
    );
  }

  void _onAddTaskPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => PAddTaskDialog(
        bloc: context.read<PTaskCreationBloc>(),
      ),
    );
  }

  // coverage:ignore-start
  @override
  Widget wrappedRoute(BuildContext context) {
    return PMultiClientProvider(
      providers: [
        PClientProvider(
          create: (context) => PDatabaseClient(
            database: PDatabase(),
          ),
        ),
      ],
      child: RepositoryProvider(
        create: (context) => PTasksRepository(
          databaseClient: context.read<PDatabaseClient>(),
        ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => PTasksStreamBloc(
                tasksRepository:
                    RepositoryProvider.of<PTasksRepository>(context),
              ),
            ),
            BlocProvider(
              create: (context) => PTaskCreationBloc(
                tasksRepository:
                    RepositoryProvider.of<PTasksRepository>(context),
              ),
            ),
            BlocProvider(
              create: (context) => PTaskEditBloc(
                tasksRepository:
                    RepositoryProvider.of<PTasksRepository>(context),
              ),
            ),
            BlocProvider(
              create: (context) => PTaskDeletionBloc(
                tasksRepository:
                    RepositoryProvider.of<PTasksRepository>(context),
              ),
            ),
            BlocProvider(
              create: (context) => PTaskStatusUpdateBloc(
                tasksRepository:
                    RepositoryProvider.of<PTasksRepository>(context),
              ),
            ),
          ],
          child: this,
        ),
      ),
    );
  }
  // coverage:ignore-end

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
      appBar: const PHomeAppBar(),
      body: MultiBlocListener(
        listeners: [
          BlocListener<PTasksStreamBloc, PTasksStreamState>(
            listener: (context, state) => const PErrorSnackBar().show(context),
            listenWhen: (_, state) => state is PTasksStreamFailure,
          ),
          BlocListener<PTaskCreationBloc, PTaskCreationState>(
            listener: (context, state) => const PErrorSnackBar().show(context),
            listenWhen: (_, state) => state is PTaskCreationFailure,
          ),
          BlocListener<PTaskEditBloc, PTaskEditState>(
            listener: (context, state) => const PErrorSnackBar().show(context),
            listenWhen: (_, state) => state is PTaskEditFailure,
          ),
          BlocListener<PTaskDeletionBloc, PTaskDeletionState>(
            listener: (context, state) => const PErrorSnackBar().show(context),
            listenWhen: (_, state) => state is PTaskDeletionFailure,
          ),
          BlocListener<PTaskStatusUpdateBloc, PTaskStatusUpdateState>(
            listener: (context, state) => const PErrorSnackBar().show(context),
            listenWhen: (_, state) => state is PTaskStatusUpdateFailure,
          ),
        ],
        child: Stack(
          children: [
            Positioned.fill(child: PConfetti()),
            PTasksList(onTaskPressed: onTaskPressed),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddTaskPressed,
        child: const Icon(Icons.add),
      ),
    );
  }
}
