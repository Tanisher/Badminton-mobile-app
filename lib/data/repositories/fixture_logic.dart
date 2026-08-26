import 'fixture_repository.dart';

/// Pure winner logic — unit-testable without a database.
int determineMatchWinner({
  required List<SetScore> sets,
  required int participant1Id,
  required int participant2Id,
}) {
  if (sets.isEmpty) {
    throw ArgumentError('At least 1 set score is required');
  }

  var p1Wins = 0;
  var p2Wins = 0;

  for (final set in sets) {
    if (set.participant1Score == set.participant2Score) {
      throw ArgumentError('No draws allowed in a set');
    }
    if (set.participant1Score > set.participant2Score) {
      p1Wins++;
    } else {
      p2Wins++;
    }
  }

  if (p1Wins == p2Wins) {
    throw ArgumentError('Match result requires a clear winner by set majority');
  }

  return p1Wins > p2Wins ? participant1Id : participant2Id;
}

/// Circle-method round-robin pairings per schedule round.
/// [participantIds] may include `null` for a bye when count is odd.
List<List<({int a, int b})>> buildRoundRobinRounds(List<int?> participantIds) {
  final ids = List<int?>.from(participantIds);
  if (ids.length < 2) return [];

  if (ids.length.isOdd) {
    ids.add(null);
  }

  final n = ids.length;
  final scheduleRounds = n - 1;
  final rounds = <List<({int a, int b})>>[];

  for (var roundIdx = 0; roundIdx < scheduleRounds; roundIdx++) {
    final matches = <({int a, int b})>[];
    for (var i = 0; i < n ~/ 2; i++) {
      final a = ids[i];
      final b = ids[n - 1 - i];
      if (a == null || b == null) continue;
      matches.add((a: a, b: b));
    }
    rounds.add(matches);

    final last = ids.removeLast();
    ids.insert(1, last);
  }

  return rounds;
}

int pairKeyForStandings(int a, int b) {
  final x = a < b ? a : b;
  final y = a < b ? b : a;
  return x * 1000000 + y;
}

/// Sort standings by wins desc, then apply 2-way head-to-head tiebreak.
/// Three-way (or more) ties keep win-count order only — known edge case.
List<StandingsCandidate> sortStandings({
  required List<StandingsCandidate> rows,
  required Map<int, int> headToHeadWinners,
}) {
  final sorted = List<StandingsCandidate>.from(rows)
    ..sort((a, b) {
      if (a.won != b.won) return b.won.compareTo(a.won);
      if (a.played != b.played) return b.played.compareTo(a.played);
      return a.participantId.compareTo(b.participantId);
    });

  var i = 0;
  while (i < sorted.length) {
    final winValue = sorted[i].won;
    var j = i;
    while (j < sorted.length && sorted[j].won == winValue) {
      j++;
    }

    if (j - i == 2) {
      final first = sorted[i];
      final second = sorted[i + 1];
      final key = pairKeyForStandings(first.participantId, second.participantId);
      final winner = headToHeadWinners[key];
      if (winner != null) {
        if (winner == second.participantId) {
          sorted[i] = second;
          sorted[i + 1] = first;
        }
      }
    }

    i = j;
  }

  return sorted;
}

class StandingsCandidate {
  const StandingsCandidate({
    required this.participantId,
    required this.played,
    required this.won,
    required this.lost,
  });

  final int participantId;
  final int played;
  final int won;
  final int lost;
}

/// Knockout bracket round name constants.
abstract final class BracketRound {
  static const roundOf64 = 'round_of_64';
  static const roundOf32 = 'round_of_32';
  static const roundOf16 = 'round_of_16';
  static const quarterfinal = 'quarterfinal';
  static const semifinal = 'semifinal';
  static const final_ = 'final';
  static const bronzeMedalMatch = 'bronze_medal_match';

  /// Display order for UI grouping (lower = earlier in bracket).
  static int sortKey(String? round) {
    switch (round) {
      case roundOf64:
        return -1;
      case roundOf32:
        return 0;
      case roundOf16:
        return 1;
      case quarterfinal:
        return 2;
      case semifinal:
        return 3;
      case bronzeMedalMatch:
        return 4;
      case final_:
        return 5;
      default:
        return 99;
    }
  }

  static String label(String? round) {
    switch (round) {
      case roundOf64:
        return 'Round of 64';
      case roundOf32:
        return 'Round of 32';
      case roundOf16:
        return 'Round of 16';
      case quarterfinal:
        return 'Quarterfinal';
      case semifinal:
        return 'Semifinal';
      case bronzeMedalMatch:
        return 'Bronze medal match';
      case final_:
        return 'Final';
      default:
        return round ?? 'Round';
    }
  }
}

/// Next power of 2 ≥ [n] (minimum 2).
int nextPowerOfTwo(int n) {
  if (n <= 2) return 2;
  var size = 2;
  while (size < n) {
    size *= 2;
  }
  return size;
}

