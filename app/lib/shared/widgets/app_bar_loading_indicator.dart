import 'package:flutter/material.dart';
import 'package:ppub/flutter_bloc.dart';

/// {@template PAppBarLoadingIndicator}
///
/// Displays a loading indicator below the app bar.
///
/// This indicator will be visible when any of the given listeners are loading.
///
/// {@endtemplate}
class PAppBarLoadingIndicator extends StatefulWidget
    implements PreferredSizeWidget {
  /// {@macro PAppBarLoadingIndicator}
  const PAppBarLoadingIndicator({
    required this.listeners,
    super.key,
  });

  /// The list of loading listeners.
  // ignore: strict_raw_type
  final List<PLoadingListener> listeners;

  @override
  Size get preferredSize => const Size.fromHeight(4);

  @override
  State<PAppBarLoadingIndicator> createState() =>
      _PAppBarLoadingIndicatorState();
}

class _PAppBarLoadingIndicatorState extends State<PAppBarLoadingIndicator> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        for (final listener in widget.listeners)
          listener.buildListener(
            (isLoading) => setState(() => this.isLoading = isLoading),
          ),
      ],
      child: Visibility(
        visible: isLoading,
        child: const LinearProgressIndicator(minHeight: 4),
      ),
    );
  }
}

/// {@template PLoadingListener}
///
/// A listener for loading states for the [PAppBarLoadingIndicator].
///
/// When the given state is loading, the [PAppBarLoadingIndicator] will be
/// visible.
///
/// {@endtemplate}
class PLoadingListener<B extends StateStreamable<S>, S> {
  /// {@macro PLoadingListener}
  PLoadingListener({required this.isLoading});

  /// Whether the given state is the loading state.
  final bool Function(S state) isLoading;

  /// Builds the bloc listener for the [PAppBarLoadingIndicator].
  BlocListener<B, S> buildListener(
    // ignore: avoid_positional_boolean_parameters
    void Function(bool isLoading) toggleLoading,
  ) {
    return BlocListener<B, S>(
      listener: (context, state) => toggleLoading(isLoading(state)),
    );
  }
}
