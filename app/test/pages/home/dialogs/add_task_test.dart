import 'package:flutter/material.dart';
import 'package:ppub/flutter_bloc.dart';
import 'package:ppub_dev/bloc_test.dart';
import 'package:ppub_dev/flutter_test.dart';
import 'package:ppub_dev/mocktail.dart';
import 'package:ppub_dev/test_beautifier.dart';
import 'package:purrfect/pages/home/bloc/_bloc.dart';
import 'package:purrfect/pages/home/dialogs/_dialogs.dart';

import '../../../mock_app.dart';

class MockPTaskCreationBloc
    extends MockBloc<PTaskCreationEvent, PTaskCreationState>
    implements PTaskCreationBloc {}

void main() {
  group('PAddTaskDialog tests', () {
    late MockPTaskCreationBloc mockTaskCreationBloc;

    Widget buildDialog() {
      return MockPApp(
        blocProviders: [
          BlocProvider<PTaskCreationBloc>(
            create: (context) => mockTaskCreationBloc,
          ),
        ],
        child: PAddTaskDialog(bloc: mockTaskCreationBloc),
      );
    }

    setUpAll(() {
      registerFallbackValue(PTaskCreationTriggered(instruction: ''));
    });

    setUp(() {
      mockTaskCreationBloc = MockPTaskCreationBloc();
      when(() => mockTaskCreationBloc.state).thenReturn(PTaskCreationInitial());
    });

    testWidgets(
      requirement(
        Given: 'Add task dialog',
        When: 'Text is entered and submit button is pressed',
        Then: 'Task creation event is dispatched and dialog is closed',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(buildDialog());

        await tester.enterText(find.byType(TextFormField), 'hi');
        await tester.tap(find.byKey(const Key('addTaskDialog_ok_button')));
        await tester.pumpAndSettle();

        verify(() => mockTaskCreationBloc.add(any())).called(1);
        expect(find.byType(PAddTaskDialog), findsNothing);
      }),
    );

    testWidgets(
      requirement(
        Given: 'Add task dialog',
        When: 'No text is entered but submit button is pressed',
        Then: 'Task creation event is not dispatched',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(buildDialog());

        await tester.tap(find.byKey(const Key('addTaskDialog_ok_button')));

        verifyNever(() => mockTaskCreationBloc.add(any()));
      }),
    );

    testWidgets(
      requirement(
        Given: 'Add task dialog',
        When: 'Cancel button is pressed',
        Then: 'Dialog is closed',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(buildDialog());

        await tester.tap(find.byKey(const Key('addTaskDialog_cancel_button')));
        await tester.pumpAndSettle();

        expect(find.byType(PAddTaskDialog), findsNothing);
      }),
    );
  });
}
