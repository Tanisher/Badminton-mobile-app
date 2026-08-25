import 'package:drift/drift.dart';

import 'players_table.dart';

/// Manually entered ranking-point results from tournaments run outside this app.
///
/// Ranking aggregation lives in a future Rankings module — this table only
/// stores what the organiser recorded. Each row awards points to one [Players]
/// row (doubles/team: enter one row per player who should receive points).
class ExternalResults extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get playerId =>
      integer().references(Players, #id, onDelete: KeyAction.cascade)();

  TextColumn get tournamentName => text()();

  TextColumn get tournamentOrganiser => text().nullable()();

  DateTimeColumn get date => dateTime()();

  /// One of: 'MS', 'WS', 'MD', 'WD', 'XD', 'TEAM'.
  TextColumn get eventType => text()();

  /// Free-text display context only ("played with ___"). Not an FK.
  TextColumn get partnerName => text().nullable()();

  /// Free text, e.g. "Winner", "Semifinalist" — not constrained to an enum.
  TextColumn get stageReached => text()();

  /// Manually entered; this app does not calculate the value.
  IntColumn get rankingPointsAwarded => integer()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
