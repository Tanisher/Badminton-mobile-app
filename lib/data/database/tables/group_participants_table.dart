import 'package:drift/drift.dart';

import 'groups_table.dart';
import 'tournament_participants_table.dart';

/// Membership of a [TournamentParticipants] row in a group-stage [Groups] row.
class GroupParticipants extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get groupId =>
      integer().references(Groups, #id, onDelete: KeyAction.cascade)();

  IntColumn get tournamentParticipantId => integer()
      .references(TournamentParticipants, #id, onDelete: KeyAction.cascade)();
}
