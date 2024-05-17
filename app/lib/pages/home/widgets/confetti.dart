import 'package:flutter/material.dart';
import 'package:ppub/confetti.dart';
import 'package:purrfect/shared/widgets/_widgets.dart';

/// {@template PConfetti}
///
/// A widget that displays confetti when a task is completed.
///
/// {@endtemplate}
class PConfetti extends PSemiStatefulWidget {
  /// {@macro PConfetti}
  PConfetti({super.key});

  final _controller = ConfettiController(
    duration: const Duration(seconds: 5),
  );

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: _controller,
      blastDirectionality: BlastDirectionality.explosive,
      colors: const [
        Colors.green,
        Colors.blue,
        Colors.pink,
        Colors.orange,
        Colors.purple,
      ],
    );
  }

  @override
  void onDispose() {
    _controller.dispose();
    super.onDispose();
  }
}
