import 'package:ppub/dartz.dart';
import 'package:ppub_dev/bloc_test.dart';
import 'package:ppub_dev/flutter_test.dart';
import 'package:ppub_dev/mocktail.dart';
import 'package:ppub_dev/test_beautifier.dart';
import 'package:ptasks_repository/ptasks_repository.dart';
import 'package:purrfect/pages/home/bloc/_bloc.dart';

class MockTasksRepository extends Mock implements PTasksRepository {}

void main() {
  group('PTaskCreationBloc tests', () {
    late MockTasksRepository repo;
    late PTaskCreationBloc bloc;

    const fakeTask = PTask(id: 3, instruction: 'sdasd', isCompleted: false);

    final fakeCreationTrigger = PTaskCreationTriggered(
      instruction: fakeTask.instruction,
    );

    Future<Either<PTaskCreationException, PTask>> mockCreateTask() {
      return repo.createTask(instruction: any(named: 'instruction'));
    }

    setUp(() {
      repo = MockTasksRepository();
      bloc = PTaskCreationBloc(tasksRepository: repo);

      when(mockCreateTask).thenAnswer((_) async => right(fakeTask));
    });

    test(
      requirement(
        When: 'first initialized',
        Then: 'state is [initial]',
      ),
      procedure(() => expect(bloc.state, PTaskCreationInitial())),
    );

    blocTest(
      requirement(
        When: 'creation is triggered',
        Then: 'state is [in progress]',
      ),
      build: () => bloc,
      act: (bloc) => bloc.add(fakeCreationTrigger),
      expect: () => [
        PTaskCreationInProgress(),
        PTaskCreationSuccess(task: fakeTask),
      ],
    );

    blocTest(
      requirement(
        When: 'creation triggered and succeeeds',
        Then: 'state is [success]',
      ),
      build: () => bloc,
      act: (bloc) => bloc.add(fakeCreationTrigger),
      skip: 1,
      expect: () => [PTaskCreationSuccess(task: fakeTask)],
    );

    blocTest(
      requirement(
        When: 'creation triggered and fails',
        Then: 'state is [failure]',
      ),
      setUp: () => when(mockCreateTask).thenAnswer(
        (_) async => left(PTaskCreationException.unknown),
      ),
      build: () => bloc,
      act: (bloc) => bloc.add(fakeCreationTrigger),
      skip: 1,
      expect: () => [
        PTaskCreationFailure(
          exception: PTaskCreationException.unknown,
        ),
      ],
    );
  });
}
