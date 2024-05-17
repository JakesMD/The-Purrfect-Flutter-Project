import 'package:pcore/pcore.dart';
import 'package:pdatabase_client/pdatabase_client.dart';
import 'package:ppub/dartz.dart';
import 'package:ppub_dev/flutter_test.dart';
import 'package:ppub_dev/mocktail.dart';
import 'package:ppub_dev/test_beautifier.dart';
import 'package:ptasks_repository/ptasks_repository.dart';

class MockPDatabaseClient extends Mock implements PDatabaseClient {}

void main() {
  group('PTasksRepository tests', () {
    late PTasksRepository repo;
    late MockPDatabaseClient mockDatabaseClient;

    const fakeTask = PTask(
      id: 1,
      instruction: 'asdds',
      isCompleted: false,
    );

    // Made to match the fakeTask.
    final fakeTaskTableData = PTasksTableData(
      id: fakeTask.id,
      instruction: fakeTask.instruction,
      isCompleted: fakeTask.isCompleted,
    );

    setUpAll(() {
      registerFallbackValue(const PTasksTableCompanion());
    });

    setUp(() {
      mockDatabaseClient = MockPDatabaseClient();
      repo = PTasksRepository(databaseClient: mockDatabaseClient);
    });

    group('tasksStream', () {
      test(
        requirement(
          When: 'streaming tasks from the database succeeds',
          Then: 'emits the list of tasks',
        ),
        procedure(() async {
          when(mockDatabaseClient.tasksTableStream)
              .thenAnswer((_) => Stream.value(right([fakeTaskTableData])));

          final result = await repo.tasksStream().first;

          expect(result.pAsRight(), equals([fakeTask]));
        }),
      );

      test(
        requirement(
          When: 'streaming tasks from the database fails',
          Then: 'emits [unknown] exception',
        ),
        procedure(() {
          when(mockDatabaseClient.tasksTableStream).thenAnswer(
            (_) => Stream.value(left(PTableStreamException.unknown)),
          );

          final result = repo.tasksStream();

          expect(result, emits(left(PTasksStreamException.unknown)));
        }),
      );
    });

    group('createTask', () {
      test(
        requirement(
          When: 'inserting a task into the database succeeds',
          Then: 'returns the created task',
        ),
        procedure(() async {
          when(() => mockDatabaseClient.insertTask(any())).thenAnswer(
            (_) => Future.value(right(fakeTaskTableData)),
          );

          final result = await repo.createTask(
            instruction: fakeTask.instruction,
          );

          expect(result.pAsRight(), equals(fakeTask));
        }),
      );

      test(
        requirement(
          When: 'inserting a task into the database fails',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(() => mockDatabaseClient.insertTask(any())).thenAnswer(
            (_) => Future.value(left(PTableInsertException.unknown)),
          );

          final result = await repo.createTask(
            instruction: fakeTask.instruction,
          );

          expect(result, left(PTaskCreationException.unknown));
        }),
      );
    });
  });
}
