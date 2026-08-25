import 'package:drift/drift.dart';

/// Tournament shell (settings only). Participants, fixtures, and results
/// are separate modules.
class Tournaments extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get venue => text().nullable()();

  /// Free text for now (e.g. "Tier 1"). Point-value mapping comes later.
  TextColumn get tier => text()();

  /// One of: 'individual', 'team'. Constrained at the repository layer.
  TextColumn get category => text()();

  /// One of: 'knockout', 'round_robin', 'group_knockout'.
  TextColumn get format => text()();

  IntColumn get numberOfCourts => integer()();
  BoolColumn get hasBronzeMedalMatch =>
      boolean().withDefault(const Constant(true))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
