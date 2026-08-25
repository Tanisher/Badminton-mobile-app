import 'package:drift/drift.dart';

/// Organiser-overridable ranking point values per tournament tier.
///
/// Hardcoded defaults also live in [RankingRepository] as a fallback when a
/// tier label has no row (or before this table is seeded).
class TierPointValues extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// e.g. "Tier 1", "Tier 2", "Tier 3".
  TextColumn get tierLabel => text().unique()();

  IntColumn get winnerPoints => integer()();
  IntColumn get runnerUpPoints => integer()();
  IntColumn get semiPoints => integer()();
  IntColumn get quarterPoints => integer()();
  IntColumn get roundOf16Points => integer()();

  /// Small bonus for each group-stage / round-robin win.
  IntColumn get groupWinPoints => integer()();
}
