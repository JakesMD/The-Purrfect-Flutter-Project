import 'package:flutter/material.dart';
import 'package:pcore/pcore.dart';
import 'package:purrfect/app/app_flavor.dart';
import 'package:purrfect/app/router.dart';
import 'package:purrfect/localization/l10n.dart';
import 'package:purrfect/shared/widgets/_widgets.dart';

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
  PurrfectApp({required this.flavor, super.key});

  /// The flavor of the app.
  final PAppFlavor flavor;

  final _router = PAppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Purrfect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        PCoreL10n.delegate,
        PAppL10n.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: PCoreL10n.supportedLocales,
      routerConfig: _router.config(),
      builder: (context, child) => Column(
        children: [
          PStagingBanner(appFlavor: flavor),
          if (child != null) Expanded(child: child),
        ],
      ),
    );
  }
}
