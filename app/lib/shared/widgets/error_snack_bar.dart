// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:purrfect/localization/l10n.dart';

/// {@template PErrorSnackBar}
///
/// A snack bar that shows an error message.
///
/// {@endtemplate}
class PErrorSnackBar {
  /// {@macro PErrorSnackBar}
  const PErrorSnackBar({this.message});

  /// The error message to display.
  ///
  /// If null, the default message will be shown.
  final String? message;

  /// Shows the snack bar.
  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(_build(context));
  }

  SnackBar _build(BuildContext context) {
    return SnackBar(
      backgroundColor: Theme.of(context).colorScheme.error,
      content: Text(
        message ?? context.pAppL10n.snackBar_error_defaultMessage,
        style: TextStyle(color: Theme.of(context).colorScheme.onError),
      ),
    );
  }
}
