import 'package:flutter/material.dart';
import 'package:pcore/pcore.dart';
import 'package:purrfect/localization/l10n.dart';
import 'package:purrfect/pages/home/bloc/_bloc.dart';

/// {@template PAddTaskDialog}
///
/// Shows a dialog for creating a task.
///
/// The dialog contains a form with validation for entering a valid
/// instruction. On submission, it dispatches an event to create the task.
///
/// {@endtemplate}
class PAddTaskDialog extends StatelessWidget {
  /// {@macro PAddTaskDialog}
  PAddTaskDialog({
    required this.bloc,
    super.key,
  });

  /// The bloc that handles creation the task.
  /// Used to dispatch the task creation event.
  final PTaskCreationBloc bloc;

  final _formKey = GlobalKey<FormFieldState<String>>();
  final _input = PTextInput();

  void _onSubmitted(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      bloc.add(PTaskCreationTriggered(instruction: _input.value(context)));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.pAppL10n.homePage_addTaskDialog_title),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: IntrinsicHeight(
          child: TextFormField(
            key: _formKey,
            validator: (value) => _input.validator(
              input: value,
              context: context,
            ),
            onChanged: _input.onChanged,
            keyboardType: TextInputType.text,
            expands: true,
            maxLines: null,
            decoration: InputDecoration(
              labelText:
                  context.pAppL10n.homePage_addTaskDialog_hint_instruction,
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          key: const Key('addTaskDialog_cancel_button'),
          onPressed: () => Navigator.pop(context),
          child: Text(context.pAppL10n.cancel),
        ),
        TextButton(
          key: const Key('addTaskDialog_ok_button'),
          onPressed: () => _onSubmitted(context),
          child: Text(context.pAppL10n.ok),
        ),
      ],
    );
  }
}
