import 'package:drift/drift.dart';

import '../database/database.dart';

class CompetitionTeamValidationException implements Exception {
  CompetitionTeamValidationException(this.message);
  final String message;

  @override
  String toString() => message;
}

class CompetitionTeamWithMembers {
  CompetitionTeamWithMembers({
    required this.team,
    required this.members,
  });

  final CompetitionTeam team;
  final List<Player> members;
}

class CompetitionTeamSummary {
  CompetitionTeamSummary({
    required this.team,
    required this.memberCount,
  });

  final CompetitionTeam team;
  final int memberCount;
}

class CompetitionTeamRepository {
  CompetitionTeamRepository(this._db);

  final AppDatabase _db;

  Future<int> createTeam({
    required String teamName,
    String? clubOrSchool,
  }) {
    final name = teamName.trim();
    if (name.isEmpty) {
      throw CompetitionTeamValidationException('Team name is required');
    }
    final club = clubOrSchool?.trim();
    return _db.into(_db.competitionTeams).insert(
          CompetitionTeamsCompanion.insert(
            teamName: name,
            clubOrSchool: Value(club == null || club.isEmpty ? null : club),
          ),
        );
  }

  Future<void> updateTeam({
    required int id,
    required String teamName,
    String? clubOrSchool,
  }) async {
    await _teamOrThrow(id);
    final name = teamName.trim();
    if (name.isEmpty) {
      throw CompetitionTeamValidationException('Team name is required');
    }
    final club = clubOrSchool?.trim();
    await (_db.update(_db.competitionTeams)..where((t) => t.id.equals(id)))
        .write(
      CompetitionTeamsCompanion(
        teamName: Value(name),
        clubOrSchool: Value(club == null || club.isEmpty ? null : club),
      ),
    );
  }

  Future<int> addMember({
    required int teamId,
    required int playerId,
  }) async {
    await _teamOrThrow(teamId);
    final player = await (_db.select(_db.players)
          ..where((t) => t.id.equals(playerId)))
        .getSingleOrNull();
    if (player == null) {
      throw CompetitionTeamValidationException('Player $playerId was not found');
    }

    final alreadyOnTeam = await (_db.select(_db.competitionTeamMembers)
          ..where(
            (t) =>
                t.competitionTeamId.equals(teamId) &
                t.playerId.equals(playerId),
          ))
        .getSingleOrNull();
    if (alreadyOnTeam != null) {
      throw CompetitionTeamValidationException(
        '${player.fullName} is already on this team',
      );
    }

    return _db.into(_db.competitionTeamMembers).insert(
          CompetitionTeamMembersCompanion.insert(
            competitionTeamId: teamId,
            playerId: playerId,
          ),
        );
  }

  Future<int> removeMember({
    required int teamId,
    required int playerId,
  }) {
    return (_db.delete(_db.competitionTeamMembers)
          ..where(
            (t) =>
                t.competitionTeamId.equals(teamId) &
                t.playerId.equals(playerId),
          ))
        .go();
  }

  Stream<List<CompetitionTeamSummary>> getAllTeams() {
    final memberCount = _db.competitionTeamMembers.id.count();

    final query = _db.select(_db.competitionTeams).join([
      leftOuterJoin(
        _db.competitionTeamMembers,
        _db.competitionTeamMembers.competitionTeamId
            .equalsExp(_db.competitionTeams.id),
      ),
    ])
      ..addColumns([memberCount])
      ..groupBy([_db.competitionTeams.id])
      ..orderBy([OrderingTerm.asc(_db.competitionTeams.teamName)]);

    return query.watch().map((rows) {
      return rows
          .map(
            (row) => CompetitionTeamSummary(
              team: row.readTable(_db.competitionTeams),
              memberCount: row.read(memberCount) ?? 0,
            ),
          )
          .toList();
    });
  }

  Stream<CompetitionTeamWithMembers?> getTeamWithMembers(int teamId) {
    final teamStream = (_db.select(_db.competitionTeams)
          ..where((t) => t.id.equals(teamId)))
        .watchSingleOrNull();

    final membersQuery = _db.select(_db.competitionTeamMembers).join([
      innerJoin(
        _db.players,
        _db.players.id.equalsExp(_db.competitionTeamMembers.playerId),
      ),
    ])
      ..where(_db.competitionTeamMembers.competitionTeamId.equals(teamId))
      ..orderBy([OrderingTerm.asc(_db.players.fullName)]);

    return teamStream.asyncExpand((team) {
      if (team == null) {
        return Stream<CompetitionTeamWithMembers?>.value(null);
      }
      return membersQuery.watch().map((rows) {
        return CompetitionTeamWithMembers(
          team: team,
          members: rows.map((row) => row.readTable(_db.players)).toList(),
        );
      });
    });
  }

  Future<int> deleteTeam(int id) async {
    await (_db.delete(_db.competitionTeamMembers)
          ..where((t) => t.competitionTeamId.equals(id)))
        .go();
    return (_db.delete(_db.competitionTeams)..where((t) => t.id.equals(id)))
        .go();
  }

  Future<CompetitionTeam> _teamOrThrow(int id) async {
    final team = await (_db.select(_db.competitionTeams)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (team == null) {
      throw CompetitionTeamValidationException('Team $id was not found');
    }
    return team;
  }
}
