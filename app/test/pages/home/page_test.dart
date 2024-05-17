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

void main() {
  group('PHomePage tests', () {
    late MockPTasksStreamBloc mockTasksStreamBloc;

    const fakeTask = PTask(id: 4, instruction: 'asdsa', isCompleted: false);

    Widget buildHomePage() {
      return MockPApp(
        blocProviders: [
          BlocProvider<PTasksStreamBloc>(
            create: (context) => mockTasksStreamBloc,
          ),
        ],
        child: const PHomePage(),
      );
    }

    setUp(() {
      mockTasksStreamBloc = MockPTasksStreamBloc();
    });

    testWidgets(
      requirement(
        Given: 'Home page',
        When: 'Tasks stream is loading',
        Then: 'Shows loading indicator',
      ),
      widgetsProcedure((tester) async {
        when(() => mockTasksStreamBloc.state).thenReturn(
          PTasksStreamInitial(),
        );

        await tester.pumpWidget(buildHomePage());

        expect(find.byType(LinearProgressIndicator), findsOneWidget);
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
        when(() => mockTasksStreamBloc.state).thenReturn(
          PTasksStreamSuccess(tasks: [fakeTask]),
        );

        await tester.pumpWidget(buildHomePage());
        await tester.tap(find.byType(PTaskItem));
        await tester.pump();

        expect(find.byType(PEditTaskDialog), findsOneWidget);
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
  });
}
