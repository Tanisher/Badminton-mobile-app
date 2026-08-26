import 'package:drift/drift.dart';

import '../database/database.dart';
import 'player_repository.dart';
import 'ranking_repository.dart';
import 'tournament_repository.dart';

abstract final class ParticipantType {
  static const player = 'player';
  static const pair = 'pair';
  static const competitionTeam = 'competition_team';
  static const all = [player, pair, competitionTeam];
}

class ParticipantValidationException implements Exception {
  ParticipantValidationException(this.message);
  final String message;

  @override
  String toString() => message;
}

class RegisteredParticipant {
  RegisteredParticipant({
    required this.participant,
    required this.displayName,
  });

  final TournamentParticipant participant;
  final String displayName;
}

class TeamAssignmentView {
  TeamAssignmentView({
    required this.assignment,
    required this.player,
  });

  final TeamEventAssignment assignment;
  final Player player;
}

class ParticipantRepository {
  ParticipantRepository(this._db);

  final AppDatabase _db;

  Future<int> registerPlayer({
    required int tournamentId,
    required String eventType,
    required int playerId,
  }) async {
    if (eventType != TournamentEventType.ms &&
        eventType != TournamentEventType.ws) {
      throw ParticipantValidationException(
        'Players can only be registered in MS or WS',
      );
    }

    await _assertEventSelected(tournamentId, eventType);
    final player = await _playerOrThrow(playerId);
    _assertPlayerGenderForEvent(eventType, player);
    if (!SslEligibility.isU19Eligible(player.dateOfBirth)) {
      throw ParticipantValidationException(SslEligibility.ineligibleMessage);
    }
    await _assertNotDuplicate(
      tournamentId: tournamentId,
      eventType: eventType,
      playerId: playerId,
    );

    return _db.into(_db.tournamentParticipants).insert(
          TournamentParticipantsCompanion.insert(
            tournamentId: tournamentId,
            eventType: eventType,
            participantType: ParticipantType.player,
            playerId: Value(playerId),
          ),
        );
  }

  Future<int> registerPair({
    required int tournamentId,
    required String eventType,
    required int individualTeamId,
  }) async {
    if (eventType != TournamentEventType.md &&
        eventType != TournamentEventType.wd &&
        eventType != TournamentEventType.xd) {
      throw ParticipantValidationException(
        'Pairs can only be registered in MD, WD, or XD',
      );
    }

    await _assertEventSelected(tournamentId, eventType);
    final pair = await (_db.select(_db.individualTeams)
          ..where((t) => t.id.equals(individualTeamId)))
        .getSingleOrNull();
    if (pair == null) {
      throw ParticipantValidationException(
        'Pair $individualTeamId was not found',
      );
    }
    if (pair.eventType != eventType) {
      throw ParticipantValidationException(
        'This pair is ${pair.eventType}, not $eventType',
      );
    }
    final p1 = await _playerOrThrow(pair.player1Id);
    final p2 = await _playerOrThrow(pair.player2Id);
    if (!SslEligibility.isU19Eligible(p1.dateOfBirth) ||
        !SslEligibility.isU19Eligible(p2.dateOfBirth)) {
      throw ParticipantValidationException(SslEligibility.ineligibleMessage);
    }
    await _assertNotDuplicate(
      tournamentId: tournamentId,
      eventType: eventType,
      individualTeamId: individualTeamId,
    );

    return _db.into(_db.tournamentParticipants).insert(
          TournamentParticipantsCompanion.insert(
            tournamentId: tournamentId,
            eventType: eventType,
            participantType: ParticipantType.pair,
            individualTeamId: Value(individualTeamId),
          ),
        );
  }

  Future<int> registerCompetitionTeam({
    required int tournamentId,
    required int competitionTeamId,
  }) async {
    await _assertEventSelected(tournamentId, TournamentEventType.team);
    final team = await (_db.select(_db.competitionTeams)
          ..where((t) => t.id.equals(competitionTeamId)))
        .getSingleOrNull();
    if (team == null) {
      throw ParticipantValidationException(
        'Competition team $competitionTeamId was not found',
      );
    }
    await _assertNotDuplicate(
      tournamentId: tournamentId,
      eventType: TournamentEventType.team,
      competitionTeamId: competitionTeamId,
    );

    return _db.into(_db.tournamentParticipants).insert(
          TournamentParticipantsCompanion.insert(
            tournamentId: tournamentId,
            eventType: TournamentEventType.team,
            participantType: ParticipantType.competitionTeam,
            competitionTeamId: Value(competitionTeamId),
          ),
        );
  }

