import 'package:flutter/widgets.dart';
import 'package:purrfect/localization/generated/localizations.g.dart';

export 'generated/localizations.g.dart';

/// {@template PAppL10nExtension}
///
/// Provides access to this widget tree's [PAppL10n] instance.
///
/// {@endtemplate}
extension PAppL10nExtension on BuildContext {
  /// {@macro PAppL10nExtension}
  PAppL10n get pAppL10n => PAppL10n.of(this);
}
