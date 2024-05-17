import 'package:flutter/material.dart';
import 'package:pdatabase_client/pdatabase_client.dart';
import 'package:ppub/flutter_bloc.dart';
import 'package:ppub_dev/bloc_test.dart';
import 'package:ppub_dev/flutter_test.dart';
import 'package:ppub_dev/mocktail.dart';
import 'package:ppub_dev/test_beautifier.dart';
import 'package:ptasks_repository/ptasks_repository.dart';
import 'package:purrfect/pages/home/bloc/_bloc.dart';
import 'package:purrfect/pages/home/dialogs/_dialogs.dart';
import 'package:purrfect/pages/home/page.dart';
import 'package:purrfect/pages/home/widgets/_widgets.dart';

import '../../mock_app.dart';

class MockPDatabaseClient extends Mock implements PDatabaseClient {}

class MockPTasksRepository extends Mock implements PTasksRepository {}

class MockPTasksStreamBloc
    extends MockBloc<PTasksStreamEvent, PTasksStreamState>
    implements PTasksStreamBloc {}

class MockPTaskCreationBloc
    extends MockBloc<PTaskCreationEvent, PTaskCreationState>
    implements PTaskCreationBloc {}

class MockPTaskEditBloc extends MockBloc<PTaskEditEvent, PTaskEditState>
    implements PTaskEditBloc {}

class MockPTaskDeletionBloc
    extends MockBloc<PTaskDeletionEvent, PTaskDeletionState>
    implements PTaskDeletionBloc {}

