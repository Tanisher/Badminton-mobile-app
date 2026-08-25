import 'package:drift/drift.dart';

import '../database/database.dart';

abstract final class TournamentCategory {
  static const individual = 'individual';
  static const team = 'team';
  static const all = [individual, team];

  static bool isValid(String value) => all.contains(value);

  static String label(String value) {
    switch (value) {
      case individual:
        return 'Individual';
      case team:
        return 'Team';
      default:
        return value;
    }
  }
}

abstract final class TournamentFormat {
  static const knockout = 'knockout';
  static const roundRobin = 'round_robin';
  static const groupKnockout = 'group_knockout';
  static const all = [knockout, roundRobin, groupKnockout];

  static bool isValid(String value) => all.contains(value);

  static String label(String value) {
    switch (value) {
      case knockout:
        return 'Knockout';
      case roundRobin:
        return 'Round Robin';
      case groupKnockout:
        return 'Group + Knockout';
      default:
        return value;
    }
  }
}

abstract final class TournamentEventType {
  static const ms = 'MS';
  static const ws = 'WS';
  static const md = 'MD';
  static const wd = 'WD';
  static const xd = 'XD';
  static const team = 'TEAM';

  static const individualEvents = [ms, ws, md, wd, xd];
  static const all = [ms, ws, md, wd, xd, team];

  static bool isValid(String value) => all.contains(value);

  static String label(String value) {
    switch (value) {
      case ms:
        return "Men's Singles";
      case ws:
        return "Women's Singles";
      case md:
        return "Men's Doubles";
      case wd:
        return "Women's Doubles";
      case xd:
        return 'Mixed Doubles';
      case team:
        return 'Team Event';
      default:
        return value;
    }
  }
}

abstract final class KnockoutStartStage {
  static const quarterfinal = 'quarterfinal';
  static const semifinal = 'semifinal';
  static const final_ = 'final';
  static const all = [quarterfinal, semifinal, final_];

  static bool isValid(String value) => all.contains(value);

  static String label(String value) {
    switch (value) {
      case quarterfinal:
        return 'Quarterfinal';
      case semifinal:
        return 'Semifinal';
      case final_:
        return 'Final';
      default:
        return value;
    }
  }
}

class TournamentValidationException implements Exception {
  TournamentValidationException(this.message);
  final String message;

  @override
  String toString() => message;
}

class GroupKnockoutSettingsInput {
  const GroupKnockoutSettingsInput({
    required this.numberOfGroups,
    required this.knockoutStartStage,
    required this.qualifiersPerGroup,
  });

  final int numberOfGroups;
  final String knockoutStartStage;
  final int qualifiersPerGroup;
}

class TournamentDetails {
  TournamentDetails({
    required this.tournament,
    required this.events,
    this.groupKnockoutSettings,
  });

  final Tournament tournament;
  final List<TournamentEvent> events;
  final GroupKnockoutSetting? groupKnockoutSettings;
}

class TournamentRepository {
  TournamentRepository(this._db);

  final AppDatabase _db;

  Future<int> createTournament({
    required String name,
    required DateTime date,
    String? venue,
    required String tier,
    required String category,
    required String format,
    required int numberOfCourts,
    required bool hasBronzeMedalMatch,
    required List<String> selectedEvents,
    GroupKnockoutSettingsInput? groupKnockoutSettings,
  }) {
    final fields = _validatedFields(
      name: name,
      venue: venue,
      tier: tier,
      category: category,
      format: format,
      numberOfCourts: numberOfCourts,
      selectedEvents: selectedEvents,
      groupKnockoutSettings: groupKnockoutSettings,
    );

    return _db.transaction(() async {
      final tournamentId = await _db.into(_db.tournaments).insert(
            TournamentsCompanion.insert(
              name: fields.name,
              date: date,
              venue: Value(fields.venue),
              tier: fields.tier,
              category: fields.category,
              format: fields.format,
              numberOfCourts: fields.numberOfCourts,
              hasBronzeMedalMatch: Value(hasBronzeMedalMatch),
            ),
          );

      await _insertEvents(tournamentId, fields.events);
      await _insertGroupSettings(
        tournamentId: tournamentId,
        format: fields.format,
        settings: fields.groupKnockoutSettings,
      );

      return tournamentId;
    });
  }

