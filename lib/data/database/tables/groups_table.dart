import 'package:drift/drift.dart';

import 'tournaments_table.dart';

/// A group within a group+knockout event (one of several mini round-robins).
class Groups extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get tournamentId =>
      integer().references(Tournaments, #id, onDelete: KeyAction.cascade)();

  TextColumn get eventType => text()();

  /// 1-based group index (1, 2, 3, …).
  IntColumn get groupNumber => integer()();
}
