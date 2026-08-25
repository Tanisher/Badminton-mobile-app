import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/database.dart';
import '../../../data/repositories/competition_team_repository.dart';
import '../../../data/repositories/individual_team_repository.dart';
import '../players/screens/player_list_screen.dart';

final individualTeamRepositoryProvider = Provider<IndividualTeamRepository>(
  (ref) => IndividualTeamRepository(ref.watch(databaseProvider)),
);

final competitionTeamRepositoryProvider = Provider<CompetitionTeamRepository>(
  (ref) => CompetitionTeamRepository(ref.watch(databaseProvider)),
);

final pairsByEventTypeProvider =
    StreamProvider.family<List<IndividualTeamWithPlayers>, String>(
  (ref, eventType) {
    return ref
        .watch(individualTeamRepositoryProvider)
        .getPairsByEventType(eventType);
  },
);

final competitionTeamsProvider =
    StreamProvider<List<CompetitionTeamSummary>>((ref) {
  return ref.watch(competitionTeamRepositoryProvider).getAllTeams();
});

final competitionTeamDetailProvider =
    StreamProvider.family<CompetitionTeamWithMembers?, int>((ref, teamId) {
  return ref.watch(competitionTeamRepositoryProvider).getTeamWithMembers(teamId);
});

final allPlayersProvider = StreamProvider<List<Player>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.players)
        ..orderBy([(t) => OrderingTerm.asc(t.fullName)]))
      .watch();
});

final playersByGenderProvider =
    StreamProvider.family<List<Player>, String>((ref, gender) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.players)
        ..where((t) => t.gender.equals(gender))
        ..orderBy([(t) => OrderingTerm.asc(t.fullName)]))
      .watch();
});
