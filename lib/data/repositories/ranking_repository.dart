import 'package:drift/drift.dart';

import '../database/database.dart';
import 'fixture_logic.dart';
import 'participant_repository.dart';
import 'tournament_repository.dart';

/// Resolved tier point values used when awarding in-app ranking points.
///
/// Defaults (also seeded into [TierPointValues] on schema create/upgrade):
/// - Tier 1: W 1000 / RU 600 / SF 360 / QF 180 / R16 90 / group win 10
/// - Tier 2: W 500 / RU 300 / SF 180 / QF 90 / R16 45 / group win 5
/// - Tier 3: W 250 / RU 150 / SF 90 / QF 45 / R16 20 / group win 3
class TierPoints {
  const TierPoints({
    required this.tierLabel,
    required this.winnerPoints,
    required this.runnerUpPoints,
    required this.semiPoints,
    required this.quarterPoints,
    required this.roundOf16Points,
    required this.groupWinPoints,
  });

  final String tierLabel;
  final int winnerPoints;
  final int runnerUpPoints;
  final int semiPoints;
  final int quarterPoints;
  final int roundOf16Points;
  final int groupWinPoints;
}

/// One player's aggregate ranking for a single event type (MS/WS/MD/WD/XD).
class PlayerRankingRow {
  const PlayerRankingRow({
    required this.playerId,
    required this.playerName,
    required this.totalPoints,
    required this.rank,
  });

  final int playerId;
  final String playerName;
  final int totalPoints;
  final int rank;
}

/// Live ranking computation (no cache table). Sources:
/// 1. [ExternalResults.rankingPointsAwarded] for matching [eventType]
/// 2. In-app completed fixtures — knockout furthest-stage points + RR/group wins
class RankingRepository {
  RankingRepository(this._db);

  final AppDatabase _db;

  /// Hardcoded fallback when [TierPointValues] has no matching row.
  /// Organisers can override by editing the table rows.
  static const Map<String, TierPoints> hardcodedDefaults = {
    'tier 1': TierPoints(
      tierLabel: 'Tier 1',
      winnerPoints: 1000,
      runnerUpPoints: 600,
      semiPoints: 360,
      quarterPoints: 180,
      roundOf16Points: 90,
      groupWinPoints: 10,
    ),
    'tier 2': TierPoints(
      tierLabel: 'Tier 2',
      winnerPoints: 500,
      runnerUpPoints: 300,
      semiPoints: 180,
      quarterPoints: 90,
      roundOf16Points: 45,
      groupWinPoints: 5,
    ),
    'tier 3': TierPoints(
      tierLabel: 'Tier 3',
      winnerPoints: 250,
      runnerUpPoints: 150,
      semiPoints: 90,
      quarterPoints: 45,
      roundOf16Points: 20,
      groupWinPoints: 3,
    ),
  };

  Future<TierPoints> getTierPoints(String tier) async {
    final normalized = tier.trim();
    final key = normalized.toLowerCase();

    final rows = await _db.select(_db.tierPointValues).get();
    for (final row in rows) {
      if (row.tierLabel.toLowerCase() == key) {
        return TierPoints(
          tierLabel: row.tierLabel,
          winnerPoints: row.winnerPoints,
          runnerUpPoints: row.runnerUpPoints,
          semiPoints: row.semiPoints,
          quarterPoints: row.quarterPoints,
          roundOf16Points: row.roundOf16Points,
          groupWinPoints: row.groupWinPoints,
        );
      }
    }

    final hardcoded = hardcodedDefaults[key];
    if (hardcoded != null) return hardcoded;

    // Unknown tier → treat as Tier 3.
    return hardcodedDefaults['tier 3']!;
  }

