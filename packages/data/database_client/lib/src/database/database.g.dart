// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PTasksTableTable extends PTasksTable
    with TableInfo<$PTasksTableTable, PTasksTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PTasksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _instructionMeta =
      const VerificationMeta('instruction');
  @override
  late final GeneratedColumn<String> instruction = GeneratedColumn<String>(
      'instruction', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1, maxTextLength: 1000),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Instruction goes here'));
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, instruction, isCompleted];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'p_tasks_table';
  @override
  VerificationContext validateIntegrity(Insertable<PTasksTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('instruction')) {
      context.handle(
          _instructionMeta,
          instruction.isAcceptableOrUnknown(
              data['instruction']!, _instructionMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PTasksTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PTasksTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      instruction: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}instruction'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
    );
  }

  @override
  $PTasksTableTable createAlias(String alias) {
    return $PTasksTableTable(attachedDatabase, alias);
  }
}

class PTasksTableData extends DataClass implements Insertable<PTasksTableData> {
  /// The primary key for the table.
  final int id;

  /// The instruction of the task.
  final String instruction;

  /// The flag indicating whether the task is completed.
  final bool isCompleted;
  const PTasksTableData(
      {required this.id, required this.instruction, required this.isCompleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['instruction'] = Variable<String>(instruction);
    map['is_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  PTasksTableCompanion toCompanion(bool nullToAbsent) {
    return PTasksTableCompanion(
      id: Value(id),
      instruction: Value(instruction),
      isCompleted: Value(isCompleted),
    );
  }

  factory PTasksTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PTasksTableData(
      id: serializer.fromJson<int>(json['id']),
      instruction: serializer.fromJson<String>(json['instruction']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'instruction': serializer.toJson<String>(instruction),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  PTasksTableData copyWith({int? id, String? instruction, bool? isCompleted}) =>
      PTasksTableData(
        id: id ?? this.id,
        instruction: instruction ?? this.instruction,
        isCompleted: isCompleted ?? this.isCompleted,
      );
  @override
  String toString() {
    return (StringBuffer('PTasksTableData(')
          ..write('id: $id, ')
          ..write('instruction: $instruction, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, instruction, isCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PTasksTableData &&
          other.id == this.id &&
          other.instruction == this.instruction &&
          other.isCompleted == this.isCompleted);
}

class PTasksTableCompanion extends UpdateCompanion<PTasksTableData> {
  final Value<int> id;
  final Value<String> instruction;
  final Value<bool> isCompleted;
  const PTasksTableCompanion({
    this.id = const Value.absent(),
    this.instruction = const Value.absent(),
    this.isCompleted = const Value.absent(),
  });
  PTasksTableCompanion.insert({
    this.id = const Value.absent(),
    this.instruction = const Value.absent(),
    this.isCompleted = const Value.absent(),
  });
  static Insertable<PTasksTableData> custom({
    Expression<int>? id,
    Expression<String>? instruction,
    Expression<bool>? isCompleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (instruction != null) 'instruction': instruction,
      if (isCompleted != null) 'is_completed': isCompleted,
    });
  }

  PTasksTableCompanion copyWith(
      {Value<int>? id, Value<String>? instruction, Value<bool>? isCompleted}) {
    return PTasksTableCompanion(
      id: id ?? this.id,
      instruction: instruction ?? this.instruction,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (instruction.present) {
      map['instruction'] = Variable<String>(instruction.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PTasksTableCompanion(')
          ..write('id: $id, ')
          ..write('instruction: $instruction, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }
}

abstract class _$PDatabase extends GeneratedDatabase {
  _$PDatabase(QueryExecutor e) : super(e);
  _$PDatabaseManager get managers => _$PDatabaseManager(this);
  late final $PTasksTableTable pTasksTable = $PTasksTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [pTasksTable];
}

typedef $$PTasksTableTableInsertCompanionBuilder = PTasksTableCompanion
    Function({
  Value<int> id,
  Value<String> instruction,
  Value<bool> isCompleted,
});
typedef $$PTasksTableTableUpdateCompanionBuilder = PTasksTableCompanion
    Function({
  Value<int> id,
  Value<String> instruction,
  Value<bool> isCompleted,
});

class $$PTasksTableTableTableManager extends RootTableManager<
    _$PDatabase,
    $PTasksTableTable,
    PTasksTableData,
    $$PTasksTableTableFilterComposer,
    $$PTasksTableTableOrderingComposer,
    $$PTasksTableTableProcessedTableManager,
    $$PTasksTableTableInsertCompanionBuilder,
    $$PTasksTableTableUpdateCompanionBuilder> {
  $$PTasksTableTableTableManager(_$PDatabase db, $PTasksTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PTasksTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PTasksTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$PTasksTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> instruction = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
          }) =>
              PTasksTableCompanion(
            id: id,
            instruction: instruction,
            isCompleted: isCompleted,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> instruction = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
          }) =>
              PTasksTableCompanion.insert(
            id: id,
            instruction: instruction,
            isCompleted: isCompleted,
          ),
        ));
}

class $$PTasksTableTableProcessedTableManager extends ProcessedTableManager<
    _$PDatabase,
    $PTasksTableTable,
    PTasksTableData,
    $$PTasksTableTableFilterComposer,
    $$PTasksTableTableOrderingComposer,
    $$PTasksTableTableProcessedTableManager,
    $$PTasksTableTableInsertCompanionBuilder,
    $$PTasksTableTableUpdateCompanionBuilder> {
  $$PTasksTableTableProcessedTableManager(super.$state);
}

class $$PTasksTableTableFilterComposer
    extends FilterComposer<_$PDatabase, $PTasksTableTable> {
  $$PTasksTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get instruction => $state.composableBuilder(
      column: $state.table.instruction,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$PTasksTableTableOrderingComposer
    extends OrderingComposer<_$PDatabase, $PTasksTableTable> {
  $$PTasksTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get instruction => $state.composableBuilder(
      column: $state.table.instruction,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$PDatabaseManager {
  final _$PDatabase _db;
  _$PDatabaseManager(this._db);
  $$PTasksTableTableTableManager get pTasksTable =>
      $$PTasksTableTableTableManager(_db, _db.pTasksTable);
}
