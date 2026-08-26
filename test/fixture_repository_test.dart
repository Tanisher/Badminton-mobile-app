import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:badminton_manager/data/database/database.dart';
import 'package:badminton_manager/data/repositories/fixture_repository.dart';
import 'package:badminton_manager/data/repositories/participant_repository.dart';
import 'package:badminton_manager/data/repositories/player_repository.dart';
import 'package:badminton_manager/data/repositories/ranking_repository.dart';
import 'package:badminton_manager/data/repositories/tournament_repository.dart';

void main() {
  late AppDatabase db;
  late PlayerRepository players;
  late TournamentRepository tournaments;
  late ParticipantRepository participants;
  late FixtureRepository fixtures;
  late RankingRepository rankings;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    players = PlayerRepository(db);
    tournaments = TournamentRepository(db);
    participants = ParticipantRepository(db);
    fixtures = FixtureRepository(db);
    rankings = RankingRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('schema opens at v11 with SSL tiers', () async {
    expect(db.schemaVersion, 11);
    final tiers = await db.select(db.tierPointValues).get();
    expect(tiers.length, 5);
    expect(tiers.map((t) => t.tierLabel), containsAll(SslTiers.all));
  });

  test('U19 blocks pre-2008 DOB', () async {
    expect(
      () => players.addPlayer(
        fullName: 'Old',
        gender: PlayerGender.male,
        dateOfBirth: DateTime(2007, 12, 31),
      ),
      throwsA(isA<ArgumentError>()),
    );
  });

  test('RR generate → result → standings', () async {
    final p1 = await players.addPlayer(
      fullName: 'Alex',
      gender: PlayerGender.male,
      dateOfBirth: DateTime(2009, 1, 1),
    );
    final p2 = await players.addPlayer(
      fullName: 'Ben',
      gender: PlayerGender.male,
      dateOfBirth: DateTime(2010, 1, 1),
    );

    final tid = await tournaments.createTournament(
      name: 'Test Open',
      date: DateTime(2026, 1, 1),
      venue: 'Hall',
      tier: SslTiers.open,
      category: TournamentCategory.individual,
      format: TournamentFormat.roundRobin,
      numberOfCourts: 2,
      hasBronzeMedalMatch: false,
      selectedEvents: [TournamentEventType.ms],
    );

    final a = await participants.registerPlayer(
      tournamentId: tid,
      eventType: TournamentEventType.ms,
      playerId: p1,
    );
    final b = await participants.registerPlayer(
      tournamentId: tid,
      eventType: TournamentEventType.ms,
      playerId: p2,
    );

    await fixtures.generateRoundRobinFixtures(
      tournamentId: tid,
      eventType: TournamentEventType.ms,
    );

    final rows = await (db.select(db.fixtures)
          ..where((f) => f.tournamentId.equals(tid)))
        .get();
    expect(rows.length, 1);

    await fixtures.recordResult(
      fixtureId: rows.first.id,
      sets: const [
        SetScore(participant1Score: 21, participant2Score: 15),
        SetScore(participant1Score: 21, participant2Score: 12),
      ],
    );

    final standings = await fixtures
        .getStandings(
          tournamentId: tid,
          eventType: TournamentEventType.ms,
        )
        .first;
    expect(standings.first.participantId, a);
    expect(standings.first.won, 1);
    expect(standings.last.participantId, b);

    final board = await rankings.computePlayerRankingPoints(
      eventType: TournamentEventType.ms,
    );
    expect(board.first.playerId, p1);
    expect(board.first.totalPoints, 350); // Open winner
  });

  test('clearFixtures regenerates after wipe', () async {
    final p1 = await players.addPlayer(
      fullName: 'Alex',
      gender: PlayerGender.male,
      dateOfBirth: DateTime(2009, 1, 1),
    );
    final p2 = await players.addPlayer(
      fullName: 'Ben',
      gender: PlayerGender.male,
      dateOfBirth: DateTime(2010, 1, 1),
    );
    final tid = await tournaments.createTournament(
      name: 'Clear Test',
      date: DateTime(2026, 1, 1),
      venue: null,
      tier: SslTiers.major,
      category: TournamentCategory.individual,
      format: TournamentFormat.roundRobin,
      numberOfCourts: 1,
      hasBronzeMedalMatch: false,
      selectedEvents: [TournamentEventType.ms],
    );
    await participants.registerPlayer(
      tournamentId: tid,
      eventType: TournamentEventType.ms,
      playerId: p1,
    );
    await participants.registerPlayer(
      tournamentId: tid,
      eventType: TournamentEventType.ms,
      playerId: p2,
    );
    await fixtures.generateRoundRobinFixtures(
      tournamentId: tid,
      eventType: TournamentEventType.ms,
    );
    await fixtures.clearFixtures(
      tournamentId: tid,
      eventType: TournamentEventType.ms,
      allowCompleted: true,
    );
    final empty = await (db.select(db.fixtures)
          ..where((f) => f.tournamentId.equals(tid)))
        .get();
    expect(empty, isEmpty);

    await fixtures.generateRoundRobinFixtures(
      tournamentId: tid,
      eventType: TournamentEventType.ms,
    );
    final again = await (db.select(db.fixtures)
          ..where((f) => f.tournamentId.equals(tid)))
        .get();
    expect(again.length, 1);
  });

  test('group exit preceding stage mapping', () {
    expect(
      RankingRepository.precedingStageForGroupExit(
        KnockoutStartStage.quarterfinal,
      ),
      'round_of_16',
    );
    expect(
      RankingRepository.precedingStageForGroupExit(
        KnockoutStartStage.semifinal,
      ),
      'quarterfinal',
    );
  });
}
