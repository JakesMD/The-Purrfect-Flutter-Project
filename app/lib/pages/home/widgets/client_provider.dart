// coverage:ignore-file

import 'package:ppub/flutter_bloc.dart';

/// {@template PClientProvider}
///
/// An extension of the [RepositoryProvider] for clients.
///
/// {@endtemplate}
class PClientProvider<T> extends RepositoryProvider<T> {
  /// {@macro PClientProvider}
  PClientProvider({
    required super.create,
    super.key,
    super.child,
    super.lazy,
  });
}

/// {@template PMultiClientProvider}
///
/// An extension of the [MultiRepositoryProvider] for clients.
///
/// {@endtemplate}
class PMultiClientProvider extends MultiRepositoryProvider {
  /// {@macro PMultiClientProvider}
  PMultiClientProvider({
    required super.providers,
    required super.child,
    super.key,
  });
}
