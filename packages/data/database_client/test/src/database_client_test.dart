import 'package:drift/drift.dart';
import 'package:pdatabase_client/pdatabase_client.dart';
import 'package:ppub/dartz.dart';
import 'package:ppub_dev/flutter_test.dart';
import 'package:ppub_dev/mocktail.dart';
import 'package:ppub_dev/test_beautifier.dart';

class Fake$PTasksTableTable extends Fake implements $PTasksTableTable {}

class MockPDatabase extends Mock implements PDatabase {}

// ignore: subtype_of_sealed_class
class MockSimpleSelectStatement extends Mock
    implements SimpleSelectStatement<$PTasksTableTable, PTasksTableData> {}

class MockInsertStatement extends Mock
    implements InsertStatement<$PTasksTableTable, PTasksTableData> {}

void main() {
  group('PDatabaseClient Tests', () {
    late PDatabaseClient client;
    late MockPDatabase mockPDatabase;
    late MockSimpleSelectStatement mockSimpleSelectStatement;
    late MockInsertStatement mockInsertStatement;

    const fakeTasksTableData = PTasksTableData(
      id: 1,
      instruction: 'asdjk',
      isCompleted: false,
    );

    // Made to match the data in [fakeTasksTableData].
    final fakeTasksTableCompanion = PTasksTableCompanion(
      instruction: Value(fakeTasksTableData.instruction),
    );

    setUpAll(() {
      registerFallbackValue(Fake$PTasksTableTable());
      registerFallbackValue(fakeTasksTableData);
    });

    setUp(() {
      mockPDatabase = MockPDatabase();
      mockSimpleSelectStatement = MockSimpleSelectStatement();
      mockInsertStatement = MockInsertStatement();
      client = PDatabaseClient(database: mockPDatabase);

      when(() => mockPDatabase.pTasksTable).thenReturn(Fake$PTasksTableTable());
      when(() => mockPDatabase.select(any<$PTasksTableTable>()))
          .thenReturn(mockSimpleSelectStatement);
      when(() => mockPDatabase.into(any<$PTasksTableTable>()))
          .thenReturn(mockInsertStatement);
    });

    group('tasksStream', () {
      test(
        requirement(
          When: 'steaming tasks table data from the database succeeds',
          Then: 'returns the data as a stream',
        ),
        procedure(() {
          final dataList = [fakeTasksTableData];

          when(mockSimpleSelectStatement.watch)
              .thenAnswer((_) => Stream.value(dataList));

          final result = client.tasksTableStream();

          expect(result, emits(right(dataList)));
        }),
      );

      test(
        requirement(
          When: 'steaming tasks table data from the database fails',
          Then: 'returns [unknown] exception',
        ),
        procedure(() {
          when(mockSimpleSelectStatement.watch)
              .thenThrow(Exception('Unknown exception'));

          final result = client.tasksTableStream();

          expect(result, emits(left(PTableStreamException.unknown)));
        }),
      );
    });
    group('insertTask', () {
      test(
        requirement(
          When: 'inserting a task into the database succeeds',
          Then: 'returns the inserted task',
        ),
        procedure(() async {
          when(() => mockInsertStatement.insertReturning(any()))
              .thenAnswer((_) async => fakeTasksTableData);

          final result = await client.insertTask(fakeTasksTableCompanion);

          expect(result, right(fakeTasksTableData));
        }),
      );

      test(
        requirement(
          When: 'inserting a task into the database fails',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(() => mockInsertStatement.insertReturning(any()))
              .thenThrow(Exception('Unknown exception'));

          final result = await client.insertTask(fakeTasksTableCompanion);

          expect(result, left(PTableInsertException.unknown));
        }),
      );
    });
  });
}
