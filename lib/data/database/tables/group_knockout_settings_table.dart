import 'package:drift/drift.dart';

import 'tournaments_table.dart';

/// 1:1 settings for format = 'group_knockout' only.
class GroupKnockoutSettings extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get tournamentId => integer()
      .unique()
      .references(Tournaments, #id, onDelete: KeyAction.cascade)();

  IntColumn get numberOfGroups => integer()();

  /// Convention values: 'quarterfinal', 'semifinal', 'final'.
  TextColumn get knockoutStartStage => text()();

  /// How many finishers from each group advance to the knockout stage.
  IntColumn get qualifiersPerGroup => integer()();
}
