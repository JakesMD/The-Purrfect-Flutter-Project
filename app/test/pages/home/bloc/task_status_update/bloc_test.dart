import 'package:ppub/dartz.dart';
import 'package:ppub_dev/bloc_test.dart';
import 'package:ppub_dev/flutter_test.dart';
import 'package:ppub_dev/mocktail.dart';
import 'package:ppub_dev/test_beautifier.dart';
import 'package:ptasks_repository/ptasks_repository.dart';
import 'package:purrfect/pages/home/bloc/_bloc.dart';

class MockTasksRepository extends Mock implements PTasksRepository {}

void main() {
  group('PTaskStatusUpdateBloc tests', () {
    late MockTasksRepository repo;
    late PTaskStatusUpdateBloc bloc;

    final fakeUpdateTrigger = PTaskStatusUpdateTriggered(
      taskID: 3,
      isCompleted: true,
    );

    Future<Either<PTaskUpdateException, Unit>> mockUpdateTaskStatus() {
      return repo.updateTaskStatus(
        taskID: any(named: 'taskID'),
        isCompleted: any(named: 'isCompleted'),
      );
    }

    setUp(() {
      repo = MockTasksRepository();
      bloc = PTaskStatusUpdateBloc(tasksRepository: repo);

      when(mockUpdateTaskStatus).thenAnswer((_) async => right(unit));
    });

    test(
      requirement(
        When: 'first initialized',
        Then: 'state is [initial]',
      ),
      procedure(() => expect(bloc.state, PTaskStatusUpdateInitial())),
    );

    blocTest(
      requirement(
        When: 'edit is triggered',
        Then: 'state is [in progress]',
      ),
      build: () => bloc,
      act: (bloc) => bloc.add(fakeUpdateTrigger),
      expect: () => [
        PTaskStatusUpdateInProgress(),
        PTaskStatusUpdateSuccess(isCompleted: true),
      ],
    );

    blocTest(
      requirement(
        When: 'edit is triggered and succeeeds',
        Then: 'state is [success]',
      ),
      build: () => bloc,
      act: (bloc) => bloc.add(fakeUpdateTrigger),
      skip: 1,
      expect: () => [
        PTaskStatusUpdateSuccess(isCompleted: true),
      ],
    );

    blocTest(
      requirement(
        When: 'edit is triggered and fails',
        Then: 'state is [failure]',
      ),
      setUp: () => when(mockUpdateTaskStatus).thenAnswer(
        (_) async => left(PTaskUpdateException.unknown),
      ),
      build: () => bloc,
      act: (bloc) => bloc.add(fakeUpdateTrigger),
      skip: 1,
      expect: () => [
        PTaskStatusUpdateFailure(exception: PTaskUpdateException.unknown),
      ],
    );
  });
}
