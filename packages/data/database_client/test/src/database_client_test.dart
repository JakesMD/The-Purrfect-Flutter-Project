import 'package:drift/src/runtime/query_builder/query_builder.dart';
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

void main() {
  group('PDatabaseClient Tests', () {
    late PDatabaseClient client;
    late MockPDatabase mockPDatabase;
    late MockSimpleSelectStatement mockSimpleSelectStatement;

    const fakeTasksTableData = PTasksTableData(
      id: 1,
      instruction: 'asdjk',
      isCompleted: false,
    );

    setUpAll(() {
      registerFallbackValue(Fake$PTasksTableTable());
    });

    setUp(() {
      mockPDatabase = MockPDatabase();
      mockSimpleSelectStatement = MockSimpleSelectStatement();
      client = PDatabaseClient(database: mockPDatabase);

      when(() => mockPDatabase.pTasksTable).thenReturn(Fake$PTasksTableTable());
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
}