  Future<int> assignTeamMember({
    required int tournamentParticipantId,
    required int playerId,
    required String assignedEvent,
  }) async {
    if (!TournamentEventType.individualEvents.contains(assignedEvent)) {
      throw ParticipantValidationException(
        "assignedEvent must be MS, WS, MD, WD, or XD — not TEAM",
      );
    }

    final parent = await (_db.select(_db.tournamentParticipants)
          ..where((t) => t.id.equals(tournamentParticipantId)))
        .getSingleOrNull();
    if (parent == null) {
      throw ParticipantValidationException(
        'Participant $tournamentParticipantId was not found',
      );
    }
    if (parent.participantType != ParticipantType.competitionTeam ||
        parent.competitionTeamId == null) {
      throw ParticipantValidationException(
        'Event assignments can only be added to a registered competition team',
      );
    }

    final onRoster = await (_db.select(_db.competitionTeamMembers)
          ..where(
            (t) =>
                t.competitionTeamId.equals(parent.competitionTeamId!) &
                t.playerId.equals(playerId),
          ))
        .getSingleOrNull();
    if (onRoster == null) {
      throw ParticipantValidationException(
        'That player is not on this competition team roster',
      );
    }

    final player = await (_db.select(_db.players)
          ..where((t) => t.id.equals(playerId)))
        .getSingleOrNull();
    if (player == null) {
      throw ParticipantValidationException('Player $playerId was not found');
    }
    _assertAssignedEventGender(assignedEvent, player);

    final existing = await (_db.select(_db.teamEventAssignments)
          ..where(
            (t) =>
                t.tournamentParticipantId.equals(tournamentParticipantId) &
                t.playerId.equals(playerId),
          ))
        .getSingleOrNull();

    if (existing != null) {
      final isDoublesEvent =
          assignedEvent == TournamentEventType.md ||
              assignedEvent == TournamentEventType.wd ||
              assignedEvent == TournamentEventType.xd;

      await _db.transaction(() async {
        // If the member switches away from doubles, drop any existing
        // explicit partner pairing.
        if (existing.partnerAssignmentId != null &&
            (!isDoublesEvent || existing.assignedEvent != assignedEvent)) {
          await unpairTeamMembers(existing.id);
        }

        await (_db.update(_db.teamEventAssignments)
              ..where((t) => t.id.equals(existing.id)))
            .write(
          TeamEventAssignmentsCompanion(
            assignedEvent: Value(assignedEvent),
          ),
        );
      });

      return existing.id;
    }

    return _db.into(_db.teamEventAssignments).insert(
          TeamEventAssignmentsCompanion.insert(
            tournamentParticipantId: tournamentParticipantId,
            playerId: playerId,
            assignedEvent: assignedEvent,
          ),
        );
  }

  /// Pair two doubles assignments for a single team tournament.
  ///
  /// Repository validation rules (enforced here, not UI):
  /// - Both assignments must belong to the same [tournamentParticipantId]
  /// - Both must have the same [assignedEvent] and it must be MD/WD/XD
  /// - Neither assignment may already be paired with someone else
  Future<void> pairTeamMembers(int assignmentId1, int assignmentId2) async {
    if (assignmentId1 == assignmentId2) {
      throw ParticipantValidationException(
        'A doubles pair must contain two different roster members',
      );
    }

    final a1 = await (_db.select(_db.teamEventAssignments)
          ..where((t) => t.id.equals(assignmentId1)))
        .getSingleOrNull();
    final a2 = await (_db.select(_db.teamEventAssignments)
          ..where((t) => t.id.equals(assignmentId2)))
        .getSingleOrNull();

    if (a1 == null || a2 == null) {
      throw ParticipantValidationException('Team assignment not found');
    }

    if (a1.tournamentParticipantId != a2.tournamentParticipantId) {
      throw ParticipantValidationException(
        'Both roster members must belong to the same team tournament entry',
      );
    }
    if (a1.assignedEvent != a2.assignedEvent) {
      throw ParticipantValidationException(
        'Both roster members must be assigned to the same doubles event',
      );
    }

    final event = a1.assignedEvent;
    final isDoubles =
        event == TournamentEventType.md || event == TournamentEventType.wd || event == TournamentEventType.xd;
    if (!isDoubles) {
      throw ParticipantValidationException(
        'Only MD, WD, and XD can be paired (not $event)',
      );
    }

    if (a1.partnerAssignmentId != null || a2.partnerAssignmentId != null) {
      throw ParticipantValidationException(
        'One or both roster members are already paired',
      );
    }

    await _db.transaction(() async {
      await (_db.update(_db.teamEventAssignments)
            ..where((t) => t.id.equals(a1.id)))
          .write(
        TeamEventAssignmentsCompanion(
          partnerAssignmentId: Value(a2.id),
        ),
      );
      await (_db.update(_db.teamEventAssignments)
            ..where((t) => t.id.equals(a2.id)))
          .write(
        TeamEventAssignmentsCompanion(
          partnerAssignmentId: Value(a1.id),
        ),
      );
    });
  }

