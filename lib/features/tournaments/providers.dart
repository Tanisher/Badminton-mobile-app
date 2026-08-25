import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/database.dart';
import '../../../data/repositories/tournament_repository.dart';
import '../players/screens/player_list_screen.dart';

final tournamentRepositoryProvider = Provider<TournamentRepository>(
  (ref) => TournamentRepository(ref.watch(databaseProvider)),
);

final tournamentsProvider = StreamProvider<List<Tournament>>((ref) {
  return ref.watch(tournamentRepositoryProvider).getAllTournaments();
});

final tournamentDetailProvider =
    FutureProvider.family<TournamentDetails?, int>((ref, id) {
  return ref.watch(tournamentRepositoryProvider).getTournamentById(id);
});
