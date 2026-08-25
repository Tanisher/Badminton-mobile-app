import 'package:drift/drift.dart';

import 'tournaments_table.dart';

/// Selected events for a tournament (MS/WS/MD/WD/XD/TEAM).
/// Stored as rows so we can query "all tournaments that include WD".
class TournamentEvents extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get tournamentId =>
      integer().references(Tournaments, #id, onDelete: KeyAction.cascade)();

  /// One of: 'MS', 'WS', 'MD', 'WD', 'XD', 'TEAM'.
  TextColumn get eventType => text()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {tournamentId, eventType},
      ];
}