  /// Clears partnerAssignmentId on both sides of an existing pairing.
  Future<void> unpairTeamMembers(int assignmentId1) async {
    final a1 = await (_db.select(_db.teamEventAssignments)
          ..where((t) => t.id.equals(assignmentId1)))
        .getSingleOrNull();
    if (a1 == null) {
      throw ParticipantValidationException('Team assignment not found');
    }

    final partnerId = a1.partnerAssignmentId;

    await _db.transaction(() async {
      await (_db.update(_db.teamEventAssignments)
            ..where((t) => t.id.equals(assignmentId1)))
          .write(
        TeamEventAssignmentsCompanion(
          partnerAssignmentId: const Value(null),
        ),
      );

      if (partnerId != null) {
        await (_db.update(_db.teamEventAssignments)
              ..where((t) => t.id.equals(partnerId)))
            .write(
          TeamEventAssignmentsCompanion(
            partnerAssignmentId: const Value(null),
          ),
        );
      }
    });
  }

  /// Sets withdrawn=true; does not delete the row.
  ///
  /// Withdrawal implies no ranking points (ranking rules). That logic lives
  /// in the Rankings module — this repository only preserves the flag.
  Future<void> withdrawParticipant(int participantId) async {
    final rows = await (_db.update(_db.tournamentParticipants)
          ..where((t) => t.id.equals(participantId)))
        .write(
      const TournamentParticipantsCompanion(withdrawn: Value(true)),
    );
    if (rows == 0) {
      throw ParticipantValidationException(
        'Participant $participantId was not found',
      );
    }
  }

  Future<void> reinstateParticipant(int participantId) async {
    final rows = await (_db.update(_db.tournamentParticipants)
          ..where((t) => t.id.equals(participantId)))
        .write(
      const TournamentParticipantsCompanion(withdrawn: Value(false)),
    );
    if (rows == 0) {
      throw ParticipantValidationException(
        'Participant $participantId was not found',
      );
    }
  }

  Future<void> setParticipantSeed({
    required int participantId,
    int? seed,
  }) async {
    if (seed != null && seed < 1) {
      throw ParticipantValidationException('Seed must be at least 1');
    }
    final rows = await (_db.update(_db.tournamentParticipants)
          ..where((t) => t.id.equals(participantId)))
        .write(
      TournamentParticipantsCompanion(seed: Value(seed)),
    );
    if (rows == 0) {
      throw ParticipantValidationException(
        'Participant $participantId was not found',
      );
    }
  }

