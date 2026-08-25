import 'dart:math';

import 'package:drift/drift.dart';

import '../database/database.dart';
import 'fixture_logic.dart';
import 'participant_repository.dart';
import 'ranking_repository.dart';
import 'tournament_repository.dart';

class SetScore {
  const SetScore({required this.participant1Score, required this.participant2Score});

  final int participant1Score;
  final int participant2Score;
}

class FixtureRowView {
  FixtureRowView({
    required this.fixture,
    required this.participant1DisplayName,
    required this.participant2DisplayName,
  });

  final Fixture fixture;
  final String participant1DisplayName;
  final String participant2DisplayName;
}

class FixtureScoreEntry {
  FixtureScoreEntry({
    required this.fixture,
    required this.participant1DisplayName,
    required this.participant2DisplayName,
    required this.status,
    required this.sets,
  });

  final Fixture fixture;
  final String participant1DisplayName;
  final String participant2DisplayName;
  final String status;
  final List<SetScore> sets;
}

class StandingsRow {
  StandingsRow({
    required this.position,
    required this.participantId,
    required this.participantDisplayName,
    required this.played,
    required this.won,
    required this.lost,
  });

  final int position;
  final int participantId;
  final String participantDisplayName;
  final int played;
  final int won;
  final int lost;
}

class FixturesAlreadyExistException implements Exception {
  FixturesAlreadyExistException(this.message);
  final String message;

  @override
  String toString() => message;
}

class FixturesCompletedExistException implements Exception {
  FixturesCompletedExistException(this.message);
  final String message;

  @override
  String toString() => message;
}

class DownstreamResultsExistException implements Exception {
  DownstreamResultsExistException(this.message);
  final String message;

  @override
  String toString() => message;
}

class FixtureRepository {
  FixtureRepository(this._db);

  final AppDatabase _db;

  // -----------------------------
  // Fixtures exist / access
  // -----------------------------
  Future<bool> hasFixturesForEvent({
    required int tournamentId,
    required String eventType,
  }) async {
    final count = await (_db.select(_db.fixtures)
          ..where(
            (f) => f.tournamentId.equals(tournamentId) & f.eventType.equals(eventType),
          ))
        .get()
        .then((rows) => rows.length);
    return count > 0;
  }

  Stream<List<FixtureRowView>> watchFixturesForEvent({
    required int tournamentId,
    required String eventType,
  }) {
    final fixturesQuery = (_db.select(_db.fixtures)
          ..where(
            (f) => f.tournamentId.equals(tournamentId) & f.eventType.equals(eventType),
          )
          ..orderBy([
            (f) => OrderingTerm.asc(f.roundNumber),
            (f) => OrderingTerm.asc(f.courtNumber),
            (f) => OrderingTerm.asc(f.id),
          ]));

    return fixturesQuery.watch().asyncMap((fixtures) async {
      final participantIds = <int>{};
      for (final f in fixtures) {
        if (f.participant1Id != null) participantIds.add(f.participant1Id!);
        if (f.participant2Id != null) participantIds.add(f.participant2Id!);
      }
      final names = await _resolveParticipantDisplayNames(participantIds);

      return fixtures
          .map(
            (f) => FixtureRowView(
              fixture: f,
              participant1DisplayName: f.participant1Id == null
                  ? 'TBD'
                  : (names[f.participant1Id] ?? '—'),
              participant2DisplayName: f.participant2Id == null
                  ? 'TBD'
                  : (names[f.participant2Id] ?? '—'),
            ),
          )
          .toList();
    });
  }

  Future<FixtureScoreEntry?> getFixtureScoreEntry(int fixtureId) async {
    final fixture = await (_db.select(_db.fixtures)
          ..where((f) => f.id.equals(fixtureId)))
        .getSingleOrNull();
    if (fixture == null) return null;

    final ids = <int>{
      if (fixture.participant1Id != null) fixture.participant1Id!,
      if (fixture.participant2Id != null) fixture.participant2Id!,
    };
    final names = await _resolveParticipantDisplayNames(ids);

    final setsRows = await (_db.select(_db.fixtureSets)
          ..where((s) => s.fixtureId.equals(fixtureId))
          ..orderBy([(s) => OrderingTerm.asc(s.setNumber)]))
        .get();

    final sets = setsRows
        .map((s) => SetScore(
              participant1Score: s.participant1Score,
              participant2Score: s.participant2Score,
            ))
        .toList();

    return FixtureScoreEntry(
      fixture: fixture,
      participant1DisplayName: fixture.participant1Id == null
          ? 'TBD'
          : (names[fixture.participant1Id] ?? '—'),
      participant2DisplayName: fixture.participant2Id == null
          ? 'TBD'
          : (names[fixture.participant2Id] ?? '—'),
      status: fixture.status,
      sets: sets,
    );
  }

