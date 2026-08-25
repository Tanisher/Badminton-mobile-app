import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/external_result_repository.dart';
import '../players/screens/player_list_screen.dart';

final externalResultRepositoryProvider = Provider<ExternalResultRepository>(
  (ref) => ExternalResultRepository(ref.watch(databaseProvider)),
);

final allExternalResultsProvider =
    StreamProvider<List<ExternalResultView>>((ref) {
  return ref.watch(externalResultRepositoryProvider).getAllExternalResults();
});

final externalResultsForPlayerProvider =
    StreamProvider.family<List<ExternalResultView>, int>((ref, playerId) {
  return ref
      .watch(externalResultRepositoryProvider)
      .getExternalResultsForPlayer(playerId);
});