  Stream<List<Tournament>> getAllTournaments() {
    return (_db.select(_db.tournaments)
          ..orderBy([
            (t) => OrderingTerm.desc(t.createdAt),
          ]))
        .watch();
  }

  Future<TournamentDetails?> getTournamentById(int id) async {
    final tournament = await (_db.select(_db.tournaments)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (tournament == null) return null;

    final events = await (_db.select(_db.tournamentEvents)
          ..where((t) => t.tournamentId.equals(id)))
        .get();

    final settings = await (_db.select(_db.groupKnockoutSettings)
          ..where((t) => t.tournamentId.equals(id)))
        .getSingleOrNull();

    return TournamentDetails(
      tournament: tournament,
      events: events,
      groupKnockoutSettings: settings,
    );
  }

  Future<void> updateTournament({
    required int id,
    required String name,
    required DateTime date,
    String? venue,
    required String tier,
    required String category,
    required String format,
    required int numberOfCourts,
    required bool hasBronzeMedalMatch,
    required List<String> selectedEvents,
    GroupKnockoutSettingsInput? groupKnockoutSettings,
  }) async {
    final fields = _validatedFields(
      name: name,
      venue: venue,
      tier: tier,
      category: category,
      format: format,
      numberOfCourts: numberOfCourts,
      selectedEvents: selectedEvents,
      groupKnockoutSettings: groupKnockoutSettings,
    );

    await _db.transaction(() async {
      final rows = await (_db.update(_db.tournaments)
            ..where((t) => t.id.equals(id)))
          .write(
        TournamentsCompanion(
          name: Value(fields.name),
          date: Value(date),
          venue: Value(fields.venue),
          tier: Value(fields.tier),
          category: Value(fields.category),
          format: Value(fields.format),
          numberOfCourts: Value(fields.numberOfCourts),
          hasBronzeMedalMatch: Value(hasBronzeMedalMatch),
        ),
      );
      if (rows == 0) {
        throw TournamentValidationException('Tournament $id was not found');
      }

      await (_db.delete(_db.tournamentEvents)
            ..where((t) => t.tournamentId.equals(id)))
          .go();
      await (_db.delete(_db.groupKnockoutSettings)
            ..where((t) => t.tournamentId.equals(id)))
          .go();

      await _insertEvents(id, fields.events);
      await _insertGroupSettings(
        tournamentId: id,
        format: fields.format,
        settings: fields.groupKnockoutSettings,
      );
    });
  }

  Future<void> deleteTournament(int id) {
    return _db.transaction(() async {
      await (_db.delete(_db.tournamentEvents)
            ..where((t) => t.tournamentId.equals(id)))
          .go();
      await (_db.delete(_db.groupKnockoutSettings)
            ..where((t) => t.tournamentId.equals(id)))
          .go();
      await (_db.delete(_db.tournaments)..where((t) => t.id.equals(id))).go();
    });
  }

  _ValidatedTournamentFields _validatedFields({
    required String name,
    String? venue,
    required String tier,
    required String category,
    required String format,
    required int numberOfCourts,
    required List<String> selectedEvents,
    GroupKnockoutSettingsInput? groupKnockoutSettings,
  }) {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      throw TournamentValidationException('Tournament name is required');
    }

    final trimmedTier = tier.trim();
    if (trimmedTier.isEmpty) {
      throw TournamentValidationException('Tier is required');
    }

    if (!TournamentCategory.isValid(category)) {
      throw TournamentValidationException(
        "category must be 'individual' or 'team'",
      );
    }
    if (!TournamentFormat.isValid(format)) {
      throw TournamentValidationException(
        "format must be 'knockout', 'round_robin', or 'group_knockout'",
      );
    }
    if (numberOfCourts < 1) {
      throw TournamentValidationException(
        'numberOfCourts must be at least 1',
      );
    }

    final events = selectedEvents.map((e) => e.trim().toUpperCase()).toSet();
    if (events.isEmpty) {
      throw TournamentValidationException('Select at least one event');
    }
    for (final event in events) {
      if (!TournamentEventType.isValid(event)) {
        throw TournamentValidationException(
          "Unknown event type '$event'. Use MS, WS, MD, WD, XD, or TEAM",
        );
      }
    }

    if (category == TournamentCategory.individual) {
      if (events.contains(TournamentEventType.team)) {
        throw TournamentValidationException(
          "Individual tournaments cannot include the 'TEAM' event",
        );
      }
    } else if (events.length != 1 ||
        !events.contains(TournamentEventType.team)) {
      throw TournamentValidationException(
        'Team tournaments can only include the TEAM event',
      );
    }

    GroupKnockoutSettingsInput? settings;
    if (format == TournamentFormat.groupKnockout) {
      if (groupKnockoutSettings == null) {
        throw TournamentValidationException(
          'Group + Knockout tournaments need number of groups, '
          'knockout start stage, and qualifiers per group',
        );
      }
      if (groupKnockoutSettings.numberOfGroups < 1) {
        throw TournamentValidationException(
          'numberOfGroups must be at least 1',
        );
      }
      if (!KnockoutStartStage.isValid(groupKnockoutSettings.knockoutStartStage)) {
        throw TournamentValidationException(
          "knockoutStartStage must be 'quarterfinal', 'semifinal', or 'final'",
        );
      }
      if (groupKnockoutSettings.qualifiersPerGroup < 1) {
        throw TournamentValidationException(
          'qualifiersPerGroup must be at least 1',
        );
      }
      settings = groupKnockoutSettings;
    } else if (groupKnockoutSettings != null) {
      throw TournamentValidationException(
        'Group/knockout settings can only be saved when format is group_knockout',
      );
    }

    final trimmedVenue = venue?.trim();
    return _ValidatedTournamentFields(
      name: trimmedName,
      venue: trimmedVenue == null || trimmedVenue.isEmpty ? null : trimmedVenue,
      tier: trimmedTier,
      category: category,
      format: format,
      numberOfCourts: numberOfCourts,
      events: events.toList()..sort(),
      groupKnockoutSettings: settings,
    );
  }

