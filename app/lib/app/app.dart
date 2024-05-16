import 'package:flutter/material.dart';
import 'package:purrfect/app/app_flavor.dart';

export 'app_flavor.dart';

/// {@template PurrfectApp}
///
/// The main app widget.
///
/// This widget is responsible for setting up the app theme and routes.
///
/// {@endtemplate}
class PurrfectApp extends StatelessWidget {
  /// {@macro PurrfectApp}
  const PurrfectApp({required this.flavor, super.key});

  /// The flavor of the app.
  final BAppFlavor flavor;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Purrfect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Container(),
    );
  }
}
