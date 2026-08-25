import 'package:drift/drift.dart';

/// A school/club/organisation roster (not a doubles pair).
///
/// Which event each member plays (MS/WS/MD/WD/XD) is assigned per tournament
/// via TournamentParticipant later — not stored as a fixed roster attribute.
class CompetitionTeams extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get teamName => text()();

  /// Organisation this roster represents; may differ from [teamName]
  /// (e.g. teamName "Riverside High - A Team", clubOrSchool "Riverside High").
  TextColumn get clubOrSchool => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
