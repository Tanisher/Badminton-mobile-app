import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/database.dart';
import '../../../data/repositories/fixture_repository.dart';
import '../players/screens/player_list_screen.dart';
import 'participant_providers.dart';

final fixtureRepositoryProvider = Provider<FixtureRepository>(
  (ref) => FixtureRepository(ref.watch(databaseProvider)),
);

final fixturesForEventProvider =
    StreamProvider.family<List<FixtureRowView>, TournamentEventKey>(
  (ref, key) {
    return ref.watch(fixtureRepositoryProvider).watchFixturesForEvent(
          tournamentId: key.tournamentId,
          eventType: key.eventType,
        );
  },
);

final standingsForEventProvider =
    StreamProvider.family<List<StandingsRow>, TournamentEventKey>(
  (ref, key) {
    return ref.watch(fixtureRepositoryProvider).getStandings(
          tournamentId: key.tournamentId,
          eventType: key.eventType,
        );
  },
);

class GroupStandingsKey {
  const GroupStandingsKey(this.tournamentId, this.eventType, this.groupId);

  final int tournamentId;
  final String eventType;
  final int groupId;

  @override
  bool operator ==(Object other) =>
      other is GroupStandingsKey &&
      other.tournamentId == tournamentId &&
      other.eventType == eventType &&
      other.groupId == groupId;

  @override
  int get hashCode => Object.hash(tournamentId, eventType, groupId);
}

final groupStandingsProvider =
    StreamProvider.family<List<StandingsRow>, GroupStandingsKey>(
  (ref, key) {
    return ref.watch(fixtureRepositoryProvider).getGroupStandings(
          tournamentId: key.tournamentId,
          eventType: key.eventType,
          groupId: key.groupId,
        );
  },
);

final groupsForEventProvider =
    StreamProvider.family<List<Group>, TournamentEventKey>(
  (ref, key) {
    return ref.watch(fixtureRepositoryProvider).watchGroupsForEvent(
          tournamentId: key.tournamentId,
          eventType: key.eventType,
        );
  },
);

final fixtureExistsProvider =
    FutureProvider.family<bool, TournamentEventKey>(
  (ref, key) async {
    return ref.read(fixtureRepositoryProvider).hasFixturesForEvent(
          tournamentId: key.tournamentId,
          eventType: key.eventType,
        );
  },
);

final hasGroupStageFixturesProvider =
    Provider.family<AsyncValue<bool>, TournamentEventKey>(
  (ref, key) {
    final fixtures = ref.watch(fixturesForEventProvider(key));
    return fixtures.whenData(
      (list) => list.any((f) => f.fixture.groupId != null),
    );
  },
);

final hasKnockoutFixturesProvider =
    Provider.family<AsyncValue<bool>, TournamentEventKey>(
  (ref, key) {
    final fixtures = ref.watch(fixturesForEventProvider(key));
    return fixtures.whenData(
      (list) => list.any((f) => f.fixture.bracketRound != null),
    );
  },
);

final groupStageCompleteProvider =
    Provider.family<AsyncValue<bool>, TournamentEventKey>(
  (ref, key) {
    final fixtures = ref.watch(fixturesForEventProvider(key));
    return fixtures.whenData((list) {
      final groupFx = list.where((f) => f.fixture.groupId != null).toList();
      if (groupFx.isEmpty) return false;
      return groupFx.every((f) => f.fixture.status == 'completed');
    });
  },
);

final fixtureScoreEntryProvider =
    FutureProvider.family<FixtureScoreEntry?, int>(
  (ref, fixtureId) async {
    return ref.read(fixtureRepositoryProvider).getFixtureScoreEntry(fixtureId);
  },
);
