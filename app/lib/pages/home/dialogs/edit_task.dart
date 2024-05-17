import 'package:flutter/material.dart';
import 'package:pcore/pcore.dart';
import 'package:ptasks_repository/ptasks_repository.dart';
import 'package:purrfect/localization/l10n.dart';

/// {@template PEditTaskDialog}
///
/// Shows a dialog for editing a task.
///
/// The dialog contains a form with validation for entering a valid
/// instruction. On submission, it dispatches an event to edit the task.
///
/// {@endtemplate}
class PEditTaskDialog extends StatelessWidget {
  /// {@macro PEditTaskDialog}
  PEditTaskDialog({
    required this.task,
    //required this.bloc,

    super.key,
  });

  /// The task to edit.
  final PTask task;

  /// The bloc that handles update the task.
  /// Used to dispatch the task update event.
  //final PTaskUpdateBloc bloc;

  final _formKey = GlobalKey<FormFieldState<String>>();
  final _input = PTextInput();

  void _onSubmitted(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.pAppL10n.homePage_editTaskDialog_title),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: IntrinsicHeight(
          child: TextFormField(
            key: _formKey,
            initialValue: task.instruction,
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
                  context.pAppL10n.homePage_editTaskDialog_hint_instruction,
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.pAppL10n.cancel),
        ),
        TextButton(
          onPressed: () => _onSubmitted(context),
          child: Text(context.pAppL10n.ok),
        ),
      ],
    );
  }
}
