import 'package:flutter/material.dart';
import 'package:ppub/flutter_bloc.dart';
import 'package:ppub_dev/bloc_test.dart';
import 'package:ppub_dev/flutter_test.dart';
import 'package:ppub_dev/mocktail.dart';
import 'package:ppub_dev/test_beautifier.dart';
import 'package:ptasks_repository/ptasks_repository.dart';
import 'package:purrfect/pages/home/bloc/_bloc.dart';
import 'package:purrfect/pages/home/widgets/_widgets.dart';

import '../../../mock_app.dart';

class MockPTaskDeletionBloc
    extends MockBloc<PTaskDeletionEvent, PTaskDeletionState>
    implements PTaskDeletionBloc {}

class MockPTaskStatusUpdateBloc
    extends MockBloc<PTaskStatusUpdateEvent, PTaskStatusUpdateState>
    implements PTaskStatusUpdateBloc {}

void main() {
  group('PTaskItem tests', () {
    late MockPTaskDeletionBloc mockTaskDeletionBloc;
    late MockPTaskStatusUpdateBloc mockTaskStatusUpdateBloc;

    const fakeTask = PTask(id: 1, instruction: 'hi', isCompleted: false);

    Widget buildItem() {
      return MockPApp(
        blocProviders: [
          BlocProvider<PTaskDeletionBloc>(
            create: (context) => mockTaskDeletionBloc,
          ),
          BlocProvider<PTaskStatusUpdateBloc>(
            create: (context) => mockTaskStatusUpdateBloc,
          ),
        ],
        child: Scaffold(
          body: PTaskItem(task: fakeTask, onPressed: (_) {}),
        ),
      );
    }

    setUpAll(() {
      registerFallbackValue(PTaskDeletionTriggered(taskID: fakeTask.id));
      registerFallbackValue(
        PTaskStatusUpdateTriggered(taskID: fakeTask.id, isCompleted: true),
      );
    });

    setUp(() {
      mockTaskDeletionBloc = MockPTaskDeletionBloc();
      mockTaskStatusUpdateBloc = MockPTaskStatusUpdateBloc();
      when(() => mockTaskDeletionBloc.state).thenReturn(PTaskDeletionInitial());
      when(() => mockTaskStatusUpdateBloc.state).thenReturn(
        PTaskStatusUpdateInitial(),
      );
    });

    testWidgets(
      requirement(
        Given: 'Task item',
        When: 'Dismissed and deletion succeeds',
        Then: 'Task deletion event is dispatched and task is removed',
      ),
      widgetsProcedure((tester) async {
        whenListen(
          mockTaskDeletionBloc,
          Stream.fromIterable([PTaskDeletionSuccess()]),
        );

        await tester.pumpWidget(buildItem());
        await tester.drag(find.byType(PTaskItem), const Offset(1000, 0));
        await tester.pump();

        verify(() => mockTaskDeletionBloc.add(any())).called(1);
        expect(find.byType(ListTile), findsNothing);
      }),
    );
    testWidgets(
      requirement(
        Given: 'Task item',
        When: 'Dismissed and deletion fails',
        Then: 'Task deletion event is dispatched and task is not removed',
      ),
      widgetsProcedure((tester) async {
        whenListen(
          mockTaskDeletionBloc,
          Stream.fromIterable(
            [PTaskDeletionFailure(exception: PTaskDeletionException.unknown)],
          ),
        );

        await tester.pumpWidget(buildItem());
        await tester.drag(find.byType(PTaskItem), const Offset(1000, 0));
        await tester.pump();

        verify(() => mockTaskDeletionBloc.add(any())).called(1);
        expect(find.byType(ListTile), findsOneWidget);
      }),
    );

    testWidgets(
      requirement(
        Given: 'Task item',
        When: 'Checkbox pressed',
        Then: 'Task status update event is dispatched',
      ),
      widgetsProcedure((tester) async {
        whenListen(
          mockTaskStatusUpdateBloc,
          Stream.fromIterable([PTaskStatusUpdateSuccess(isCompleted: true)]),
        );

        await tester.pumpWidget(buildItem());
        await tester.tap(find.byType(Checkbox));
        await tester.pump();

        verify(() => mockTaskStatusUpdateBloc.add(any())).called(1);
      }),
    );
  });
}
