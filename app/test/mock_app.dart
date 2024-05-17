import 'package:flutter/material.dart';
import 'package:pcore/pcore.dart';
import 'package:ppub/flutter_bloc.dart';
import 'package:ppub_dev/mocktail.dart';
import 'package:purrfect/localization/l10n.dart';
import 'package:purrfect/pages/home/widgets/client_provider.dart';

class MockPApp extends StatelessWidget {
  const MockPApp({
    required this.child,
    this.clients = const [],
    this.repositories = const [],
    this.blocProviders = const [],
    super.key,
  });

  final Widget child;

  final List<Mock> clients;

  final List<Mock> repositories;

  final List<BlocProvider> blocProviders;

  Widget buildClients({
    required Widget child,
  }) {
    if (clients.isEmpty) return child;
    return PMultiClientProvider(
      providers: [
        for (final client in clients)
          PClientProvider(create: (context) => client),
      ],
      child: child,
    );
  }

  Widget buildRepositories({
    required Widget child,
  }) {
    if (repositories.isEmpty) return child;
    return MultiRepositoryProvider(
      providers: [
        for (final repo in repositories)
          RepositoryProvider(create: (context) => repo),
      ],
      child: child,
    );
  }

  Widget buildBlocProviders({
    required Widget child,
  }) {
    if (blocProviders.isEmpty) return child;
    return MultiBlocProvider(
      providers: blocProviders,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        PAppL10n.delegate,
        PCoreL10n.delegate,
      ],
      home: buildClients(
        child: buildRepositories(
          child: buildBlocProviders(
            child: child,
          ),
        ),
      ),
    );
  }
}
