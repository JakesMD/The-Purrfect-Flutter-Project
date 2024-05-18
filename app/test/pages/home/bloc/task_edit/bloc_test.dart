import 'package:ppub/dartz.dart';
import 'package:ppub_dev/bloc_test.dart';
import 'package:ppub_dev/flutter_test.dart';
import 'package:ppub_dev/mocktail.dart';
import 'package:ppub_dev/test_beautifier.dart';
import 'package:ptasks_repository/ptasks_repository.dart';
import 'package:purrfect/pages/home/bloc/_bloc.dart';

class MockTasksRepository extends Mock implements PTasksRepository {}

void main() {
  group('PTaskEditBloc tests', () {
    late MockTasksRepository repo;
    late PTaskEditBloc bloc;

    final fakeEditTrigger = PTaskEditTriggered(taskID: 3, instruction: 'adj');

    Future<Either<PTaskUpdateException, Unit>> mockEditTask() {
      return repo.editTask(
        taskID: any(named: 'taskID'),
        instruction: any(named: 'instruction'),
      );
    }

    setUp(() {
      repo = MockTasksRepository();
      bloc = PTaskEditBloc(tasksRepository: repo);

      when(mockEditTask).thenAnswer((_) async => right(unit));
    });

    test(
      requirement(
        When: 'first initialized',
        Then: 'state is [initial]',
      ),
      procedure(() => expect(bloc.state, PTaskEditInitial())),
    );

    blocTest(
      requirement(
        When: 'edit is triggered',
        Then: 'state is [in progress]',
      ),
      build: () => bloc,
      act: (bloc) => bloc.add(fakeEditTrigger),
      expect: () => [PTaskEditInProgress(), PTaskEditSuccess()],
    );

    blocTest(
      requirement(
        When: 'edit is triggered and succeeeds',
        Then: 'state is [success]',
      ),
      build: () => bloc,
      act: (bloc) => bloc.add(fakeEditTrigger),
      skip: 1,
      expect: () => [PTaskEditSuccess()],
    );

    blocTest(
      requirement(
        When: 'edit is triggered and fails',
        Then: 'state is [failure]',
      ),
      setUp: () => when(mockEditTask).thenAnswer(
        (_) async => left(PTaskUpdateException.unknown),
      ),
      build: () => bloc,
      act: (bloc) => bloc.add(fakeEditTrigger),
      skip: 1,
      expect: () => [
        PTaskEditFailure(exception: PTaskUpdateException.unknown),
      ],
    );
  });
}
