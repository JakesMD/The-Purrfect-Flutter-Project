import 'dart:async';

import 'package:ppub/dartz.dart';
import 'package:ppub_dev/flutter_test.dart';
import 'package:ppub_dev/mocktail.dart';
import 'package:ppub_dev/test_beautifier.dart';
import 'package:ptasks_repository/ptasks_repository.dart';
import 'package:purrfect/pages/home/bloc/tasks_stream/bloc.dart';

class MockPTasksRepository extends Mock implements PTasksRepository {}

void main() {
  group('PTasksStreamBloc tests', () {
    late PTasksStreamBloc bloc;
    late MockPTasksRepository mockPTasksRepository;
    late StreamController<Either<PTasksStreamException, List<PTask>>>
        controller;

    const fakeTask = PTask(id: 3, instruction: 'asdjkl', isCompleted: false);

    setUp(() {
      mockPTasksRepository = MockPTasksRepository();
      controller = StreamController();

      when(mockPTasksRepository.tasksStream)
          .thenAnswer((_) => controller.stream);

      bloc = PTasksStreamBloc(tasksRepository: mockPTasksRepository);
    });

    tearDown(() {
      controller.close();
      bloc.close();
    });

    test(
      requirement(
        When: 'first initialized',
        Then: 'state is [initial]',
      ),
      procedure(() => expect(bloc.state, PTasksStreamInitial())),
    );

    test(
      requirement(
        When: 'tasks are streamed',
        Then: 'state is [success]',
      ),
      procedure(() {
        controller.add(right([fakeTask]));
        expectLater(bloc.stream, emits(PTasksStreamSuccess(tasks: [fakeTask])));
      }),
    );

    test(
      requirement(
        When: 'tasks stream returns exception',
        Then: 'state is [failure]',
      ),
      procedure(() {
        controller.add(left(PTasksStreamException.unknown));
        expectLater(
          bloc.stream,
          emits(PTasksStreamFailure(exception: PTasksStreamException.unknown)),
        );
      }),
    );

    test(
      requirement(
        When: 'bloc is closed',
        Then: 'tasks subscription is cancelled',
      ),
      procedure(() {
        bloc.close();
        expect(controller.hasListener, false);
      }),
    );
  });
}