  Stream<List<RegisteredParticipant>> getParticipantsForTournamentEvent({
    required int tournamentId,
    required String eventType,
  }) {
    final player = _db.alias(_db.players, 'regPlayer');
    final pair = _db.alias(_db.individualTeams, 'regPair');
    final p1 = _db.alias(_db.players, 'pairP1');
    final p2 = _db.alias(_db.players, 'pairP2');
    final team = _db.alias(_db.competitionTeams, 'regTeam');

    final query = _db.select(_db.tournamentParticipants).join([
      leftOuterJoin(player, player.id.equalsExp(_db.tournamentParticipants.playerId)),
      leftOuterJoin(
        pair,
        pair.id.equalsExp(_db.tournamentParticipants.individualTeamId),
      ),
      leftOuterJoin(p1, p1.id.equalsExp(pair.player1Id)),
      leftOuterJoin(p2, p2.id.equalsExp(pair.player2Id)),
      leftOuterJoin(
        team,
        team.id.equalsExp(_db.tournamentParticipants.competitionTeamId),
      ),
    ])
      ..where(
        _db.tournamentParticipants.tournamentId.equals(tournamentId) &
            _db.tournamentParticipants.eventType.equals(eventType),
      )
      ..orderBy([OrderingTerm.asc(_db.tournamentParticipants.createdAt)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        final participant = row.readTable(_db.tournamentParticipants);
        return RegisteredParticipant(
          participant: participant,
          displayName: _displayName(
            participant: participant,
            player: row.readTableOrNull(player),
            player1: row.readTableOrNull(p1),
            player2: row.readTableOrNull(p2),
            team: row.readTableOrNull(team),
          ),
        );
      }).toList();
    });
  }

  Stream<List<TeamAssignmentView>> getTeamAssignments(
    int tournamentParticipantId,
  ) {
    final query = _db.select(_db.teamEventAssignments).join([
      innerJoin(
        _db.players,
        _db.players.id.equalsExp(_db.teamEventAssignments.playerId),
      ),
    ])
      ..where(
        _db.teamEventAssignments.tournamentParticipantId
            .equals(tournamentParticipantId),
      )
      ..orderBy([OrderingTerm.asc(_db.players.fullName)]);

    return query.watch().map((rows) {
      return rows
          .map(
            (row) => TeamAssignmentView(
              assignment: row.readTable(_db.teamEventAssignments),
              player: row.readTable(_db.players),
            ),
          )
          .toList();
    });
  }

  Future<void> _assertEventSelected(int tournamentId, String eventType) async {
    final selected = await (_db.select(_db.tournamentEvents)
          ..where(
            (t) =>
                t.tournamentId.equals(tournamentId) &
                t.eventType.equals(eventType),
          ))
        .getSingleOrNull();
    if (selected == null) {
      throw ParticipantValidationException(
        'This tournament did not select $eventType',
      );
    }
  }

  Future<void> _assertNotDuplicate({
    required int tournamentId,
    required String eventType,
    int? playerId,
    int? individualTeamId,
    int? competitionTeamId,
  }) async {
    final query = _db.select(_db.tournamentParticipants)
      ..where(
        (t) => t.tournamentId.equals(tournamentId) & t.eventType.equals(eventType),
      );

    if (playerId != null) {
      query.where((t) => t.playerId.equals(playerId));
    } else if (individualTeamId != null) {
      query.where((t) => t.individualTeamId.equals(individualTeamId));
    } else if (competitionTeamId != null) {
      query.where((t) => t.competitionTeamId.equals(competitionTeamId));
    }

    final existing = await query.getSingleOrNull();
    if (existing != null) {
      throw ParticipantValidationException(
        'Already registered in this tournament event',
      );
    }
  }

  Future<Player> _playerOrThrow(int id) async {
    final player = await (_db.select(_db.players)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (player == null) {
      throw ParticipantValidationException('Player $id was not found');
    }
    return player;
  }

  void _assertPlayerGenderForEvent(String eventType, Player player) {
    if (eventType == TournamentEventType.ms &&
        player.gender != PlayerGender.male) {
      throw ParticipantValidationException(
        "Men's Singles registrations must be male players",
      );
    }
    if (eventType == TournamentEventType.ws &&
        player.gender != PlayerGender.female) {
      throw ParticipantValidationException(
        "Women's Singles registrations must be female players",
      );
    }
  }

  void _assertAssignedEventGender(String assignedEvent, Player player) {
    switch (assignedEvent) {
      case TournamentEventType.ms:
        if (player.gender != PlayerGender.male) {
          throw ParticipantValidationException(
            "MS assignments must be male players",
          );
        }
      case TournamentEventType.ws:
        if (player.gender != PlayerGender.female) {
          throw ParticipantValidationException(
            "WS assignments must be female players",
          );
        }
      case TournamentEventType.md:
        if (player.gender != PlayerGender.male) {
          throw ParticipantValidationException(
            "MD assignments must be male players",
          );
        }
      case TournamentEventType.wd:
        if (player.gender != PlayerGender.female) {
          throw ParticipantValidationException(
            "WD assignments must be female players",
          );
        }
      case TournamentEventType.xd:
        break; // either gender OK alone; pairing validates later
      default:
        break;
    }
  }

  String _displayName({
    required TournamentParticipant participant,
    required Player? player,
    required Player? player1,
    required Player? player2,
    required CompetitionTeam? team,
  }) {
    switch (participant.participantType) {
      case ParticipantType.player:
        return player?.fullName ?? 'Unknown player';
      case ParticipantType.pair:
        final a = player1?.fullName ?? '?';
        final b = player2?.fullName ?? '?';
        return '$a / $b';
      case ParticipantType.competitionTeam:
        return team?.teamName ?? 'Unknown team';
      default:
        return 'Participant #${participant.id}';
    }
  }
}
