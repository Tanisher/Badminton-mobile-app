import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/participant_repository.dart';
import '../players/screens/player_list_screen.dart';

final participantRepositoryProvider = Provider<ParticipantRepository>(
  (ref) => ParticipantRepository(ref.watch(databaseProvider)),
);

class TournamentEventKey {
  const TournamentEventKey(this.tournamentId, this.eventType);

  final int tournamentId;
  final String eventType;

  @override
  bool operator ==(Object other) =>
      other is TournamentEventKey &&
      other.tournamentId == tournamentId &&
      other.eventType == eventType;

  @override
  int get hashCode => Object.hash(tournamentId, eventType);
}

final participantsForEventProvider = StreamProvider.family<
    List<RegisteredParticipant>, TournamentEventKey>((ref, key) {
  return ref.watch(participantRepositoryProvider).getParticipantsForTournamentEvent(
        tournamentId: key.tournamentId,
        eventType: key.eventType,
      );
});

final teamAssignmentsProvider =
    StreamProvider.family<List<TeamAssignmentView>, int>((ref, participantId) {
  return ref.watch(participantRepositoryProvider).getTeamAssignments(participantId);
});
