import 'package:flutter/material.dart';
import 'package:ppub/confetti.dart';
import 'package:ppub/flutter_bloc.dart';
import 'package:ppub_dev/bloc_test.dart';
import 'package:ppub_dev/flutter_test.dart';
import 'package:ppub_dev/mocktail.dart';
import 'package:ppub_dev/test_beautifier.dart';
import 'package:purrfect/pages/home/bloc/_bloc.dart';
import 'package:purrfect/pages/home/widgets/_widgets.dart';

import '../../../mock_app.dart';

class MockPTaskStatusUpdateBloc
    extends MockBloc<PTaskStatusUpdateEvent, PTaskStatusUpdateState>
    implements PTaskStatusUpdateBloc {}

void main() {
  group('PConfetti tests', () {
    late MockPTaskStatusUpdateBloc mockTaskStatusUpdateBloc;
    Widget buildItem() {
      return MockPApp(
        blocProviders: [
          BlocProvider<PTaskStatusUpdateBloc>(
            create: (context) => mockTaskStatusUpdateBloc,
          ),
        ],
        child: PConfetti(),
      );
    }

    setUp(() {
      mockTaskStatusUpdateBloc = MockPTaskStatusUpdateBloc();
      when(() => mockTaskStatusUpdateBloc.state).thenReturn(
        PTaskStatusUpdateInitial(),
      );
    });

    testWidgets(
      requirement(
        When: 'the task status is updated to completed',
        Then: 'confetti should play',
      ),
      widgetsProcedure(
        (tester) async {
          whenListen(
            mockTaskStatusUpdateBloc,
            Stream.fromIterable([
              PTaskStatusUpdateSuccess(isCompleted: true),
            ]),
          );

          await tester.pumpWidget(buildItem());
          final confetti =
              tester.firstWidget<PConfetti>(find.byType(PConfetti));

          expect(confetti.controller.state, ConfettiControllerState.playing);
        },
      ),
    );

    testWidgets(
      requirement(
        When: 'the task status is updated to not completed',
        Then: 'confetti should not play',
      ),
      widgetsProcedure(
        (tester) async {
          whenListen(
            mockTaskStatusUpdateBloc,
            Stream.fromIterable([
              PTaskStatusUpdateSuccess(isCompleted: false),
            ]),
          );

          await tester.pumpWidget(buildItem());
          final confetti =
              tester.firstWidget<PConfetti>(find.byType(PConfetti));

          expect(confetti.controller.state, ConfettiControllerState.stopped);
        },
      ),
    );
  });
}
