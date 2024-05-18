import 'package:flutter/material.dart';
import 'package:ppub/flutter_bloc.dart';
import 'package:ppub_dev/bloc_test.dart';
import 'package:ppub_dev/flutter_test.dart';
import 'package:ppub_dev/mocktail.dart';
import 'package:ppub_dev/test_beautifier.dart';
import 'package:ptasks_repository/ptasks_repository.dart';
import 'package:purrfect/pages/home/bloc/_bloc.dart';
import 'package:purrfect/pages/home/dialogs/_dialogs.dart';

import '../../../mock_app.dart';

class MockPTaskEditBloc extends MockBloc<PTaskEditEvent, PTaskEditState>
    implements PTaskEditBloc {}

void main() {
  group('PEditTaskDialog tests', () {
    late MockPTaskEditBloc mockTaskEditBloc;

    const fakeTask = PTask(id: 3, instruction: 'sdasd', isCompleted: false);

    Widget buildDialog() {
      return MockPApp(
        blocProviders: [
          BlocProvider<PTaskEditBloc>(
            create: (context) => mockTaskEditBloc,
          ),
        ],
        child: PEditTaskDialog(
          bloc: mockTaskEditBloc,
          task: fakeTask,
        ),
      );
    }

    setUpAll(() {
      registerFallbackValue(
        PTaskEditTriggered(
          taskID: fakeTask.id,
          instruction: fakeTask.instruction,
        ),
      );
    });

    setUp(() {
      mockTaskEditBloc = MockPTaskEditBloc();
      when(() => mockTaskEditBloc.state).thenReturn(PTaskEditInitial());
    });

    testWidgets(
      requirement(
        Given: 'Edit task dialog',
        When: 'Submit button is pressed',
        Then: 'Task edit event is dispatched and dialog is closed',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(buildDialog());

        await tester.tap(find.byKey(const Key('editTaskDialog_submit_button')));
        await tester.pumpAndSettle();

        verify(() => mockTaskEditBloc.add(any())).called(1);
        expect(find.byType(PEditTaskDialog), findsNothing);
      }),
    );

    testWidgets(
      requirement(
        Given: 'Edit task dialog',
        When: 'Cancel button is pressed',
        Then: 'Dialog is closed',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(buildDialog());

        await tester.tap(find.byKey(const Key('editTaskDialog_cancel_button')));
        await tester.pumpAndSettle();

        expect(find.byType(PEditTaskDialog), findsNothing);
      }),
    );
  });
}
