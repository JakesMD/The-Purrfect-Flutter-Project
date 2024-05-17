import 'package:flutter/material.dart';
import 'package:purrfect/pages/home/bloc/_bloc.dart';
import 'package:purrfect/shared/widgets/_widgets.dart';

/// {@template PHomeAppBar}
///
/// The app bar for the home page.
///
/// This app bar is displayed at the top of the home page and displays the app
/// title. It also displays a loading indicator when the tasks are loading or
/// being created or edited.
///
/// {@endtemplate}
class PHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// {@macro PHomeAppBar}
  const PHomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Purrfect'),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      bottom: PAppBarLoadingIndicator(
        listeners: [
          PLoadingListener<PTasksStreamBloc, PTasksStreamState>(
            isLoading: (state) => state is PTasksStreamInitial,
          ),
          PLoadingListener<PTaskCreationBloc, PTaskCreationState>(
            isLoading: (state) => state is PTaskCreationInitial,
          ),
        ],
      ),
    );
  }
}
