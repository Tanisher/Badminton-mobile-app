import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/competition_team_members_table.dart';
import 'tables/competition_teams_table.dart';
import 'tables/external_results_table.dart';
import 'tables/group_knockout_settings_table.dart';
import 'tables/group_participants_table.dart';
import 'tables/groups_table.dart';
import 'tables/individual_teams_table.dart';
import 'tables/players_table.dart';
import 'tables/team_event_assignments_table.dart';
import 'tables/tournament_events_table.dart';
import 'tables/tournament_participants_table.dart';
import 'tables/tournaments_table.dart';
import 'tables/fixtures_table.dart';
import 'tables/fixture_sets_table.dart';
import 'tables/tier_point_values_table.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Players,
    IndividualTeams,
    CompetitionTeams,
    CompetitionTeamMembers,
    Tournaments,
    TournamentEvents,
    GroupKnockoutSettings,
    TournamentParticipants,
    TeamEventAssignments,
    Groups,
    GroupParticipants,
    Fixtures,
    FixtureSets,
    ExternalResults,
    TierPointValues,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Useful for tests or custom executors.
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _seedDefaultTier();
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // v1 had Players only. Existing player/team rows are left untouched.
        if (from < 2) {
          await m.createTable(individualTeams);
          await m.createTable(competitionTeams);
          await m.createTable(competitionTeamMembers);
        }
        if (from < 3) {
          await m.createTable(tournaments);
          await m.createTable(tournamentEvents);
          await m.createTable(groupKnockoutSettings);
        }
        if (from < 4) {
          await m.createTable(tournamentParticipants);
          await m.createTable(teamEventAssignments);
        }
        if (from < 5) {
          await m.createTable(fixtures);
          await m.createTable(fixtureSets);
        }

        // v6: replace TeamEventAssignments.individualTeamId (unused placeholder)
        // with partnerAssignmentId (explicit doubles partner pairing).
        //
        // SQLite doesn't support altering columns in place, so we:
        // 1) create corrected table
        // 2) copy existing rows (partnerAssignmentId stays NULL)
        // 3) drop old table
        // 4) rename new table into place
        if (from < 6) {
          await customStatement('''
            CREATE TABLE team_event_assignments_new_v6 (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              tournament_participant_id INTEGER NOT NULL,
              player_id INTEGER NOT NULL,
              assigned_event TEXT NOT NULL,
              partner_assignment_id INTEGER,
              FOREIGN KEY (tournament_participant_id)
                REFERENCES tournament_participants(id)
                ON DELETE CASCADE,
              FOREIGN KEY (player_id)
                REFERENCES players(id),
              FOREIGN KEY (partner_assignment_id)
                REFERENCES team_event_assignments_new_v6(id)
                ON DELETE SET NULL
            );
          ''');

          await customStatement('''
            INSERT INTO team_event_assignments_new_v6 (
              id,
              tournament_participant_id,
              player_id,
              assigned_event,
              partner_assignment_id
            )
            SELECT
              id,
              tournament_participant_id,
              player_id,
              assigned_event,
              NULL as partner_assignment_id
            FROM team_event_assignments;
          ''');

          await customStatement('DROP TABLE team_event_assignments;');
          await customStatement('ALTER TABLE team_event_assignments_new_v6 RENAME TO team_event_assignments;');
        }

        // v7: Knockout columns on Fixtures + nullable participants for TBD slots.
        // Same recreate approach as v6 (SQLite cannot ALTER ADD these cleanly).
        if (from < 7) {
          await customStatement('PRAGMA foreign_keys = OFF');

          await customStatement('''
            CREATE TABLE fixtures_new_v7 (
              id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              tournament_id INTEGER NOT NULL
                REFERENCES tournaments(id) ON DELETE CASCADE,
              event_type TEXT NOT NULL,
              participant1_id INTEGER
                REFERENCES tournament_participants(id) ON DELETE CASCADE,
              participant2_id INTEGER
                REFERENCES tournament_participants(id) ON DELETE CASCADE,
              court_number INTEGER NULL,
              round_number INTEGER NOT NULL,
              status TEXT NOT NULL DEFAULT 'pending',
              winner_participant_id INTEGER NULL
                REFERENCES tournament_participants(id) ON DELETE SET NULL,
              created_at INTEGER NOT NULL,
              bracket_round TEXT NULL,
              next_fixture_id INTEGER NULL
                REFERENCES fixtures_new_v7(id) ON DELETE SET NULL,
              next_fixture_slot INTEGER NULL,
              is_bye INTEGER NOT NULL DEFAULT 0 CHECK (is_bye IN (0, 1)),
              loser_next_fixture_id INTEGER NULL
                REFERENCES fixtures_new_v7(id) ON DELETE SET NULL,
              loser_next_fixture_slot INTEGER NULL
            );
          ''');

          await customStatement('''
            INSERT INTO fixtures_new_v7 (
              id,
              tournament_id,
              event_type,
              participant1_id,
              participant2_id,
              court_number,
              round_number,
              status,
              winner_participant_id,
              created_at,
              bracket_round,
              next_fixture_id,
              next_fixture_slot,
              is_bye,
              loser_next_fixture_id,
              loser_next_fixture_slot
            )
            SELECT
              id,
              tournament_id,
              event_type,
              participant1_id,
              participant2_id,
              court_number,
              round_number,
              status,
              winner_participant_id,
              created_at,
              NULL,
              NULL,
              NULL,
              0,
              NULL,
              NULL
            FROM fixtures;
          ''');

          await customStatement('DROP TABLE fixtures;');
          await customStatement(
            'ALTER TABLE fixtures_new_v7 RENAME TO fixtures;',
          );

          await customStatement('PRAGMA foreign_keys = ON');
        }

        // v8: Groups + GroupParticipants; qualifiersPerGroup on settings;
        // groupId on Fixtures.
        if (from < 8) {
          await customStatement('PRAGMA foreign_keys = OFF');

          await m.createTable(groups);
          await m.createTable(groupParticipants);

          await customStatement('''
            CREATE TABLE group_knockout_settings_new_v8 (
              id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              tournament_id INTEGER NOT NULL UNIQUE
                REFERENCES tournaments(id) ON DELETE CASCADE,
              number_of_groups INTEGER NOT NULL,
              knockout_start_stage TEXT NOT NULL,
              qualifiers_per_group INTEGER NOT NULL
            );
          ''');

          await customStatement('''
            INSERT INTO group_knockout_settings_new_v8 (
              id,
              tournament_id,
              number_of_groups,
              knockout_start_stage,
              qualifiers_per_group
            )
            SELECT
              id,
              tournament_id,
              number_of_groups,
              knockout_start_stage,
              2
            FROM group_knockout_settings;
          ''');

          await customStatement('DROP TABLE group_knockout_settings;');
          await customStatement(
            'ALTER TABLE group_knockout_settings_new_v8 '
            'RENAME TO group_knockout_settings;',
          );

          await customStatement('''
            CREATE TABLE fixtures_new_v8 (
              id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              tournament_id INTEGER NOT NULL
                REFERENCES tournaments(id) ON DELETE CASCADE,
              event_type TEXT NOT NULL,
              participant1_id INTEGER
                REFERENCES tournament_participants(id) ON DELETE CASCADE,
              participant2_id INTEGER
                REFERENCES tournament_participants(id) ON DELETE CASCADE,
              court_number INTEGER NULL,
              round_number INTEGER NOT NULL,
              status TEXT NOT NULL DEFAULT 'pending',
              winner_participant_id INTEGER NULL
                REFERENCES tournament_participants(id) ON DELETE SET NULL,
              created_at INTEGER NOT NULL,
              bracket_round TEXT NULL,
              next_fixture_id INTEGER NULL
                REFERENCES fixtures_new_v8(id) ON DELETE SET NULL,
              next_fixture_slot INTEGER NULL,
              is_bye INTEGER NOT NULL DEFAULT 0 CHECK (is_bye IN (0, 1)),
              loser_next_fixture_id INTEGER NULL
                REFERENCES fixtures_new_v8(id) ON DELETE SET NULL,
              loser_next_fixture_slot INTEGER NULL,
              group_id INTEGER NULL
                REFERENCES groups(id) ON DELETE CASCADE
            );
          ''');

          await customStatement('''
            INSERT INTO fixtures_new_v8 (
              id,
              tournament_id,
              event_type,
              participant1_id,
              participant2_id,
              court_number,
              round_number,
              status,
              winner_participant_id,
              created_at,
              bracket_round,
              next_fixture_id,
              next_fixture_slot,
              is_bye,
              loser_next_fixture_id,
              loser_next_fixture_slot,
              group_id
            )
            SELECT
              id,
              tournament_id,
              event_type,
              participant1_id,
              participant2_id,
              court_number,
              round_number,
              status,
              winner_participant_id,
              created_at,
              bracket_round,
              next_fixture_id,
              next_fixture_slot,
              is_bye,
              loser_next_fixture_id,
              loser_next_fixture_slot,
              NULL
            FROM fixtures;
          ''');

          await customStatement('DROP TABLE fixtures;');
          await customStatement(
            'ALTER TABLE fixtures_new_v8 RENAME TO fixtures;',
          );

          await customStatement('PRAGMA foreign_keys = ON');
        }

        // v9: ExternalResults — manual ranking-point entries from outside events.
        if (from < 9) {
          await m.createTable(externalResults);
        }

        // v10: TierPointValues — organiser-overridable tier → ranking points.
        if (from < 10) {
          await m.createTable(tierPointValues);
          await _seedDefaultTier();
        }
      },
    );
  }

  /// Sensible badminton-like defaults for Tier 1 / 2 / 3.
  Future<void> _seedDefaultTier() async {
    await batch((b) {
      b.insertAll(tierPointValues, [
        TierPointValuesCompanion.insert(
          tierLabel: 'Tier 1',
          winnerPoints: 1000,
          runnerUpPoints: 600,
          semiPoints: 360,
          quarterPoints: 180,
          roundOf16Points: 90,
          groupWinPoints: 10,
        ),
        TierPointValuesCompanion.insert(
          tierLabel: 'Tier 2',
          winnerPoints: 500,
          runnerUpPoints: 300,
          semiPoints: 180,
          quarterPoints: 90,
          roundOf16Points: 45,
          groupWinPoints: 5,
        ),
        TierPointValuesCompanion.insert(
          tierLabel: 'Tier 3',
          winnerPoints: 250,
          runnerUpPoints: 150,
          semiPoints: 90,
          quarterPoints: 45,
          roundOf16Points: 20,
          groupWinPoints: 3,
        ),
      ]);
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'badminton_manager.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
