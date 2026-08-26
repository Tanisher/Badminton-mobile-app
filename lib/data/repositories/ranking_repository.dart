import 'package:drift/drift.dart';

import '../database/database.dart';
import 'fixture_logic.dart';
import 'participant_repository.dart';
import 'tournament_repository.dart';

/// Canonical SSL tournament tiers (dropdown + DB labels).
abstract final class SslTiers {
  static const premier = 'Premier';
  static const major = 'Major';
  static const open = 'Open';
  static const challenge = 'Challenge';
  static const development = 'Development';

  static const all = [premier, major, open, challenge, development];

  static bool isValid(String value) => all.contains(value.trim());
}

/// U19 eligibility — DOB on or after 1 Jan 2008.
abstract final class SslEligibility {
  static final DateTime u19Cutoff = DateTime(2008, 1, 1);

  static bool isU19Eligible(DateTime dateOfBirth) {
    final d = DateTime(dateOfBirth.year, dateOfBirth.month, dateOfBirth.day);
    return !d.isBefore(u19Cutoff);
  }

  static const ineligibleMessage =
      'Only U19 players are eligible (born on or after 1 January 2008).';
}

/// Resolved tier point values for SSL stages.
class TierPoints {
  const TierPoints({
    required this.tierLabel,
    required this.winnerPoints,
    required this.runnerUpPoints,
    required this.semiPoints,
    required this.quarterPoints,
    required this.roundOf16Points,
    required this.roundOf32Points,
    required this.roundOf64Points,
  });

  final String tierLabel;
  final int winnerPoints;
  final int runnerUpPoints;
  final int semiPoints;
  final int quarterPoints;
  final int roundOf16Points;
  final int roundOf32Points;
  final int roundOf64Points;
}

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

class PartnershipRankingRow {
  const PartnershipRankingRow({
    required this.individualTeamId,
    required this.displayName,
    required this.totalPoints,
    required this.rank,
  });

  final int individualTeamId;
  final String displayName;
  final int totalPoints;
  final int rank;
}

/// SSL ranking engine:
/// - Rolling 12 months
/// - MS/WS → players (+ external)
/// - MD/WD/XD → partnerships only (in-app pair results)
/// - Pure RR → clustered standings bands
/// - G+K group exits → preceding KO-round points
class RankingRepository {
  RankingRepository(this._db);

  final AppDatabase _db;

  static DateTime rollingWindowStart([DateTime? now]) {
    final n = now ?? DateTime.now();
    return DateTime(n.year - 1, n.month, n.day);
  }

  static const Map<String, TierPoints> hardcodedDefaults = {
    'premier': TierPoints(
      tierLabel: SslTiers.premier,
      winnerPoints: 525,
      runnerUpPoints: 440,
      semiPoints: 365,
      quarterPoints: 290,
      roundOf16Points: 190,
      roundOf32Points: 110,
      roundOf64Points: 41,
    ),
    'major': TierPoints(
      tierLabel: SslTiers.major,
      winnerPoints: 425,
      runnerUpPoints: 355,
      semiPoints: 293,
      quarterPoints: 230,
      roundOf16Points: 156,
      roundOf32Points: 86,
      roundOf64Points: 33,
    ),
    'open': TierPoints(
      tierLabel: SslTiers.open,
      winnerPoints: 350,
      runnerUpPoints: 293,
      semiPoints: 243,
      quarterPoints: 192,
      roundOf16Points: 130,
      roundOf32Points: 72,
      roundOf64Points: 27,
    ),
    'challenge': TierPoints(
      tierLabel: SslTiers.challenge,
      winnerPoints: 283,
      runnerUpPoints: 236,
      semiPoints: 195,
      quarterPoints: 153,
      roundOf16Points: 100,
      roundOf32Points: 58,
      roundOf64Points: 21,
    ),
    'development': TierPoints(
      tierLabel: SslTiers.development,
      winnerPoints: 190,
      runnerUpPoints: 157,
      semiPoints: 130,
      quarterPoints: 102,
      roundOf16Points: 67,
      roundOf32Points: 39,
      roundOf64Points: 14,
    ),
  };

