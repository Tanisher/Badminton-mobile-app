import 'package:drift/drift.dart';

import '../database/database.dart';
import 'tournament_repository.dart';

class ExternalResultValidationException implements Exception {
  ExternalResultValidationException(this.message);
  final String message;

  @override
  String toString() => message;
}

/// An [ExternalResult] with the linked player's display name resolved.
class ExternalResultView {
  const ExternalResultView({
    required this.result,
    required this.playerName,
  });

  final ExternalResult result;
  final String playerName;
}

class ExternalResultRepository {
  ExternalResultRepository(this._db);

  final AppDatabase _db;

  Future<int> addExternalResult({
    required int playerId,
    required String tournamentName,
    String? tournamentOrganiser,
    required DateTime date,
    required String eventType,
    String? partnerName,
    required String stageReached,
    required int rankingPointsAwarded,
  }) async {
    final fields = await _validated(
      playerId: playerId,
      tournamentName: tournamentName,
      tournamentOrganiser: tournamentOrganiser,
      eventType: eventType,
      partnerName: partnerName,
      stageReached: stageReached,
      rankingPointsAwarded: rankingPointsAwarded,
    );

    return _db.into(_db.externalResults).insert(
          ExternalResultsCompanion.insert(
            playerId: fields.playerId,
            tournamentName: fields.tournamentName,
            tournamentOrganiser: Value(fields.tournamentOrganiser),
            date: date,
            eventType: fields.eventType,
            partnerName: Value(fields.partnerName),
            stageReached: fields.stageReached,
            rankingPointsAwarded: fields.rankingPointsAwarded,
          ),
        );
  }

  Stream<List<ExternalResultView>> getExternalResultsForPlayer(int playerId) {
    final query = (_db.select(_db.externalResults).join([
      innerJoin(
        _db.players,
        _db.players.id.equalsExp(_db.externalResults.playerId),
      ),
    ])
      ..where(_db.externalResults.playerId.equals(playerId))
      ..orderBy([OrderingTerm.desc(_db.externalResults.date)]));

    return query.watch().map(_mapRows);
  }

  Stream<List<ExternalResultView>> getAllExternalResults() {
    final query = (_db.select(_db.externalResults).join([
      innerJoin(
        _db.players,
        _db.players.id.equalsExp(_db.externalResults.playerId),
      ),
    ])
      ..orderBy([
        OrderingTerm.desc(_db.externalResults.date),
        OrderingTerm.desc(_db.externalResults.createdAt),
      ]));

    return query.watch().map(_mapRows);
  }

  Future<void> updateExternalResult({
    required int id,
    required int playerId,
    required String tournamentName,
    String? tournamentOrganiser,
    required DateTime date,
    required String eventType,
    String? partnerName,
    required String stageReached,
    required int rankingPointsAwarded,
  }) async {
    final existing = await (_db.select(_db.externalResults)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (existing == null) {
      throw ExternalResultValidationException(
        'External result $id was not found',
      );
    }

    final fields = await _validated(
      playerId: playerId,
      tournamentName: tournamentName,
      tournamentOrganiser: tournamentOrganiser,
      eventType: eventType,
      partnerName: partnerName,
      stageReached: stageReached,
      rankingPointsAwarded: rankingPointsAwarded,
    );

    await (_db.update(_db.externalResults)..where((t) => t.id.equals(id)))
        .write(
      ExternalResultsCompanion(
        playerId: Value(fields.playerId),
        tournamentName: Value(fields.tournamentName),
        tournamentOrganiser: Value(fields.tournamentOrganiser),
        date: Value(date),
        eventType: Value(fields.eventType),
        partnerName: Value(fields.partnerName),
        stageReached: Value(fields.stageReached),
        rankingPointsAwarded: Value(fields.rankingPointsAwarded),
      ),
    );
  }

  Future<void> deleteExternalResult(int id) async {
    final deleted = await (_db.delete(_db.externalResults)
          ..where((t) => t.id.equals(id)))
        .go();
    if (deleted == 0) {
      throw ExternalResultValidationException(
        'External result $id was not found',
      );
    }
  }

  List<ExternalResultView> _mapRows(List<TypedResult> rows) {
    return rows.map((row) {
      final result = row.readTable(_db.externalResults);
      final player = row.readTable(_db.players);
      return ExternalResultView(
        result: result,
        playerName: player.fullName,
      );
    }).toList();
  }

  Future<_ValidatedExternalResult> _validated({
    required int playerId,
    required String tournamentName,
    String? tournamentOrganiser,
    required String eventType,
    String? partnerName,
    required String stageReached,
    required int rankingPointsAwarded,
  }) async {
    final player = await (_db.select(_db.players)
          ..where((p) => p.id.equals(playerId)))
        .getSingleOrNull();
    if (player == null) {
      throw ExternalResultValidationException(
        'Player $playerId was not found',
      );
    }

    final trimmedName = tournamentName.trim();
    if (trimmedName.isEmpty) {
      throw ExternalResultValidationException('Tournament name is required');
    }

    if (!TournamentEventType.isValid(eventType)) {
      throw ExternalResultValidationException(
        "eventType must be one of MS, WS, MD, WD, XD, TEAM",
      );
    }

    final trimmedStage = stageReached.trim();
    if (trimmedStage.isEmpty) {
      throw ExternalResultValidationException('Stage reached is required');
    }

    if (rankingPointsAwarded < 0) {
      throw ExternalResultValidationException(
        'Ranking points cannot be negative',
      );
    }

    final trimmedOrg = tournamentOrganiser?.trim();
    final trimmedPartner = partnerName?.trim();

    final isDoublesOrTeam = eventType == TournamentEventType.md ||
        eventType == TournamentEventType.wd ||
        eventType == TournamentEventType.xd ||
        eventType == TournamentEventType.team;

    return _ValidatedExternalResult(
      playerId: playerId,
      tournamentName: trimmedName,
      tournamentOrganiser:
          trimmedOrg == null || trimmedOrg.isEmpty ? null : trimmedOrg,
      eventType: eventType,
      partnerName: !isDoublesOrTeam ||
              trimmedPartner == null ||
              trimmedPartner.isEmpty
          ? null
          : trimmedPartner,
      stageReached: trimmedStage,
      rankingPointsAwarded: rankingPointsAwarded,
    );
  }
}

class _ValidatedExternalResult {
  const _ValidatedExternalResult({
    required this.playerId,
    required this.tournamentName,
    required this.tournamentOrganiser,
    required this.eventType,
    required this.partnerName,
    required this.stageReached,
    required this.rankingPointsAwarded,
  });

  final int playerId;
  final String tournamentName;
  final String? tournamentOrganiser;
  final String eventType;
  final String? partnerName;
  final String stageReached;
  final int rankingPointsAwarded;
}