void main() {
  group('PHomePage tests', () {
    late MockPTasksStreamBloc mockTasksStreamBloc;
    late MockPTaskCreationBloc mockTaskCreationBloc;
    late MockPTaskEditBloc mockTaskEditBloc;
    late MockPTaskDeletionBloc mockTaskDeletionBloc;

    const fakeTask = PTask(id: 4, instruction: 'asdsa', isCompleted: false);

    Widget buildHomePage() {
      return MockPApp(
        blocProviders: [
          BlocProvider<PTasksStreamBloc>(
            create: (context) => mockTasksStreamBloc,
          ),
          BlocProvider<PTaskCreationBloc>(
            create: (context) => mockTaskCreationBloc,
          ),
          BlocProvider<PTaskEditBloc>(
            create: (context) => mockTaskEditBloc,
          ),
          BlocProvider<PTaskDeletionBloc>(
            create: (context) => mockTaskDeletionBloc,
          ),
        ],
        child: const PHomePage(),
      );
    }

    setUp(() {
      mockTasksStreamBloc = MockPTasksStreamBloc();
      mockTaskCreationBloc = MockPTaskCreationBloc();
      mockTaskEditBloc = MockPTaskEditBloc();
      mockTaskDeletionBloc = MockPTaskDeletionBloc();

      when(() => mockTasksStreamBloc.state).thenReturn(PTasksStreamInitial());
      when(() => mockTaskCreationBloc.state).thenReturn(PTaskCreationInitial());
      when(() => mockTaskEditBloc.state).thenReturn(PTaskEditInitial());
      when(() => mockTaskDeletionBloc.state).thenReturn(PTaskDeletionInitial());
    });

    testWidgets(
      requirement(
        Given: 'Home page',
        When: 'Tasks stream is loading',
        Then: 'Shows loading indicator',
      ),
      widgetsProcedure((tester) async {
        whenListen(
          mockTasksStreamBloc,
          Stream.fromIterable([PTasksStreamLoading()]),
          initialState: PTasksStreamInitial(),
        );

        await tester.pumpWidget(buildHomePage());
        await tester.pump();

        expect(
          find.byKey(const Key('app_bar_loading_indicator')),
          findsOneWidget,
        );
      }),
    );

    testWidgets(
      requirement(
        Given: 'Home page',
        When: 'Task creation is in progress',
        Then: 'Shows loading indicator',
      ),
      widgetsProcedure((tester) async {
        whenListen(
          mockTaskCreationBloc,
          Stream.fromIterable([PTaskCreationInProgress()]),
          initialState: PTaskCreationInitial(),
        );

        await tester.pumpWidget(buildHomePage());
        await tester.pump();

        expect(
          find.byKey(const Key('app_bar_loading_indicator')),
          findsOneWidget,
        );
      }),
    );
    testWidgets(
      requirement(
        Given: 'Home page',
        When: 'Task edit is in progress',
        Then: 'Shows loading indicator',
      ),
      widgetsProcedure((tester) async {
        whenListen(
          mockTaskEditBloc,
          Stream.fromIterable([PTaskEditInProgress()]),
          initialState: PTaskEditInitial(),
        );

        await tester.pumpWidget(buildHomePage());
        await tester.pump();

        expect(
          find.byKey(const Key('app_bar_loading_indicator')),
          findsOneWidget,
        );
      }),
    );
    testWidgets(
      requirement(
        Given: 'Home page',
        When: 'Task deletion is in progress',
        Then: 'Shows loading indicator',
      ),
      widgetsProcedure((tester) async {
        whenListen(
          mockTaskDeletionBloc,
          Stream.fromIterable([PTaskDeletionInProgress()]),
          initialState: PTaskDeletionInitial(),
        );

        await tester.pumpWidget(buildHomePage());
        await tester.pump();

        expect(
          find.byKey(const Key('app_bar_loading_indicator')),
          findsOneWidget,
        );
      }),
    );

    testWidgets(
      requirement(
        Given: 'Home page',
        When: 'When task stream fails',
        Then: 'Snackbar is shown',
      ),
      widgetsProcedure((tester) async {
        whenListen(
          mockTasksStreamBloc,
          Stream.fromIterable([
            PTasksStreamFailure(exception: PTasksStreamException.unknown),
          ]),
          initialState: PTasksStreamInitial(),
        );

        await tester.pumpWidget(buildHomePage());
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
      }),
    );

    testWidgets(
      requirement(
        Given: 'Home page',
        When: 'When task creation fails',
        Then: 'Snackbar is shown',
      ),
      widgetsProcedure((tester) async {
        whenListen(
          mockTaskCreationBloc,
          Stream.fromIterable([
            PTaskCreationFailure(exception: PTaskCreationException.unknown),
          ]),
          initialState: PTaskCreationInitial(),
        );

        await tester.pumpWidget(buildHomePage());
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
      }),
    );

    testWidgets(
      requirement(
        Given: 'Home page',
        When: 'When task edit fails',
        Then: 'Snackbar is shown',
      ),
      widgetsProcedure((tester) async {
        whenListen(
          mockTaskEditBloc,
          Stream.fromIterable([
            PTaskEditFailure(exception: PTaskUpdateException.unknown),
          ]),
          initialState: PTaskEditInitial(),
        );

        await tester.pumpWidget(buildHomePage());
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
      }),
    );

    testWidgets(
      requirement(
        Given: 'Home page',
        When: 'When task deletion fails',
        Then: 'Snackbar is shown',
      ),
      widgetsProcedure((tester) async {
        whenListen(
          mockTaskDeletionBloc,
          Stream.fromIterable([
            PTaskDeletionFailure(exception: PTaskDeletionException.unknown),
          ]),
          initialState: PTaskDeletionInitial(),
        );

        await tester.pumpWidget(buildHomePage());
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
      }),
    );

    testWidgets(
      requirement(
        Given: 'Home page',
        When: 'Add button pressed',
        Then: 'Opens add task popup',
      ),
      widgetsProcedure((tester) async {
        when(() => mockTasksStreamBloc.state).thenReturn(PTasksStreamInitial());

        await tester.pumpWidget(buildHomePage());
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump();

        expect(find.byType(PAddTaskDialog), findsOneWidget);
      }),
    );

    testWidgets(
      requirement(
        Given: 'Home page with tasks',
        When: 'Task item pressed',
        Then: 'Opens edit task popup',
      ),
      widgetsProcedure((tester) async {
        when(() => mockTasksStreamBloc.state)
            .thenReturn(PTasksStreamSuccess(tasks: [fakeTask]));

        await tester.pumpWidget(buildHomePage());
        await tester.tap(find.byType(PTaskItem));
        await tester.pump();

        expect(find.byType(PEditTaskDialog), findsOneWidget);
      }),
    );
  });
}
