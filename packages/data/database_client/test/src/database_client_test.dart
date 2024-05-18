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

class MockUpdateStatement extends Mock
    implements UpdateStatement<$PTasksTableTable, PTasksTableData> {}

class MockDeleteStatement extends Mock
    implements DeleteStatement<$PTasksTableTable, PTasksTableData> {}

void main() {
  group('PDatabaseClient Tests', () {
    late PDatabaseClient client;
    late MockPDatabase mockPDatabase;

    const fakeTasksTableData = PTasksTableData(
      id: 1,
      instruction: 'asdjk',
      isCompleted: false,
    );

    // Made to match the data in [fakeTasksTableData].
    final fakeTasksTableCompanion = PTasksTableCompanion(
      id: Value(fakeTasksTableData.id),
      instruction: Value(fakeTasksTableData.instruction),
      isCompleted: Value(fakeTasksTableData.isCompleted),
    );

    setUpAll(() {
      registerFallbackValue(Fake$PTasksTableTable());
      registerFallbackValue(fakeTasksTableData);
    });

    setUp(() {
      mockPDatabase = MockPDatabase();
      client = PDatabaseClient(database: mockPDatabase);

      when(() => mockPDatabase.pTasksTable).thenReturn(Fake$PTasksTableTable());
    });

    group('tasksStream', () {
      late MockSimpleSelectStatement mockSimpleSelectStatement;

      setUp(() {
        mockSimpleSelectStatement = MockSimpleSelectStatement();
        when(() => mockPDatabase.select(any<$PTasksTableTable>()))
            .thenReturn(mockSimpleSelectStatement);
      });
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
      late MockInsertStatement mockInsertStatement;

      setUp(() {
        mockInsertStatement = MockInsertStatement();
        when(() => mockPDatabase.into(any<$PTasksTableTable>()))
            .thenReturn(mockInsertStatement);
      });

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

    group('updateTask', () {
      late MockUpdateStatement mockUpdateStatement;

      setUp(() {
        mockUpdateStatement = MockUpdateStatement();
        when(() => mockPDatabase.update(any<$PTasksTableTable>()))
            .thenReturn(mockUpdateStatement);
      });
      test(
        requirement(
          When: 'updating a task in the database succeeds',
          Then: 'returns [unit]',
        ),
        procedure(() async {
          when(() => mockUpdateStatement.write(any()))
              .thenAnswer((_) async => 1);

          final result = await client.updateTask(fakeTasksTableCompanion);

          expect(result, right(unit));
        }),
      );

      test(
        requirement(
          When: 'updating a task in the database fails',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(() => mockUpdateStatement.write(any()))
              .thenThrow(Exception('Unknown exception'));

          final result = await client.updateTask(fakeTasksTableCompanion);

          expect(result, left(PTableUpdateException.unknown));
        }),
      );
    });

    group('deleteTask', () {
      late MockDeleteStatement mockDeleteStatement;

      setUp(() {
        mockDeleteStatement = MockDeleteStatement();
        when(() => mockPDatabase.delete(any<$PTasksTableTable>()))
            .thenReturn(mockDeleteStatement);
      });
      test(
        requirement(
          When: 'deleting a task in the database succeeds',
          Then: 'returns [unit]',
        ),
        procedure(() async {
          when(() => mockDeleteStatement.go()).thenAnswer((_) async => 1);

          final result = await client.deleteTask(fakeTasksTableCompanion);

          expect(result, right(unit));
        }),
      );

      test(
        requirement(
          When: 'deleting a task in the database fails',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(() => mockDeleteStatement.go())
              .thenThrow(Exception('Unknown exception'));

          final result = await client.deleteTask(fakeTasksTableCompanion);

          expect(result, left(PTableDeletionException.unknown));
        }),
      );
    });
  });
}