  Future<void> _insertEvents(int tournamentId, List<String> events) async {
    await _db.batch((batch) {
      batch.insertAll(
        _db.tournamentEvents,
        events
            .map(
              (eventType) => TournamentEventsCompanion.insert(
                tournamentId: tournamentId,
                eventType: eventType,
              ),
            )
            .toList(),
      );
    });
  }

  Future<void> _insertGroupSettings({
    required int tournamentId,
    required String format,
    required GroupKnockoutSettingsInput? settings,
  }) async {
    if (settings == null) return;
    if (format != TournamentFormat.groupKnockout) {
      throw TournamentValidationException(
        'Group/knockout settings can only be saved when format is group_knockout',
      );
    }
    await _db.into(_db.groupKnockoutSettings).insert(
          GroupKnockoutSettingsCompanion.insert(
            tournamentId: tournamentId,
            numberOfGroups: settings.numberOfGroups,
            knockoutStartStage: settings.knockoutStartStage,
            qualifiersPerGroup: settings.qualifiersPerGroup,
          ),
        );
  }
}

class _ValidatedTournamentFields {
  const _ValidatedTournamentFields({
    required this.name,
    required this.venue,
    required this.tier,
    required this.category,
    required this.format,
    required this.numberOfCourts,
    required this.events,
    required this.groupKnockoutSettings,
  });

  final String name;
  final String? venue;
  final String tier;
  final String category;
  final String format;
  final int numberOfCourts;
  final List<String> events;
  final GroupKnockoutSettingsInput? groupKnockoutSettings;
}
