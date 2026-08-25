import 'package:drift/drift.dart';

import 'players_table.dart';

/// A fixed doubles pair for one event type (MD, WD, or XD).
///
/// Ranking points earned by the pair will be applied to both players later;
/// that lives outside this table.
class IndividualTeams extends Table {
  IntColumn get id => integer().autoIncrement()();

  @ReferenceName('pairsAsPlayer1')
  IntColumn get player1Id => integer().references(Players, #id)();
  @ReferenceName('pairsAsPlayer2')
  IntColumn get player2Id => integer().references(Players, #id)();

  /// One of: 'MD', 'WD', 'XD'. Constrained at the repository layer.
  TextColumn get eventType => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
