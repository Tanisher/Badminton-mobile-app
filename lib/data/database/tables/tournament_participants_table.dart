import 'package:drift/drift.dart';

import 'competition_teams_table.dart';
import 'individual_teams_table.dart';
import 'players_table.dart';
import 'tournaments_table.dart';

/// A competitor in one tournament + event slot.
///
/// Polymorphic: exactly one of [playerId] / [individualTeamId] /
/// [competitionTeamId] is set, matching [participantType].
/// Fixture generation later queries this table by tournament + eventType.
class TournamentParticipants extends Table {
  IntColumn get id => integer().autoIncrement()();

  @ReferenceName('participants')
  IntColumn get tournamentId =>
      integer().references(Tournaments, #id, onDelete: KeyAction.cascade)();

  /// Must be one of the tournament's selected TournamentEvents rows.
  TextColumn get eventType => text()();

  /// One of: 'player', 'pair', 'competition_team'.
  TextColumn get participantType => text()();

  @ReferenceName('playerRegistrations')
  IntColumn get playerId => integer().nullable().references(Players, #id)();

  @ReferenceName('pairRegistrations')
  IntColumn get individualTeamId =>
      integer().nullable().references(IndividualTeams, #id)();

  @ReferenceName('competitionTeamRegistrations')
  IntColumn get competitionTeamId =>
      integer().nullable().references(CompetitionTeams, #id)();

  /// Reserved for future seeding. Not populated by this module.
  IntColumn get seed => integer().nullable()();

  /// Withdrawal implies no ranking points (Rankings module later).
  /// This table only preserves the flag for that module to read.
  BoolColumn get withdrawn => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
