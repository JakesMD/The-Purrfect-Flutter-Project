import 'dart:async';

import 'package:ppub/dartz.dart';
import 'package:ppub_dev/bloc_test.dart';
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
        Then: 'state is [loading]',
      ),
      procedure(() async {
        await Future.delayed(Duration.zero);
        expect(bloc.state, PTasksStreamLoading());
      }),
    );

    blocTest(
      requirement(
        When: 'tasks are streamed',
        Then: 'state is [success]',
      ),
      build: () => bloc,
      act: (bloc) => controller.add(right([fakeTask])),
      expect: () => [
        PTasksStreamSuccess(tasks: [fakeTask]),
      ],
    );

    blocTest(
      requirement(
        When: 'tasks stream returns exception',
        Then: 'state is [failure]',
      ),
      build: () => bloc,
      act: (bloc) => controller.add(left(PTasksStreamException.unknown)),
      expect: () => [
        PTasksStreamFailure(exception: PTasksStreamException.unknown),
      ],
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
