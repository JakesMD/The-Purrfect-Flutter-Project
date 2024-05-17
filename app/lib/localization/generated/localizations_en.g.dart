import 'localizations.g.dart';

/// The translations for English (`en`).
class PAppL10nEn extends PAppL10n {
  PAppL10nEn([String locale = 'en']) : super(locale);

  @override
  String get stagingBanner_message => 'You\'re using the staging version.';

  @override
  String get stagingBanner_button => 'Release version';

  @override
  String get snackBar_error_defaultMessage => 'Oops! Something went wrong. Please check your internet connection and try again.';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get homePage_addTaskDialog_title => 'Add a task';

  @override
  String get homePage_addTaskDialog_hint_instruction => 'Instruction';

  @override
  String get homePage_editTaskDialog_title => 'Edit task';

  @override
  String get homePage_editTaskDialog_hint_instruction => 'Instruction';
}
