import 'package:drift/drift.dart';

import 'groups_table.dart';
import 'tournament_participants_table.dart';
import 'tournaments_table.dart';

/// A scheduled match in a tournament event (round-robin or knockout).
///
/// All competitors (player, pair, competition team) are represented as rows
/// in [TournamentParticipants]. This module never special-cases TEAM.
///
/// Knockout later-round fixtures may have null [participant1Id]/[participant2Id]
/// until earlier rounds propagate winners into them.
class Fixtures extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get tournamentId =>
      integer().references(Tournaments, #id, onDelete: KeyAction.cascade)();

  /// Event type for this match (MS/WS/MD/WD/XD/TEAM).
  TextColumn get eventType => text()();

  @ReferenceName('fixturesAsParticipant1')
  IntColumn get participant1Id => integer().nullable().references(
        TournamentParticipants,
        #id,
        onDelete: KeyAction.cascade,
      )();

  @ReferenceName('fixturesAsParticipant2')
  IntColumn get participant2Id => integer().nullable().references(
        TournamentParticipants,
        #id,
        onDelete: KeyAction.cascade,
      )();

  /// Optional, can be filled during generation.
  IntColumn get courtNumber => integer().nullable()();

  /// Round/time-slot (round-robin schedule) or knockout round index.
  IntColumn get roundNumber => integer()();

  /// 'pending' or 'completed'
  TextColumn get status =>
      text().withDefault(const Constant('pending'))();

  /// Winner participant, set once completed.
  IntColumn get winnerParticipantId => integer().nullable().references(
        TournamentParticipants,
        #id,
        onDelete: KeyAction.setNull,
      )();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Knockout only: e.g. 'round_of_16', 'quarterfinal', 'semifinal', 'final',
  /// 'bronze_medal_match'. Null for round-robin fixtures.
  TextColumn get bracketRound => text().nullable()();

  /// Knockout only: fixture the winner advances into. Null for final / bronze.
  @ReferenceName('fixturesAdvancingWinnerInto')
  IntColumn get nextFixtureId => integer().nullable().references(
        Fixtures,
        #id,
        onDelete: KeyAction.setNull,
      )();

  /// Knockout only: 1 or 2 — which slot in [nextFixtureId] the winner fills.
  IntColumn get nextFixtureSlot => integer().nullable()();

  /// True when this row is a bye (one participant auto-advances, no match).
  BoolColumn get isBye =>
      boolean().withDefault(const Constant(false))();

  /// Knockout only: used for semifinal losers feeding a bronze medal match.
  @ReferenceName('fixturesAdvancingLoserInto')
  IntColumn get loserNextFixtureId => integer().nullable().references(
        Fixtures,
        #id,
        onDelete: KeyAction.setNull,
      )();

  /// Knockout only: 1 or 2 — slot in [loserNextFixtureId] the loser fills.
  IntColumn get loserNextFixtureSlot => integer().nullable()();

  /// Group-stage only: which group this fixture belongs to.
  /// Null for plain round-robin and knockout fixtures.
  IntColumn get groupId => integer().nullable().references(
        Groups,
        #id,
        onDelete: KeyAction.cascade,
      )();
}
