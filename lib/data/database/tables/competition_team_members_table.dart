import 'package:drift/drift.dart';

import 'competition_teams_table.dart';
import 'players_table.dart';

/// Join table: players on a competition-team roster.
///
/// Event assignment for a member is not stored here — that will be attached
/// to TournamentParticipant later.
class CompetitionTeamMembers extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get competitionTeamId =>
      integer().references(CompetitionTeams, #id)();
  IntColumn get playerId => integer().references(Players, #id)();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