  Future<void> generateRoundRobinFixtures({
    required int tournamentId,
    required String eventType,
  }) async {
    // Reject if any fixtures already exist for that tournament+event.
    final existingCount = await (_db.select(_db.fixtures)
          ..where(
            (f) => f.tournamentId.equals(tournamentId) & f.eventType.equals(eventType),
          ))
        .get()
        .then((rows) => rows.length);
    if (existingCount > 0) {
      throw FixturesAlreadyExistException(
        'Fixtures already exist for this tournament/event. Clear them first to regenerate.',
      );
    }

    // Fetch non-withdrawn participants.
    final tournament = await (_db.select(_db.tournaments)
          ..where((t) => t.id.equals(tournamentId)))
        .getSingle();

    if (tournament.format != TournamentFormat.roundRobin) {
      throw ArgumentError('Fixtures can only be generated for round_robin tournaments');
    }

    final participants = await (_db.select(_db.tournamentParticipants)
          ..where((t) =>
              t.tournamentId.equals(tournamentId) &
              t.eventType.equals(eventType) &
              t.withdrawn.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();

    if (participants.length < 2) {
      throw ArgumentError(
        'Need at least 2 non-withdrawn participants to generate round-robin fixtures',
      );
    }

    final scheduled = scheduleRoundRobinWithCourts(
      participantIds: participants.map((p) => p.id).toList(),
      courtCount: tournament.numberOfCourts,
    );

    final fixturesToInsert = scheduled
        .map(
          (m) => FixturesCompanion.insert(
            tournamentId: tournamentId,
            eventType: eventType,
            participant1Id: Value(m.participant1Id),
            participant2Id: Value(m.participant2Id),
            roundNumber: m.roundNumber,
            courtNumber: Value(m.courtNumber),
          ),
        )
        .toList();

    await _db.transaction(() async {
      await _db.batch((batch) {
        batch.insertAll(_db.fixtures, fixturesToInsert);
      });
    });
  }

  Future<void> clearFixtures({
    required int tournamentId,
    required String eventType,
    bool allowCompleted = false,
  }) async {
    if (!allowCompleted) {
      final completedReal = await (_db.select(_db.fixtures)
            ..where((f) =>
                f.tournamentId.equals(tournamentId) &
                f.eventType.equals(eventType) &
                f.status.equals('completed') &
                f.isBye.equals(false)))
          .get()
          .then((rows) => rows.length);

      if (completedReal > 0) {
        throw FixturesCompletedExistException(
          'Cannot clear fixtures because some matches already have results. '
          'Confirm force-clear to wipe recorded results, or clear only pending.',
        );
      }
    }

    await (_db.delete(_db.fixtures)
          ..where((f) =>
              f.tournamentId.equals(tournamentId) &
              f.eventType.equals(eventType)))
        .go();
  }

  /// Deletes only knockout-phase fixtures (bracketRound set), keeping group stage.
  Future<void> clearKnockoutFixtures({
    required int tournamentId,
    required String eventType,
    bool allowCompleted = false,
  }) async {
    if (!allowCompleted) {
      final completedReal = await (_db.select(_db.fixtures)
            ..where((f) =>
                f.tournamentId.equals(tournamentId) &
                f.eventType.equals(eventType) &
                f.bracketRound.isNotNull() &
                f.status.equals('completed') &
                f.isBye.equals(false)))
          .get();
      if (completedReal.isNotEmpty) {
        throw FixturesCompletedExistException(
          'Cannot clear knockout fixtures: ${completedReal.length} completed '
          'match(es). Force-clear to wipe those results.',
        );
      }
    }

    await (_db.delete(_db.fixtures)
          ..where((f) =>
              f.tournamentId.equals(tournamentId) &
              f.eventType.equals(eventType) &
              f.bracketRound.isNotNull()))
        .go();
  }

  /// Deletes only group-stage fixtures (groupId set). Rejects if knockout exists.
  Future<void> clearGroupStageFixtures({
    required int tournamentId,
    required String eventType,
    bool allowCompleted = false,
  }) async {
    if (await hasKnockoutFixtures(
      tournamentId: tournamentId,
      eventType: eventType,
    )) {
      throw ArgumentError(
        'Clear the knockout bracket first before clearing group-stage fixtures.',
      );
    }

    if (!allowCompleted) {
      final completedReal = await (_db.select(_db.fixtures)
            ..where((f) =>
                f.tournamentId.equals(tournamentId) &
                f.eventType.equals(eventType) &
                f.groupId.isNotNull() &
                f.status.equals('completed') &
                f.isBye.equals(false)))
          .get();
      if (completedReal.isNotEmpty) {
        throw FixturesCompletedExistException(
          'Cannot clear group fixtures: ${completedReal.length} completed '
          'match(es). Force-clear to wipe those results.',
        );
      }
    }

    await (_db.delete(_db.fixtures)
          ..where((f) =>
              f.tournamentId.equals(tournamentId) &
              f.eventType.equals(eventType) &
              f.groupId.isNotNull()))
        .go();
  }

  /// Removes Groups + GroupParticipants for an event.
  /// Requires group-stage and knockout fixtures to be cleared first.
  Future<void> clearGroups({
    required int tournamentId,
    required String eventType,
  }) async {
    if (await hasGroupStageFixtures(
      tournamentId: tournamentId,
      eventType: eventType,
    )) {
      throw ArgumentError(
        'Clear group-stage fixtures before clearing groups.',
      );
    }
    if (await hasKnockoutFixtures(
      tournamentId: tournamentId,
      eventType: eventType,
    )) {
      throw ArgumentError(
        'Clear the knockout bracket before clearing groups.',
      );
    }

    final groups = await (_db.select(_db.groups)
          ..where(
            (g) =>
                g.tournamentId.equals(tournamentId) &
                g.eventType.equals(eventType),
          ))
        .get();

    await _db.transaction(() async {
      for (final g in groups) {
        await (_db.delete(_db.groupParticipants)
              ..where((gp) => gp.groupId.equals(g.id)))
            .go();
        await (_db.delete(_db.groups)..where((row) => row.id.equals(g.id))).go();
      }
    });
  }

  // -----------------------------
  // Knockout seeding & bracket
  // -----------------------------

  /// Ordered participant list for knockout seeding.
  ///
  /// Order of preference:
  /// 1. Ranking points for [eventType] (higher points = better seed)
  /// 2. Manual [TournamentParticipants.seed] column (ascending = seed 1 highest)
  /// 3. Random shuffle
  Future<List<TournamentParticipant>> seedParticipants({
    required int tournamentId,
    required String eventType,
  }) async {
    final participants = await (_db.select(_db.tournamentParticipants)
          ..where((t) =>
              t.tournamentId.equals(tournamentId) &
              t.eventType.equals(eventType) &
              t.withdrawn.equals(false)))
        .get();

    if (participants.isEmpty) return participants;

    final rankingRepo = RankingRepository(_db);
    final rankings = await rankingRepo.computePlayerRankingPoints(
      eventType: eventType,
    );
    final pointsByPlayer = {
      for (final r in rankings) r.playerId: r.totalPoints,
    };

    final scoreByParticipant = <int, int>{};
    var anyRanked = false;
    for (final p in participants) {
      final playerIds = await _playerIdsForParticipant(p);
      final score = playerIds.fold<int>(
        0,
        (sum, id) => sum + (pointsByPlayer[id] ?? 0),
      );
      scoreByParticipant[p.id] = score;
      if (score > 0) anyRanked = true;
    }

    if (anyRanked) {
      participants.sort((a, b) {
        final byPts = scoreByParticipant[b.id]!
            .compareTo(scoreByParticipant[a.id]!);
        if (byPts != 0) return byPts;
        return a.id.compareTo(b.id);
      });
      return participants;
    }

    final anySeeded = participants.any((p) => p.seed != null);
    if (anySeeded) {
      participants.sort((a, b) {
        if (a.seed == null && b.seed == null) {
          return a.id.compareTo(b.id);
        }
        if (a.seed == null) return 1;
        if (b.seed == null) return -1;
        final bySeed = a.seed!.compareTo(b.seed!);
        if (bySeed != 0) return bySeed;
        return a.id.compareTo(b.id);
      });
    } else {
      participants.shuffle(Random());
    }
    return participants;
  }

  Future<void> generateKnockoutBracket({
    required int tournamentId,
    required String eventType,
  }) async {
    final existingCount = await (_db.select(_db.fixtures)
          ..where(
            (f) =>
                f.tournamentId.equals(tournamentId) &
                f.eventType.equals(eventType),
          ))
        .get()
        .then((rows) => rows.length);
    if (existingCount > 0) {
      throw FixturesAlreadyExistException(
        'Fixtures already exist for this tournament/event. Clear them first to regenerate.',
      );
    }

    final tournament = await (_db.select(_db.tournaments)
          ..where((t) => t.id.equals(tournamentId)))
        .getSingle();

    if (tournament.format != TournamentFormat.knockout) {
      throw ArgumentError(
        'Knockout brackets can only be generated for knockout tournaments',
      );
    }

    final seeded = await seedParticipants(
      tournamentId: tournamentId,
      eventType: eventType,
    );
    if (seeded.length < 2) {
      throw ArgumentError(
        'Need at least 2 non-withdrawn participants to generate a knockout bracket',
      );
    }

    final bracketSize = nextPowerOfTwo(seeded.length);
    final seedOrder = standardSeedPositions(bracketSize);
    final slots = List<int?>.filled(bracketSize, null);
    for (var seed = 1; seed <= seeded.length; seed++) {
      final pos = seedOrder.indexOf(seed);
      slots[pos] = seeded[seed - 1].id;
    }

    await _db.transaction(() async {
      await _insertKnockoutBracketStructure(
        tournamentId: tournamentId,
        eventType: eventType,
        tournament: tournament,
        bracketSize: bracketSize,
        firstRoundSlots: slots,
      );
    });
  }

  /// Shared knockout bracket insert (pure knockout + group→knockout).
  Future<void> _insertKnockoutBracketStructure({
    required int tournamentId,
    required String eventType,
    required Tournament tournament,
    required int bracketSize,
    required List<int?> firstRoundSlots,
  }) async {
    final roundNames = knockoutRoundNames(bracketSize);
    final roundFixtures = <List<int>>[];

    for (var r = roundNames.length - 1; r >= 0; r--) {
      final matchCount = bracketSize ~/ (1 << (r + 1));
      final ids = <int>[];
      for (var m = 0; m < matchCount; m++) {
        int? nextId;
        int? nextSlot;
        if (r < roundNames.length - 1) {
          nextId = roundFixtures[0][m ~/ 2];
          nextSlot = (m % 2) + 1;
        }

        final id = await _db.into(_db.fixtures).insert(
              FixturesCompanion.insert(
                tournamentId: tournamentId,
                eventType: eventType,
                roundNumber: r + 1,
                bracketRound: Value(roundNames[r]),
                nextFixtureId: Value(nextId),
                nextFixtureSlot: Value(nextSlot),
                isBye: const Value(false),
              ),
            );
        ids.add(id);
      }
      roundFixtures.insert(0, ids);
    }

    if (tournament.hasBronzeMedalMatch &&
        roundNames.contains(BracketRound.semifinal)) {
      final sfIndex = roundNames.indexOf(BracketRound.semifinal);
      final semis = roundFixtures[sfIndex];
      final bronzeId = await _db.into(_db.fixtures).insert(
            FixturesCompanion.insert(
              tournamentId: tournamentId,
              eventType: eventType,
              roundNumber: sfIndex + 1,
              bracketRound: const Value(BracketRound.bronzeMedalMatch),
              isBye: const Value(false),
            ),
          );
      for (var i = 0; i < semis.length; i++) {
        await (_db.update(_db.fixtures)..where((f) => f.id.equals(semis[i])))
            .write(
          FixturesCompanion(
            loserNextFixtureId: Value(bronzeId),
            loserNextFixtureSlot: Value(i + 1),
          ),
        );
      }
    }

    final firstRound = roundFixtures[0];
    for (var m = 0; m < firstRound.length; m++) {
      final p1 = firstRoundSlots[m * 2];
      final p2 = firstRoundSlots[m * 2 + 1];
      final fixtureId = firstRound[m];
      final isBye = (p1 == null) != (p2 == null);

      if (p1 == null && p2 == null) {
        // Empty bye-bye slot should not occur with valid seeding; leave TBD.
        continue;
      }

      if (isBye) {
        final advancer = p1 ?? p2!;
        await (_db.update(_db.fixtures)..where((f) => f.id.equals(fixtureId)))
            .write(
          FixturesCompanion(
            participant1Id: Value(p1),
            participant2Id: Value(p2),
            isBye: const Value(true),
            status: const Value('completed'),
            winnerParticipantId: Value(advancer),
          ),
        );

        final fixture = await (_db.select(_db.fixtures)
              ..where((f) => f.id.equals(fixtureId)))
            .getSingle();
        await _writeParticipantIntoSlot(
          nextFixtureId: fixture.nextFixtureId,
          slot: fixture.nextFixtureSlot,
          participantId: advancer,
        );
      } else {
        await (_db.update(_db.fixtures)..where((f) => f.id.equals(fixtureId)))
            .write(
          FixturesCompanion(
            participant1Id: Value(p1),
            participant2Id: Value(p2),
          ),
        );
      }
    }
  }

  // -----------------------------
  // Results
  // -----------------------------

  Future<void> recordResult({
    required int fixtureId,
    required List<SetScore> sets,
  }) async {
    final fixture = await (_db.select(_db.fixtures)
          ..where((f) => f.id.equals(fixtureId)))
        .getSingleOrNull();
    if (fixture == null) {
      throw ArgumentError('Fixture $fixtureId not found');
    }
    if (fixture.isBye) {
      throw ArgumentError('Cannot record a result for a bye fixture');
    }
    if (fixture.status == 'completed') {
      throw ArgumentError(
        'Fixture $fixtureId already completed. Use editResult instead.',
      );
    }
    if (fixture.participant1Id == null || fixture.participant2Id == null) {
      throw ArgumentError(
        'Both participants must be known before recording a result',
      );
    }

    final winnerId = determineMatchWinner(
      sets: sets,
      participant1Id: fixture.participant1Id!,
      participant2Id: fixture.participant2Id!,
    );

    await _db.transaction(() async {
      await _saveSetsAndWinner(
        fixtureId: fixtureId,
        sets: sets,
        winnerId: winnerId,
      );
      await _applyCareerStatsForResult(
        fixture: fixture,
        winnerParticipantId: winnerId,
        reverse: false,
      );
      await _propagateKnockoutResult(
        fixture: fixture,
        winnerId: winnerId,
      );
    });
  }

  Future<void> editResult({
    required int fixtureId,
    required List<SetScore> sets,
  }) async {
    final fixture = await (_db.select(_db.fixtures)
          ..where((f) => f.id.equals(fixtureId)))
        .getSingleOrNull();
    if (fixture == null) {
      throw ArgumentError('Fixture $fixtureId not found');
    }
    if (fixture.isBye) {
      throw ArgumentError('Cannot edit a bye fixture');
    }
    if (fixture.participant1Id == null || fixture.participant2Id == null) {
      throw ArgumentError(
        'Both participants must be known before editing a result',
      );
    }

    final winnerId = determineMatchWinner(
      sets: sets,
      participant1Id: fixture.participant1Id!,
      participant2Id: fixture.participant2Id!,
    );

    // Known limitation (spec §3.3): full cascade-undo of downstream completed
    // fixtures is not implemented. Organiser must clear downstream results first.
    await _assertDownstreamEditable(fixture);

    await _db.transaction(() async {
      if (fixture.status == 'completed' &&
          fixture.winnerParticipantId != null) {
        await _applyCareerStatsForResult(
          fixture: fixture,
          winnerParticipantId: fixture.winnerParticipantId!,
          reverse: true,
        );
      }
      await _saveSetsAndWinner(
        fixtureId: fixtureId,
        sets: sets,
        winnerId: winnerId,
      );
      await _applyCareerStatsForResult(
        fixture: fixture,
        winnerParticipantId: winnerId,
        reverse: false,
      );
      await _propagateKnockoutResult(
        fixture: fixture,
        winnerId: winnerId,
      );
    });
  }

  /// Increments (or reverses) career stats on [Players] for a completed match.
  Future<void> _applyCareerStatsForResult({
    required Fixture fixture,
    required int winnerParticipantId,
    required bool reverse,
  }) async {
    if (fixture.isBye) return;
    final p1Id = fixture.participant1Id;
    final p2Id = fixture.participant2Id;
    if (p1Id == null || p2Id == null) return;

    final delta = reverse ? -1 : 1;
    final p1 = await (_db.select(_db.tournamentParticipants)
          ..where((t) => t.id.equals(p1Id)))
        .getSingleOrNull();
    final p2 = await (_db.select(_db.tournamentParticipants)
          ..where((t) => t.id.equals(p2Id)))
        .getSingleOrNull();
    if (p1 == null || p2 == null) return;

    final p1Players = await _playerIdsForParticipant(p1);
    final p2Players = await _playerIdsForParticipant(p2);
    final winnerIsP1 = winnerParticipantId == p1Id;
    final winnerPlayers = winnerIsP1 ? p1Players : p2Players;
    final loserPlayers = winnerIsP1 ? p2Players : p1Players;
    final isFinal = fixture.bracketRound == BracketRound.final_;

    final touched = <int>{...p1Players, ...p2Players};
    for (final id in touched) {
      final isWinner = winnerPlayers.contains(id);
      final isLoser = loserPlayers.contains(id);
      await _adjustPlayerStat(
        id,
        matchesPlayed: delta,
        matchesWon: isWinner ? delta : 0,
        matchesLost: isLoser ? delta : 0,
        titlesWon: (isWinner && isFinal) ? delta : 0,
      );
    }
  }

  Future<void> _adjustPlayerStat(
    int playerId, {
    int matchesPlayed = 0,
    int matchesWon = 0,
    int matchesLost = 0,
    int titlesWon = 0,
  }) async {
    final player = await (_db.select(_db.players)
          ..where((p) => p.id.equals(playerId)))
        .getSingleOrNull();
    if (player == null) return;

    int clampNonNeg(int value) => value < 0 ? 0 : value;

    await (_db.update(_db.players)..where((p) => p.id.equals(playerId))).write(
      PlayersCompanion(
        matchesPlayed: Value(clampNonNeg(player.matchesPlayed + matchesPlayed)),
        matchesWon: Value(clampNonNeg(player.matchesWon + matchesWon)),
        matchesLost: Value(clampNonNeg(player.matchesLost + matchesLost)),
        titlesWon: Value(clampNonNeg(player.titlesWon + titlesWon)),
      ),
    );
  }

  Future<List<int>> _playerIdsForParticipant(
    TournamentParticipant participant,
  ) async {
    switch (participant.participantType) {
      case ParticipantType.player:
        return participant.playerId != null ? [participant.playerId!] : const [];
      case ParticipantType.pair:
        if (participant.individualTeamId == null) return const [];
        final team = await (_db.select(_db.individualTeams)
              ..where((t) => t.id.equals(participant.individualTeamId!)))
            .getSingleOrNull();
        if (team == null) return const [];
        return [team.player1Id, team.player2Id];
      case ParticipantType.competitionTeam:
        return const [];
      default:
        return const [];
    }
  }

  Future<void> _saveSetsAndWinner({
    required int fixtureId,
    required List<SetScore> sets,
    required int winnerId,
  }) async {
    await (_db.delete(_db.fixtureSets)
          ..where((s) => s.fixtureId.equals(fixtureId)))
        .go();

    await _db.batch((batch) {
      for (var i = 0; i < sets.length; i++) {
        final set = sets[i];
        batch.insert(
          _db.fixtureSets,
          FixtureSetsCompanion.insert(
            fixtureId: fixtureId,
            setNumber: i + 1,
            participant1Score: set.participant1Score,
            participant2Score: set.participant2Score,
          ),
        );
      }
    });

    await (_db.update(_db.fixtures)..where((f) => f.id.equals(fixtureId))).write(
      FixturesCompanion(
        status: const Value('completed'),
        winnerParticipantId: Value(winnerId),
      ),
    );
  }

  /// Throws if any fixture this result already fed is itself completed.
  Future<void> _assertDownstreamEditable(Fixture fixture) async {
    Future<void> check(int? nextId) async {
      if (nextId == null) return;
      final next = await (_db.select(_db.fixtures)
            ..where((f) => f.id.equals(nextId)))
          .getSingleOrNull();
      if (next != null && next.status == 'completed' && !next.isBye) {
        throw DownstreamResultsExistException(
          'Cannot edit this result because a later fixture in the bracket '
          'already has a recorded result. Clear results in affected downstream '
          'fixtures first, then edit this one.',
        );
      }
    }

    await check(fixture.nextFixtureId);
    await check(fixture.loserNextFixtureId);
  }

  Future<void> _propagateKnockoutResult({
    required Fixture fixture,
    required int winnerId,
  }) async {
    if (fixture.nextFixtureId == null && fixture.loserNextFixtureId == null) {
      return;
    }

    final p1 = fixture.participant1Id!;
    final p2 = fixture.participant2Id!;
    final loserId = winnerId == p1 ? p2 : p1;

    await _writeParticipantIntoSlot(
      nextFixtureId: fixture.nextFixtureId,
      slot: fixture.nextFixtureSlot,
      participantId: winnerId,
    );

    await _writeParticipantIntoSlot(
      nextFixtureId: fixture.loserNextFixtureId,
      slot: fixture.loserNextFixtureSlot,
      participantId: loserId,
    );
  }

  Future<void> _writeParticipantIntoSlot({
    required int? nextFixtureId,
    required int? slot,
    required int participantId,
  }) async {
    if (nextFixtureId == null || slot == null) return;
    if (slot != 1 && slot != 2) {
      throw ArgumentError('nextFixtureSlot must be 1 or 2, got $slot');
    }

    final companion = slot == 1
        ? FixturesCompanion(participant1Id: Value(participantId))
        : FixturesCompanion(participant2Id: Value(participantId));

    await (_db.update(_db.fixtures)..where((f) => f.id.equals(nextFixtureId)))
        .write(companion);
  }

  // -----------------------------
  // Group + Knockout
  // -----------------------------

  Future<bool> hasGroupsForEvent({
    required int tournamentId,
    required String eventType,
  }) async {
    final rows = await (_db.select(_db.groups)
          ..where(
            (g) =>
                g.tournamentId.equals(tournamentId) &
                g.eventType.equals(eventType),
          ))
        .get();
    return rows.isNotEmpty;
  }

  Stream<List<Group>> watchGroupsForEvent({
    required int tournamentId,
    required String eventType,
  }) {
    return (_db.select(_db.groups)
          ..where(
            (g) =>
                g.tournamentId.equals(tournamentId) &
                g.eventType.equals(eventType),
          )
          ..orderBy([(g) => OrderingTerm.asc(g.groupNumber)]))
        .watch();
  }

  Future<bool> hasGroupStageFixtures({
    required int tournamentId,
    required String eventType,
  }) async {
    final rows = await (_db.select(_db.fixtures)
          ..where(
            (f) =>
                f.tournamentId.equals(tournamentId) &
                f.eventType.equals(eventType) &
                f.groupId.isNotNull(),
          ))
        .get();
    return rows.isNotEmpty;
  }

  Future<bool> hasKnockoutFixtures({
    required int tournamentId,
    required String eventType,
  }) async {
    final rows = await (_db.select(_db.fixtures)
          ..where(
            (f) =>
                f.tournamentId.equals(tournamentId) &
                f.eventType.equals(eventType) &
                f.bracketRound.isNotNull(),
          ))
        .get();
    return rows.isNotEmpty;
  }

  Future<bool> areAllGroupFixturesCompleted({
    required int tournamentId,
    required String eventType,
  }) async {
    final pending = await (_db.select(_db.fixtures)
          ..where(
            (f) =>
                f.tournamentId.equals(tournamentId) &
                f.eventType.equals(eventType) &
                f.groupId.isNotNull() &
                f.status.equals('pending'),
          ))
        .get();
    return pending.isEmpty &&
        await hasGroupStageFixtures(
          tournamentId: tournamentId,
          eventType: eventType,
        );
  }

  Future<void> assignGroups({
    required int tournamentId,
    required String eventType,
  }) async {
    final tournament = await (_db.select(_db.tournaments)
          ..where((t) => t.id.equals(tournamentId)))
        .getSingle();
    if (tournament.format != TournamentFormat.groupKnockout) {
      throw ArgumentError(
        'Groups can only be assigned for group_knockout tournaments',
      );
    }

    if (await hasGroupsForEvent(
      tournamentId: tournamentId,
      eventType: eventType,
    )) {
      throw FixturesAlreadyExistException(
        'Groups already exist for this tournament/event. Clear them first to reassign.',
      );
    }

    final settings = await (_db.select(_db.groupKnockoutSettings)
          ..where((s) => s.tournamentId.equals(tournamentId)))
        .getSingleOrNull();
    if (settings == null) {
      throw ArgumentError(
        'Missing GroupKnockoutSettings for tournament $tournamentId',
      );
    }

    final seeded = await seedParticipants(
      tournamentId: tournamentId,
      eventType: eventType,
    );
    if (seeded.isEmpty) {
      throw ArgumentError('No participants to assign to groups');
    }

    final buckets = snakeDistribute(seeded, settings.numberOfGroups);

    await _db.transaction(() async {
      for (var i = 0; i < buckets.length; i++) {
        final groupId = await _db.into(_db.groups).insert(
              GroupsCompanion.insert(
                tournamentId: tournamentId,
                eventType: eventType,
                groupNumber: i + 1,
              ),
            );
        for (final p in buckets[i]) {
          await _db.into(_db.groupParticipants).insert(
                GroupParticipantsCompanion.insert(
                  groupId: groupId,
                  tournamentParticipantId: p.id,
                ),
              );
        }
      }
    });
  }

  Future<void> generateGroupStageFixtures({
    required int tournamentId,
    required String eventType,
  }) async {
    final tournament = await (_db.select(_db.tournaments)
          ..where((t) => t.id.equals(tournamentId)))
        .getSingle();
    if (tournament.format != TournamentFormat.groupKnockout) {
      throw ArgumentError(
        'Group-stage fixtures require format group_knockout',
      );
    }

    if (await hasGroupStageFixtures(
      tournamentId: tournamentId,
      eventType: eventType,
    )) {
      throw FixturesAlreadyExistException(
        'Group-stage fixtures already exist for this tournament/event.',
      );
    }

    final groups = await (_db.select(_db.groups)
          ..where(
            (g) =>
                g.tournamentId.equals(tournamentId) &
                g.eventType.equals(eventType),
          )
          ..orderBy([(g) => OrderingTerm.asc(g.groupNumber)]))
        .get();
    if (groups.isEmpty) {
      throw ArgumentError('Assign groups before generating group-stage fixtures');
    }

    // Per-group RR schedules, then pack each schedule-round across groups
    // into court-limited global rounds (participants never clash across groups).
    final perGroupRounds =
        <List<List<({int a, int b, int groupId})>>>[];
    var maxRounds = 0;
    for (final group in groups) {
      final members = await (_db.select(_db.groupParticipants)
            ..where((gp) => gp.groupId.equals(group.id)))
          .get();
      final ids = members.map((m) => m.tournamentParticipantId).toList();
      final rounds = buildRoundRobinRounds(ids);
      final tagged = rounds
          .map(
            (matches) => matches
                .map((m) => (a: m.a, b: m.b, groupId: group.id))
                .toList(),
          )
          .toList();
      perGroupRounds.add(tagged);
      if (tagged.length > maxRounds) maxRounds = tagged.length;
    }

    final courtCount = max(1, tournament.numberOfCourts);
    final fixturesToInsert = <FixturesCompanion>[];
    var roundNumber = 1;

    for (var r = 0; r < maxRounds; r++) {
      final matches = <({int a, int b, int groupId})>[];
      for (final schedule in perGroupRounds) {
        if (r < schedule.length) matches.addAll(schedule[r]);
      }

      final subSlots = (matches.length + courtCount - 1) ~/ courtCount;
      for (var sub = 0; sub < subSlots; sub++) {
        final start = sub * courtCount;
        final end = min(start + courtCount, matches.length);
        for (var mi = start; mi < end; mi++) {
          final match = matches[mi];
          fixturesToInsert.add(
            FixturesCompanion.insert(
              tournamentId: tournamentId,
              eventType: eventType,
              participant1Id: Value(match.a),
              participant2Id: Value(match.b),
              roundNumber: roundNumber,
              courtNumber: Value((mi - start) + 1),
              groupId: Value(match.groupId),
            ),
          );
        }
        roundNumber++;
      }
    }

    await _db.transaction(() async {
      await _db.batch((batch) {
        batch.insertAll(_db.fixtures, fixturesToInsert);
      });
    });
  }

  Stream<List<StandingsRow>> getGroupStandings({
    required int tournamentId,
    required String eventType,
    required int groupId,
  }) {
    return _watchStandings(
      tournamentId: tournamentId,
      eventType: eventType,
      groupId: groupId,
    );
  }

  Future<void> generateKnockoutFromGroups({
    required int tournamentId,
    required String eventType,
  }) async {
    final tournament = await (_db.select(_db.tournaments)
          ..where((t) => t.id.equals(tournamentId)))
        .getSingle();
    if (tournament.format != TournamentFormat.groupKnockout) {
      throw ArgumentError(
        'generateKnockoutFromGroups requires format group_knockout',
      );
    }

    if (await hasKnockoutFixtures(
      tournamentId: tournamentId,
      eventType: eventType,
    )) {
      throw FixturesAlreadyExistException(
        'Knockout fixtures already exist for this tournament/event.',
      );
    }

    final settings = await (_db.select(_db.groupKnockoutSettings)
          ..where((s) => s.tournamentId.equals(tournamentId)))
        .getSingleOrNull();
    if (settings == null) {
      throw ArgumentError('Missing GroupKnockoutSettings');
    }

    final groups = await (_db.select(_db.groups)
          ..where(
            (g) =>
                g.tournamentId.equals(tournamentId) &
                g.eventType.equals(eventType),
          )
          ..orderBy([(g) => OrderingTerm.asc(g.groupNumber)]))
        .get();
    if (groups.isEmpty) {
      throw ArgumentError('No groups found — assign groups first');
    }

    // Require all group-stage fixtures completed.
    final pendingByGroup = <int, int>{};
    for (final group in groups) {
      final pending = await (_db.select(_db.fixtures)
            ..where(
              (f) =>
                  f.groupId.equals(group.id) & f.status.equals('pending'),
            ))
          .get();
      if (pending.isNotEmpty) {
        pendingByGroup[group.groupNumber] = pending.length;
      }
    }
    if (pendingByGroup.isNotEmpty) {
      final detail = pendingByGroup.entries
          .map((e) => 'Group ${e.key} (${e.value} pending)')
          .join(', ');
      throw ArgumentError(
        'All group-stage fixtures must be completed before generating the '
        'knockout bracket. Still pending: $detail',
      );
    }

    final bracketSize = bracketSlotsForStartStage(settings.knockoutStartStage);
    final qualifiersByGroup = <List<int>>[];
    var totalQualifiers = 0;

    for (final group in groups) {
      final standings = await _computeStandingsOnce(
        tournamentId: tournamentId,
        eventType: eventType,
        groupId: group.id,
      );
      final take = min(settings.qualifiersPerGroup, standings.length);
      // Soft: advance however many the group actually has (up to qualifiersPerGroup).
      if (take == 0) continue;
      final ids = standings.take(take).map((s) => s.participantId).toList();
      qualifiersByGroup.add(ids);
      totalQualifiers += ids.length;
    }

    if (totalQualifiers < 2) {
      throw ArgumentError('Need at least 2 qualifiers for a knockout bracket');
    }
    if (totalQualifiers > bracketSize) {
      throw ArgumentError(
        'Total qualifiers ($totalQualifiers) exceed the '
        '${settings.knockoutStartStage} bracket size ($bracketSize). '
        'Reduce qualifiersPerGroup or choose a later knockout start stage.',
      );
    }

    final slots = buildCrossGroupFirstRoundSlots(
      qualifiersByGroup: qualifiersByGroup,
      bracketSize: bracketSize,
    );

    await _db.transaction(() async {
      await _insertKnockoutBracketStructure(
        tournamentId: tournamentId,
        eventType: eventType,
        tournament: tournament,
        bracketSize: bracketSize,
        firstRoundSlots: slots,
      );
    });
  }

  // -----------------------------
  // Standings
  // -----------------------------

  Stream<List<StandingsRow>> getStandings({
    required int tournamentId,
    required String eventType,
  }) {
    return _watchStandings(
      tournamentId: tournamentId,
      eventType: eventType,
      groupId: null,
    );
  }

  Stream<List<StandingsRow>> _watchStandings({
    required int tournamentId,
    required String eventType,
    required int? groupId,
  }) {
    final completedFixturesWatch = (_db.select(_db.fixtures)
          ..where(
            (f) =>
                f.tournamentId.equals(tournamentId) &
                f.eventType.equals(eventType) &
                f.status.equals('completed'),
          ))
        .watch();

    return completedFixturesWatch.asyncMap((_) async {
      return _computeStandingsOnce(
        tournamentId: tournamentId,
        eventType: eventType,
        groupId: groupId,
      );
    });
  }

  Future<List<StandingsRow>> _computeStandingsOnce({
    required int tournamentId,
    required String eventType,
    int? groupId,
  }) async {
    late final List<TournamentParticipant> participants;

    if (groupId != null) {
      final memberRows = await (_db.select(_db.groupParticipants)
            ..where((gp) => gp.groupId.equals(groupId)))
          .get();
      final ids = memberRows.map((m) => m.tournamentParticipantId).toSet();
      if (ids.isEmpty) return [];
      participants = await (_db.select(_db.tournamentParticipants)
            ..where((p) => p.id.isIn(ids) & p.withdrawn.equals(false)))
          .get();
    } else {
      participants = await (_db.select(_db.tournamentParticipants)
            ..where((p) =>
                p.tournamentId.equals(tournamentId) &
                p.eventType.equals(eventType) &
                p.withdrawn.equals(false)))
          .get();
    }

    var completedFixtures = await (_db.select(_db.fixtures)
          ..where((f) =>
              f.tournamentId.equals(tournamentId) &
              f.eventType.equals(eventType) &
              f.status.equals('completed')))
        .get();

    if (groupId != null) {
      completedFixtures =
          completedFixtures.where((f) => f.groupId == groupId).toList();
    }

    final stats = <int, ({int played, int won, int lost})>{
      for (final p in participants) p.id: (played: 0, won: 0, lost: 0),
    };

    for (final fx in completedFixtures) {
      if (fx.isBye) continue;
      final p1 = fx.participant1Id;
      final p2 = fx.participant2Id;
      final winner = fx.winnerParticipantId;
      if (p1 == null || p2 == null || winner == null) continue;
      if (!stats.containsKey(p1) || !stats.containsKey(p2)) continue;

      stats[p1] = (
        played: stats[p1]!.played + 1,
        won: stats[p1]!.won + (winner == p1 ? 1 : 0),
        lost: stats[p1]!.lost + (winner == p1 ? 0 : 1),
      );
      stats[p2] = (
        played: stats[p2]!.played + 1,
        won: stats[p2]!.won + (winner == p2 ? 1 : 0),
        lost: stats[p2]!.lost + (winner == p2 ? 0 : 1),
      );
    }

    final rows = participants.map((p) {
      final s = stats[p.id]!;
      return _StandingCandidate(
        participantId: p.id,
        participantType: p.participantType,
        participantPlayerId: p.playerId,
        participantTeamIds: (p.individualTeamId, p.competitionTeamId),
        played: s.played,
        won: s.won,
        lost: s.lost,
      );
    }).toList();

    rows.sort((a, b) {
      if (a.won != b.won) return b.won.compareTo(a.won);
      if (a.played != b.played) return b.played.compareTo(a.played);
      return a.participantId.compareTo(b.participantId);
    });

    var i = 0;
    while (i < rows.length) {
      final winValue = rows[i].won;
      var j = i;
      while (j < rows.length && rows[j].won == winValue) {
        j++;
      }
      if (j - i == 2) {
        final a = rows[i];
        final b = rows[i + 1];
        final headWinner =
            _findHeadWinner(completedFixtures, a.participantId, b.participantId);
        if (headWinner != null) {
          rows[i] = headWinner == a.participantId ? a : b;
          rows[i + 1] = headWinner == a.participantId ? b : a;
        }
      }
      i = j;
    }

    final names = await _resolveParticipantDisplayNames(
      participants.map((p) => p.id).toSet(),
    );

    final standings = <StandingsRow>[];
    for (var pos = 0; pos < rows.length; pos++) {
      final r = rows[pos];
      standings.add(
        StandingsRow(
          position: pos + 1,
          participantId: r.participantId,
          participantDisplayName: names[r.participantId] ?? '—',
          played: r.played,
          won: r.won,
          lost: r.lost,
        ),
      );
    }
    return standings;
  }

  int? _findHeadWinner(
    List<Fixture> completedFixtures,
    int aId,
    int bId,
  ) {
    for (final fx in completedFixtures) {
      if (fx.isBye) continue;
      if (fx.winnerParticipantId == null) continue;
      if (fx.participant1Id == null || fx.participant2Id == null) continue;
      final involves =
          (fx.participant1Id == aId && fx.participant2Id == bId) ||
              (fx.participant1Id == bId && fx.participant2Id == aId);
      if (!involves) continue;
      return fx.winnerParticipantId;
    }
    return null;
  }

  // -----------------------------
  // Display name resolution
  // -----------------------------

  Future<Map<int, String>> _resolveParticipantDisplayNames(Set<int> ids) async {
    if (ids.isEmpty) return {};

    final parts = await (_db.select(_db.tournamentParticipants)
          ..where((t) => t.id.isIn(ids)))
        .get();

    final playerIds = <int>{};
    final pairTeamIds = <int>{};
    final competitionTeamIds = <int>{};

    for (final p in parts) {
      switch (p.participantType) {
        case 'player':
          if (p.playerId != null) playerIds.add(p.playerId!);
          break;
        case 'pair':
          if (p.individualTeamId != null) pairTeamIds.add(p.individualTeamId!);
          break;
        case 'competition_team':
          if (p.competitionTeamId != null) competitionTeamIds.add(p.competitionTeamId!);
          break;
        default:
          break;
      }
    }

    final players = await (_db.select(_db.players)
          ..where((p) => p.id.isIn(playerIds)))
        .get()
        .then((rows) => {for (final r in rows) r.id: r.fullName});

    final teams = await (_db.select(_db.individualTeams)
          ..where((t) => t.id.isIn(pairTeamIds)))
        .get();

    final teamPlayers = <int>{};
    for (final t in teams) {
      teamPlayers.add(t.player1Id);
      teamPlayers.add(t.player2Id);
    }
    final teamPlayersResolved = await (_db.select(_db.players)
          ..where((p) => p.id.isIn(teamPlayers)))
        .get()
        .then((rows) => {for (final r in rows) r.id: r.fullName});

    final competitionTeams = await (_db.select(_db.competitionTeams)
          ..where((t) => t.id.isIn(competitionTeamIds)))
        .get()
        .then((rows) => {for (final r in rows) r.id: r.teamName});

    final result = <int, String>{};

    for (final p in parts) {
      switch (p.participantType) {
        case 'player':
          result[p.id] = players[p.playerId] ?? 'Unknown player';
          break;
        case 'pair': {
          final team = teams.firstWhere((t) => t.id == p.individualTeamId);
          final a = teamPlayersResolved[team.player1Id] ?? '?';
          final b = teamPlayersResolved[team.player2Id] ?? '?';
          result[p.id] = '$a / $b';
          break;
        }
        case 'competition_team':
          result[p.id] = competitionTeams[p.competitionTeamId] ?? 'Unknown team';
          break;
        default:
          result[p.id] = 'Participant ${p.id}';
      }
    }

    return result;
  }
}

class _StandingCandidate {
  _StandingCandidate({
    required this.participantId,
    required this.participantType,
    required this.participantPlayerId,
    required this.participantTeamIds,
    required this.played,
    required this.won,
    required this.lost,
  });

  final int participantId;
  final String participantType;
  final int? participantPlayerId;
  final (int?, int?) participantTeamIds;

  final int played;
  final int won;
  final int lost;
}

