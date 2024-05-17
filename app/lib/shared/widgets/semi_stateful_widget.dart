import 'package:flutter/material.dart';
import 'package:ppub/meta.dart';

/// {@template PSemiStatefulWidget}
///
/// A semi-stateful widget that provides lifecycle methods.
///
/// Extend this class to create a widget that requires lifecycle methods.
///
/// {@endtemplate}
class PSemiStatefulWidget extends StatefulWidget {
  /// {@macro PSemiStatefulWidget}
  const PSemiStatefulWidget({super.key});

  /// Called when the widget is initialized.
  @mustCallSuper
  void onInit() {}

  /// Called when the widget is disposed.
  @mustCallSuper
  void onDispose() {}

  /// Builds the widget.
  @mustBeOverridden
  Widget build(BuildContext context) => const Placeholder();

  @override
  State<PSemiStatefulWidget> createState() => _PSemiStatefulWidgetState();
}

class _PSemiStatefulWidgetState extends State<PSemiStatefulWidget> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.build(context);

  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
  }
}
