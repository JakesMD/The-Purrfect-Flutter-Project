import 'package:flutter/widgets.dart';
import 'package:pcore/pcore.dart';

/// Validates that the input string can be parsed as text.
final class PTextInput extends PFormInput<String> {
  @override
  String parse({required String input, required BuildContext context}) {
    return input.trim();
  }

  @override
  String? validator({required String? input, required BuildContext context}) {
    onChanged(input);
    final text = input?.trim();

    if (text == null || text.isEmpty) {
      return context.pCoreL10n.inputError_text_empty;
    }
    return null;
  }
}
