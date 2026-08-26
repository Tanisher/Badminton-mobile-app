import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/ranking_repository.dart';
import '../../../data/repositories/tournament_repository.dart';
import '../players/screens/player_list_screen.dart';

final rankingRepositoryProvider = Provider<RankingRepository>(
  (ref) => RankingRepository(ref.watch(databaseProvider)),
);

/// MS/WS player rankings (rolling 12 months).
final playerRankingsForEventProvider =
    FutureProvider.family<List<PlayerRankingRow>, String>((ref, eventType) {
  return ref
      .watch(rankingRepositoryProvider)
      .computePlayerRankingPoints(eventType: eventType);
});

/// MD/WD/XD partnership rankings (rolling 12 months).
final partnershipRankingsForEventProvider =
    FutureProvider.family<List<PartnershipRankingRow>, String>((ref, eventType) {
  return ref
      .watch(rankingRepositoryProvider)
      .computePartnershipRankingPoints(eventType: eventType);
});

bool isDoublesEvent(String eventType) {
  return eventType == TournamentEventType.md ||
      eventType == TournamentEventType.wd ||
      eventType == TournamentEventType.xd;
}
