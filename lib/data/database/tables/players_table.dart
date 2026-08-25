import 'package:drift/drift.dart';

/// Players in the local Player Pool.
///
/// Ranking / ranking points per event (MS/WS/MD/WD/XD) will live in a separate
/// RankingPoints table later — one player can have different rankings per event,
/// so those fields intentionally are not columns here.
class Players extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Manually entered
  TextColumn get fullName => text()();
  /// App-layer constraint: 'male' or 'female' only (not a Drift enum).
  TextColumn get gender => text()();
  DateTimeColumn get dateOfBirth => dateTime()();
  TextColumn get clubOrSchool => text().nullable()();
  TextColumn get phoneNumber => text().nullable()();

  // Auto-generated / maintained
  IntColumn get matchesPlayed => integer().withDefault(const Constant(0))();
  IntColumn get matchesWon => integer().withDefault(const Constant(0))();
  IntColumn get matchesLost => integer().withDefault(const Constant(0))();
  IntColumn get titlesWon => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
