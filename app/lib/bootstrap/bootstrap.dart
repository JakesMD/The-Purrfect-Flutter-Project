import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:ppub/bloc.dart';
import 'package:purrfect/bootstrap/mobile_url_strategy.dart'
    if (dart.library.html) 'package:purrfect/bootstrap/web_url_strategy.dart';

/// {@template PAppBlocObserver}
///
/// A the main observer which observes and logs all the bloc instances for the
/// whole app.
///
/// {@endtemplate}
class PAppBlocObserver extends BlocObserver {
  /// {@macro PAppBlocObserver}
  const PAppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

/// Bootstraps the app with the given [builder].
///
/// This function sets up the error handling, bloc observer, and URL strategy.
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    debugPrint(details.toString());
    log(details.toString(), stackTrace: details.stack);
  };

  Bloc.observer = const PAppBlocObserver();

  bConfigureURLStrategy();

  runApp(await builder());
}
