import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations_de.g.dart';
import 'localizations_en.g.dart';

/// Callers can lookup localized strings with an instance of PAppL10n
/// returned by `PAppL10n.of(context)`.
///
/// Applications need to include `PAppL10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/localizations.g.dart';
///
/// return MaterialApp(
///   localizationsDelegates: PAppL10n.localizationsDelegates,
///   supportedLocales: PAppL10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the PAppL10n.supportedLocales
/// property.
abstract class PAppL10n {
  PAppL10n(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static PAppL10n of(BuildContext context) {
    return Localizations.of<PAppL10n>(context, PAppL10n)!;
  }

  static const LocalizationsDelegate<PAppL10n> delegate = _PAppL10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @stagingBanner_message.
  ///
  /// In de, this message translates to:
  /// **'Sie nutzen die Vorabversion.'**
  String get stagingBanner_message;

  /// No description provided for @stagingBanner_button.
  ///
  /// In de, this message translates to:
  /// **'Zur Endversion'**
  String get stagingBanner_button;

  /// No description provided for @snackBar_error_defaultMessage.
  ///
  /// In de, this message translates to:
  /// **'Hoppla! Etwas ist schiefgelaufen. Bitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.'**
  String get snackBar_error_defaultMessage;

  /// No description provided for @ok.
  ///
  /// In de, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In de, this message translates to:
  /// **'Schließen'**
  String get close;

  /// No description provided for @save.
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get delete;

  /// No description provided for @homePage_addTaskDialog_title.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe hinzufügen'**
  String get homePage_addTaskDialog_title;

  /// No description provided for @homePage_addTaskDialog_hint_instruction.
  ///
  /// In de, this message translates to:
  /// **'Anweisung'**
  String get homePage_addTaskDialog_hint_instruction;

  /// No description provided for @homePage_editTaskDialog_title.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe bearbeiten'**
  String get homePage_editTaskDialog_title;

  /// No description provided for @homePage_editTaskDialog_hint_instruction.
  ///
  /// In de, this message translates to:
  /// **'Anweisung'**
  String get homePage_editTaskDialog_hint_instruction;
}

class _PAppL10nDelegate extends LocalizationsDelegate<PAppL10n> {
  const _PAppL10nDelegate();

  @override
  Future<PAppL10n> load(Locale locale) {
    return SynchronousFuture<PAppL10n>(lookupPAppL10n(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_PAppL10nDelegate old) => false;
}

PAppL10n lookupPAppL10n(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return PAppL10nDe();
    case 'en': return PAppL10nEn();
  }

  throw FlutterError(
    'PAppL10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