  /// Computes current rankings for [eventType] (MS/WS/MD/WD/XD).
  ///
  /// TEAM fixtures are skipped for individual event rankings. Doubles pair
  /// results award the same stage/win points to both players.
  Future<List<PlayerRankingRow>> computePlayerRankingPoints({
    required String eventType,
  }) async {
    if (!TournamentEventType.individualEvents.contains(eventType)) {
      return const [];
    }

    final points = <int, int>{};

    void addPoints(int playerId, int amount) {
      if (amount == 0) return;
      points[playerId] = (points[playerId] ?? 0) + amount;
    }

    // --- (a) External results ---
    final external = await (_db.select(_db.externalResults)
          ..where((e) => e.eventType.equals(eventType)))
        .get();
    for (final row in external) {
      addPoints(row.playerId, row.rankingPointsAwarded);
    }

    // --- (b/c/d) In-app completed fixtures ---
    final fixtures = await (_db.select(_db.fixtures)
          ..where(
            (f) =>
                f.eventType.equals(eventType) &
                f.status.equals('completed') &
                f.isBye.equals(false),
          ))
        .get();

    if (fixtures.isNotEmpty) {
      final tournamentIds = fixtures.map((f) => f.tournamentId).toSet();
      final tournaments = await (_db.select(_db.tournaments)
            ..where((t) => t.id.isIn(tournamentIds)))
          .get();
      final tournamentById = {for (final t in tournaments) t.id: t};

      final participantIds = <int>{};
      for (final f in fixtures) {
        if (f.participant1Id != null) participantIds.add(f.participant1Id!);
        if (f.participant2Id != null) participantIds.add(f.participant2Id!);
        if (f.winnerParticipantId != null) {
          participantIds.add(f.winnerParticipantId!);
        }
      }

      final participants = await (_db.select(_db.tournamentParticipants)
            ..where((p) => p.id.isIn(participantIds)))
          .get();
      final participantById = {for (final p in participants) p.id: p};

      final playerIdsByParticipant =
          await _resolvePlayerIdsByParticipant(participants);

      // Group fixtures by tournament for stage + win awards.
      final byTournament = <int, List<Fixture>>{};
      for (final f in fixtures) {
        byTournament.putIfAbsent(f.tournamentId, () => []).add(f);
      }

      for (final entry in byTournament.entries) {
        final tournament = tournamentById[entry.key];
        if (tournament == null) continue;
        final tierPoints = await getTierPoints(tournament.tier);
        final tournamentFixtures = entry.value;

        // (d) Round-robin / group-stage wins (not knockout-phase fixtures).
        for (final f in tournamentFixtures) {
          final isKnockoutPhase =
              f.bracketRound != null && f.groupId == null;
          if (isKnockoutPhase) continue;

          final winnerId = f.winnerParticipantId;
          if (winnerId == null) continue;
          final winner = participantById[winnerId];
          if (winner == null || winner.withdrawn) continue;
          for (final pid in playerIdsByParticipant[winnerId] ?? const []) {
            addPoints(pid, tierPoints.groupWinPoints);
          }
        }

        // (c) Knockout furthest-stage awards (elimination round or champion).
        final koFixtures = tournamentFixtures
            .where((f) => f.bracketRound != null && f.groupId == null)
            .toList();
        if (koFixtures.isEmpty) continue;

        // participantId → stage key used by _pointsForStage
        final furthest = <int, String>{};
        void setFurthest(int participantId, String stage) {
          final p = participantById[participantId];
          if (p == null || p.withdrawn) return;
          final current = furthest[participantId];
          if (current == null ||
              _stageRank(stage) > _stageRank(current)) {
            furthest[participantId] = stage;
          }
        }

        for (final f in koFixtures) {
          if (f.bracketRound == BracketRound.bronzeMedalMatch) continue;
          final winner = f.winnerParticipantId;
          final p1 = f.participant1Id;
          final p2 = f.participant2Id;
          if (winner == null || p1 == null || p2 == null) continue;
          final loser = winner == p1 ? p2 : p1;

          if (f.bracketRound == BracketRound.final_) {
            setFurthest(winner, '_champion');
            setFurthest(loser, BracketRound.final_);
          } else {
            // Loser is eliminated at this round; winner advances further.
            setFurthest(loser, f.bracketRound!);
          }
        }

        for (final e in furthest.entries) {
          final stagePoints = _pointsForStage(e.value, tierPoints);
          for (final pid in playerIdsByParticipant[e.key] ?? const []) {
            addPoints(pid, stagePoints);
          }
        }
      }
    }

    if (points.isEmpty) return const [];

    final players = await (_db.select(_db.players)
          ..where((p) => p.id.isIn(points.keys)))
        .get();
    final nameById = {for (final p in players) p.id: p.fullName};

    final rows = points.entries
        .map(
          (e) => (
            playerId: e.key,
            playerName: nameById[e.key] ?? 'Unknown',
            totalPoints: e.value,
          ),
        )
        .toList()
      ..sort((a, b) {
        final byPts = b.totalPoints.compareTo(a.totalPoints);
        if (byPts != 0) return byPts;
        return a.playerName.compareTo(b.playerName);
      });

    final result = <PlayerRankingRow>[];
    for (var i = 0; i < rows.length; i++) {
      final r = rows[i];
      result.add(
        PlayerRankingRow(
          playerId: r.playerId,
          playerName: r.playerName,
          totalPoints: r.totalPoints,
          rank: i + 1,
        ),
      );
    }
    return result;
  }

  Future<Map<int, List<int>>> _resolvePlayerIdsByParticipant(
    List<TournamentParticipant> participants,
  ) async {
    final result = <int, List<int>>{};
    final pairIds = <int>{};

    for (final p in participants) {
      switch (p.participantType) {
        case ParticipantType.player:
          if (p.playerId != null) {
            result[p.id] = [p.playerId!];
          } else {
            result[p.id] = const [];
          }
        case ParticipantType.pair:
          if (p.individualTeamId != null) {
            pairIds.add(p.individualTeamId!);
          }
          result[p.id] = const [];
        case ParticipantType.competitionTeam:
          // TEAM competitors skip individual rankings.
          result[p.id] = const [];
        default:
          result[p.id] = const [];
      }
    }

    if (pairIds.isEmpty) return result;

    final pairs = await (_db.select(_db.individualTeams)
          ..where((t) => t.id.isIn(pairIds)))
        .get();
    final pairById = {for (final t in pairs) t.id: t};

    for (final p in participants) {
      if (p.participantType != ParticipantType.pair) continue;
      final team = pairById[p.individualTeamId];
      if (team == null) continue;
      result[p.id] = [team.player1Id, team.player2Id];
    }
    return result;
  }

  /// Higher = further in the tournament.
  static int _stageRank(String round) {
    switch (round) {
      case '_champion':
        return 100;
      case BracketRound.final_:
        return 50; // runner-up marker when used for loser
      case BracketRound.semifinal:
        return 40;
      case BracketRound.quarterfinal:
        return 30;
      case BracketRound.roundOf16:
        return 20;
      case BracketRound.roundOf32:
        return 10;
      default:
        return 0;
    }
  }

  static int _pointsForStage(String stage, TierPoints tier) {
    switch (stage) {
      case '_champion':
        return tier.winnerPoints;
      case BracketRound.final_:
        return tier.runnerUpPoints;
      case BracketRound.semifinal:
        return tier.semiPoints;
      case BracketRound.quarterfinal:
        return tier.quarterPoints;
      case BracketRound.roundOf16:
        return tier.roundOf16Points;
      case BracketRound.roundOf32:
        // No dedicated column — use half of R16 as a soft default.
        return tier.roundOf16Points ~/ 2;
      default:
        return 0;
    }
  }
}
