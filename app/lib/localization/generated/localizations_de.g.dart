import 'localizations.g.dart';

/// The translations for German (`de`).
class PAppL10nDe extends PAppL10n {
  PAppL10nDe([String locale = 'de']) : super(locale);

  @override
  String get stagingBanner_message => 'Sie nutzen die Vorabversion.';

  @override
  String get stagingBanner_button => 'Zur Endversion';

  @override
  String get snackBar_error_defaultMessage => 'Hoppla! Etwas ist schiefgelaufen. Bitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.';

  @override
  String get ok => 'Ok';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get close => 'Schließen';

  @override
  String get save => 'Speichern';

  @override
  String get delete => 'Löschen';

  @override
  String get homePage_addTaskDialog_title => 'Aufgabe hinzufügen';

  @override
  String get homePage_addTaskDialog_hint_instruction => 'Anweisung';

  @override
  String get homePage_editTaskDialog_title => 'Aufgabe bearbeiten';

  @override
  String get homePage_editTaskDialog_hint_instruction => 'Anweisung';
}
