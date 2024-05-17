import 'package:ppub/dartz.dart';
import 'package:ppub_dev/bloc_test.dart';
import 'package:ppub_dev/flutter_test.dart';
import 'package:ppub_dev/mocktail.dart';
import 'package:ppub_dev/test_beautifier.dart';
import 'package:ptasks_repository/ptasks_repository.dart';
import 'package:purrfect/pages/home/bloc/_bloc.dart';

class MockTasksRepository extends Mock implements PTasksRepository {}

void main() {
  group('PTaskDeletionBloc tests', () {
    late MockTasksRepository repo;
    late PTaskDeletionBloc bloc;

    final fakeDeletionTrigger = PTaskDeletionTriggered(taskID: 3);

    Future<Either<PTaskDeletionException, Unit>> mockDeleteTask() {
      return repo.deleteTask(taskID: any(named: 'taskID'));
    }

    setUp(() {
      repo = MockTasksRepository();
      bloc = PTaskDeletionBloc(tasksRepository: repo);

      when(mockDeleteTask).thenAnswer((_) async => right(unit));
    });

    test(
      requirement(
        When: 'first initialized',
        Then: 'state is [initial]',
      ),
      procedure(() => expect(bloc.state, PTaskDeletionInitial())),
    );

    blocTest(
      requirement(
        When: 'deletion is triggered',
        Then: 'state is [in progress]',
      ),
      build: () => bloc,
      act: (bloc) => bloc.add(fakeDeletionTrigger),
      expect: () => [
        PTaskDeletionInProgress(),
        PTaskDeletionSuccess(),
      ],
    );

    blocTest(
      requirement(
        When: 'deletion triggered and succeeeds',
        Then: 'state is [success]',
      ),
      build: () => bloc,
      act: (bloc) => bloc.add(fakeDeletionTrigger),
      skip: 1,
      expect: () => [PTaskDeletionSuccess()],
    );

    blocTest(
      requirement(
        When: 'deletion triggered and fails',
        Then: 'state is [failure]',
      ),
      setUp: () => when(mockDeleteTask).thenAnswer(
        (_) async => left(PTaskDeletionException.unknown),
      ),
      build: () => bloc,
      act: (bloc) => bloc.add(fakeDeletionTrigger),
      skip: 1,
      expect: () => [
        PTaskDeletionFailure(exception: PTaskDeletionException.unknown),
      ],
    );
  });
}
