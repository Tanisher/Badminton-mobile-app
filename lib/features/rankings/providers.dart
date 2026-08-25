import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/ranking_repository.dart';
import '../players/screens/player_list_screen.dart';

final rankingRepositoryProvider = Provider<RankingRepository>(
  (ref) => RankingRepository(ref.watch(databaseProvider)),
);

/// Live ranking list for one event type (MS/WS/MD/WD/XD).
final rankingsForEventProvider =
    FutureProvider.family<List<PlayerRankingRow>, String>((ref, eventType) {
  return ref
      .watch(rankingRepositoryProvider)
      .computePlayerRankingPoints(eventType: eventType);
});