/// Standard single-elim seed placement order for a bracket of [bracketSize].
///
/// Returns a list of length [bracketSize] where each entry is a 1-based seed
/// number in the order they appear in first-round slots (paired as 0vs1, 2vs3…).
/// Seed 1 and seed 2 land on opposite halves.
List<int> standardSeedPositions(int bracketSize) {
  var positions = <int>[1];
  while (positions.length < bracketSize) {
    final next = <int>[];
    final sum = positions.length * 2 + 1;
    for (final p in positions) {
      next.add(p);
      next.add(sum - p);
    }
    positions = next;
  }
  return positions;
}

/// Bracket round names from first round through final for a given [bracketSize].
List<String> knockoutRoundNames(int bracketSize) {
  final names = <String>[];
  for (var size = bracketSize; size >= 2; size ~/= 2) {
    switch (size) {
      case 2:
        names.add(BracketRound.final_);
      case 4:
        names.add(BracketRound.semifinal);
      case 8:
        names.add(BracketRound.quarterfinal);
      case 16:
        names.add(BracketRound.roundOf16);
      case 32:
        names.add(BracketRound.roundOf32);
      default:
        names.add('round_of_$size');
    }
  }
  return names;
}

/// Bracket slot count for a configured knockout start stage.
int bracketSlotsForStartStage(String knockoutStartStage) {
  switch (knockoutStartStage) {
    case 'quarterfinal':
      return 8;
    case 'semifinal':
      return 4;
    case 'final':
      return 2;
    default:
      throw ArgumentError(
        "Unknown knockoutStartStage '$knockoutStartStage'",
      );
  }
}

/// Snake/serpentine draft: 1→N then N→1, repeating.
List<List<T>> snakeDistribute<T>(List<T> items, int groupCount) {
  if (groupCount < 1) {
    throw ArgumentError('groupCount must be at least 1');
  }
  final groups = List.generate(groupCount, (_) => <T>[]);
  if (items.isEmpty) return groups;

  for (var i = 0; i < items.length; i++) {
    final row = i ~/ groupCount;
    final col = i % groupCount;
    final g = row.isEven ? col : groupCount - 1 - col;
    groups[g].add(items[i]);
  }
  return groups;
}

/// Build first-round bracket slots (length [bracketSize], paired 0vs1, 2vs3…).
///
/// Best-effort: pairs Gi#1 with G(i+1)#2 when possible so same-group meetings
/// in round 1 are avoided when the numbers allow. Remaining qualifiers fill
/// leftover slots; unused slots stay null (byes).
List<int?> buildCrossGroupFirstRoundSlots({
  required List<List<int>> qualifiersByGroup,
  required int bracketSize,
}) {
  final slots = List<int?>.filled(bracketSize, null);
  if (qualifiersByGroup.isEmpty) return slots;

  final placed = <int>{};
  final pairCount = bracketSize ~/ 2;
  final nGroups = qualifiersByGroup.length;

  // Primary pairings: group i's #1 vs group (i+1)'s #2.
  for (var i = 0; i < pairCount && i < nGroups; i++) {
    final g1 = qualifiersByGroup[i];
    final g2 = qualifiersByGroup[(i + 1) % nGroups];
    final a = g1.isNotEmpty ? g1[0] : null;
    final b = g2.length > 1 ? g2[1] : null;
    slots[i * 2] = a;
    slots[i * 2 + 1] = b;
    if (a != null) placed.add(a);
    if (b != null) placed.add(b);
  }

  // Remaining qualifiers (e.g. 3rd place, unpaired #1/#2) fill empty slots.
  final remaining = <int>[];
  for (final group in qualifiersByGroup) {
    for (final id in group) {
      if (!placed.contains(id)) remaining.add(id);
    }
  }
  var ri = 0;
  for (var s = 0; s < slots.length && ri < remaining.length; s++) {
    if (slots[s] == null) {
      slots[s] = remaining[ri++];
    }
  }

  return slots;
}

/// Schedule round-robin matches into court-constrained rounds.
///
/// Pure helper used by plain RR and group-stage generation.
List<({int participant1Id, int participant2Id, int roundNumber, int courtNumber})>
    scheduleRoundRobinWithCourts({
  required List<int> participantIds,
  required int courtCount,
  int startingRoundNumber = 1,
}) {
  final courts = courtCount < 1 ? 1 : courtCount;
  final scheduleRounds = buildRoundRobinRounds(participantIds);
  final out =
      <({int participant1Id, int participant2Id, int roundNumber, int courtNumber})>[];
  var roundNumber = startingRoundNumber;

  for (final matches in scheduleRounds) {
    final subSlots = (matches.length + courts - 1) ~/ courts;
    for (var sub = 0; sub < subSlots; sub++) {
      final start = sub * courts;
      final end =
          start + courts < matches.length ? start + courts : matches.length;
      for (var mi = start; mi < end; mi++) {
        final match = matches[mi];
        out.add((
          participant1Id: match.a,
          participant2Id: match.b,
          roundNumber: roundNumber,
          courtNumber: (mi - start) + 1,
        ));
      }
      roundNumber++;
    }
  }
  return out;
}
