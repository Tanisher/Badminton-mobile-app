import 'package:drift/drift.dart';

/// SSL tournament tier → stage ranking points.
///
/// Canonical labels: Premier, Major, Open, Challenge, Development.
class TierPointValues extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get tierLabel => text().unique()();

  IntColumn get winnerPoints => integer()();
  IntColumn get runnerUpPoints => integer()();
  IntColumn get semiPoints => integer()();
  IntColumn get quarterPoints => integer()();
  IntColumn get roundOf16Points => integer()();
  IntColumn get roundOf32Points => integer()();
  IntColumn get roundOf64Points => integer()();
}
