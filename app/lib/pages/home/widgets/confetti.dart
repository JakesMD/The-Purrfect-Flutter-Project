import 'package:flutter/material.dart';
import 'package:ppub/confetti.dart';
import 'package:ppub/flutter_bloc.dart';
import 'package:purrfect/pages/home/bloc/_bloc.dart';
import 'package:purrfect/shared/widgets/_widgets.dart';

/// {@template PConfetti}
///
/// A widget that displays confetti when a task is completed.
///
/// {@endtemplate}
class PConfetti extends PSemiStatefulWidget {
  /// {@macro PConfetti}
  PConfetti({super.key});

  /// The confetti controller.
  final controller = ConfettiController(duration: const Duration(seconds: 1));

  void _onSuccess(BuildContext context, PTaskStatusUpdateState state) {
    if ((state as PTaskStatusUpdateSuccess).isCompleted) controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: BlocListener<PTaskStatusUpdateBloc, PTaskStatusUpdateState>(
        listener: _onSuccess,
        listenWhen: (_, state) => state is PTaskStatusUpdateSuccess,
        child: ConfettiWidget(
          confettiController: controller,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 15,
          colors: const [
            Colors.green,
            Colors.blue,
            Colors.pink,
            Colors.orange,
            Colors.purple,
          ],
        ),
      ),
    );
  }

  @override
  void onDispose() {
    controller.dispose();
    super.onDispose();
  }
}
