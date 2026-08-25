import 'package:drift/drift.dart';

import '../database/database.dart';

/// Gender values stored as text (app-layer constraint — not a Drift enum).
abstract final class PlayerGender {
  static const male = 'male';
  static const female = 'female';

  static const all = [male, female];

  static bool isValid(String value) => all.contains(value);
}

/// Local CRUD for the Player Pool, split by gender.
class PlayerRepository {
  PlayerRepository(this._db);

  final AppDatabase _db;

  Future<int> addPlayer({
    required String fullName,
    required String gender,
    required DateTime dateOfBirth,
    String? clubOrSchool,
    String? phoneNumber,
  }) {
    _assertGender(gender);
    return _db.into(_db.players).insert(
          PlayersCompanion.insert(
            fullName: fullName.trim(),
            gender: gender,
            dateOfBirth: dateOfBirth,
            clubOrSchool: Value(
              clubOrSchool?.trim().isEmpty == true
                  ? null
                  : clubOrSchool?.trim(),
            ),
            phoneNumber: Value(
              phoneNumber?.trim().isEmpty == true
                  ? null
                  : phoneNumber?.trim(),
            ),
          ),
        );
  }

  /// Returns separate reactive lists for the Men / Women pool tabs.
  (Stream<List<Player>>, Stream<List<Player>>) getAllPlayers() {
    final men = (_db.select(_db.players)
          ..where((t) => t.gender.equals(PlayerGender.male))
          ..orderBy([(t) => OrderingTerm.asc(t.fullName)]))
        .watch();

    final women = (_db.select(_db.players)
          ..where((t) => t.gender.equals(PlayerGender.female))
          ..orderBy([(t) => OrderingTerm.asc(t.fullName)]))
        .watch();

    return (men, women);
  }

  Future<Player?> getPlayerById(int id) {
    return (_db.select(_db.players)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<bool> updatePlayer({
    required int id,
    required String fullName,
    required String gender,
    required DateTime dateOfBirth,
    String? clubOrSchool,
    String? phoneNumber,
  }) async {
    _assertGender(gender);
    final rows = await (_db.update(_db.players)..where((t) => t.id.equals(id)))
        .write(
      PlayersCompanion(
        fullName: Value(fullName.trim()),
        gender: Value(gender),
        dateOfBirth: Value(dateOfBirth),
        clubOrSchool: Value(
          clubOrSchool?.trim().isEmpty == true ? null : clubOrSchool?.trim(),
        ),
        phoneNumber: Value(
          phoneNumber?.trim().isEmpty == true ? null : phoneNumber?.trim(),
        ),
      ),
    );
    return rows > 0;
  }

  Future<int> deletePlayer(int id) {
    return (_db.delete(_db.players)..where((t) => t.id.equals(id))).go();
  }

  void _assertGender(String gender) {
    if (!PlayerGender.isValid(gender)) {
      throw ArgumentError.value(
        gender,
        'gender',
        "Must be '${PlayerGender.male}' or '${PlayerGender.female}'",
      );
    }
  }
}
