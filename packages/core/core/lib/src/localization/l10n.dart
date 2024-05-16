import 'package:flutter/widgets.dart';
import 'package:pcore/pcore.dart';
import 'package:ppub/intl.dart';

export 'generated/localizations.g.dart';

/// {@template PCoreL10nExtension}
///
/// Provides access to this widget tree's [PCoreL10n] instance.
///
/// {@endtemplate}
extension PCoreL10nExtension on BuildContext {
  /// {@macro PCoreL10nExtension}
  PCoreL10n get pCoreL10n => PCoreL10n.of(this);
}

/// The different ways of formatting dates in a localized string.
enum PDateFormat {
  /// 02/10/2024
  yearMonthNumDayNum,

  /// Feburary 2024
  yearMonth,
}

/// {@template PL10nDateExtension}
///
/// Formats the [DateTime] into a localized string with date and time
/// information for the current [BuildContext]'s locale.
///
/// {@endtemplate}
extension PL10nDateExtension on DateTime {
  /// {@macro PL10nDateExtension}
  String pLocalize(
    BuildContext context, {
    PDateFormat dateFormat = PDateFormat.yearMonthNumDayNum,
  }) {
    final pattern = switch (dateFormat) {
      PDateFormat.yearMonthNumDayNum => 'yMd',
      PDateFormat.yearMonth => 'yMMMM',
    };

    return DateFormat(
      pattern,
      Localizations.localeOf(context).toLanguageTag(),
    ).format(this);
  }
}

/// {@template PL10nNumExtension}
///
/// Formats the [num] into a localized string using the decimal pattern
/// for the current [BuildContext]'s locale.
///
/// {@endtemplate}
extension PL10nNumExtension on num {
  /// {@macro PL10nNumExtension}
  String pLocalize(BuildContext context, {int? decimalDigits}) {
    return NumberFormat.decimalPatternDigits(
      locale: Localizations.localeOf(context).toLanguageTag(),
      decimalDigits: decimalDigits,
    ).format(this);
  }
}

/// {@template PL10nStringExtension}
///
/// Returns the number represented by this string localized to the given
/// [BuildContext]'s locale, or null if the string does not contain a valid
/// number.
///
/// {@endtemplate}
extension PL10nStringExtension on String {
  /// {@macro PL10nStringExtension}
  num? pToLocalizedNum(BuildContext context) {
    try {
      return NumberFormat.decimalPattern(
        Localizations.localeOf(context).toLanguageTag(),
      ).parse(this);
    } on FormatException catch (_) {
      return null;
    }
  }
}
