import 'package:drift/drift.dart';

import '../database/database.dart';
import 'player_repository.dart';

/// Doubles event types stored as text (app-layer constraint — not a Drift enum).
abstract final class DoublesEventType {
  static const md = 'MD';
  static const wd = 'WD';
  static const xd = 'XD';

  static const all = [md, wd, xd];

  static bool isValid(String value) => all.contains(value);

  static String label(String value) {
    switch (value) {
      case md:
        return "Men's Doubles";
      case wd:
        return "Women's Doubles";
      case xd:
        return 'Mixed Doubles';
      default:
        return value;
    }
  }
}

class IndividualTeamValidationException implements Exception {
  IndividualTeamValidationException(this.message);
  final String message;

  @override
  String toString() => message;
}

class IndividualTeamWithPlayers {
  IndividualTeamWithPlayers({
    required this.pair,
    required this.player1,
    required this.player2,
  });

  final IndividualTeam pair;
  final Player player1;
  final Player player2;
}

class IndividualTeamRepository {
  IndividualTeamRepository(this._db);

  final AppDatabase _db;

  Future<int> createPair({
    required int player1Id,
    required int player2Id,
    required String eventType,
  }) async {
    if (!DoublesEventType.isValid(eventType)) {
      throw IndividualTeamValidationException(
        "eventType must be 'MD', 'WD', or 'XD'",
      );
    }
    if (player1Id == player2Id) {
      throw IndividualTeamValidationException(
        'A pair must be two different players',
      );
    }

    final player1 = await _playerOrThrow(player1Id);
    final player2 = await _playerOrThrow(player2Id);
    _assertGenderForEvent(eventType, player1, player2);

    final existing = await _findDuplicate(
      player1Id: player1Id,
      player2Id: player2Id,
      eventType: eventType,
    );
    if (existing != null) {
      throw IndividualTeamValidationException(
        '${player1.fullName} and ${player2.fullName} are already a '
        '${DoublesEventType.label(eventType)} pair',
      );
    }

    return _db.into(_db.individualTeams).insert(
          IndividualTeamsCompanion.insert(
            player1Id: player1Id,
            player2Id: player2Id,
            eventType: eventType,
          ),
        );
  }

  Stream<List<IndividualTeamWithPlayers>> getPairsByEventType(
    String eventType,
  ) {
    return _watchPairs(
      (t) => t.eventType.equals(eventType),
    );
  }

  Stream<List<IndividualTeamWithPlayers>> getPairsForPlayer(int playerId) {
    return _watchPairs(
      (t) => t.player1Id.equals(playerId) | t.player2Id.equals(playerId),
    );
  }

  Future<int> deletePair(int id) {
    return (_db.delete(_db.individualTeams)..where((t) => t.id.equals(id)))
        .go();
  }

  Stream<List<IndividualTeamWithPlayers>> _watchPairs(
    Expression<bool> Function($IndividualTeamsTable t) whereClause,
  ) {
    final p1 = _db.alias(_db.players, 'p1');
    final p2 = _db.alias(_db.players, 'p2');

    final query = _db.select(_db.individualTeams).join([
      innerJoin(p1, p1.id.equalsExp(_db.individualTeams.player1Id)),
      innerJoin(p2, p2.id.equalsExp(_db.individualTeams.player2Id)),
    ])
      ..where(whereClause(_db.individualTeams))
      ..orderBy([OrderingTerm.asc(p1.fullName)]);

    return query.watch().map((rows) {
      return rows
          .map(
            (row) => IndividualTeamWithPlayers(
              pair: row.readTable(_db.individualTeams),
              player1: row.readTable(p1),
              player2: row.readTable(p2),
            ),
          )
          .toList();
    });
  }

  Future<Player> _playerOrThrow(int id) async {
    final player = await (_db.select(_db.players)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (player == null) {
      throw IndividualTeamValidationException('Player $id was not found');
    }
    return player;
  }

  void _assertGenderForEvent(
    String eventType,
    Player player1,
    Player player2,
  ) {
    switch (eventType) {
      case DoublesEventType.md:
        if (player1.gender != PlayerGender.male ||
            player2.gender != PlayerGender.male) {
          throw IndividualTeamValidationException(
            "Men's Doubles pairs must be two male players",
          );
        }
      case DoublesEventType.wd:
        if (player1.gender != PlayerGender.female ||
            player2.gender != PlayerGender.female) {
          throw IndividualTeamValidationException(
            "Women's Doubles pairs must be two female players",
          );
        }
      case DoublesEventType.xd:
        final genders = {player1.gender, player2.gender};
        if (genders.length != 2 ||
            !genders.contains(PlayerGender.male) ||
            !genders.contains(PlayerGender.female)) {
          throw IndividualTeamValidationException(
            'Mixed Doubles pairs must be one male and one female player',
          );
        }
    }
  }

  Future<IndividualTeam?> _findDuplicate({
    required int player1Id,
    required int player2Id,
    required String eventType,
  }) {
    return (_db.select(_db.individualTeams)
          ..where(
            (t) =>
                t.eventType.equals(eventType) &
                ((t.player1Id.equals(player1Id) &
                        t.player2Id.equals(player2Id)) |
                    (t.player1Id.equals(player2Id) &
                        t.player2Id.equals(player1Id))),
          ))
        .getSingleOrNull();
  }
}
