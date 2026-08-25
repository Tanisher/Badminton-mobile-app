import 'package:drift/drift.dart';

import 'players_table.dart';
import 'tournament_participants_table.dart';

/// Per-tournament event assignment for a Competition Team member.
///
/// [assignedEvent] is the member's individual contribution (not TEAM).
class TeamEventAssignments extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get tournamentParticipantId => integer()
      .references(TournamentParticipants, #id, onDelete: KeyAction.cascade)();

  @ReferenceName('teamEventAssignments')
  IntColumn get playerId => integer().references(Players, #id)();

  /// One of: 'MS', 'WS', 'MD', 'WD', 'XD' — never 'TEAM'.
  TextColumn get assignedEvent => text()();

  /// Explicit doubles partner pairing for MD/WD/XD within a Team Event.
  ///
  /// Self-referencing: points at the other [TeamEventAssignments] row this
  /// player is explicitly paired with for that doubles slot.
  ///
  /// Only relevant when [assignedEvent] is MD, WD, or XD.
  IntColumn get partnerAssignmentId => integer().nullable().references(
        TeamEventAssignments,
        #id,
        onDelete: KeyAction.setNull,
      )();
}