  Future<TierPoints> getTierPoints(String tier) async {
    final key = tier.trim().toLowerCase();
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
          roundOf32Points: row.roundOf32Points,
          roundOf64Points: row.roundOf64Points,
        );
      }
    }
    return hardcodedDefaults[key] ?? hardcodedDefaults['open']!;
  }

  Future<List<String>> listTierLabels() async {
    final rows = await (_db.select(_db.tierPointValues)
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
    if (rows.isEmpty) return SslTiers.all;
    return rows.map((r) => r.tierLabel).toList();
  }

  /// MS/WS only — player rankings (+ external for that event in rolling year).
  Future<List<PlayerRankingRow>> computePlayerRankingPoints({
    required String eventType,
    DateTime? asOf,
  }) async {
    if (eventType != TournamentEventType.ms &&
        eventType != TournamentEventType.ws) {
      return const [];
    }

    final windowStart = rollingWindowStart(asOf);
    final points = <int, int>{};

    void add(int playerId, int amount) {
      if (amount <= 0) return;
      points[playerId] = (points[playerId] ?? 0) + amount;
    }

    final external = await (_db.select(_db.externalResults)
          ..where(
            (e) =>
                e.eventType.equals(eventType) &
                e.date.isBiggerOrEqualValue(windowStart),
          ))
        .get();
    for (final row in external) {
      add(row.playerId, row.rankingPointsAwarded);
    }

    final awards = await _inAppStageAwards(
      eventType: eventType,
      windowStart: windowStart,
    );
    for (final a in awards) {
      for (final pid in a.playerIds) {
        add(pid, a.points);
      }
    }

    return _rankPlayers(points);
  }

  /// MD/WD/XD — partnership rankings from in-app pair results only.
  Future<List<PartnershipRankingRow>> computePartnershipRankingPoints({
    required String eventType,
    DateTime? asOf,
  }) async {
    if (eventType != TournamentEventType.md &&
        eventType != TournamentEventType.wd &&
        eventType != TournamentEventType.xd) {
      return const [];
    }

    final windowStart = rollingWindowStart(asOf);
    final points = <int, int>{};

    void add(int teamId, int amount) {
      if (amount <= 0) return;
      points[teamId] = (points[teamId] ?? 0) + amount;
    }

    final awards = await _inAppStageAwards(
      eventType: eventType,
      windowStart: windowStart,
    );
    for (final a in awards) {
      if (a.individualTeamId != null) {
        add(a.individualTeamId!, a.points);
      }
    }

    if (points.isEmpty) return const [];

    final teams = await (_db.select(_db.individualTeams)
          ..where((t) => t.id.isIn(points.keys)))
        .get();
    final playerIds = <int>{};
    for (final t in teams) {
      playerIds.add(t.player1Id);
      playerIds.add(t.player2Id);
    }
    final players = await (_db.select(_db.players)
          ..where((p) => p.id.isIn(playerIds)))
        .get();
    final nameById = {for (final p in players) p.id: p.fullName};

    final rows = teams
        .map((t) {
          final n1 = nameById[t.player1Id] ?? '?';
          final n2 = nameById[t.player2Id] ?? '?';
          return (
            id: t.id,
            name: '$n1 + $n2',
            pts: points[t.id] ?? 0,
          );
        })
        .toList()
      ..sort((a, b) {
        final byPts = b.pts.compareTo(a.pts);
        if (byPts != 0) return byPts;
        return a.name.compareTo(b.name);
      });

    return [
      for (var i = 0; i < rows.length; i++)
        PartnershipRankingRow(
          individualTeamId: rows[i].id,
          displayName: rows[i].name,
          totalPoints: rows[i].pts,
          rank: i + 1,
        ),
    ];
  }

  /// One award packet from a tournament result for a competitor.
  Future<List<_StageAward>> _inAppStageAwards({
    required String eventType,
    required DateTime windowStart,
  }) async {
    final tournaments = await (_db.select(_db.tournaments)
          ..where((t) => t.date.isBiggerOrEqualValue(windowStart)))
        .get();
    if (tournaments.isEmpty) return const [];

    final awards = <_StageAward>[];
    for (final tournament in tournaments) {
      final tier = await getTierPoints(tournament.tier);
      final fixtures = await (_db.select(_db.fixtures)
            ..where(
              (f) =>
                  f.tournamentId.equals(tournament.id) &
                  f.eventType.equals(eventType) &
                  f.status.equals('completed') &
                  f.isBye.equals(false),
            ))
          .get();
      if (fixtures.isEmpty) continue;

      final participantIds = <int>{};
      for (final f in fixtures) {
        if (f.participant1Id != null) participantIds.add(f.participant1Id!);
        if (f.participant2Id != null) participantIds.add(f.participant2Id!);
        if (f.winnerParticipantId != null) {
          participantIds.add(f.winnerParticipantId!);
        }
      }
      // Also include registered non-withdrawn for group-elim coverage.
      final registered = await (_db.select(_db.tournamentParticipants)
            ..where(
              (p) =>
                  p.tournamentId.equals(tournament.id) &
                  p.eventType.equals(eventType) &
                  p.withdrawn.equals(false),
            ))
          .get();
      for (final p in registered) {
        participantIds.add(p.id);
      }

      final participants = await (_db.select(_db.tournamentParticipants)
            ..where((p) => p.id.isIn(participantIds)))
          .get();
      final participantById = {for (final p in participants) p.id: p};
      final meta = await _participantMeta(participants);

      final stageByParticipant = <int, String>{};

      void setStage(int participantId, String stage) {
        final p = participantById[participantId];
        if (p == null || p.withdrawn) return;
        final cur = stageByParticipant[participantId];
        if (cur == null || _stageRank(stage) > _stageRank(cur)) {
          stageByParticipant[participantId] = stage;
        }
      }

      if (tournament.format == TournamentFormat.roundRobin) {
        final standings = await _computeStandingsOnce(
          tournamentId: tournament.id,
          eventType: eventType,
        );
        for (var i = 0; i < standings.length; i++) {
          final pos = i + 1;
          setStage(standings[i].participantId, _rrClusterStage(pos));
        }
      } else if (tournament.format == TournamentFormat.knockout) {
        _applyKnockoutFurthest(fixtures, setStage);
      } else if (tournament.format == TournamentFormat.groupKnockout) {
        final settings = await (_db.select(_db.groupKnockoutSettings)
              ..where((s) => s.tournamentId.equals(tournament.id)))
            .getSingleOrNull();
        final start = settings?.knockoutStartStage ??
            KnockoutStartStage.quarterfinal;
        final groupExitStage = precedingStageForGroupExit(start);

        final koFixtures = fixtures
            .where((f) => f.bracketRound != null && f.groupId == null)
            .toList();
        final inKnockout = <int>{};
        for (final f in koFixtures) {
          if (f.participant1Id != null) inKnockout.add(f.participant1Id!);
          if (f.participant2Id != null) inKnockout.add(f.participant2Id!);
        }

        _applyKnockoutFurthest(koFixtures, setStage);

        for (final p in registered) {
          if (!inKnockout.contains(p.id)) {
            setStage(p.id, groupExitStage);
          }
        }
      }

      for (final e in stageByParticipant.entries) {
        final pts = _pointsForStage(e.value, tier);
        if (pts <= 0) continue;
        final m = meta[e.key];
        if (m == null) continue;
        awards.add(
          _StageAward(
            points: pts,
            playerIds: m.playerIds,
            individualTeamId: m.individualTeamId,
          ),
        );
      }
    }
    return awards;
  }

  void _applyKnockoutFurthest(
    List<Fixture> koFixtures,
    void Function(int participantId, String stage) setStage,
  ) {
    for (final f in koFixtures) {
      if (f.bracketRound == BracketRound.bronzeMedalMatch) continue;
      final winner = f.winnerParticipantId;
      final p1 = f.participant1Id;
      final p2 = f.participant2Id;
      if (winner == null || p1 == null || p2 == null) continue;
      final loser = winner == p1 ? p2 : p1;
      if (f.bracketRound == BracketRound.final_) {
        setStage(winner, '_champion');
        setStage(loser, BracketRound.final_);
      } else {
        setStage(loser, f.bracketRound!);
      }
    }
  }

  Future<List<StandingsRowLite>> _computeStandingsOnce({
    required int tournamentId,
    required String eventType,
  }) async {
    final fixtures = await (_db.select(_db.fixtures)
          ..where(
            (f) =>
                f.tournamentId.equals(tournamentId) &
                f.eventType.equals(eventType) &
                f.groupId.isNull() &
                f.bracketRound.isNull() &
                f.status.equals('completed') &
                f.isBye.equals(false),
          ))
        .get();

    final stats = <int, ({int played, int won, int lost})>{};
    final h2h = <int, int>{};

    void touch(int id) {
      stats.putIfAbsent(id, () => (played: 0, won: 0, lost: 0));
    }

    for (final f in fixtures) {
      final p1 = f.participant1Id;
      final p2 = f.participant2Id;
      final w = f.winnerParticipantId;
      if (p1 == null || p2 == null || w == null) continue;
      touch(p1);
      touch(p2);
      final s1 = stats[p1]!;
      final s2 = stats[p2]!;
      if (w == p1) {
        stats[p1] = (played: s1.played + 1, won: s1.won + 1, lost: s1.lost);
        stats[p2] = (played: s2.played + 1, won: s2.won, lost: s2.lost + 1);
      } else {
        stats[p2] = (played: s2.played + 1, won: s2.won + 1, lost: s2.lost);
        stats[p1] = (played: s1.played + 1, won: s1.won, lost: s1.lost + 1);
      }
      h2h[pairKeyForStandings(p1, p2)] = w;
    }

    final candidates = stats.entries
        .map(
          (e) => StandingsCandidate(
            participantId: e.key,
            played: e.value.played,
            won: e.value.won,
            lost: e.value.lost,
          ),
        )
        .toList();
    final sorted = sortStandings(rows: candidates, headToHeadWinners: h2h);
    return [
      for (final s in sorted)
        StandingsRowLite(participantId: s.participantId),
    ];
  }

  Future<Map<int, _ParticipantMeta>> _participantMeta(
    List<TournamentParticipant> participants,
  ) async {
    final result = <int, _ParticipantMeta>{};
    final pairIds = <int>{};
    for (final p in participants) {
      if (p.participantType == ParticipantType.player && p.playerId != null) {
        result[p.id] = _ParticipantMeta(
          playerIds: [p.playerId!],
          individualTeamId: null,
        );
      } else if (p.participantType == ParticipantType.pair &&
          p.individualTeamId != null) {
        pairIds.add(p.individualTeamId!);
        result[p.id] = _ParticipantMeta(
          playerIds: const [],
          individualTeamId: p.individualTeamId,
        );
      } else {
        result[p.id] = const _ParticipantMeta(
          playerIds: [],
          individualTeamId: null,
        );
      }
    }
    if (pairIds.isEmpty) return result;
    final pairs = await (_db.select(_db.individualTeams)
          ..where((t) => t.id.isIn(pairIds)))
        .get();
    final byId = {for (final t in pairs) t.id: t};
    for (final p in participants) {
      if (p.participantType != ParticipantType.pair) continue;
      final team = byId[p.individualTeamId];
      if (team == null) continue;
      result[p.id] = _ParticipantMeta(
        playerIds: [team.player1Id, team.player2Id],
        individualTeamId: team.id,
      );
    }
    return result;
  }

  Future<List<PlayerRankingRow>> _rankPlayers(Map<int, int> points) async {
    if (points.isEmpty) return const [];
    final players = await (_db.select(_db.players)
          ..where((p) => p.id.isIn(points.keys)))
        .get();
    final nameById = {for (final p in players) p.id: p.fullName};
    final rows = points.entries
        .map(
          (e) => (
            id: e.key,
            name: nameById[e.key] ?? 'Unknown',
            pts: e.value,
          ),
        )
        .toList()
      ..sort((a, b) {
        final byPts = b.pts.compareTo(a.pts);
        if (byPts != 0) return byPts;
        return a.name.compareTo(b.name);
      });
    return [
      for (var i = 0; i < rows.length; i++)
        PlayerRankingRow(
          playerId: rows[i].id,
          playerName: rows[i].name,
          totalPoints: rows[i].pts,
          rank: i + 1,
        ),
    ];
  }

  /// Pure RR final position → stage band (D2).
  static String _rrClusterStage(int position) {
    if (position <= 1) return '_champion';
    if (position == 2) return BracketRound.final_;
    if (position <= 4) return BracketRound.semifinal;
    if (position <= 8) return BracketRound.quarterfinal;
    if (position <= 16) return BracketRound.roundOf32;
    return BracketRound.roundOf64;
  }

  /// Group exit inherits points of the round before first KO round.
  static String precedingStageForGroupExit(String knockoutStartStage) {
    switch (knockoutStartStage) {
      case KnockoutStartStage.quarterfinal:
        return BracketRound.roundOf16;
      case KnockoutStartStage.semifinal:
        return BracketRound.quarterfinal;
      case KnockoutStartStage.final_:
        return BracketRound.semifinal;
      default:
        // If start is R16-like custom, fall back to R32.
        if (knockoutStartStage.contains('16')) {
          return BracketRound.roundOf32;
        }
        return BracketRound.roundOf16;
    }
  }

  static int _stageRank(String round) {
    switch (round) {
      case '_champion':
        return 100;
      case BracketRound.final_:
        return 50;
      case BracketRound.semifinal:
        return 40;
      case BracketRound.quarterfinal:
        return 30;
      case BracketRound.roundOf16:
        return 20;
      case BracketRound.roundOf32:
        return 10;
      case BracketRound.roundOf64:
        return 5;
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
        return tier.roundOf32Points;
      case BracketRound.roundOf64:
        return tier.roundOf64Points;
      default:
        return 0;
    }
  }
}

class StandingsRowLite {
  StandingsRowLite({required this.participantId});
  final int participantId;
}

class _StageAward {
  const _StageAward({
    required this.points,
    required this.playerIds,
    required this.individualTeamId,
  });

  final int points;
  final List<int> playerIds;
  final int? individualTeamId;
}

class _ParticipantMeta {
  const _ParticipantMeta({
    required this.playerIds,
    required this.individualTeamId,
  });

  final List<int> playerIds;
  final int? individualTeamId;
}
