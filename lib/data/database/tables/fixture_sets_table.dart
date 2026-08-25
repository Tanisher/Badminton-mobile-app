import 'package:drift/drift.dart';

import 'fixtures_table.dart';

/// Set/game scores for a [Fixtures] row.
class FixtureSets extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get fixtureId =>
      integer().references(Fixtures, #id, onDelete: KeyAction.cascade)();

  IntColumn get setNumber => integer()();

  IntColumn get participant1Score => integer()();
  IntColumn get participant2Score => integer()();
}

