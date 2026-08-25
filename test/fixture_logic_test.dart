import 'package:badminton_manager/data/repositories/fixture_logic.dart';
import 'package:badminton_manager/data/repositories/fixture_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('determineMatchWinner', () {
    test('majority of sets', () {
      final winner = determineMatchWinner(
        sets: const [
          SetScore(participant1Score: 21, participant2Score: 15),
          SetScore(participant1Score: 19, participant2Score: 21),
          SetScore(participant1Score: 21, participant2Score: 18),
        ],
        participant1Id: 1,
        participant2Id: 2,
      );
      expect(winner, 1);
    });

    test('rejects set draw', () {
      expect(
        () => determineMatchWinner(
          sets: const [
            SetScore(participant1Score: 21, participant2Score: 21),
          ],
          participant1Id: 1,
          participant2Id: 2,
        ),
        throwsArgumentError,
      );
    });
  });

  group('buildRoundRobinRounds', () {
    test('4 players → 3 rounds of 2 matches', () {
      final rounds = buildRoundRobinRounds([1, 2, 3, 4]);
      expect(rounds.length, 3);
      expect(rounds.every((r) => r.length == 2), isTrue);
      final pairs = <String>{};
      for (final round in rounds) {
        for (final m in round) {
          pairs.add('${m.a}-${m.b}');
        }
      }
      expect(pairs.length, 6);
    });

    test('odd count adds bye (null skipped)', () {
      final rounds = buildRoundRobinRounds([1, 2, 3]);
      expect(rounds.length, 3);
      final matchCount = rounds.fold<int>(0, (n, r) => n + r.length);
      expect(matchCount, 3);
    });
  });

  group('nextPowerOfTwo / standardSeedPositions', () {
    test('powers of two', () {
      expect(nextPowerOfTwo(5), 8);
      expect(nextPowerOfTwo(8), 8);
      expect(nextPowerOfTwo(2), 2);
    });

    test('seed positions length matches bracket', () {
      expect(standardSeedPositions(8).length, 8);
      expect(standardSeedPositions(8).toSet().length, 8);
    });
  });

  group('snakeDistribute', () {
    test('snake order across groups', () {
      final groups = snakeDistribute([1, 2, 3, 4, 5, 6], 3);
      expect(groups.length, 3);
      expect(groups[0], [1, 6]);
      expect(groups[1], [2, 5]);
      expect(groups[2], [3, 4]);
    });
  });

  group('sortStandings', () {
    test('2-way H2H breaks win tie', () {
      final sorted = sortStandings(
        rows: [
          StandingsCandidate(participantId: 1, played: 2, won: 1, lost: 1),
          StandingsCandidate(participantId: 2, played: 2, won: 1, lost: 1),
        ],
        headToHeadWinners: {pairKeyForStandings(1, 2): 2},
      );
      expect(sorted.first.participantId, 2);
    });
  });
}
