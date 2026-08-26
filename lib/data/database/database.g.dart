// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PlayersTable extends Players with TableInfo<$PlayersTable, Player> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
    'date_of_birth',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clubOrSchoolMeta = const VerificationMeta(
    'clubOrSchool',
  );
  @override
  late final GeneratedColumn<String> clubOrSchool = GeneratedColumn<String>(
    'club_or_school',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _matchesPlayedMeta = const VerificationMeta(
    'matchesPlayed',
  );
  @override
  late final GeneratedColumn<int> matchesPlayed = GeneratedColumn<int>(
    'matches_played',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _matchesWonMeta = const VerificationMeta(
    'matchesWon',
  );
  @override
  late final GeneratedColumn<int> matchesWon = GeneratedColumn<int>(
    'matches_won',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _matchesLostMeta = const VerificationMeta(
    'matchesLost',
  );
  @override
  late final GeneratedColumn<int> matchesLost = GeneratedColumn<int>(
    'matches_lost',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _titlesWonMeta = const VerificationMeta(
    'titlesWon',
  );
  @override
  late final GeneratedColumn<int> titlesWon = GeneratedColumn<int>(
    'titles_won',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fullName,
    gender,
    dateOfBirth,
    clubOrSchool,
    phoneNumber,
    matchesPlayed,
    matchesWon,
    matchesLost,
    titlesWon,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'players';
  @override
  VerificationContext validateIntegrity(
    Insertable<Player> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateOfBirthMeta);
    }
    if (data.containsKey('club_or_school')) {
      context.handle(
        _clubOrSchoolMeta,
        clubOrSchool.isAcceptableOrUnknown(
          data['club_or_school']!,
          _clubOrSchoolMeta,
        ),
      );
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    if (data.containsKey('matches_played')) {
      context.handle(
        _matchesPlayedMeta,
        matchesPlayed.isAcceptableOrUnknown(
          data['matches_played']!,
          _matchesPlayedMeta,
        ),
      );
    }
    if (data.containsKey('matches_won')) {
      context.handle(
        _matchesWonMeta,
        matchesWon.isAcceptableOrUnknown(data['matches_won']!, _matchesWonMeta),
      );
    }
    if (data.containsKey('matches_lost')) {
      context.handle(
        _matchesLostMeta,
        matchesLost.isAcceptableOrUnknown(
          data['matches_lost']!,
          _matchesLostMeta,
        ),
      );
    }
    if (data.containsKey('titles_won')) {
      context.handle(
        _titlesWonMeta,
        titlesWon.isAcceptableOrUnknown(data['titles_won']!, _titlesWonMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Player map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Player(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      )!,
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_of_birth'],
      )!,
      clubOrSchool: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}club_or_school'],
      ),
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      ),
      matchesPlayed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}matches_played'],
      )!,
      matchesWon: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}matches_won'],
      )!,
      matchesLost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}matches_lost'],
      )!,
      titlesWon: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}titles_won'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PlayersTable createAlias(String alias) {
    return $PlayersTable(attachedDatabase, alias);
  }
}

class Player extends DataClass implements Insertable<Player> {
  final int id;
  final String fullName;

  /// App-layer constraint: 'male' or 'female' only (not a Drift enum).
  final String gender;
  final DateTime dateOfBirth;
  final String? clubOrSchool;
  final String? phoneNumber;
  final int matchesPlayed;
  final int matchesWon;
  final int matchesLost;
  final int titlesWon;
  final DateTime createdAt;
  const Player({
    required this.id,
    required this.fullName,
    required this.gender,
    required this.dateOfBirth,
    this.clubOrSchool,
    this.phoneNumber,
    required this.matchesPlayed,
    required this.matchesWon,
    required this.matchesLost,
    required this.titlesWon,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['full_name'] = Variable<String>(fullName);
    map['gender'] = Variable<String>(gender);
    map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    if (!nullToAbsent || clubOrSchool != null) {
      map['club_or_school'] = Variable<String>(clubOrSchool);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    map['matches_played'] = Variable<int>(matchesPlayed);
    map['matches_won'] = Variable<int>(matchesWon);
    map['matches_lost'] = Variable<int>(matchesLost);
    map['titles_won'] = Variable<int>(titlesWon);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      id: Value(id),
      fullName: Value(fullName),
      gender: Value(gender),
      dateOfBirth: Value(dateOfBirth),
      clubOrSchool: clubOrSchool == null && nullToAbsent
          ? const Value.absent()
          : Value(clubOrSchool),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      matchesPlayed: Value(matchesPlayed),
      matchesWon: Value(matchesWon),
      matchesLost: Value(matchesLost),
      titlesWon: Value(titlesWon),
      createdAt: Value(createdAt),
    );
  }

  factory Player.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Player(
      id: serializer.fromJson<int>(json['id']),
      fullName: serializer.fromJson<String>(json['fullName']),
      gender: serializer.fromJson<String>(json['gender']),
      dateOfBirth: serializer.fromJson<DateTime>(json['dateOfBirth']),
      clubOrSchool: serializer.fromJson<String?>(json['clubOrSchool']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      matchesPlayed: serializer.fromJson<int>(json['matchesPlayed']),
      matchesWon: serializer.fromJson<int>(json['matchesWon']),
      matchesLost: serializer.fromJson<int>(json['matchesLost']),
      titlesWon: serializer.fromJson<int>(json['titlesWon']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fullName': serializer.toJson<String>(fullName),
      'gender': serializer.toJson<String>(gender),
      'dateOfBirth': serializer.toJson<DateTime>(dateOfBirth),
      'clubOrSchool': serializer.toJson<String?>(clubOrSchool),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'matchesPlayed': serializer.toJson<int>(matchesPlayed),
      'matchesWon': serializer.toJson<int>(matchesWon),
      'matchesLost': serializer.toJson<int>(matchesLost),
      'titlesWon': serializer.toJson<int>(titlesWon),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Player copyWith({
    int? id,
    String? fullName,
    String? gender,
    DateTime? dateOfBirth,
    Value<String?> clubOrSchool = const Value.absent(),
    Value<String?> phoneNumber = const Value.absent(),
    int? matchesPlayed,
    int? matchesWon,
    int? matchesLost,
    int? titlesWon,
    DateTime? createdAt,
  }) => Player(
    id: id ?? this.id,
    fullName: fullName ?? this.fullName,
    gender: gender ?? this.gender,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    clubOrSchool: clubOrSchool.present ? clubOrSchool.value : this.clubOrSchool,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    matchesPlayed: matchesPlayed ?? this.matchesPlayed,
    matchesWon: matchesWon ?? this.matchesWon,
    matchesLost: matchesLost ?? this.matchesLost,
    titlesWon: titlesWon ?? this.titlesWon,
    createdAt: createdAt ?? this.createdAt,
  );
  Player copyWithCompanion(PlayersCompanion data) {
    return Player(
      id: data.id.present ? data.id.value : this.id,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      gender: data.gender.present ? data.gender.value : this.gender,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      clubOrSchool: data.clubOrSchool.present
          ? data.clubOrSchool.value
          : this.clubOrSchool,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      matchesPlayed: data.matchesPlayed.present
          ? data.matchesPlayed.value
          : this.matchesPlayed,
      matchesWon: data.matchesWon.present
          ? data.matchesWon.value
          : this.matchesWon,
      matchesLost: data.matchesLost.present
          ? data.matchesLost.value
          : this.matchesLost,
      titlesWon: data.titlesWon.present ? data.titlesWon.value : this.titlesWon,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Player(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('gender: $gender, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('clubOrSchool: $clubOrSchool, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('matchesPlayed: $matchesPlayed, ')
          ..write('matchesWon: $matchesWon, ')
          ..write('matchesLost: $matchesLost, ')
          ..write('titlesWon: $titlesWon, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fullName,
    gender,
    dateOfBirth,
    clubOrSchool,
    phoneNumber,
    matchesPlayed,
    matchesWon,
    matchesLost,
    titlesWon,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.id == this.id &&
          other.fullName == this.fullName &&
          other.gender == this.gender &&
          other.dateOfBirth == this.dateOfBirth &&
          other.clubOrSchool == this.clubOrSchool &&
          other.phoneNumber == this.phoneNumber &&
          other.matchesPlayed == this.matchesPlayed &&
          other.matchesWon == this.matchesWon &&
          other.matchesLost == this.matchesLost &&
          other.titlesWon == this.titlesWon &&
          other.createdAt == this.createdAt);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<int> id;
  final Value<String> fullName;
  final Value<String> gender;
  final Value<DateTime> dateOfBirth;
  final Value<String?> clubOrSchool;
  final Value<String?> phoneNumber;
  final Value<int> matchesPlayed;
  final Value<int> matchesWon;
  final Value<int> matchesLost;
  final Value<int> titlesWon;
  final Value<DateTime> createdAt;
  const PlayersCompanion({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.gender = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.clubOrSchool = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.matchesPlayed = const Value.absent(),
    this.matchesWon = const Value.absent(),
    this.matchesLost = const Value.absent(),
    this.titlesWon = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PlayersCompanion.insert({
    this.id = const Value.absent(),
    required String fullName,
    required String gender,
    required DateTime dateOfBirth,
    this.clubOrSchool = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.matchesPlayed = const Value.absent(),
    this.matchesWon = const Value.absent(),
    this.matchesLost = const Value.absent(),
    this.titlesWon = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : fullName = Value(fullName),
       gender = Value(gender),
       dateOfBirth = Value(dateOfBirth);
  static Insertable<Player> custom({
    Expression<int>? id,
    Expression<String>? fullName,
    Expression<String>? gender,
    Expression<DateTime>? dateOfBirth,
    Expression<String>? clubOrSchool,
    Expression<String>? phoneNumber,
    Expression<int>? matchesPlayed,
    Expression<int>? matchesWon,
    Expression<int>? matchesLost,
    Expression<int>? titlesWon,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fullName != null) 'full_name': fullName,
      if (gender != null) 'gender': gender,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (clubOrSchool != null) 'club_or_school': clubOrSchool,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (matchesPlayed != null) 'matches_played': matchesPlayed,
      if (matchesWon != null) 'matches_won': matchesWon,
      if (matchesLost != null) 'matches_lost': matchesLost,
      if (titlesWon != null) 'titles_won': titlesWon,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PlayersCompanion copyWith({
    Value<int>? id,
    Value<String>? fullName,
    Value<String>? gender,
    Value<DateTime>? dateOfBirth,
    Value<String?>? clubOrSchool,
    Value<String?>? phoneNumber,
    Value<int>? matchesPlayed,
    Value<int>? matchesWon,
    Value<int>? matchesLost,
    Value<int>? titlesWon,
    Value<DateTime>? createdAt,
  }) {
    return PlayersCompanion(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      clubOrSchool: clubOrSchool ?? this.clubOrSchool,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      matchesPlayed: matchesPlayed ?? this.matchesPlayed,
      matchesWon: matchesWon ?? this.matchesWon,
      matchesLost: matchesLost ?? this.matchesLost,
      titlesWon: titlesWon ?? this.titlesWon,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (clubOrSchool.present) {
      map['club_or_school'] = Variable<String>(clubOrSchool.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (matchesPlayed.present) {
      map['matches_played'] = Variable<int>(matchesPlayed.value);
    }
    if (matchesWon.present) {
      map['matches_won'] = Variable<int>(matchesWon.value);
    }
    if (matchesLost.present) {
      map['matches_lost'] = Variable<int>(matchesLost.value);
    }
    if (titlesWon.present) {
      map['titles_won'] = Variable<int>(titlesWon.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersCompanion(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('gender: $gender, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('clubOrSchool: $clubOrSchool, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('matchesPlayed: $matchesPlayed, ')
          ..write('matchesWon: $matchesWon, ')
          ..write('matchesLost: $matchesLost, ')
          ..write('titlesWon: $titlesWon, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $IndividualTeamsTable extends IndividualTeams
    with TableInfo<$IndividualTeamsTable, IndividualTeam> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IndividualTeamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _player1IdMeta = const VerificationMeta(
    'player1Id',
  );
  @override
  late final GeneratedColumn<int> player1Id = GeneratedColumn<int>(
    'player1_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  static const VerificationMeta _player2IdMeta = const VerificationMeta(
    'player2Id',
  );
  @override
  late final GeneratedColumn<int> player2Id = GeneratedColumn<int>(
    'player2_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    player1Id,
    player2Id,
    eventType,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'individual_teams';
  @override
  VerificationContext validateIntegrity(
    Insertable<IndividualTeam> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player1_id')) {
      context.handle(
        _player1IdMeta,
        player1Id.isAcceptableOrUnknown(data['player1_id']!, _player1IdMeta),
      );
    } else if (isInserting) {
      context.missing(_player1IdMeta);
    }
    if (data.containsKey('player2_id')) {
      context.handle(
        _player2IdMeta,
        player2Id.isAcceptableOrUnknown(data['player2_id']!, _player2IdMeta),
      );
    } else if (isInserting) {
      context.missing(_player2IdMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IndividualTeam map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IndividualTeam(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      player1Id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player1_id'],
      )!,
      player2Id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player2_id'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $IndividualTeamsTable createAlias(String alias) {
    return $IndividualTeamsTable(attachedDatabase, alias);
  }
}

class IndividualTeam extends DataClass implements Insertable<IndividualTeam> {
  final int id;
  final int player1Id;
  final int player2Id;

  /// One of: 'MD', 'WD', 'XD'. Constrained at the repository layer.
  final String eventType;
  final DateTime createdAt;
  const IndividualTeam({
    required this.id,
    required this.player1Id,
    required this.player2Id,
    required this.eventType,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player1_id'] = Variable<int>(player1Id);
    map['player2_id'] = Variable<int>(player2Id);
    map['event_type'] = Variable<String>(eventType);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  IndividualTeamsCompanion toCompanion(bool nullToAbsent) {
    return IndividualTeamsCompanion(
      id: Value(id),
      player1Id: Value(player1Id),
      player2Id: Value(player2Id),
      eventType: Value(eventType),
      createdAt: Value(createdAt),
    );
  }

  factory IndividualTeam.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IndividualTeam(
      id: serializer.fromJson<int>(json['id']),
      player1Id: serializer.fromJson<int>(json['player1Id']),
      player2Id: serializer.fromJson<int>(json['player2Id']),
      eventType: serializer.fromJson<String>(json['eventType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'player1Id': serializer.toJson<int>(player1Id),
      'player2Id': serializer.toJson<int>(player2Id),
      'eventType': serializer.toJson<String>(eventType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  IndividualTeam copyWith({
    int? id,
    int? player1Id,
    int? player2Id,
    String? eventType,
    DateTime? createdAt,
  }) => IndividualTeam(
    id: id ?? this.id,
    player1Id: player1Id ?? this.player1Id,
    player2Id: player2Id ?? this.player2Id,
    eventType: eventType ?? this.eventType,
    createdAt: createdAt ?? this.createdAt,
  );
  IndividualTeam copyWithCompanion(IndividualTeamsCompanion data) {
    return IndividualTeam(
      id: data.id.present ? data.id.value : this.id,
      player1Id: data.player1Id.present ? data.player1Id.value : this.player1Id,
      player2Id: data.player2Id.present ? data.player2Id.value : this.player2Id,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IndividualTeam(')
          ..write('id: $id, ')
          ..write('player1Id: $player1Id, ')
          ..write('player2Id: $player2Id, ')
          ..write('eventType: $eventType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, player1Id, player2Id, eventType, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IndividualTeam &&
          other.id == this.id &&
          other.player1Id == this.player1Id &&
          other.player2Id == this.player2Id &&
          other.eventType == this.eventType &&
          other.createdAt == this.createdAt);
}

class IndividualTeamsCompanion extends UpdateCompanion<IndividualTeam> {
  final Value<int> id;
  final Value<int> player1Id;
  final Value<int> player2Id;
  final Value<String> eventType;
  final Value<DateTime> createdAt;
  const IndividualTeamsCompanion({
    this.id = const Value.absent(),
    this.player1Id = const Value.absent(),
    this.player2Id = const Value.absent(),
    this.eventType = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  IndividualTeamsCompanion.insert({
    this.id = const Value.absent(),
    required int player1Id,
    required int player2Id,
    required String eventType,
    this.createdAt = const Value.absent(),
  }) : player1Id = Value(player1Id),
       player2Id = Value(player2Id),
       eventType = Value(eventType);
  static Insertable<IndividualTeam> custom({
    Expression<int>? id,
    Expression<int>? player1Id,
    Expression<int>? player2Id,
    Expression<String>? eventType,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (player1Id != null) 'player1_id': player1Id,
      if (player2Id != null) 'player2_id': player2Id,
      if (eventType != null) 'event_type': eventType,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  IndividualTeamsCompanion copyWith({
    Value<int>? id,
    Value<int>? player1Id,
    Value<int>? player2Id,
    Value<String>? eventType,
    Value<DateTime>? createdAt,
  }) {
    return IndividualTeamsCompanion(
      id: id ?? this.id,
      player1Id: player1Id ?? this.player1Id,
      player2Id: player2Id ?? this.player2Id,
      eventType: eventType ?? this.eventType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (player1Id.present) {
      map['player1_id'] = Variable<int>(player1Id.value);
    }
    if (player2Id.present) {
      map['player2_id'] = Variable<int>(player2Id.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IndividualTeamsCompanion(')
          ..write('id: $id, ')
          ..write('player1Id: $player1Id, ')
          ..write('player2Id: $player2Id, ')
          ..write('eventType: $eventType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CompetitionTeamsTable extends CompetitionTeams
    with TableInfo<$CompetitionTeamsTable, CompetitionTeam> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompetitionTeamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _teamNameMeta = const VerificationMeta(
    'teamName',
  );
  @override
  late final GeneratedColumn<String> teamName = GeneratedColumn<String>(
    'team_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clubOrSchoolMeta = const VerificationMeta(
    'clubOrSchool',
  );
  @override
  late final GeneratedColumn<String> clubOrSchool = GeneratedColumn<String>(
    'club_or_school',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, teamName, clubOrSchool, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'competition_teams';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompetitionTeam> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('team_name')) {
      context.handle(
        _teamNameMeta,
        teamName.isAcceptableOrUnknown(data['team_name']!, _teamNameMeta),
      );
    } else if (isInserting) {
      context.missing(_teamNameMeta);
    }
    if (data.containsKey('club_or_school')) {
      context.handle(
        _clubOrSchoolMeta,
        clubOrSchool.isAcceptableOrUnknown(
          data['club_or_school']!,
          _clubOrSchoolMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompetitionTeam map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompetitionTeam(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      teamName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_name'],
      )!,
      clubOrSchool: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}club_or_school'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CompetitionTeamsTable createAlias(String alias) {
    return $CompetitionTeamsTable(attachedDatabase, alias);
  }
}

class CompetitionTeam extends DataClass implements Insertable<CompetitionTeam> {
  final int id;
  final String teamName;

  /// Organisation this roster represents; may differ from [teamName]
  /// (e.g. teamName "Riverside High - A Team", clubOrSchool "Riverside High").
  final String? clubOrSchool;
  final DateTime createdAt;
  const CompetitionTeam({
    required this.id,
    required this.teamName,
    this.clubOrSchool,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['team_name'] = Variable<String>(teamName);
    if (!nullToAbsent || clubOrSchool != null) {
      map['club_or_school'] = Variable<String>(clubOrSchool);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CompetitionTeamsCompanion toCompanion(bool nullToAbsent) {
    return CompetitionTeamsCompanion(
      id: Value(id),
      teamName: Value(teamName),
      clubOrSchool: clubOrSchool == null && nullToAbsent
          ? const Value.absent()
          : Value(clubOrSchool),
      createdAt: Value(createdAt),
    );
  }

  factory CompetitionTeam.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompetitionTeam(
      id: serializer.fromJson<int>(json['id']),
      teamName: serializer.fromJson<String>(json['teamName']),
      clubOrSchool: serializer.fromJson<String?>(json['clubOrSchool']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'teamName': serializer.toJson<String>(teamName),
      'clubOrSchool': serializer.toJson<String?>(clubOrSchool),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CompetitionTeam copyWith({
    int? id,
    String? teamName,
    Value<String?> clubOrSchool = const Value.absent(),
    DateTime? createdAt,
  }) => CompetitionTeam(
    id: id ?? this.id,
    teamName: teamName ?? this.teamName,
    clubOrSchool: clubOrSchool.present ? clubOrSchool.value : this.clubOrSchool,
    createdAt: createdAt ?? this.createdAt,
  );
  CompetitionTeam copyWithCompanion(CompetitionTeamsCompanion data) {
    return CompetitionTeam(
      id: data.id.present ? data.id.value : this.id,
      teamName: data.teamName.present ? data.teamName.value : this.teamName,
      clubOrSchool: data.clubOrSchool.present
          ? data.clubOrSchool.value
          : this.clubOrSchool,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompetitionTeam(')
          ..write('id: $id, ')
          ..write('teamName: $teamName, ')
          ..write('clubOrSchool: $clubOrSchool, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, teamName, clubOrSchool, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompetitionTeam &&
          other.id == this.id &&
          other.teamName == this.teamName &&
          other.clubOrSchool == this.clubOrSchool &&
          other.createdAt == this.createdAt);
}

class CompetitionTeamsCompanion extends UpdateCompanion<CompetitionTeam> {
  final Value<int> id;
  final Value<String> teamName;
  final Value<String?> clubOrSchool;
  final Value<DateTime> createdAt;
  const CompetitionTeamsCompanion({
    this.id = const Value.absent(),
    this.teamName = const Value.absent(),
    this.clubOrSchool = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CompetitionTeamsCompanion.insert({
    this.id = const Value.absent(),
    required String teamName,
    this.clubOrSchool = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : teamName = Value(teamName);
  static Insertable<CompetitionTeam> custom({
    Expression<int>? id,
    Expression<String>? teamName,
    Expression<String>? clubOrSchool,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (teamName != null) 'team_name': teamName,
      if (clubOrSchool != null) 'club_or_school': clubOrSchool,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CompetitionTeamsCompanion copyWith({
    Value<int>? id,
    Value<String>? teamName,
    Value<String?>? clubOrSchool,
    Value<DateTime>? createdAt,
  }) {
    return CompetitionTeamsCompanion(
      id: id ?? this.id,
      teamName: teamName ?? this.teamName,
      clubOrSchool: clubOrSchool ?? this.clubOrSchool,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (teamName.present) {
      map['team_name'] = Variable<String>(teamName.value);
    }
    if (clubOrSchool.present) {
      map['club_or_school'] = Variable<String>(clubOrSchool.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompetitionTeamsCompanion(')
          ..write('id: $id, ')
          ..write('teamName: $teamName, ')
          ..write('clubOrSchool: $clubOrSchool, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CompetitionTeamMembersTable extends CompetitionTeamMembers
    with TableInfo<$CompetitionTeamMembersTable, CompetitionTeamMember> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompetitionTeamMembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _competitionTeamIdMeta = const VerificationMeta(
    'competitionTeamId',
  );
  @override
  late final GeneratedColumn<int> competitionTeamId = GeneratedColumn<int>(
    'competition_team_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES competition_teams (id)',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    competitionTeamId,
    playerId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'competition_team_members';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompetitionTeamMember> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('competition_team_id')) {
      context.handle(
        _competitionTeamIdMeta,
        competitionTeamId.isAcceptableOrUnknown(
          data['competition_team_id']!,
          _competitionTeamIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_competitionTeamIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompetitionTeamMember map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompetitionTeamMember(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      competitionTeamId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}competition_team_id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CompetitionTeamMembersTable createAlias(String alias) {
    return $CompetitionTeamMembersTable(attachedDatabase, alias);
  }
}

class CompetitionTeamMember extends DataClass
    implements Insertable<CompetitionTeamMember> {
  final int id;
  final int competitionTeamId;
  final int playerId;
  final DateTime createdAt;
  const CompetitionTeamMember({
    required this.id,
    required this.competitionTeamId,
    required this.playerId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['competition_team_id'] = Variable<int>(competitionTeamId);
    map['player_id'] = Variable<int>(playerId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CompetitionTeamMembersCompanion toCompanion(bool nullToAbsent) {
    return CompetitionTeamMembersCompanion(
      id: Value(id),
      competitionTeamId: Value(competitionTeamId),
      playerId: Value(playerId),
      createdAt: Value(createdAt),
    );
  }

  factory CompetitionTeamMember.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompetitionTeamMember(
      id: serializer.fromJson<int>(json['id']),
      competitionTeamId: serializer.fromJson<int>(json['competitionTeamId']),
      playerId: serializer.fromJson<int>(json['playerId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'competitionTeamId': serializer.toJson<int>(competitionTeamId),
      'playerId': serializer.toJson<int>(playerId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CompetitionTeamMember copyWith({
    int? id,
    int? competitionTeamId,
    int? playerId,
    DateTime? createdAt,
  }) => CompetitionTeamMember(
    id: id ?? this.id,
    competitionTeamId: competitionTeamId ?? this.competitionTeamId,
    playerId: playerId ?? this.playerId,
    createdAt: createdAt ?? this.createdAt,
  );
  CompetitionTeamMember copyWithCompanion(
    CompetitionTeamMembersCompanion data,
  ) {
    return CompetitionTeamMember(
      id: data.id.present ? data.id.value : this.id,
      competitionTeamId: data.competitionTeamId.present
          ? data.competitionTeamId.value
          : this.competitionTeamId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompetitionTeamMember(')
          ..write('id: $id, ')
          ..write('competitionTeamId: $competitionTeamId, ')
          ..write('playerId: $playerId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, competitionTeamId, playerId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompetitionTeamMember &&
          other.id == this.id &&
          other.competitionTeamId == this.competitionTeamId &&
          other.playerId == this.playerId &&
          other.createdAt == this.createdAt);
}

class CompetitionTeamMembersCompanion
    extends UpdateCompanion<CompetitionTeamMember> {
  final Value<int> id;
  final Value<int> competitionTeamId;
  final Value<int> playerId;
  final Value<DateTime> createdAt;
  const CompetitionTeamMembersCompanion({
    this.id = const Value.absent(),
    this.competitionTeamId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CompetitionTeamMembersCompanion.insert({
    this.id = const Value.absent(),
    required int competitionTeamId,
    required int playerId,
    this.createdAt = const Value.absent(),
  }) : competitionTeamId = Value(competitionTeamId),
       playerId = Value(playerId);
  static Insertable<CompetitionTeamMember> custom({
    Expression<int>? id,
    Expression<int>? competitionTeamId,
    Expression<int>? playerId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (competitionTeamId != null) 'competition_team_id': competitionTeamId,
      if (playerId != null) 'player_id': playerId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CompetitionTeamMembersCompanion copyWith({
    Value<int>? id,
    Value<int>? competitionTeamId,
    Value<int>? playerId,
    Value<DateTime>? createdAt,
  }) {
    return CompetitionTeamMembersCompanion(
      id: id ?? this.id,
      competitionTeamId: competitionTeamId ?? this.competitionTeamId,
      playerId: playerId ?? this.playerId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (competitionTeamId.present) {
      map['competition_team_id'] = Variable<int>(competitionTeamId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompetitionTeamMembersCompanion(')
          ..write('id: $id, ')
          ..write('competitionTeamId: $competitionTeamId, ')
          ..write('playerId: $playerId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TournamentsTable extends Tournaments
    with TableInfo<$TournamentsTable, Tournament> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TournamentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueMeta = const VerificationMeta('venue');
  @override
  late final GeneratedColumn<String> venue = GeneratedColumn<String>(
    'venue',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<String> tier = GeneratedColumn<String>(
    'tier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formatMeta = const VerificationMeta('format');
  @override
  late final GeneratedColumn<String> format = GeneratedColumn<String>(
    'format',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberOfCourtsMeta = const VerificationMeta(
    'numberOfCourts',
  );
  @override
  late final GeneratedColumn<int> numberOfCourts = GeneratedColumn<int>(
    'number_of_courts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hasBronzeMedalMatchMeta =
      const VerificationMeta('hasBronzeMedalMatch');
  @override
  late final GeneratedColumn<bool> hasBronzeMedalMatch = GeneratedColumn<bool>(
    'has_bronze_medal_match',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_bronze_medal_match" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    date,
    venue,
    tier,
    category,
    format,
    numberOfCourts,
    hasBronzeMedalMatch,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tournaments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tournament> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('venue')) {
      context.handle(
        _venueMeta,
        venue.isAcceptableOrUnknown(data['venue']!, _venueMeta),
      );
    }
    if (data.containsKey('tier')) {
      context.handle(
        _tierMeta,
        tier.isAcceptableOrUnknown(data['tier']!, _tierMeta),
      );
    } else if (isInserting) {
      context.missing(_tierMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('format')) {
      context.handle(
        _formatMeta,
        format.isAcceptableOrUnknown(data['format']!, _formatMeta),
      );
    } else if (isInserting) {
      context.missing(_formatMeta);
    }
    if (data.containsKey('number_of_courts')) {
      context.handle(
        _numberOfCourtsMeta,
        numberOfCourts.isAcceptableOrUnknown(
          data['number_of_courts']!,
          _numberOfCourtsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numberOfCourtsMeta);
    }
    if (data.containsKey('has_bronze_medal_match')) {
      context.handle(
        _hasBronzeMedalMatchMeta,
        hasBronzeMedalMatch.isAcceptableOrUnknown(
          data['has_bronze_medal_match']!,
          _hasBronzeMedalMatchMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tournament map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tournament(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      venue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue'],
      ),
      tier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tier'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      format: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}format'],
      )!,
      numberOfCourts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_of_courts'],
      )!,
      hasBronzeMedalMatch: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_bronze_medal_match'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TournamentsTable createAlias(String alias) {
    return $TournamentsTable(attachedDatabase, alias);
  }
}

class Tournament extends DataClass implements Insertable<Tournament> {
  final int id;
  final String name;
  final DateTime date;
  final String? venue;

  /// Free text for now (e.g. "Tier 1"). Point-value mapping comes later.
  final String tier;

  /// One of: 'individual', 'team'. Constrained at the repository layer.
  final String category;

  /// One of: 'knockout', 'round_robin', 'group_knockout'.
  final String format;
  final int numberOfCourts;
  final bool hasBronzeMedalMatch;
  final DateTime createdAt;
  const Tournament({
    required this.id,
    required this.name,
    required this.date,
    this.venue,
    required this.tier,
    required this.category,
    required this.format,
    required this.numberOfCourts,
    required this.hasBronzeMedalMatch,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || venue != null) {
      map['venue'] = Variable<String>(venue);
    }
    map['tier'] = Variable<String>(tier);
    map['category'] = Variable<String>(category);
    map['format'] = Variable<String>(format);
    map['number_of_courts'] = Variable<int>(numberOfCourts);
    map['has_bronze_medal_match'] = Variable<bool>(hasBronzeMedalMatch);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TournamentsCompanion toCompanion(bool nullToAbsent) {
    return TournamentsCompanion(
      id: Value(id),
      name: Value(name),
      date: Value(date),
      venue: venue == null && nullToAbsent
          ? const Value.absent()
          : Value(venue),
      tier: Value(tier),
      category: Value(category),
      format: Value(format),
      numberOfCourts: Value(numberOfCourts),
      hasBronzeMedalMatch: Value(hasBronzeMedalMatch),
      createdAt: Value(createdAt),
    );
  }

  factory Tournament.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tournament(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      date: serializer.fromJson<DateTime>(json['date']),
      venue: serializer.fromJson<String?>(json['venue']),
      tier: serializer.fromJson<String>(json['tier']),
      category: serializer.fromJson<String>(json['category']),
      format: serializer.fromJson<String>(json['format']),
      numberOfCourts: serializer.fromJson<int>(json['numberOfCourts']),
      hasBronzeMedalMatch: serializer.fromJson<bool>(
        json['hasBronzeMedalMatch'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'date': serializer.toJson<DateTime>(date),
      'venue': serializer.toJson<String?>(venue),
      'tier': serializer.toJson<String>(tier),
      'category': serializer.toJson<String>(category),
      'format': serializer.toJson<String>(format),
      'numberOfCourts': serializer.toJson<int>(numberOfCourts),
      'hasBronzeMedalMatch': serializer.toJson<bool>(hasBronzeMedalMatch),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Tournament copyWith({
    int? id,
    String? name,
    DateTime? date,
    Value<String?> venue = const Value.absent(),
    String? tier,
    String? category,
    String? format,
    int? numberOfCourts,
    bool? hasBronzeMedalMatch,
    DateTime? createdAt,
  }) => Tournament(
    id: id ?? this.id,
    name: name ?? this.name,
    date: date ?? this.date,
    venue: venue.present ? venue.value : this.venue,
    tier: tier ?? this.tier,
    category: category ?? this.category,
    format: format ?? this.format,
    numberOfCourts: numberOfCourts ?? this.numberOfCourts,
    hasBronzeMedalMatch: hasBronzeMedalMatch ?? this.hasBronzeMedalMatch,
    createdAt: createdAt ?? this.createdAt,
  );
  Tournament copyWithCompanion(TournamentsCompanion data) {
    return Tournament(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      date: data.date.present ? data.date.value : this.date,
      venue: data.venue.present ? data.venue.value : this.venue,
      tier: data.tier.present ? data.tier.value : this.tier,
      category: data.category.present ? data.category.value : this.category,
      format: data.format.present ? data.format.value : this.format,
      numberOfCourts: data.numberOfCourts.present
          ? data.numberOfCourts.value
          : this.numberOfCourts,
      hasBronzeMedalMatch: data.hasBronzeMedalMatch.present
          ? data.hasBronzeMedalMatch.value
          : this.hasBronzeMedalMatch,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tournament(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('date: $date, ')
          ..write('venue: $venue, ')
          ..write('tier: $tier, ')
          ..write('category: $category, ')
          ..write('format: $format, ')
          ..write('numberOfCourts: $numberOfCourts, ')
          ..write('hasBronzeMedalMatch: $hasBronzeMedalMatch, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    date,
    venue,
    tier,
    category,
    format,
    numberOfCourts,
    hasBronzeMedalMatch,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tournament &&
          other.id == this.id &&
          other.name == this.name &&
          other.date == this.date &&
          other.venue == this.venue &&
          other.tier == this.tier &&
          other.category == this.category &&
          other.format == this.format &&
          other.numberOfCourts == this.numberOfCourts &&
          other.hasBronzeMedalMatch == this.hasBronzeMedalMatch &&
          other.createdAt == this.createdAt);
}

class TournamentsCompanion extends UpdateCompanion<Tournament> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> date;
  final Value<String?> venue;
  final Value<String> tier;
  final Value<String> category;
  final Value<String> format;
  final Value<int> numberOfCourts;
  final Value<bool> hasBronzeMedalMatch;
  final Value<DateTime> createdAt;
  const TournamentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.date = const Value.absent(),
    this.venue = const Value.absent(),
    this.tier = const Value.absent(),
    this.category = const Value.absent(),
    this.format = const Value.absent(),
    this.numberOfCourts = const Value.absent(),
    this.hasBronzeMedalMatch = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TournamentsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required DateTime date,
    this.venue = const Value.absent(),
    required String tier,
    required String category,
    required String format,
    required int numberOfCourts,
    this.hasBronzeMedalMatch = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       date = Value(date),
       tier = Value(tier),
       category = Value(category),
       format = Value(format),
       numberOfCourts = Value(numberOfCourts);
  static Insertable<Tournament> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? date,
    Expression<String>? venue,
    Expression<String>? tier,
    Expression<String>? category,
    Expression<String>? format,
    Expression<int>? numberOfCourts,
    Expression<bool>? hasBronzeMedalMatch,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (date != null) 'date': date,
      if (venue != null) 'venue': venue,
      if (tier != null) 'tier': tier,
      if (category != null) 'category': category,
      if (format != null) 'format': format,
      if (numberOfCourts != null) 'number_of_courts': numberOfCourts,
      if (hasBronzeMedalMatch != null)
        'has_bronze_medal_match': hasBronzeMedalMatch,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TournamentsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime>? date,
    Value<String?>? venue,
    Value<String>? tier,
    Value<String>? category,
    Value<String>? format,
    Value<int>? numberOfCourts,
    Value<bool>? hasBronzeMedalMatch,
    Value<DateTime>? createdAt,
  }) {
    return TournamentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      venue: venue ?? this.venue,
      tier: tier ?? this.tier,
      category: category ?? this.category,
      format: format ?? this.format,
      numberOfCourts: numberOfCourts ?? this.numberOfCourts,
      hasBronzeMedalMatch: hasBronzeMedalMatch ?? this.hasBronzeMedalMatch,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (venue.present) {
      map['venue'] = Variable<String>(venue.value);
    }
    if (tier.present) {
      map['tier'] = Variable<String>(tier.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (format.present) {
      map['format'] = Variable<String>(format.value);
    }
    if (numberOfCourts.present) {
      map['number_of_courts'] = Variable<int>(numberOfCourts.value);
    }
    if (hasBronzeMedalMatch.present) {
      map['has_bronze_medal_match'] = Variable<bool>(hasBronzeMedalMatch.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TournamentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('date: $date, ')
          ..write('venue: $venue, ')
          ..write('tier: $tier, ')
          ..write('category: $category, ')
          ..write('format: $format, ')
          ..write('numberOfCourts: $numberOfCourts, ')
          ..write('hasBronzeMedalMatch: $hasBronzeMedalMatch, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TournamentEventsTable extends TournamentEvents
    with TableInfo<$TournamentEventsTable, TournamentEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TournamentEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tournamentIdMeta = const VerificationMeta(
    'tournamentId',
  );
  @override
  late final GeneratedColumn<int> tournamentId = GeneratedColumn<int>(
    'tournament_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tournaments (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, tournamentId, eventType];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tournament_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<TournamentEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tournament_id')) {
      context.handle(
        _tournamentIdMeta,
        tournamentId.isAcceptableOrUnknown(
          data['tournament_id']!,
          _tournamentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tournamentIdMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {tournamentId, eventType},
  ];
  @override
  TournamentEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TournamentEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tournamentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tournament_id'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
    );
  }

  @override
  $TournamentEventsTable createAlias(String alias) {
    return $TournamentEventsTable(attachedDatabase, alias);
  }
}

class TournamentEvent extends DataClass implements Insertable<TournamentEvent> {
  final int id;
  final int tournamentId;

  /// One of: 'MS', 'WS', 'MD', 'WD', 'XD', 'TEAM'.
  final String eventType;
  const TournamentEvent({
    required this.id,
    required this.tournamentId,
    required this.eventType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tournament_id'] = Variable<int>(tournamentId);
    map['event_type'] = Variable<String>(eventType);
    return map;
  }

  TournamentEventsCompanion toCompanion(bool nullToAbsent) {
    return TournamentEventsCompanion(
      id: Value(id),
      tournamentId: Value(tournamentId),
      eventType: Value(eventType),
    );
  }

  factory TournamentEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TournamentEvent(
      id: serializer.fromJson<int>(json['id']),
      tournamentId: serializer.fromJson<int>(json['tournamentId']),
      eventType: serializer.fromJson<String>(json['eventType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tournamentId': serializer.toJson<int>(tournamentId),
      'eventType': serializer.toJson<String>(eventType),
    };
  }

  TournamentEvent copyWith({int? id, int? tournamentId, String? eventType}) =>
      TournamentEvent(
        id: id ?? this.id,
        tournamentId: tournamentId ?? this.tournamentId,
        eventType: eventType ?? this.eventType,
      );
  TournamentEvent copyWithCompanion(TournamentEventsCompanion data) {
    return TournamentEvent(
      id: data.id.present ? data.id.value : this.id,
      tournamentId: data.tournamentId.present
          ? data.tournamentId.value
          : this.tournamentId,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TournamentEvent(')
          ..write('id: $id, ')
          ..write('tournamentId: $tournamentId, ')
          ..write('eventType: $eventType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tournamentId, eventType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TournamentEvent &&
          other.id == this.id &&
          other.tournamentId == this.tournamentId &&
          other.eventType == this.eventType);
}

class TournamentEventsCompanion extends UpdateCompanion<TournamentEvent> {
  final Value<int> id;
  final Value<int> tournamentId;
  final Value<String> eventType;
  const TournamentEventsCompanion({
    this.id = const Value.absent(),
    this.tournamentId = const Value.absent(),
    this.eventType = const Value.absent(),
  });
  TournamentEventsCompanion.insert({
    this.id = const Value.absent(),
    required int tournamentId,
    required String eventType,
  }) : tournamentId = Value(tournamentId),
       eventType = Value(eventType);
  static Insertable<TournamentEvent> custom({
    Expression<int>? id,
    Expression<int>? tournamentId,
    Expression<String>? eventType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tournamentId != null) 'tournament_id': tournamentId,
      if (eventType != null) 'event_type': eventType,
    });
  }

  TournamentEventsCompanion copyWith({
    Value<int>? id,
    Value<int>? tournamentId,
    Value<String>? eventType,
  }) {
    return TournamentEventsCompanion(
      id: id ?? this.id,
      tournamentId: tournamentId ?? this.tournamentId,
      eventType: eventType ?? this.eventType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tournamentId.present) {
      map['tournament_id'] = Variable<int>(tournamentId.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TournamentEventsCompanion(')
          ..write('id: $id, ')
          ..write('tournamentId: $tournamentId, ')
          ..write('eventType: $eventType')
          ..write(')'))
        .toString();
  }
}

class $GroupKnockoutSettingsTable extends GroupKnockoutSettings
    with TableInfo<$GroupKnockoutSettingsTable, GroupKnockoutSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupKnockoutSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tournamentIdMeta = const VerificationMeta(
    'tournamentId',
  );
  @override
  late final GeneratedColumn<int> tournamentId = GeneratedColumn<int>(
    'tournament_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES tournaments (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _numberOfGroupsMeta = const VerificationMeta(
    'numberOfGroups',
  );
  @override
  late final GeneratedColumn<int> numberOfGroups = GeneratedColumn<int>(
    'number_of_groups',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _knockoutStartStageMeta =
      const VerificationMeta('knockoutStartStage');
  @override
  late final GeneratedColumn<String> knockoutStartStage =
      GeneratedColumn<String>(
        'knockout_start_stage',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _qualifiersPerGroupMeta =
      const VerificationMeta('qualifiersPerGroup');
  @override
  late final GeneratedColumn<int> qualifiersPerGroup = GeneratedColumn<int>(
    'qualifiers_per_group',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tournamentId,
    numberOfGroups,
    knockoutStartStage,
    qualifiersPerGroup,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'group_knockout_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<GroupKnockoutSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tournament_id')) {
      context.handle(
        _tournamentIdMeta,
        tournamentId.isAcceptableOrUnknown(
          data['tournament_id']!,
          _tournamentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tournamentIdMeta);
    }
    if (data.containsKey('number_of_groups')) {
      context.handle(
        _numberOfGroupsMeta,
        numberOfGroups.isAcceptableOrUnknown(
          data['number_of_groups']!,
          _numberOfGroupsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numberOfGroupsMeta);
    }
    if (data.containsKey('knockout_start_stage')) {
      context.handle(
        _knockoutStartStageMeta,
        knockoutStartStage.isAcceptableOrUnknown(
          data['knockout_start_stage']!,
          _knockoutStartStageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_knockoutStartStageMeta);
    }
    if (data.containsKey('qualifiers_per_group')) {
      context.handle(
        _qualifiersPerGroupMeta,
        qualifiersPerGroup.isAcceptableOrUnknown(
          data['qualifiers_per_group']!,
          _qualifiersPerGroupMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_qualifiersPerGroupMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroupKnockoutSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupKnockoutSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tournamentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tournament_id'],
      )!,
      numberOfGroups: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_of_groups'],
      )!,
      knockoutStartStage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}knockout_start_stage'],
      )!,
      qualifiersPerGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}qualifiers_per_group'],
      )!,
    );
  }

  @override
  $GroupKnockoutSettingsTable createAlias(String alias) {
    return $GroupKnockoutSettingsTable(attachedDatabase, alias);
  }
}

class GroupKnockoutSetting extends DataClass
    implements Insertable<GroupKnockoutSetting> {
  final int id;
  final int tournamentId;
  final int numberOfGroups;

  /// Convention values: 'quarterfinal', 'semifinal', 'final'.
  final String knockoutStartStage;

  /// How many finishers from each group advance to the knockout stage.
  final int qualifiersPerGroup;
  const GroupKnockoutSetting({
    required this.id,
    required this.tournamentId,
    required this.numberOfGroups,
    required this.knockoutStartStage,
    required this.qualifiersPerGroup,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tournament_id'] = Variable<int>(tournamentId);
    map['number_of_groups'] = Variable<int>(numberOfGroups);
    map['knockout_start_stage'] = Variable<String>(knockoutStartStage);
    map['qualifiers_per_group'] = Variable<int>(qualifiersPerGroup);
    return map;
  }

  GroupKnockoutSettingsCompanion toCompanion(bool nullToAbsent) {
    return GroupKnockoutSettingsCompanion(
      id: Value(id),
      tournamentId: Value(tournamentId),
      numberOfGroups: Value(numberOfGroups),
      knockoutStartStage: Value(knockoutStartStage),
      qualifiersPerGroup: Value(qualifiersPerGroup),
    );
  }

  factory GroupKnockoutSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupKnockoutSetting(
      id: serializer.fromJson<int>(json['id']),
      tournamentId: serializer.fromJson<int>(json['tournamentId']),
      numberOfGroups: serializer.fromJson<int>(json['numberOfGroups']),
      knockoutStartStage: serializer.fromJson<String>(
        json['knockoutStartStage'],
      ),
      qualifiersPerGroup: serializer.fromJson<int>(json['qualifiersPerGroup']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tournamentId': serializer.toJson<int>(tournamentId),
      'numberOfGroups': serializer.toJson<int>(numberOfGroups),
      'knockoutStartStage': serializer.toJson<String>(knockoutStartStage),
      'qualifiersPerGroup': serializer.toJson<int>(qualifiersPerGroup),
    };
  }

  GroupKnockoutSetting copyWith({
    int? id,
    int? tournamentId,
    int? numberOfGroups,
    String? knockoutStartStage,
    int? qualifiersPerGroup,
  }) => GroupKnockoutSetting(
    id: id ?? this.id,
    tournamentId: tournamentId ?? this.tournamentId,
    numberOfGroups: numberOfGroups ?? this.numberOfGroups,
    knockoutStartStage: knockoutStartStage ?? this.knockoutStartStage,
    qualifiersPerGroup: qualifiersPerGroup ?? this.qualifiersPerGroup,
  );
  GroupKnockoutSetting copyWithCompanion(GroupKnockoutSettingsCompanion data) {
    return GroupKnockoutSetting(
      id: data.id.present ? data.id.value : this.id,
      tournamentId: data.tournamentId.present
          ? data.tournamentId.value
          : this.tournamentId,
      numberOfGroups: data.numberOfGroups.present
          ? data.numberOfGroups.value
          : this.numberOfGroups,
      knockoutStartStage: data.knockoutStartStage.present
          ? data.knockoutStartStage.value
          : this.knockoutStartStage,
      qualifiersPerGroup: data.qualifiersPerGroup.present
          ? data.qualifiersPerGroup.value
          : this.qualifiersPerGroup,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupKnockoutSetting(')
          ..write('id: $id, ')
          ..write('tournamentId: $tournamentId, ')
          ..write('numberOfGroups: $numberOfGroups, ')
          ..write('knockoutStartStage: $knockoutStartStage, ')
          ..write('qualifiersPerGroup: $qualifiersPerGroup')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tournamentId,
    numberOfGroups,
    knockoutStartStage,
    qualifiersPerGroup,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupKnockoutSetting &&
          other.id == this.id &&
          other.tournamentId == this.tournamentId &&
          other.numberOfGroups == this.numberOfGroups &&
          other.knockoutStartStage == this.knockoutStartStage &&
          other.qualifiersPerGroup == this.qualifiersPerGroup);
}

class GroupKnockoutSettingsCompanion
    extends UpdateCompanion<GroupKnockoutSetting> {
  final Value<int> id;
  final Value<int> tournamentId;
  final Value<int> numberOfGroups;
  final Value<String> knockoutStartStage;
  final Value<int> qualifiersPerGroup;
  const GroupKnockoutSettingsCompanion({
    this.id = const Value.absent(),
    this.tournamentId = const Value.absent(),
    this.numberOfGroups = const Value.absent(),
    this.knockoutStartStage = const Value.absent(),
    this.qualifiersPerGroup = const Value.absent(),
  });
  GroupKnockoutSettingsCompanion.insert({
    this.id = const Value.absent(),
    required int tournamentId,
    required int numberOfGroups,
    required String knockoutStartStage,
    required int qualifiersPerGroup,
  }) : tournamentId = Value(tournamentId),
       numberOfGroups = Value(numberOfGroups),
       knockoutStartStage = Value(knockoutStartStage),
       qualifiersPerGroup = Value(qualifiersPerGroup);
  static Insertable<GroupKnockoutSetting> custom({
    Expression<int>? id,
    Expression<int>? tournamentId,
    Expression<int>? numberOfGroups,
    Expression<String>? knockoutStartStage,
    Expression<int>? qualifiersPerGroup,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tournamentId != null) 'tournament_id': tournamentId,
      if (numberOfGroups != null) 'number_of_groups': numberOfGroups,
      if (knockoutStartStage != null)
        'knockout_start_stage': knockoutStartStage,
      if (qualifiersPerGroup != null)
        'qualifiers_per_group': qualifiersPerGroup,
    });
  }

  GroupKnockoutSettingsCompanion copyWith({
    Value<int>? id,
    Value<int>? tournamentId,
    Value<int>? numberOfGroups,
    Value<String>? knockoutStartStage,
    Value<int>? qualifiersPerGroup,
  }) {
    return GroupKnockoutSettingsCompanion(
      id: id ?? this.id,
      tournamentId: tournamentId ?? this.tournamentId,
      numberOfGroups: numberOfGroups ?? this.numberOfGroups,
      knockoutStartStage: knockoutStartStage ?? this.knockoutStartStage,
      qualifiersPerGroup: qualifiersPerGroup ?? this.qualifiersPerGroup,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tournamentId.present) {
      map['tournament_id'] = Variable<int>(tournamentId.value);
    }
    if (numberOfGroups.present) {
      map['number_of_groups'] = Variable<int>(numberOfGroups.value);
    }
    if (knockoutStartStage.present) {
      map['knockout_start_stage'] = Variable<String>(knockoutStartStage.value);
    }
    if (qualifiersPerGroup.present) {
      map['qualifiers_per_group'] = Variable<int>(qualifiersPerGroup.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupKnockoutSettingsCompanion(')
          ..write('id: $id, ')
          ..write('tournamentId: $tournamentId, ')
          ..write('numberOfGroups: $numberOfGroups, ')
          ..write('knockoutStartStage: $knockoutStartStage, ')
          ..write('qualifiersPerGroup: $qualifiersPerGroup')
          ..write(')'))
        .toString();
  }
}

class $TournamentParticipantsTable extends TournamentParticipants
    with TableInfo<$TournamentParticipantsTable, TournamentParticipant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TournamentParticipantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tournamentIdMeta = const VerificationMeta(
    'tournamentId',
  );
  @override
  late final GeneratedColumn<int> tournamentId = GeneratedColumn<int>(
    'tournament_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tournaments (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _participantTypeMeta = const VerificationMeta(
    'participantType',
  );
  @override
  late final GeneratedColumn<String> participantType = GeneratedColumn<String>(
    'participant_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  static const VerificationMeta _individualTeamIdMeta = const VerificationMeta(
    'individualTeamId',
  );
  @override
  late final GeneratedColumn<int> individualTeamId = GeneratedColumn<int>(
    'individual_team_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES individual_teams (id)',
    ),
  );
  static const VerificationMeta _competitionTeamIdMeta = const VerificationMeta(
    'competitionTeamId',
  );
  @override
  late final GeneratedColumn<int> competitionTeamId = GeneratedColumn<int>(
    'competition_team_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES competition_teams (id)',
    ),
  );
  static const VerificationMeta _seedMeta = const VerificationMeta('seed');
  @override
  late final GeneratedColumn<int> seed = GeneratedColumn<int>(
    'seed',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _withdrawnMeta = const VerificationMeta(
    'withdrawn',
  );
  @override
  late final GeneratedColumn<bool> withdrawn = GeneratedColumn<bool>(
    'withdrawn',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("withdrawn" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tournamentId,
    eventType,
    participantType,
    playerId,
    individualTeamId,
    competitionTeamId,
    seed,
    withdrawn,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tournament_participants';
  @override
  VerificationContext validateIntegrity(
    Insertable<TournamentParticipant> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tournament_id')) {
      context.handle(
        _tournamentIdMeta,
        tournamentId.isAcceptableOrUnknown(
          data['tournament_id']!,
          _tournamentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tournamentIdMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('participant_type')) {
      context.handle(
        _participantTypeMeta,
        participantType.isAcceptableOrUnknown(
          data['participant_type']!,
          _participantTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_participantTypeMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    }
    if (data.containsKey('individual_team_id')) {
      context.handle(
        _individualTeamIdMeta,
        individualTeamId.isAcceptableOrUnknown(
          data['individual_team_id']!,
          _individualTeamIdMeta,
        ),
      );
    }
    if (data.containsKey('competition_team_id')) {
      context.handle(
        _competitionTeamIdMeta,
        competitionTeamId.isAcceptableOrUnknown(
          data['competition_team_id']!,
          _competitionTeamIdMeta,
        ),
      );
    }
    if (data.containsKey('seed')) {
      context.handle(
        _seedMeta,
        seed.isAcceptableOrUnknown(data['seed']!, _seedMeta),
      );
    }
    if (data.containsKey('withdrawn')) {
      context.handle(
        _withdrawnMeta,
        withdrawn.isAcceptableOrUnknown(data['withdrawn']!, _withdrawnMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TournamentParticipant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TournamentParticipant(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tournamentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tournament_id'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      participantType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}participant_type'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_id'],
      ),
      individualTeamId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}individual_team_id'],
      ),
      competitionTeamId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}competition_team_id'],
      ),
      seed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seed'],
      ),
      withdrawn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}withdrawn'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TournamentParticipantsTable createAlias(String alias) {
    return $TournamentParticipantsTable(attachedDatabase, alias);
  }
}

class TournamentParticipant extends DataClass
    implements Insertable<TournamentParticipant> {
  final int id;
  final int tournamentId;

  /// Must be one of the tournament's selected TournamentEvents rows.
  final String eventType;

  /// One of: 'player', 'pair', 'competition_team'.
  final String participantType;
  final int? playerId;
  final int? individualTeamId;
  final int? competitionTeamId;

  /// Reserved for future seeding. Not populated by this module.
  final int? seed;

  /// Withdrawal implies no ranking points (Rankings module later).
  /// This table only preserves the flag for that module to read.
  final bool withdrawn;
  final DateTime createdAt;
  const TournamentParticipant({
    required this.id,
    required this.tournamentId,
    required this.eventType,
    required this.participantType,
    this.playerId,
    this.individualTeamId,
    this.competitionTeamId,
    this.seed,
    required this.withdrawn,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tournament_id'] = Variable<int>(tournamentId);
    map['event_type'] = Variable<String>(eventType);
    map['participant_type'] = Variable<String>(participantType);
    if (!nullToAbsent || playerId != null) {
      map['player_id'] = Variable<int>(playerId);
    }
    if (!nullToAbsent || individualTeamId != null) {
      map['individual_team_id'] = Variable<int>(individualTeamId);
    }
    if (!nullToAbsent || competitionTeamId != null) {
      map['competition_team_id'] = Variable<int>(competitionTeamId);
    }
    if (!nullToAbsent || seed != null) {
      map['seed'] = Variable<int>(seed);
    }
    map['withdrawn'] = Variable<bool>(withdrawn);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TournamentParticipantsCompanion toCompanion(bool nullToAbsent) {
    return TournamentParticipantsCompanion(
      id: Value(id),
      tournamentId: Value(tournamentId),
      eventType: Value(eventType),
      participantType: Value(participantType),
      playerId: playerId == null && nullToAbsent
          ? const Value.absent()
          : Value(playerId),
      individualTeamId: individualTeamId == null && nullToAbsent
          ? const Value.absent()
          : Value(individualTeamId),
      competitionTeamId: competitionTeamId == null && nullToAbsent
          ? const Value.absent()
          : Value(competitionTeamId),
      seed: seed == null && nullToAbsent ? const Value.absent() : Value(seed),
      withdrawn: Value(withdrawn),
      createdAt: Value(createdAt),
    );
  }

  factory TournamentParticipant.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TournamentParticipant(
      id: serializer.fromJson<int>(json['id']),
      tournamentId: serializer.fromJson<int>(json['tournamentId']),
      eventType: serializer.fromJson<String>(json['eventType']),
      participantType: serializer.fromJson<String>(json['participantType']),
      playerId: serializer.fromJson<int?>(json['playerId']),
      individualTeamId: serializer.fromJson<int?>(json['individualTeamId']),
      competitionTeamId: serializer.fromJson<int?>(json['competitionTeamId']),
      seed: serializer.fromJson<int?>(json['seed']),
      withdrawn: serializer.fromJson<bool>(json['withdrawn']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tournamentId': serializer.toJson<int>(tournamentId),
      'eventType': serializer.toJson<String>(eventType),
      'participantType': serializer.toJson<String>(participantType),
      'playerId': serializer.toJson<int?>(playerId),
      'individualTeamId': serializer.toJson<int?>(individualTeamId),
      'competitionTeamId': serializer.toJson<int?>(competitionTeamId),
      'seed': serializer.toJson<int?>(seed),
      'withdrawn': serializer.toJson<bool>(withdrawn),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TournamentParticipant copyWith({
    int? id,
    int? tournamentId,
    String? eventType,
    String? participantType,
    Value<int?> playerId = const Value.absent(),
    Value<int?> individualTeamId = const Value.absent(),
    Value<int?> competitionTeamId = const Value.absent(),
    Value<int?> seed = const Value.absent(),
    bool? withdrawn,
    DateTime? createdAt,
  }) => TournamentParticipant(
    id: id ?? this.id,
    tournamentId: tournamentId ?? this.tournamentId,
    eventType: eventType ?? this.eventType,
    participantType: participantType ?? this.participantType,
    playerId: playerId.present ? playerId.value : this.playerId,
    individualTeamId: individualTeamId.present
        ? individualTeamId.value
        : this.individualTeamId,
    competitionTeamId: competitionTeamId.present
        ? competitionTeamId.value
        : this.competitionTeamId,
    seed: seed.present ? seed.value : this.seed,
    withdrawn: withdrawn ?? this.withdrawn,
    createdAt: createdAt ?? this.createdAt,
  );
  TournamentParticipant copyWithCompanion(
    TournamentParticipantsCompanion data,
  ) {
    return TournamentParticipant(
      id: data.id.present ? data.id.value : this.id,
      tournamentId: data.tournamentId.present
          ? data.tournamentId.value
          : this.tournamentId,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      participantType: data.participantType.present
          ? data.participantType.value
          : this.participantType,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      individualTeamId: data.individualTeamId.present
          ? data.individualTeamId.value
          : this.individualTeamId,
      competitionTeamId: data.competitionTeamId.present
          ? data.competitionTeamId.value
          : this.competitionTeamId,
      seed: data.seed.present ? data.seed.value : this.seed,
      withdrawn: data.withdrawn.present ? data.withdrawn.value : this.withdrawn,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TournamentParticipant(')
          ..write('id: $id, ')
          ..write('tournamentId: $tournamentId, ')
          ..write('eventType: $eventType, ')
          ..write('participantType: $participantType, ')
          ..write('playerId: $playerId, ')
          ..write('individualTeamId: $individualTeamId, ')
          ..write('competitionTeamId: $competitionTeamId, ')
          ..write('seed: $seed, ')
          ..write('withdrawn: $withdrawn, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tournamentId,
    eventType,
    participantType,
    playerId,
    individualTeamId,
    competitionTeamId,
    seed,
    withdrawn,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TournamentParticipant &&
          other.id == this.id &&
          other.tournamentId == this.tournamentId &&
          other.eventType == this.eventType &&
          other.participantType == this.participantType &&
          other.playerId == this.playerId &&
          other.individualTeamId == this.individualTeamId &&
          other.competitionTeamId == this.competitionTeamId &&
          other.seed == this.seed &&
          other.withdrawn == this.withdrawn &&
          other.createdAt == this.createdAt);
}

class TournamentParticipantsCompanion
    extends UpdateCompanion<TournamentParticipant> {
  final Value<int> id;
  final Value<int> tournamentId;
  final Value<String> eventType;
  final Value<String> participantType;
  final Value<int?> playerId;
  final Value<int?> individualTeamId;
  final Value<int?> competitionTeamId;
  final Value<int?> seed;
  final Value<bool> withdrawn;
  final Value<DateTime> createdAt;
  const TournamentParticipantsCompanion({
    this.id = const Value.absent(),
    this.tournamentId = const Value.absent(),
    this.eventType = const Value.absent(),
    this.participantType = const Value.absent(),
    this.playerId = const Value.absent(),
    this.individualTeamId = const Value.absent(),
    this.competitionTeamId = const Value.absent(),
    this.seed = const Value.absent(),
    this.withdrawn = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TournamentParticipantsCompanion.insert({
    this.id = const Value.absent(),
    required int tournamentId,
    required String eventType,
    required String participantType,
    this.playerId = const Value.absent(),
    this.individualTeamId = const Value.absent(),
    this.competitionTeamId = const Value.absent(),
    this.seed = const Value.absent(),
    this.withdrawn = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : tournamentId = Value(tournamentId),
       eventType = Value(eventType),
       participantType = Value(participantType);
  static Insertable<TournamentParticipant> custom({
    Expression<int>? id,
    Expression<int>? tournamentId,
    Expression<String>? eventType,
    Expression<String>? participantType,
    Expression<int>? playerId,
    Expression<int>? individualTeamId,
    Expression<int>? competitionTeamId,
    Expression<int>? seed,
    Expression<bool>? withdrawn,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tournamentId != null) 'tournament_id': tournamentId,
      if (eventType != null) 'event_type': eventType,
      if (participantType != null) 'participant_type': participantType,
      if (playerId != null) 'player_id': playerId,
      if (individualTeamId != null) 'individual_team_id': individualTeamId,
      if (competitionTeamId != null) 'competition_team_id': competitionTeamId,
      if (seed != null) 'seed': seed,
      if (withdrawn != null) 'withdrawn': withdrawn,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TournamentParticipantsCompanion copyWith({
    Value<int>? id,
    Value<int>? tournamentId,
    Value<String>? eventType,
    Value<String>? participantType,
    Value<int?>? playerId,
    Value<int?>? individualTeamId,
    Value<int?>? competitionTeamId,
    Value<int?>? seed,
    Value<bool>? withdrawn,
    Value<DateTime>? createdAt,
  }) {
    return TournamentParticipantsCompanion(
      id: id ?? this.id,
      tournamentId: tournamentId ?? this.tournamentId,
      eventType: eventType ?? this.eventType,
      participantType: participantType ?? this.participantType,
      playerId: playerId ?? this.playerId,
      individualTeamId: individualTeamId ?? this.individualTeamId,
      competitionTeamId: competitionTeamId ?? this.competitionTeamId,
      seed: seed ?? this.seed,
      withdrawn: withdrawn ?? this.withdrawn,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tournamentId.present) {
      map['tournament_id'] = Variable<int>(tournamentId.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (participantType.present) {
      map['participant_type'] = Variable<String>(participantType.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (individualTeamId.present) {
      map['individual_team_id'] = Variable<int>(individualTeamId.value);
    }
    if (competitionTeamId.present) {
      map['competition_team_id'] = Variable<int>(competitionTeamId.value);
    }
    if (seed.present) {
      map['seed'] = Variable<int>(seed.value);
    }
    if (withdrawn.present) {
      map['withdrawn'] = Variable<bool>(withdrawn.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TournamentParticipantsCompanion(')
          ..write('id: $id, ')
          ..write('tournamentId: $tournamentId, ')
          ..write('eventType: $eventType, ')
          ..write('participantType: $participantType, ')
          ..write('playerId: $playerId, ')
          ..write('individualTeamId: $individualTeamId, ')
          ..write('competitionTeamId: $competitionTeamId, ')
          ..write('seed: $seed, ')
          ..write('withdrawn: $withdrawn, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TeamEventAssignmentsTable extends TeamEventAssignments
    with TableInfo<$TeamEventAssignmentsTable, TeamEventAssignment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamEventAssignmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tournamentParticipantIdMeta =
      const VerificationMeta('tournamentParticipantId');
  @override
  late final GeneratedColumn<int> tournamentParticipantId =
      GeneratedColumn<int>(
        'tournament_participant_id',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tournament_participants (id) ON DELETE CASCADE',
        ),
      );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id)',
    ),
  );
  static const VerificationMeta _assignedEventMeta = const VerificationMeta(
    'assignedEvent',
  );
  @override
  late final GeneratedColumn<String> assignedEvent = GeneratedColumn<String>(
    'assigned_event',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _partnerAssignmentIdMeta =
      const VerificationMeta('partnerAssignmentId');
  @override
  late final GeneratedColumn<int> partnerAssignmentId = GeneratedColumn<int>(
    'partner_assignment_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES team_event_assignments (id) ON DELETE SET NULL',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tournamentParticipantId,
    playerId,
    assignedEvent,
    partnerAssignmentId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'team_event_assignments';
  @override
  VerificationContext validateIntegrity(
    Insertable<TeamEventAssignment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tournament_participant_id')) {
      context.handle(
        _tournamentParticipantIdMeta,
        tournamentParticipantId.isAcceptableOrUnknown(
          data['tournament_participant_id']!,
          _tournamentParticipantIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tournamentParticipantIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('assigned_event')) {
      context.handle(
        _assignedEventMeta,
        assignedEvent.isAcceptableOrUnknown(
          data['assigned_event']!,
          _assignedEventMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_assignedEventMeta);
    }
    if (data.containsKey('partner_assignment_id')) {
      context.handle(
        _partnerAssignmentIdMeta,
        partnerAssignmentId.isAcceptableOrUnknown(
          data['partner_assignment_id']!,
          _partnerAssignmentIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TeamEventAssignment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeamEventAssignment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tournamentParticipantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tournament_participant_id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_id'],
      )!,
      assignedEvent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assigned_event'],
      )!,
      partnerAssignmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}partner_assignment_id'],
      ),
    );
  }

  @override
  $TeamEventAssignmentsTable createAlias(String alias) {
    return $TeamEventAssignmentsTable(attachedDatabase, alias);
  }
}

class TeamEventAssignment extends DataClass
    implements Insertable<TeamEventAssignment> {
  final int id;
  final int tournamentParticipantId;
  final int playerId;

  /// One of: 'MS', 'WS', 'MD', 'WD', 'XD' — never 'TEAM'.
  final String assignedEvent;

  /// Explicit doubles partner pairing for MD/WD/XD within a Team Event.
  ///
  /// Self-referencing: points at the other [TeamEventAssignments] row this
  /// player is explicitly paired with for that doubles slot.
  ///
  /// Only relevant when [assignedEvent] is MD, WD, or XD.
  final int? partnerAssignmentId;
  const TeamEventAssignment({
    required this.id,
    required this.tournamentParticipantId,
    required this.playerId,
    required this.assignedEvent,
    this.partnerAssignmentId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tournament_participant_id'] = Variable<int>(tournamentParticipantId);
    map['player_id'] = Variable<int>(playerId);
    map['assigned_event'] = Variable<String>(assignedEvent);
    if (!nullToAbsent || partnerAssignmentId != null) {
      map['partner_assignment_id'] = Variable<int>(partnerAssignmentId);
    }
    return map;
  }

  TeamEventAssignmentsCompanion toCompanion(bool nullToAbsent) {
    return TeamEventAssignmentsCompanion(
      id: Value(id),
      tournamentParticipantId: Value(tournamentParticipantId),
      playerId: Value(playerId),
      assignedEvent: Value(assignedEvent),
      partnerAssignmentId: partnerAssignmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(partnerAssignmentId),
    );
  }

  factory TeamEventAssignment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeamEventAssignment(
      id: serializer.fromJson<int>(json['id']),
      tournamentParticipantId: serializer.fromJson<int>(
        json['tournamentParticipantId'],
      ),
      playerId: serializer.fromJson<int>(json['playerId']),
      assignedEvent: serializer.fromJson<String>(json['assignedEvent']),
      partnerAssignmentId: serializer.fromJson<int?>(
        json['partnerAssignmentId'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tournamentParticipantId': serializer.toJson<int>(
        tournamentParticipantId,
      ),
      'playerId': serializer.toJson<int>(playerId),
      'assignedEvent': serializer.toJson<String>(assignedEvent),
      'partnerAssignmentId': serializer.toJson<int?>(partnerAssignmentId),
    };
  }

  TeamEventAssignment copyWith({
    int? id,
    int? tournamentParticipantId,
    int? playerId,
    String? assignedEvent,
    Value<int?> partnerAssignmentId = const Value.absent(),
  }) => TeamEventAssignment(
    id: id ?? this.id,
    tournamentParticipantId:
        tournamentParticipantId ?? this.tournamentParticipantId,
    playerId: playerId ?? this.playerId,
    assignedEvent: assignedEvent ?? this.assignedEvent,
    partnerAssignmentId: partnerAssignmentId.present
        ? partnerAssignmentId.value
        : this.partnerAssignmentId,
  );
  TeamEventAssignment copyWithCompanion(TeamEventAssignmentsCompanion data) {
    return TeamEventAssignment(
      id: data.id.present ? data.id.value : this.id,
      tournamentParticipantId: data.tournamentParticipantId.present
          ? data.tournamentParticipantId.value
          : this.tournamentParticipantId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      assignedEvent: data.assignedEvent.present
          ? data.assignedEvent.value
          : this.assignedEvent,
      partnerAssignmentId: data.partnerAssignmentId.present
          ? data.partnerAssignmentId.value
          : this.partnerAssignmentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeamEventAssignment(')
          ..write('id: $id, ')
          ..write('tournamentParticipantId: $tournamentParticipantId, ')
          ..write('playerId: $playerId, ')
          ..write('assignedEvent: $assignedEvent, ')
          ..write('partnerAssignmentId: $partnerAssignmentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tournamentParticipantId,
    playerId,
    assignedEvent,
    partnerAssignmentId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamEventAssignment &&
          other.id == this.id &&
          other.tournamentParticipantId == this.tournamentParticipantId &&
          other.playerId == this.playerId &&
          other.assignedEvent == this.assignedEvent &&
          other.partnerAssignmentId == this.partnerAssignmentId);
}

class TeamEventAssignmentsCompanion
    extends UpdateCompanion<TeamEventAssignment> {
  final Value<int> id;
  final Value<int> tournamentParticipantId;
  final Value<int> playerId;
  final Value<String> assignedEvent;
  final Value<int?> partnerAssignmentId;
  const TeamEventAssignmentsCompanion({
    this.id = const Value.absent(),
    this.tournamentParticipantId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.assignedEvent = const Value.absent(),
    this.partnerAssignmentId = const Value.absent(),
  });
  TeamEventAssignmentsCompanion.insert({
    this.id = const Value.absent(),
    required int tournamentParticipantId,
    required int playerId,
    required String assignedEvent,
    this.partnerAssignmentId = const Value.absent(),
  }) : tournamentParticipantId = Value(tournamentParticipantId),
       playerId = Value(playerId),
       assignedEvent = Value(assignedEvent);
  static Insertable<TeamEventAssignment> custom({
    Expression<int>? id,
    Expression<int>? tournamentParticipantId,
    Expression<int>? playerId,
    Expression<String>? assignedEvent,
    Expression<int>? partnerAssignmentId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tournamentParticipantId != null)
        'tournament_participant_id': tournamentParticipantId,
      if (playerId != null) 'player_id': playerId,
      if (assignedEvent != null) 'assigned_event': assignedEvent,
      if (partnerAssignmentId != null)
        'partner_assignment_id': partnerAssignmentId,
    });
  }

  TeamEventAssignmentsCompanion copyWith({
    Value<int>? id,
    Value<int>? tournamentParticipantId,
    Value<int>? playerId,
    Value<String>? assignedEvent,
    Value<int?>? partnerAssignmentId,
  }) {
    return TeamEventAssignmentsCompanion(
      id: id ?? this.id,
      tournamentParticipantId:
          tournamentParticipantId ?? this.tournamentParticipantId,
      playerId: playerId ?? this.playerId,
      assignedEvent: assignedEvent ?? this.assignedEvent,
      partnerAssignmentId: partnerAssignmentId ?? this.partnerAssignmentId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tournamentParticipantId.present) {
      map['tournament_participant_id'] = Variable<int>(
        tournamentParticipantId.value,
      );
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (assignedEvent.present) {
      map['assigned_event'] = Variable<String>(assignedEvent.value);
    }
    if (partnerAssignmentId.present) {
      map['partner_assignment_id'] = Variable<int>(partnerAssignmentId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamEventAssignmentsCompanion(')
          ..write('id: $id, ')
          ..write('tournamentParticipantId: $tournamentParticipantId, ')
          ..write('playerId: $playerId, ')
          ..write('assignedEvent: $assignedEvent, ')
          ..write('partnerAssignmentId: $partnerAssignmentId')
          ..write(')'))
        .toString();
  }
}

class $GroupsTable extends Groups with TableInfo<$GroupsTable, Group> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tournamentIdMeta = const VerificationMeta(
    'tournamentId',
  );
  @override
  late final GeneratedColumn<int> tournamentId = GeneratedColumn<int>(
    'tournament_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tournaments (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groupNumberMeta = const VerificationMeta(
    'groupNumber',
  );
  @override
  late final GeneratedColumn<int> groupNumber = GeneratedColumn<int>(
    'group_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tournamentId,
    eventType,
    groupNumber,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<Group> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tournament_id')) {
      context.handle(
        _tournamentIdMeta,
        tournamentId.isAcceptableOrUnknown(
          data['tournament_id']!,
          _tournamentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tournamentIdMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('group_number')) {
      context.handle(
        _groupNumberMeta,
        groupNumber.isAcceptableOrUnknown(
          data['group_number']!,
          _groupNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_groupNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Group map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Group(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tournamentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tournament_id'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      groupNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_number'],
      )!,
    );
  }

  @override
  $GroupsTable createAlias(String alias) {
    return $GroupsTable(attachedDatabase, alias);
  }
}

class Group extends DataClass implements Insertable<Group> {
  final int id;
  final int tournamentId;
  final String eventType;

  /// 1-based group index (1, 2, 3, …).
  final int groupNumber;
  const Group({
    required this.id,
    required this.tournamentId,
    required this.eventType,
    required this.groupNumber,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tournament_id'] = Variable<int>(tournamentId);
    map['event_type'] = Variable<String>(eventType);
    map['group_number'] = Variable<int>(groupNumber);
    return map;
  }

  GroupsCompanion toCompanion(bool nullToAbsent) {
    return GroupsCompanion(
      id: Value(id),
      tournamentId: Value(tournamentId),
      eventType: Value(eventType),
      groupNumber: Value(groupNumber),
    );
  }

  factory Group.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Group(
      id: serializer.fromJson<int>(json['id']),
      tournamentId: serializer.fromJson<int>(json['tournamentId']),
      eventType: serializer.fromJson<String>(json['eventType']),
      groupNumber: serializer.fromJson<int>(json['groupNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tournamentId': serializer.toJson<int>(tournamentId),
      'eventType': serializer.toJson<String>(eventType),
      'groupNumber': serializer.toJson<int>(groupNumber),
    };
  }

  Group copyWith({
    int? id,
    int? tournamentId,
    String? eventType,
    int? groupNumber,
  }) => Group(
    id: id ?? this.id,
    tournamentId: tournamentId ?? this.tournamentId,
    eventType: eventType ?? this.eventType,
    groupNumber: groupNumber ?? this.groupNumber,
  );
  Group copyWithCompanion(GroupsCompanion data) {
    return Group(
      id: data.id.present ? data.id.value : this.id,
      tournamentId: data.tournamentId.present
          ? data.tournamentId.value
          : this.tournamentId,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      groupNumber: data.groupNumber.present
          ? data.groupNumber.value
          : this.groupNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Group(')
          ..write('id: $id, ')
          ..write('tournamentId: $tournamentId, ')
          ..write('eventType: $eventType, ')
          ..write('groupNumber: $groupNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tournamentId, eventType, groupNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Group &&
          other.id == this.id &&
          other.tournamentId == this.tournamentId &&
          other.eventType == this.eventType &&
          other.groupNumber == this.groupNumber);
}

class GroupsCompanion extends UpdateCompanion<Group> {
  final Value<int> id;
  final Value<int> tournamentId;
  final Value<String> eventType;
  final Value<int> groupNumber;
  const GroupsCompanion({
    this.id = const Value.absent(),
    this.tournamentId = const Value.absent(),
    this.eventType = const Value.absent(),
    this.groupNumber = const Value.absent(),
  });
  GroupsCompanion.insert({
    this.id = const Value.absent(),
    required int tournamentId,
    required String eventType,
    required int groupNumber,
  }) : tournamentId = Value(tournamentId),
       eventType = Value(eventType),
       groupNumber = Value(groupNumber);
  static Insertable<Group> custom({
    Expression<int>? id,
    Expression<int>? tournamentId,
    Expression<String>? eventType,
    Expression<int>? groupNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tournamentId != null) 'tournament_id': tournamentId,
      if (eventType != null) 'event_type': eventType,
      if (groupNumber != null) 'group_number': groupNumber,
    });
  }

  GroupsCompanion copyWith({
    Value<int>? id,
    Value<int>? tournamentId,
    Value<String>? eventType,
    Value<int>? groupNumber,
  }) {
    return GroupsCompanion(
      id: id ?? this.id,
      tournamentId: tournamentId ?? this.tournamentId,
      eventType: eventType ?? this.eventType,
      groupNumber: groupNumber ?? this.groupNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tournamentId.present) {
      map['tournament_id'] = Variable<int>(tournamentId.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (groupNumber.present) {
      map['group_number'] = Variable<int>(groupNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupsCompanion(')
          ..write('id: $id, ')
          ..write('tournamentId: $tournamentId, ')
          ..write('eventType: $eventType, ')
          ..write('groupNumber: $groupNumber')
          ..write(')'))
        .toString();
  }
}

class $GroupParticipantsTable extends GroupParticipants
    with TableInfo<$GroupParticipantsTable, GroupParticipant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupParticipantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES "groups" (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tournamentParticipantIdMeta =
      const VerificationMeta('tournamentParticipantId');
  @override
  late final GeneratedColumn<int> tournamentParticipantId =
      GeneratedColumn<int>(
        'tournament_participant_id',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tournament_participants (id) ON DELETE CASCADE',
        ),
      );
  @override
  List<GeneratedColumn> get $columns => [id, groupId, tournamentParticipantId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'group_participants';
  @override
  VerificationContext validateIntegrity(
    Insertable<GroupParticipant> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('tournament_participant_id')) {
      context.handle(
        _tournamentParticipantIdMeta,
        tournamentParticipantId.isAcceptableOrUnknown(
          data['tournament_participant_id']!,
          _tournamentParticipantIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tournamentParticipantIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroupParticipant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupParticipant(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_id'],
      )!,
      tournamentParticipantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tournament_participant_id'],
      )!,
    );
  }

  @override
  $GroupParticipantsTable createAlias(String alias) {
    return $GroupParticipantsTable(attachedDatabase, alias);
  }
}

class GroupParticipant extends DataClass
    implements Insertable<GroupParticipant> {
  final int id;
  final int groupId;
  final int tournamentParticipantId;
  const GroupParticipant({
    required this.id,
    required this.groupId,
    required this.tournamentParticipantId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['group_id'] = Variable<int>(groupId);
    map['tournament_participant_id'] = Variable<int>(tournamentParticipantId);
    return map;
  }

  GroupParticipantsCompanion toCompanion(bool nullToAbsent) {
    return GroupParticipantsCompanion(
      id: Value(id),
      groupId: Value(groupId),
      tournamentParticipantId: Value(tournamentParticipantId),
    );
  }

  factory GroupParticipant.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupParticipant(
      id: serializer.fromJson<int>(json['id']),
      groupId: serializer.fromJson<int>(json['groupId']),
      tournamentParticipantId: serializer.fromJson<int>(
        json['tournamentParticipantId'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'groupId': serializer.toJson<int>(groupId),
      'tournamentParticipantId': serializer.toJson<int>(
        tournamentParticipantId,
      ),
    };
  }

  GroupParticipant copyWith({
    int? id,
    int? groupId,
    int? tournamentParticipantId,
  }) => GroupParticipant(
    id: id ?? this.id,
    groupId: groupId ?? this.groupId,
    tournamentParticipantId:
        tournamentParticipantId ?? this.tournamentParticipantId,
  );
  GroupParticipant copyWithCompanion(GroupParticipantsCompanion data) {
    return GroupParticipant(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      tournamentParticipantId: data.tournamentParticipantId.present
          ? data.tournamentParticipantId.value
          : this.tournamentParticipantId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupParticipant(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('tournamentParticipantId: $tournamentParticipantId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupId, tournamentParticipantId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupParticipant &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.tournamentParticipantId == this.tournamentParticipantId);
}

class GroupParticipantsCompanion extends UpdateCompanion<GroupParticipant> {
  final Value<int> id;
  final Value<int> groupId;
  final Value<int> tournamentParticipantId;
  const GroupParticipantsCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.tournamentParticipantId = const Value.absent(),
  });
  GroupParticipantsCompanion.insert({
    this.id = const Value.absent(),
    required int groupId,
    required int tournamentParticipantId,
  }) : groupId = Value(groupId),
       tournamentParticipantId = Value(tournamentParticipantId);
  static Insertable<GroupParticipant> custom({
    Expression<int>? id,
    Expression<int>? groupId,
    Expression<int>? tournamentParticipantId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (tournamentParticipantId != null)
        'tournament_participant_id': tournamentParticipantId,
    });
  }

  GroupParticipantsCompanion copyWith({
    Value<int>? id,
    Value<int>? groupId,
    Value<int>? tournamentParticipantId,
  }) {
    return GroupParticipantsCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      tournamentParticipantId:
          tournamentParticipantId ?? this.tournamentParticipantId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (tournamentParticipantId.present) {
      map['tournament_participant_id'] = Variable<int>(
        tournamentParticipantId.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupParticipantsCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('tournamentParticipantId: $tournamentParticipantId')
          ..write(')'))
        .toString();
  }
}

class $FixturesTable extends Fixtures with TableInfo<$FixturesTable, Fixture> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FixturesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tournamentIdMeta = const VerificationMeta(
    'tournamentId',
  );
  @override
  late final GeneratedColumn<int> tournamentId = GeneratedColumn<int>(
    'tournament_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tournaments (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _participant1IdMeta = const VerificationMeta(
    'participant1Id',
  );
  @override
  late final GeneratedColumn<int> participant1Id = GeneratedColumn<int>(
    'participant1_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tournament_participants (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _participant2IdMeta = const VerificationMeta(
    'participant2Id',
  );
  @override
  late final GeneratedColumn<int> participant2Id = GeneratedColumn<int>(
    'participant2_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tournament_participants (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _courtNumberMeta = const VerificationMeta(
    'courtNumber',
  );
  @override
  late final GeneratedColumn<int> courtNumber = GeneratedColumn<int>(
    'court_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roundNumberMeta = const VerificationMeta(
    'roundNumber',
  );
  @override
  late final GeneratedColumn<int> roundNumber = GeneratedColumn<int>(
    'round_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _winnerParticipantIdMeta =
      const VerificationMeta('winnerParticipantId');
  @override
  late final GeneratedColumn<int> winnerParticipantId = GeneratedColumn<int>(
    'winner_participant_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tournament_participants (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _bracketRoundMeta = const VerificationMeta(
    'bracketRound',
  );
  @override
  late final GeneratedColumn<String> bracketRound = GeneratedColumn<String>(
    'bracket_round',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextFixtureIdMeta = const VerificationMeta(
    'nextFixtureId',
  );
  @override
  late final GeneratedColumn<int> nextFixtureId = GeneratedColumn<int>(
    'next_fixture_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fixtures (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _nextFixtureSlotMeta = const VerificationMeta(
    'nextFixtureSlot',
  );
  @override
  late final GeneratedColumn<int> nextFixtureSlot = GeneratedColumn<int>(
    'next_fixture_slot',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isByeMeta = const VerificationMeta('isBye');
  @override
  late final GeneratedColumn<bool> isBye = GeneratedColumn<bool>(
    'is_bye',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_bye" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _loserNextFixtureIdMeta =
      const VerificationMeta('loserNextFixtureId');
  @override
  late final GeneratedColumn<int> loserNextFixtureId = GeneratedColumn<int>(
    'loser_next_fixture_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fixtures (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _loserNextFixtureSlotMeta =
      const VerificationMeta('loserNextFixtureSlot');
  @override
  late final GeneratedColumn<int> loserNextFixtureSlot = GeneratedColumn<int>(
    'loser_next_fixture_slot',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
    'group_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES "groups" (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tournamentId,
    eventType,
    participant1Id,
    participant2Id,
    courtNumber,
    roundNumber,
    status,
    winnerParticipantId,
    createdAt,
    bracketRound,
    nextFixtureId,
    nextFixtureSlot,
    isBye,
    loserNextFixtureId,
    loserNextFixtureSlot,
    groupId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fixtures';
  @override
  VerificationContext validateIntegrity(
    Insertable<Fixture> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tournament_id')) {
      context.handle(
        _tournamentIdMeta,
        tournamentId.isAcceptableOrUnknown(
          data['tournament_id']!,
          _tournamentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tournamentIdMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('participant1_id')) {
      context.handle(
        _participant1IdMeta,
        participant1Id.isAcceptableOrUnknown(
          data['participant1_id']!,
          _participant1IdMeta,
        ),
      );
    }
    if (data.containsKey('participant2_id')) {
      context.handle(
        _participant2IdMeta,
        participant2Id.isAcceptableOrUnknown(
          data['participant2_id']!,
          _participant2IdMeta,
        ),
      );
    }
    if (data.containsKey('court_number')) {
      context.handle(
        _courtNumberMeta,
        courtNumber.isAcceptableOrUnknown(
          data['court_number']!,
          _courtNumberMeta,
        ),
      );
    }
    if (data.containsKey('round_number')) {
      context.handle(
        _roundNumberMeta,
        roundNumber.isAcceptableOrUnknown(
          data['round_number']!,
          _roundNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_roundNumberMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('winner_participant_id')) {
      context.handle(
        _winnerParticipantIdMeta,
        winnerParticipantId.isAcceptableOrUnknown(
          data['winner_participant_id']!,
          _winnerParticipantIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('bracket_round')) {
      context.handle(
        _bracketRoundMeta,
        bracketRound.isAcceptableOrUnknown(
          data['bracket_round']!,
          _bracketRoundMeta,
        ),
      );
    }
    if (data.containsKey('next_fixture_id')) {
      context.handle(
        _nextFixtureIdMeta,
        nextFixtureId.isAcceptableOrUnknown(
          data['next_fixture_id']!,
          _nextFixtureIdMeta,
        ),
      );
    }
    if (data.containsKey('next_fixture_slot')) {
      context.handle(
        _nextFixtureSlotMeta,
        nextFixtureSlot.isAcceptableOrUnknown(
          data['next_fixture_slot']!,
          _nextFixtureSlotMeta,
        ),
      );
    }
    if (data.containsKey('is_bye')) {
      context.handle(
        _isByeMeta,
        isBye.isAcceptableOrUnknown(data['is_bye']!, _isByeMeta),
      );
    }
    if (data.containsKey('loser_next_fixture_id')) {
      context.handle(
        _loserNextFixtureIdMeta,
        loserNextFixtureId.isAcceptableOrUnknown(
          data['loser_next_fixture_id']!,
          _loserNextFixtureIdMeta,
        ),
      );
    }
    if (data.containsKey('loser_next_fixture_slot')) {
      context.handle(
        _loserNextFixtureSlotMeta,
        loserNextFixtureSlot.isAcceptableOrUnknown(
          data['loser_next_fixture_slot']!,
          _loserNextFixtureSlotMeta,
        ),
      );
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Fixture map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Fixture(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tournamentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tournament_id'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      participant1Id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}participant1_id'],
      ),
      participant2Id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}participant2_id'],
      ),
      courtNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}court_number'],
      ),
      roundNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}round_number'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      winnerParticipantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}winner_participant_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      bracketRound: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bracket_round'],
      ),
      nextFixtureId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_fixture_id'],
      ),
      nextFixtureSlot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_fixture_slot'],
      ),
      isBye: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_bye'],
      )!,
      loserNextFixtureId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}loser_next_fixture_id'],
      ),
      loserNextFixtureSlot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}loser_next_fixture_slot'],
      ),
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_id'],
      ),
    );
  }

  @override
  $FixturesTable createAlias(String alias) {
    return $FixturesTable(attachedDatabase, alias);
  }
}

class Fixture extends DataClass implements Insertable<Fixture> {
  final int id;
  final int tournamentId;

  /// Event type for this match (MS/WS/MD/WD/XD/TEAM).
  final String eventType;
  final int? participant1Id;
  final int? participant2Id;

  /// Optional, can be filled during generation.
  final int? courtNumber;

  /// Round/time-slot (round-robin schedule) or knockout round index.
  final int roundNumber;

  /// 'pending' or 'completed'
  final String status;

  /// Winner participant, set once completed.
  final int? winnerParticipantId;
  final DateTime createdAt;

  /// Knockout only: e.g. 'round_of_16', 'quarterfinal', 'semifinal', 'final',
  /// 'bronze_medal_match'. Null for round-robin fixtures.
  final String? bracketRound;

  /// Knockout only: fixture the winner advances into. Null for final / bronze.
  final int? nextFixtureId;

  /// Knockout only: 1 or 2 — which slot in [nextFixtureId] the winner fills.
  final int? nextFixtureSlot;

  /// True when this row is a bye (one participant auto-advances, no match).
  final bool isBye;

  /// Knockout only: used for semifinal losers feeding a bronze medal match.
  final int? loserNextFixtureId;

  /// Knockout only: 1 or 2 — slot in [loserNextFixtureId] the loser fills.
  final int? loserNextFixtureSlot;

  /// Group-stage only: which group this fixture belongs to.
  /// Null for plain round-robin and knockout fixtures.
  final int? groupId;
  const Fixture({
    required this.id,
    required this.tournamentId,
    required this.eventType,
    this.participant1Id,
    this.participant2Id,
    this.courtNumber,
    required this.roundNumber,
    required this.status,
    this.winnerParticipantId,
    required this.createdAt,
    this.bracketRound,
    this.nextFixtureId,
    this.nextFixtureSlot,
    required this.isBye,
    this.loserNextFixtureId,
    this.loserNextFixtureSlot,
    this.groupId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tournament_id'] = Variable<int>(tournamentId);
    map['event_type'] = Variable<String>(eventType);
    if (!nullToAbsent || participant1Id != null) {
      map['participant1_id'] = Variable<int>(participant1Id);
    }
    if (!nullToAbsent || participant2Id != null) {
      map['participant2_id'] = Variable<int>(participant2Id);
    }
    if (!nullToAbsent || courtNumber != null) {
      map['court_number'] = Variable<int>(courtNumber);
    }
    map['round_number'] = Variable<int>(roundNumber);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || winnerParticipantId != null) {
      map['winner_participant_id'] = Variable<int>(winnerParticipantId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || bracketRound != null) {
      map['bracket_round'] = Variable<String>(bracketRound);
    }
    if (!nullToAbsent || nextFixtureId != null) {
      map['next_fixture_id'] = Variable<int>(nextFixtureId);
    }
    if (!nullToAbsent || nextFixtureSlot != null) {
      map['next_fixture_slot'] = Variable<int>(nextFixtureSlot);
    }
    map['is_bye'] = Variable<bool>(isBye);
    if (!nullToAbsent || loserNextFixtureId != null) {
      map['loser_next_fixture_id'] = Variable<int>(loserNextFixtureId);
    }
    if (!nullToAbsent || loserNextFixtureSlot != null) {
      map['loser_next_fixture_slot'] = Variable<int>(loserNextFixtureSlot);
    }
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<int>(groupId);
    }
    return map;
  }

  FixturesCompanion toCompanion(bool nullToAbsent) {
    return FixturesCompanion(
      id: Value(id),
      tournamentId: Value(tournamentId),
      eventType: Value(eventType),
      participant1Id: participant1Id == null && nullToAbsent
          ? const Value.absent()
          : Value(participant1Id),
      participant2Id: participant2Id == null && nullToAbsent
          ? const Value.absent()
          : Value(participant2Id),
      courtNumber: courtNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(courtNumber),
      roundNumber: Value(roundNumber),
      status: Value(status),
      winnerParticipantId: winnerParticipantId == null && nullToAbsent
          ? const Value.absent()
          : Value(winnerParticipantId),
      createdAt: Value(createdAt),
      bracketRound: bracketRound == null && nullToAbsent
          ? const Value.absent()
          : Value(bracketRound),
      nextFixtureId: nextFixtureId == null && nullToAbsent
          ? const Value.absent()
          : Value(nextFixtureId),
      nextFixtureSlot: nextFixtureSlot == null && nullToAbsent
          ? const Value.absent()
          : Value(nextFixtureSlot),
      isBye: Value(isBye),
      loserNextFixtureId: loserNextFixtureId == null && nullToAbsent
          ? const Value.absent()
          : Value(loserNextFixtureId),
      loserNextFixtureSlot: loserNextFixtureSlot == null && nullToAbsent
          ? const Value.absent()
          : Value(loserNextFixtureSlot),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
    );
  }

  factory Fixture.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Fixture(
      id: serializer.fromJson<int>(json['id']),
      tournamentId: serializer.fromJson<int>(json['tournamentId']),
      eventType: serializer.fromJson<String>(json['eventType']),
      participant1Id: serializer.fromJson<int?>(json['participant1Id']),
      participant2Id: serializer.fromJson<int?>(json['participant2Id']),
      courtNumber: serializer.fromJson<int?>(json['courtNumber']),
      roundNumber: serializer.fromJson<int>(json['roundNumber']),
      status: serializer.fromJson<String>(json['status']),
      winnerParticipantId: serializer.fromJson<int?>(
        json['winnerParticipantId'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      bracketRound: serializer.fromJson<String?>(json['bracketRound']),
      nextFixtureId: serializer.fromJson<int?>(json['nextFixtureId']),
      nextFixtureSlot: serializer.fromJson<int?>(json['nextFixtureSlot']),
      isBye: serializer.fromJson<bool>(json['isBye']),
      loserNextFixtureId: serializer.fromJson<int?>(json['loserNextFixtureId']),
      loserNextFixtureSlot: serializer.fromJson<int?>(
        json['loserNextFixtureSlot'],
      ),
      groupId: serializer.fromJson<int?>(json['groupId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tournamentId': serializer.toJson<int>(tournamentId),
      'eventType': serializer.toJson<String>(eventType),
      'participant1Id': serializer.toJson<int?>(participant1Id),
      'participant2Id': serializer.toJson<int?>(participant2Id),
      'courtNumber': serializer.toJson<int?>(courtNumber),
      'roundNumber': serializer.toJson<int>(roundNumber),
      'status': serializer.toJson<String>(status),
      'winnerParticipantId': serializer.toJson<int?>(winnerParticipantId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'bracketRound': serializer.toJson<String?>(bracketRound),
      'nextFixtureId': serializer.toJson<int?>(nextFixtureId),
      'nextFixtureSlot': serializer.toJson<int?>(nextFixtureSlot),
      'isBye': serializer.toJson<bool>(isBye),
      'loserNextFixtureId': serializer.toJson<int?>(loserNextFixtureId),
      'loserNextFixtureSlot': serializer.toJson<int?>(loserNextFixtureSlot),
      'groupId': serializer.toJson<int?>(groupId),
    };
  }

  Fixture copyWith({
    int? id,
    int? tournamentId,
    String? eventType,
    Value<int?> participant1Id = const Value.absent(),
    Value<int?> participant2Id = const Value.absent(),
    Value<int?> courtNumber = const Value.absent(),
    int? roundNumber,
    String? status,
    Value<int?> winnerParticipantId = const Value.absent(),
    DateTime? createdAt,
    Value<String?> bracketRound = const Value.absent(),
    Value<int?> nextFixtureId = const Value.absent(),
    Value<int?> nextFixtureSlot = const Value.absent(),
    bool? isBye,
    Value<int?> loserNextFixtureId = const Value.absent(),
    Value<int?> loserNextFixtureSlot = const Value.absent(),
    Value<int?> groupId = const Value.absent(),
  }) => Fixture(
    id: id ?? this.id,
    tournamentId: tournamentId ?? this.tournamentId,
    eventType: eventType ?? this.eventType,
    participant1Id: participant1Id.present
        ? participant1Id.value
        : this.participant1Id,
    participant2Id: participant2Id.present
        ? participant2Id.value
        : this.participant2Id,
    courtNumber: courtNumber.present ? courtNumber.value : this.courtNumber,
    roundNumber: roundNumber ?? this.roundNumber,
    status: status ?? this.status,
    winnerParticipantId: winnerParticipantId.present
        ? winnerParticipantId.value
        : this.winnerParticipantId,
    createdAt: createdAt ?? this.createdAt,
    bracketRound: bracketRound.present ? bracketRound.value : this.bracketRound,
    nextFixtureId: nextFixtureId.present
        ? nextFixtureId.value
        : this.nextFixtureId,
    nextFixtureSlot: nextFixtureSlot.present
        ? nextFixtureSlot.value
        : this.nextFixtureSlot,
    isBye: isBye ?? this.isBye,
    loserNextFixtureId: loserNextFixtureId.present
        ? loserNextFixtureId.value
        : this.loserNextFixtureId,
    loserNextFixtureSlot: loserNextFixtureSlot.present
        ? loserNextFixtureSlot.value
        : this.loserNextFixtureSlot,
    groupId: groupId.present ? groupId.value : this.groupId,
  );
  Fixture copyWithCompanion(FixturesCompanion data) {
    return Fixture(
      id: data.id.present ? data.id.value : this.id,
      tournamentId: data.tournamentId.present
          ? data.tournamentId.value
          : this.tournamentId,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      participant1Id: data.participant1Id.present
          ? data.participant1Id.value
          : this.participant1Id,
      participant2Id: data.participant2Id.present
          ? data.participant2Id.value
          : this.participant2Id,
      courtNumber: data.courtNumber.present
          ? data.courtNumber.value
          : this.courtNumber,
      roundNumber: data.roundNumber.present
          ? data.roundNumber.value
          : this.roundNumber,
      status: data.status.present ? data.status.value : this.status,
      winnerParticipantId: data.winnerParticipantId.present
          ? data.winnerParticipantId.value
          : this.winnerParticipantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      bracketRound: data.bracketRound.present
          ? data.bracketRound.value
          : this.bracketRound,
      nextFixtureId: data.nextFixtureId.present
          ? data.nextFixtureId.value
          : this.nextFixtureId,
      nextFixtureSlot: data.nextFixtureSlot.present
          ? data.nextFixtureSlot.value
          : this.nextFixtureSlot,
      isBye: data.isBye.present ? data.isBye.value : this.isBye,
      loserNextFixtureId: data.loserNextFixtureId.present
          ? data.loserNextFixtureId.value
          : this.loserNextFixtureId,
      loserNextFixtureSlot: data.loserNextFixtureSlot.present
          ? data.loserNextFixtureSlot.value
          : this.loserNextFixtureSlot,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Fixture(')
          ..write('id: $id, ')
          ..write('tournamentId: $tournamentId, ')
          ..write('eventType: $eventType, ')
          ..write('participant1Id: $participant1Id, ')
          ..write('participant2Id: $participant2Id, ')
          ..write('courtNumber: $courtNumber, ')
          ..write('roundNumber: $roundNumber, ')
          ..write('status: $status, ')
          ..write('winnerParticipantId: $winnerParticipantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('bracketRound: $bracketRound, ')
          ..write('nextFixtureId: $nextFixtureId, ')
          ..write('nextFixtureSlot: $nextFixtureSlot, ')
          ..write('isBye: $isBye, ')
          ..write('loserNextFixtureId: $loserNextFixtureId, ')
          ..write('loserNextFixtureSlot: $loserNextFixtureSlot, ')
          ..write('groupId: $groupId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tournamentId,
    eventType,
    participant1Id,
    participant2Id,
    courtNumber,
    roundNumber,
    status,
    winnerParticipantId,
    createdAt,
    bracketRound,
    nextFixtureId,
    nextFixtureSlot,
    isBye,
    loserNextFixtureId,
    loserNextFixtureSlot,
    groupId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Fixture &&
          other.id == this.id &&
          other.tournamentId == this.tournamentId &&
          other.eventType == this.eventType &&
          other.participant1Id == this.participant1Id &&
          other.participant2Id == this.participant2Id &&
          other.courtNumber == this.courtNumber &&
          other.roundNumber == this.roundNumber &&
          other.status == this.status &&
          other.winnerParticipantId == this.winnerParticipantId &&
          other.createdAt == this.createdAt &&
          other.bracketRound == this.bracketRound &&
          other.nextFixtureId == this.nextFixtureId &&
          other.nextFixtureSlot == this.nextFixtureSlot &&
          other.isBye == this.isBye &&
          other.loserNextFixtureId == this.loserNextFixtureId &&
          other.loserNextFixtureSlot == this.loserNextFixtureSlot &&
          other.groupId == this.groupId);
}

class FixturesCompanion extends UpdateCompanion<Fixture> {
  final Value<int> id;
  final Value<int> tournamentId;
  final Value<String> eventType;
  final Value<int?> participant1Id;
  final Value<int?> participant2Id;
  final Value<int?> courtNumber;
  final Value<int> roundNumber;
  final Value<String> status;
  final Value<int?> winnerParticipantId;
  final Value<DateTime> createdAt;
  final Value<String?> bracketRound;
  final Value<int?> nextFixtureId;
  final Value<int?> nextFixtureSlot;
  final Value<bool> isBye;
  final Value<int?> loserNextFixtureId;
  final Value<int?> loserNextFixtureSlot;
  final Value<int?> groupId;
  const FixturesCompanion({
    this.id = const Value.absent(),
    this.tournamentId = const Value.absent(),
    this.eventType = const Value.absent(),
    this.participant1Id = const Value.absent(),
    this.participant2Id = const Value.absent(),
    this.courtNumber = const Value.absent(),
    this.roundNumber = const Value.absent(),
    this.status = const Value.absent(),
    this.winnerParticipantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.bracketRound = const Value.absent(),
    this.nextFixtureId = const Value.absent(),
    this.nextFixtureSlot = const Value.absent(),
    this.isBye = const Value.absent(),
    this.loserNextFixtureId = const Value.absent(),
    this.loserNextFixtureSlot = const Value.absent(),
    this.groupId = const Value.absent(),
  });
  FixturesCompanion.insert({
    this.id = const Value.absent(),
    required int tournamentId,
    required String eventType,
    this.participant1Id = const Value.absent(),
    this.participant2Id = const Value.absent(),
    this.courtNumber = const Value.absent(),
    required int roundNumber,
    this.status = const Value.absent(),
    this.winnerParticipantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.bracketRound = const Value.absent(),
    this.nextFixtureId = const Value.absent(),
    this.nextFixtureSlot = const Value.absent(),
    this.isBye = const Value.absent(),
    this.loserNextFixtureId = const Value.absent(),
    this.loserNextFixtureSlot = const Value.absent(),
    this.groupId = const Value.absent(),
  }) : tournamentId = Value(tournamentId),
       eventType = Value(eventType),
       roundNumber = Value(roundNumber);
  static Insertable<Fixture> custom({
    Expression<int>? id,
    Expression<int>? tournamentId,
    Expression<String>? eventType,
    Expression<int>? participant1Id,
    Expression<int>? participant2Id,
    Expression<int>? courtNumber,
    Expression<int>? roundNumber,
    Expression<String>? status,
    Expression<int>? winnerParticipantId,
    Expression<DateTime>? createdAt,
    Expression<String>? bracketRound,
    Expression<int>? nextFixtureId,
    Expression<int>? nextFixtureSlot,
    Expression<bool>? isBye,
    Expression<int>? loserNextFixtureId,
    Expression<int>? loserNextFixtureSlot,
    Expression<int>? groupId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tournamentId != null) 'tournament_id': tournamentId,
      if (eventType != null) 'event_type': eventType,
      if (participant1Id != null) 'participant1_id': participant1Id,
      if (participant2Id != null) 'participant2_id': participant2Id,
      if (courtNumber != null) 'court_number': courtNumber,
      if (roundNumber != null) 'round_number': roundNumber,
      if (status != null) 'status': status,
      if (winnerParticipantId != null)
        'winner_participant_id': winnerParticipantId,
      if (createdAt != null) 'created_at': createdAt,
      if (bracketRound != null) 'bracket_round': bracketRound,
      if (nextFixtureId != null) 'next_fixture_id': nextFixtureId,
      if (nextFixtureSlot != null) 'next_fixture_slot': nextFixtureSlot,
      if (isBye != null) 'is_bye': isBye,
      if (loserNextFixtureId != null)
        'loser_next_fixture_id': loserNextFixtureId,
      if (loserNextFixtureSlot != null)
        'loser_next_fixture_slot': loserNextFixtureSlot,
      if (groupId != null) 'group_id': groupId,
    });
  }

  FixturesCompanion copyWith({
    Value<int>? id,
    Value<int>? tournamentId,
    Value<String>? eventType,
    Value<int?>? participant1Id,
    Value<int?>? participant2Id,
    Value<int?>? courtNumber,
    Value<int>? roundNumber,
    Value<String>? status,
    Value<int?>? winnerParticipantId,
    Value<DateTime>? createdAt,
    Value<String?>? bracketRound,
    Value<int?>? nextFixtureId,
    Value<int?>? nextFixtureSlot,
    Value<bool>? isBye,
    Value<int?>? loserNextFixtureId,
    Value<int?>? loserNextFixtureSlot,
    Value<int?>? groupId,
  }) {
    return FixturesCompanion(
      id: id ?? this.id,
      tournamentId: tournamentId ?? this.tournamentId,
      eventType: eventType ?? this.eventType,
      participant1Id: participant1Id ?? this.participant1Id,
      participant2Id: participant2Id ?? this.participant2Id,
      courtNumber: courtNumber ?? this.courtNumber,
      roundNumber: roundNumber ?? this.roundNumber,
      status: status ?? this.status,
      winnerParticipantId: winnerParticipantId ?? this.winnerParticipantId,
      createdAt: createdAt ?? this.createdAt,
      bracketRound: bracketRound ?? this.bracketRound,
      nextFixtureId: nextFixtureId ?? this.nextFixtureId,
      nextFixtureSlot: nextFixtureSlot ?? this.nextFixtureSlot,
      isBye: isBye ?? this.isBye,
      loserNextFixtureId: loserNextFixtureId ?? this.loserNextFixtureId,
      loserNextFixtureSlot: loserNextFixtureSlot ?? this.loserNextFixtureSlot,
      groupId: groupId ?? this.groupId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tournamentId.present) {
      map['tournament_id'] = Variable<int>(tournamentId.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (participant1Id.present) {
      map['participant1_id'] = Variable<int>(participant1Id.value);
    }
    if (participant2Id.present) {
      map['participant2_id'] = Variable<int>(participant2Id.value);
    }
    if (courtNumber.present) {
      map['court_number'] = Variable<int>(courtNumber.value);
    }
    if (roundNumber.present) {
      map['round_number'] = Variable<int>(roundNumber.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (winnerParticipantId.present) {
      map['winner_participant_id'] = Variable<int>(winnerParticipantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (bracketRound.present) {
      map['bracket_round'] = Variable<String>(bracketRound.value);
    }
    if (nextFixtureId.present) {
      map['next_fixture_id'] = Variable<int>(nextFixtureId.value);
    }
    if (nextFixtureSlot.present) {
      map['next_fixture_slot'] = Variable<int>(nextFixtureSlot.value);
    }
    if (isBye.present) {
      map['is_bye'] = Variable<bool>(isBye.value);
    }
    if (loserNextFixtureId.present) {
      map['loser_next_fixture_id'] = Variable<int>(loserNextFixtureId.value);
    }
    if (loserNextFixtureSlot.present) {
      map['loser_next_fixture_slot'] = Variable<int>(
        loserNextFixtureSlot.value,
      );
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FixturesCompanion(')
          ..write('id: $id, ')
          ..write('tournamentId: $tournamentId, ')
          ..write('eventType: $eventType, ')
          ..write('participant1Id: $participant1Id, ')
          ..write('participant2Id: $participant2Id, ')
          ..write('courtNumber: $courtNumber, ')
          ..write('roundNumber: $roundNumber, ')
          ..write('status: $status, ')
          ..write('winnerParticipantId: $winnerParticipantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('bracketRound: $bracketRound, ')
          ..write('nextFixtureId: $nextFixtureId, ')
          ..write('nextFixtureSlot: $nextFixtureSlot, ')
          ..write('isBye: $isBye, ')
          ..write('loserNextFixtureId: $loserNextFixtureId, ')
          ..write('loserNextFixtureSlot: $loserNextFixtureSlot, ')
          ..write('groupId: $groupId')
          ..write(')'))
        .toString();
  }
}

class $FixtureSetsTable extends FixtureSets
    with TableInfo<$FixtureSetsTable, FixtureSet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FixtureSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fixtureIdMeta = const VerificationMeta(
    'fixtureId',
  );
  @override
  late final GeneratedColumn<int> fixtureId = GeneratedColumn<int>(
    'fixture_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fixtures (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _setNumberMeta = const VerificationMeta(
    'setNumber',
  );
  @override
  late final GeneratedColumn<int> setNumber = GeneratedColumn<int>(
    'set_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _participant1ScoreMeta = const VerificationMeta(
    'participant1Score',
  );
  @override
  late final GeneratedColumn<int> participant1Score = GeneratedColumn<int>(
    'participant1_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _participant2ScoreMeta = const VerificationMeta(
    'participant2Score',
  );
  @override
  late final GeneratedColumn<int> participant2Score = GeneratedColumn<int>(
    'participant2_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fixtureId,
    setNumber,
    participant1Score,
    participant2Score,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fixture_sets';
  @override
  VerificationContext validateIntegrity(
    Insertable<FixtureSet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fixture_id')) {
      context.handle(
        _fixtureIdMeta,
        fixtureId.isAcceptableOrUnknown(data['fixture_id']!, _fixtureIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fixtureIdMeta);
    }
    if (data.containsKey('set_number')) {
      context.handle(
        _setNumberMeta,
        setNumber.isAcceptableOrUnknown(data['set_number']!, _setNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_setNumberMeta);
    }
    if (data.containsKey('participant1_score')) {
      context.handle(
        _participant1ScoreMeta,
        participant1Score.isAcceptableOrUnknown(
          data['participant1_score']!,
          _participant1ScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_participant1ScoreMeta);
    }
    if (data.containsKey('participant2_score')) {
      context.handle(
        _participant2ScoreMeta,
        participant2Score.isAcceptableOrUnknown(
          data['participant2_score']!,
          _participant2ScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_participant2ScoreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FixtureSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FixtureSet(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fixtureId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fixture_id'],
      )!,
      setNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}set_number'],
      )!,
      participant1Score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}participant1_score'],
      )!,
      participant2Score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}participant2_score'],
      )!,
    );
  }

  @override
  $FixtureSetsTable createAlias(String alias) {
    return $FixtureSetsTable(attachedDatabase, alias);
  }
}

class FixtureSet extends DataClass implements Insertable<FixtureSet> {
  final int id;
  final int fixtureId;
  final int setNumber;
  final int participant1Score;
  final int participant2Score;
  const FixtureSet({
    required this.id,
    required this.fixtureId,
    required this.setNumber,
    required this.participant1Score,
    required this.participant2Score,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fixture_id'] = Variable<int>(fixtureId);
    map['set_number'] = Variable<int>(setNumber);
    map['participant1_score'] = Variable<int>(participant1Score);
    map['participant2_score'] = Variable<int>(participant2Score);
    return map;
  }

  FixtureSetsCompanion toCompanion(bool nullToAbsent) {
    return FixtureSetsCompanion(
      id: Value(id),
      fixtureId: Value(fixtureId),
      setNumber: Value(setNumber),
      participant1Score: Value(participant1Score),
      participant2Score: Value(participant2Score),
    );
  }

  factory FixtureSet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FixtureSet(
      id: serializer.fromJson<int>(json['id']),
      fixtureId: serializer.fromJson<int>(json['fixtureId']),
      setNumber: serializer.fromJson<int>(json['setNumber']),
      participant1Score: serializer.fromJson<int>(json['participant1Score']),
      participant2Score: serializer.fromJson<int>(json['participant2Score']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fixtureId': serializer.toJson<int>(fixtureId),
      'setNumber': serializer.toJson<int>(setNumber),
      'participant1Score': serializer.toJson<int>(participant1Score),
      'participant2Score': serializer.toJson<int>(participant2Score),
    };
  }

  FixtureSet copyWith({
    int? id,
    int? fixtureId,
    int? setNumber,
    int? participant1Score,
    int? participant2Score,
  }) => FixtureSet(
    id: id ?? this.id,
    fixtureId: fixtureId ?? this.fixtureId,
    setNumber: setNumber ?? this.setNumber,
    participant1Score: participant1Score ?? this.participant1Score,
    participant2Score: participant2Score ?? this.participant2Score,
  );
  FixtureSet copyWithCompanion(FixtureSetsCompanion data) {
    return FixtureSet(
      id: data.id.present ? data.id.value : this.id,
      fixtureId: data.fixtureId.present ? data.fixtureId.value : this.fixtureId,
      setNumber: data.setNumber.present ? data.setNumber.value : this.setNumber,
      participant1Score: data.participant1Score.present
          ? data.participant1Score.value
          : this.participant1Score,
      participant2Score: data.participant2Score.present
          ? data.participant2Score.value
          : this.participant2Score,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FixtureSet(')
          ..write('id: $id, ')
          ..write('fixtureId: $fixtureId, ')
          ..write('setNumber: $setNumber, ')
          ..write('participant1Score: $participant1Score, ')
          ..write('participant2Score: $participant2Score')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fixtureId,
    setNumber,
    participant1Score,
    participant2Score,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FixtureSet &&
          other.id == this.id &&
          other.fixtureId == this.fixtureId &&
          other.setNumber == this.setNumber &&
          other.participant1Score == this.participant1Score &&
          other.participant2Score == this.participant2Score);
}

class FixtureSetsCompanion extends UpdateCompanion<FixtureSet> {
  final Value<int> id;
  final Value<int> fixtureId;
  final Value<int> setNumber;
  final Value<int> participant1Score;
  final Value<int> participant2Score;
  const FixtureSetsCompanion({
    this.id = const Value.absent(),
    this.fixtureId = const Value.absent(),
    this.setNumber = const Value.absent(),
    this.participant1Score = const Value.absent(),
    this.participant2Score = const Value.absent(),
  });
  FixtureSetsCompanion.insert({
    this.id = const Value.absent(),
    required int fixtureId,
    required int setNumber,
    required int participant1Score,
    required int participant2Score,
  }) : fixtureId = Value(fixtureId),
       setNumber = Value(setNumber),
       participant1Score = Value(participant1Score),
       participant2Score = Value(participant2Score);
  static Insertable<FixtureSet> custom({
    Expression<int>? id,
    Expression<int>? fixtureId,
    Expression<int>? setNumber,
    Expression<int>? participant1Score,
    Expression<int>? participant2Score,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fixtureId != null) 'fixture_id': fixtureId,
      if (setNumber != null) 'set_number': setNumber,
      if (participant1Score != null) 'participant1_score': participant1Score,
      if (participant2Score != null) 'participant2_score': participant2Score,
    });
  }

  FixtureSetsCompanion copyWith({
    Value<int>? id,
    Value<int>? fixtureId,
    Value<int>? setNumber,
    Value<int>? participant1Score,
    Value<int>? participant2Score,
  }) {
    return FixtureSetsCompanion(
      id: id ?? this.id,
      fixtureId: fixtureId ?? this.fixtureId,
      setNumber: setNumber ?? this.setNumber,
      participant1Score: participant1Score ?? this.participant1Score,
      participant2Score: participant2Score ?? this.participant2Score,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fixtureId.present) {
      map['fixture_id'] = Variable<int>(fixtureId.value);
    }
    if (setNumber.present) {
      map['set_number'] = Variable<int>(setNumber.value);
    }
    if (participant1Score.present) {
      map['participant1_score'] = Variable<int>(participant1Score.value);
    }
    if (participant2Score.present) {
      map['participant2_score'] = Variable<int>(participant2Score.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FixtureSetsCompanion(')
          ..write('id: $id, ')
          ..write('fixtureId: $fixtureId, ')
          ..write('setNumber: $setNumber, ')
          ..write('participant1Score: $participant1Score, ')
          ..write('participant2Score: $participant2Score')
          ..write(')'))
        .toString();
  }
}

class $ExternalResultsTable extends ExternalResults
    with TableInfo<$ExternalResultsTable, ExternalResult> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExternalResultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tournamentNameMeta = const VerificationMeta(
    'tournamentName',
  );
  @override
  late final GeneratedColumn<String> tournamentName = GeneratedColumn<String>(
    'tournament_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tournamentOrganiserMeta =
      const VerificationMeta('tournamentOrganiser');
  @override
  late final GeneratedColumn<String> tournamentOrganiser =
      GeneratedColumn<String>(
        'tournament_organiser',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _partnerNameMeta = const VerificationMeta(
    'partnerName',
  );
  @override
  late final GeneratedColumn<String> partnerName = GeneratedColumn<String>(
    'partner_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stageReachedMeta = const VerificationMeta(
    'stageReached',
  );
  @override
  late final GeneratedColumn<String> stageReached = GeneratedColumn<String>(
    'stage_reached',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rankingPointsAwardedMeta =
      const VerificationMeta('rankingPointsAwarded');
  @override
  late final GeneratedColumn<int> rankingPointsAwarded = GeneratedColumn<int>(
    'ranking_points_awarded',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    playerId,
    tournamentName,
    tournamentOrganiser,
    date,
    eventType,
    partnerName,
    stageReached,
    rankingPointsAwarded,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'external_results';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExternalResult> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('tournament_name')) {
      context.handle(
        _tournamentNameMeta,
        tournamentName.isAcceptableOrUnknown(
          data['tournament_name']!,
          _tournamentNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tournamentNameMeta);
    }
    if (data.containsKey('tournament_organiser')) {
      context.handle(
        _tournamentOrganiserMeta,
        tournamentOrganiser.isAcceptableOrUnknown(
          data['tournament_organiser']!,
          _tournamentOrganiserMeta,
        ),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('partner_name')) {
      context.handle(
        _partnerNameMeta,
        partnerName.isAcceptableOrUnknown(
          data['partner_name']!,
          _partnerNameMeta,
        ),
      );
    }
    if (data.containsKey('stage_reached')) {
      context.handle(
        _stageReachedMeta,
        stageReached.isAcceptableOrUnknown(
          data['stage_reached']!,
          _stageReachedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stageReachedMeta);
    }
    if (data.containsKey('ranking_points_awarded')) {
      context.handle(
        _rankingPointsAwardedMeta,
        rankingPointsAwarded.isAcceptableOrUnknown(
          data['ranking_points_awarded']!,
          _rankingPointsAwardedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rankingPointsAwardedMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExternalResult map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExternalResult(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_id'],
      )!,
      tournamentName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tournament_name'],
      )!,
      tournamentOrganiser: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tournament_organiser'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      partnerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}partner_name'],
      ),
      stageReached: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stage_reached'],
      )!,
      rankingPointsAwarded: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ranking_points_awarded'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ExternalResultsTable createAlias(String alias) {
    return $ExternalResultsTable(attachedDatabase, alias);
  }
}

class ExternalResult extends DataClass implements Insertable<ExternalResult> {
  final int id;
  final int playerId;
  final String tournamentName;
  final String? tournamentOrganiser;
  final DateTime date;

  /// One of: 'MS', 'WS', 'MD', 'WD', 'XD', 'TEAM'.
  final String eventType;

  /// Free-text display context only ("played with ___"). Not an FK.
  final String? partnerName;

  /// Free text, e.g. "Winner", "Semifinalist" — not constrained to an enum.
  final String stageReached;

  /// Manually entered; this app does not calculate the value.
  final int rankingPointsAwarded;
  final DateTime createdAt;
  const ExternalResult({
    required this.id,
    required this.playerId,
    required this.tournamentName,
    this.tournamentOrganiser,
    required this.date,
    required this.eventType,
    this.partnerName,
    required this.stageReached,
    required this.rankingPointsAwarded,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_id'] = Variable<int>(playerId);
    map['tournament_name'] = Variable<String>(tournamentName);
    if (!nullToAbsent || tournamentOrganiser != null) {
      map['tournament_organiser'] = Variable<String>(tournamentOrganiser);
    }
    map['date'] = Variable<DateTime>(date);
    map['event_type'] = Variable<String>(eventType);
    if (!nullToAbsent || partnerName != null) {
      map['partner_name'] = Variable<String>(partnerName);
    }
    map['stage_reached'] = Variable<String>(stageReached);
    map['ranking_points_awarded'] = Variable<int>(rankingPointsAwarded);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExternalResultsCompanion toCompanion(bool nullToAbsent) {
    return ExternalResultsCompanion(
      id: Value(id),
      playerId: Value(playerId),
      tournamentName: Value(tournamentName),
      tournamentOrganiser: tournamentOrganiser == null && nullToAbsent
          ? const Value.absent()
          : Value(tournamentOrganiser),
      date: Value(date),
      eventType: Value(eventType),
      partnerName: partnerName == null && nullToAbsent
          ? const Value.absent()
          : Value(partnerName),
      stageReached: Value(stageReached),
      rankingPointsAwarded: Value(rankingPointsAwarded),
      createdAt: Value(createdAt),
    );
  }

  factory ExternalResult.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExternalResult(
      id: serializer.fromJson<int>(json['id']),
      playerId: serializer.fromJson<int>(json['playerId']),
      tournamentName: serializer.fromJson<String>(json['tournamentName']),
      tournamentOrganiser: serializer.fromJson<String?>(
        json['tournamentOrganiser'],
      ),
      date: serializer.fromJson<DateTime>(json['date']),
      eventType: serializer.fromJson<String>(json['eventType']),
      partnerName: serializer.fromJson<String?>(json['partnerName']),
      stageReached: serializer.fromJson<String>(json['stageReached']),
      rankingPointsAwarded: serializer.fromJson<int>(
        json['rankingPointsAwarded'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerId': serializer.toJson<int>(playerId),
      'tournamentName': serializer.toJson<String>(tournamentName),
      'tournamentOrganiser': serializer.toJson<String?>(tournamentOrganiser),
      'date': serializer.toJson<DateTime>(date),
      'eventType': serializer.toJson<String>(eventType),
      'partnerName': serializer.toJson<String?>(partnerName),
      'stageReached': serializer.toJson<String>(stageReached),
      'rankingPointsAwarded': serializer.toJson<int>(rankingPointsAwarded),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ExternalResult copyWith({
    int? id,
    int? playerId,
    String? tournamentName,
    Value<String?> tournamentOrganiser = const Value.absent(),
    DateTime? date,
    String? eventType,
    Value<String?> partnerName = const Value.absent(),
    String? stageReached,
    int? rankingPointsAwarded,
    DateTime? createdAt,
  }) => ExternalResult(
    id: id ?? this.id,
    playerId: playerId ?? this.playerId,
    tournamentName: tournamentName ?? this.tournamentName,
    tournamentOrganiser: tournamentOrganiser.present
        ? tournamentOrganiser.value
        : this.tournamentOrganiser,
    date: date ?? this.date,
    eventType: eventType ?? this.eventType,
    partnerName: partnerName.present ? partnerName.value : this.partnerName,
    stageReached: stageReached ?? this.stageReached,
    rankingPointsAwarded: rankingPointsAwarded ?? this.rankingPointsAwarded,
    createdAt: createdAt ?? this.createdAt,
  );
  ExternalResult copyWithCompanion(ExternalResultsCompanion data) {
    return ExternalResult(
      id: data.id.present ? data.id.value : this.id,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      tournamentName: data.tournamentName.present
          ? data.tournamentName.value
          : this.tournamentName,
      tournamentOrganiser: data.tournamentOrganiser.present
          ? data.tournamentOrganiser.value
          : this.tournamentOrganiser,
      date: data.date.present ? data.date.value : this.date,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      partnerName: data.partnerName.present
          ? data.partnerName.value
          : this.partnerName,
      stageReached: data.stageReached.present
          ? data.stageReached.value
          : this.stageReached,
      rankingPointsAwarded: data.rankingPointsAwarded.present
          ? data.rankingPointsAwarded.value
          : this.rankingPointsAwarded,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExternalResult(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('tournamentName: $tournamentName, ')
          ..write('tournamentOrganiser: $tournamentOrganiser, ')
          ..write('date: $date, ')
          ..write('eventType: $eventType, ')
          ..write('partnerName: $partnerName, ')
          ..write('stageReached: $stageReached, ')
          ..write('rankingPointsAwarded: $rankingPointsAwarded, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    playerId,
    tournamentName,
    tournamentOrganiser,
    date,
    eventType,
    partnerName,
    stageReached,
    rankingPointsAwarded,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExternalResult &&
          other.id == this.id &&
          other.playerId == this.playerId &&
          other.tournamentName == this.tournamentName &&
          other.tournamentOrganiser == this.tournamentOrganiser &&
          other.date == this.date &&
          other.eventType == this.eventType &&
          other.partnerName == this.partnerName &&
          other.stageReached == this.stageReached &&
          other.rankingPointsAwarded == this.rankingPointsAwarded &&
          other.createdAt == this.createdAt);
}

class ExternalResultsCompanion extends UpdateCompanion<ExternalResult> {
  final Value<int> id;
  final Value<int> playerId;
  final Value<String> tournamentName;
  final Value<String?> tournamentOrganiser;
  final Value<DateTime> date;
  final Value<String> eventType;
  final Value<String?> partnerName;
  final Value<String> stageReached;
  final Value<int> rankingPointsAwarded;
  final Value<DateTime> createdAt;
  const ExternalResultsCompanion({
    this.id = const Value.absent(),
    this.playerId = const Value.absent(),
    this.tournamentName = const Value.absent(),
    this.tournamentOrganiser = const Value.absent(),
    this.date = const Value.absent(),
    this.eventType = const Value.absent(),
    this.partnerName = const Value.absent(),
    this.stageReached = const Value.absent(),
    this.rankingPointsAwarded = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ExternalResultsCompanion.insert({
    this.id = const Value.absent(),
    required int playerId,
    required String tournamentName,
    this.tournamentOrganiser = const Value.absent(),
    required DateTime date,
    required String eventType,
    this.partnerName = const Value.absent(),
    required String stageReached,
    required int rankingPointsAwarded,
    this.createdAt = const Value.absent(),
  }) : playerId = Value(playerId),
       tournamentName = Value(tournamentName),
       date = Value(date),
       eventType = Value(eventType),
       stageReached = Value(stageReached),
       rankingPointsAwarded = Value(rankingPointsAwarded);
  static Insertable<ExternalResult> custom({
    Expression<int>? id,
    Expression<int>? playerId,
    Expression<String>? tournamentName,
    Expression<String>? tournamentOrganiser,
    Expression<DateTime>? date,
    Expression<String>? eventType,
    Expression<String>? partnerName,
    Expression<String>? stageReached,
    Expression<int>? rankingPointsAwarded,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerId != null) 'player_id': playerId,
      if (tournamentName != null) 'tournament_name': tournamentName,
      if (tournamentOrganiser != null)
        'tournament_organiser': tournamentOrganiser,
      if (date != null) 'date': date,
      if (eventType != null) 'event_type': eventType,
      if (partnerName != null) 'partner_name': partnerName,
      if (stageReached != null) 'stage_reached': stageReached,
      if (rankingPointsAwarded != null)
        'ranking_points_awarded': rankingPointsAwarded,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ExternalResultsCompanion copyWith({
    Value<int>? id,
    Value<int>? playerId,
    Value<String>? tournamentName,
    Value<String?>? tournamentOrganiser,
    Value<DateTime>? date,
    Value<String>? eventType,
    Value<String?>? partnerName,
    Value<String>? stageReached,
    Value<int>? rankingPointsAwarded,
    Value<DateTime>? createdAt,
  }) {
    return ExternalResultsCompanion(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      tournamentName: tournamentName ?? this.tournamentName,
      tournamentOrganiser: tournamentOrganiser ?? this.tournamentOrganiser,
      date: date ?? this.date,
      eventType: eventType ?? this.eventType,
      partnerName: partnerName ?? this.partnerName,
      stageReached: stageReached ?? this.stageReached,
      rankingPointsAwarded: rankingPointsAwarded ?? this.rankingPointsAwarded,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (tournamentName.present) {
      map['tournament_name'] = Variable<String>(tournamentName.value);
    }
    if (tournamentOrganiser.present) {
      map['tournament_organiser'] = Variable<String>(tournamentOrganiser.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (partnerName.present) {
      map['partner_name'] = Variable<String>(partnerName.value);
    }
    if (stageReached.present) {
      map['stage_reached'] = Variable<String>(stageReached.value);
    }
    if (rankingPointsAwarded.present) {
      map['ranking_points_awarded'] = Variable<int>(rankingPointsAwarded.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExternalResultsCompanion(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('tournamentName: $tournamentName, ')
          ..write('tournamentOrganiser: $tournamentOrganiser, ')
          ..write('date: $date, ')
          ..write('eventType: $eventType, ')
          ..write('partnerName: $partnerName, ')
          ..write('stageReached: $stageReached, ')
          ..write('rankingPointsAwarded: $rankingPointsAwarded, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TierPointValuesTable extends TierPointValues
    with TableInfo<$TierPointValuesTable, TierPointValue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TierPointValuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tierLabelMeta = const VerificationMeta(
    'tierLabel',
  );
  @override
  late final GeneratedColumn<String> tierLabel = GeneratedColumn<String>(
    'tier_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _winnerPointsMeta = const VerificationMeta(
    'winnerPoints',
  );
  @override
  late final GeneratedColumn<int> winnerPoints = GeneratedColumn<int>(
    'winner_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _runnerUpPointsMeta = const VerificationMeta(
    'runnerUpPoints',
  );
  @override
  late final GeneratedColumn<int> runnerUpPoints = GeneratedColumn<int>(
    'runner_up_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _semiPointsMeta = const VerificationMeta(
    'semiPoints',
  );
  @override
  late final GeneratedColumn<int> semiPoints = GeneratedColumn<int>(
    'semi_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quarterPointsMeta = const VerificationMeta(
    'quarterPoints',
  );
  @override
  late final GeneratedColumn<int> quarterPoints = GeneratedColumn<int>(
    'quarter_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roundOf16PointsMeta = const VerificationMeta(
    'roundOf16Points',
  );
  @override
  late final GeneratedColumn<int> roundOf16Points = GeneratedColumn<int>(
    'round_of16_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roundOf32PointsMeta = const VerificationMeta(
    'roundOf32Points',
  );
  @override
  late final GeneratedColumn<int> roundOf32Points = GeneratedColumn<int>(
    'round_of32_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roundOf64PointsMeta = const VerificationMeta(
    'roundOf64Points',
  );
  @override
  late final GeneratedColumn<int> roundOf64Points = GeneratedColumn<int>(
    'round_of64_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tierLabel,
    winnerPoints,
    runnerUpPoints,
    semiPoints,
    quarterPoints,
    roundOf16Points,
    roundOf32Points,
    roundOf64Points,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tier_point_values';
  @override
  VerificationContext validateIntegrity(
    Insertable<TierPointValue> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tier_label')) {
      context.handle(
        _tierLabelMeta,
        tierLabel.isAcceptableOrUnknown(data['tier_label']!, _tierLabelMeta),
      );
    } else if (isInserting) {
      context.missing(_tierLabelMeta);
    }
    if (data.containsKey('winner_points')) {
      context.handle(
        _winnerPointsMeta,
        winnerPoints.isAcceptableOrUnknown(
          data['winner_points']!,
          _winnerPointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_winnerPointsMeta);
    }
    if (data.containsKey('runner_up_points')) {
      context.handle(
        _runnerUpPointsMeta,
        runnerUpPoints.isAcceptableOrUnknown(
          data['runner_up_points']!,
          _runnerUpPointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_runnerUpPointsMeta);
    }
    if (data.containsKey('semi_points')) {
      context.handle(
        _semiPointsMeta,
        semiPoints.isAcceptableOrUnknown(data['semi_points']!, _semiPointsMeta),
      );
    } else if (isInserting) {
      context.missing(_semiPointsMeta);
    }
    if (data.containsKey('quarter_points')) {
      context.handle(
        _quarterPointsMeta,
        quarterPoints.isAcceptableOrUnknown(
          data['quarter_points']!,
          _quarterPointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_quarterPointsMeta);
    }
    if (data.containsKey('round_of16_points')) {
      context.handle(
        _roundOf16PointsMeta,
        roundOf16Points.isAcceptableOrUnknown(
          data['round_of16_points']!,
          _roundOf16PointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_roundOf16PointsMeta);
    }
    if (data.containsKey('round_of32_points')) {
      context.handle(
        _roundOf32PointsMeta,
        roundOf32Points.isAcceptableOrUnknown(
          data['round_of32_points']!,
          _roundOf32PointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_roundOf32PointsMeta);
    }
    if (data.containsKey('round_of64_points')) {
      context.handle(
        _roundOf64PointsMeta,
        roundOf64Points.isAcceptableOrUnknown(
          data['round_of64_points']!,
          _roundOf64PointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_roundOf64PointsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TierPointValue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TierPointValue(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tierLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tier_label'],
      )!,
      winnerPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}winner_points'],
      )!,
      runnerUpPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}runner_up_points'],
      )!,
      semiPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}semi_points'],
      )!,
      quarterPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quarter_points'],
      )!,
      roundOf16Points: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}round_of16_points'],
      )!,
      roundOf32Points: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}round_of32_points'],
      )!,
      roundOf64Points: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}round_of64_points'],
      )!,
    );
  }

  @override
  $TierPointValuesTable createAlias(String alias) {
    return $TierPointValuesTable(attachedDatabase, alias);
  }
}

class TierPointValue extends DataClass implements Insertable<TierPointValue> {
  final int id;
  final String tierLabel;
  final int winnerPoints;
  final int runnerUpPoints;
  final int semiPoints;
  final int quarterPoints;
  final int roundOf16Points;
  final int roundOf32Points;
  final int roundOf64Points;
  const TierPointValue({
    required this.id,
    required this.tierLabel,
    required this.winnerPoints,
    required this.runnerUpPoints,
    required this.semiPoints,
    required this.quarterPoints,
    required this.roundOf16Points,
    required this.roundOf32Points,
    required this.roundOf64Points,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tier_label'] = Variable<String>(tierLabel);
    map['winner_points'] = Variable<int>(winnerPoints);
    map['runner_up_points'] = Variable<int>(runnerUpPoints);
    map['semi_points'] = Variable<int>(semiPoints);
    map['quarter_points'] = Variable<int>(quarterPoints);
    map['round_of16_points'] = Variable<int>(roundOf16Points);
    map['round_of32_points'] = Variable<int>(roundOf32Points);
    map['round_of64_points'] = Variable<int>(roundOf64Points);
    return map;
  }

  TierPointValuesCompanion toCompanion(bool nullToAbsent) {
    return TierPointValuesCompanion(
      id: Value(id),
      tierLabel: Value(tierLabel),
      winnerPoints: Value(winnerPoints),
      runnerUpPoints: Value(runnerUpPoints),
      semiPoints: Value(semiPoints),
      quarterPoints: Value(quarterPoints),
      roundOf16Points: Value(roundOf16Points),
      roundOf32Points: Value(roundOf32Points),
      roundOf64Points: Value(roundOf64Points),
    );
  }

  factory TierPointValue.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TierPointValue(
      id: serializer.fromJson<int>(json['id']),
      tierLabel: serializer.fromJson<String>(json['tierLabel']),
      winnerPoints: serializer.fromJson<int>(json['winnerPoints']),
      runnerUpPoints: serializer.fromJson<int>(json['runnerUpPoints']),
      semiPoints: serializer.fromJson<int>(json['semiPoints']),
      quarterPoints: serializer.fromJson<int>(json['quarterPoints']),
      roundOf16Points: serializer.fromJson<int>(json['roundOf16Points']),
      roundOf32Points: serializer.fromJson<int>(json['roundOf32Points']),
      roundOf64Points: serializer.fromJson<int>(json['roundOf64Points']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tierLabel': serializer.toJson<String>(tierLabel),
      'winnerPoints': serializer.toJson<int>(winnerPoints),
      'runnerUpPoints': serializer.toJson<int>(runnerUpPoints),
      'semiPoints': serializer.toJson<int>(semiPoints),
      'quarterPoints': serializer.toJson<int>(quarterPoints),
      'roundOf16Points': serializer.toJson<int>(roundOf16Points),
      'roundOf32Points': serializer.toJson<int>(roundOf32Points),
      'roundOf64Points': serializer.toJson<int>(roundOf64Points),
    };
  }

  TierPointValue copyWith({
    int? id,
    String? tierLabel,
    int? winnerPoints,
    int? runnerUpPoints,
    int? semiPoints,
    int? quarterPoints,
    int? roundOf16Points,
    int? roundOf32Points,
    int? roundOf64Points,
  }) => TierPointValue(
    id: id ?? this.id,
    tierLabel: tierLabel ?? this.tierLabel,
    winnerPoints: winnerPoints ?? this.winnerPoints,
    runnerUpPoints: runnerUpPoints ?? this.runnerUpPoints,
    semiPoints: semiPoints ?? this.semiPoints,
    quarterPoints: quarterPoints ?? this.quarterPoints,
    roundOf16Points: roundOf16Points ?? this.roundOf16Points,
    roundOf32Points: roundOf32Points ?? this.roundOf32Points,
    roundOf64Points: roundOf64Points ?? this.roundOf64Points,
  );
  TierPointValue copyWithCompanion(TierPointValuesCompanion data) {
    return TierPointValue(
      id: data.id.present ? data.id.value : this.id,
      tierLabel: data.tierLabel.present ? data.tierLabel.value : this.tierLabel,
      winnerPoints: data.winnerPoints.present
          ? data.winnerPoints.value
          : this.winnerPoints,
      runnerUpPoints: data.runnerUpPoints.present
          ? data.runnerUpPoints.value
          : this.runnerUpPoints,
      semiPoints: data.semiPoints.present
          ? data.semiPoints.value
          : this.semiPoints,
      quarterPoints: data.quarterPoints.present
          ? data.quarterPoints.value
          : this.quarterPoints,
      roundOf16Points: data.roundOf16Points.present
          ? data.roundOf16Points.value
          : this.roundOf16Points,
      roundOf32Points: data.roundOf32Points.present
          ? data.roundOf32Points.value
          : this.roundOf32Points,
      roundOf64Points: data.roundOf64Points.present
          ? data.roundOf64Points.value
          : this.roundOf64Points,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TierPointValue(')
          ..write('id: $id, ')
          ..write('tierLabel: $tierLabel, ')
          ..write('winnerPoints: $winnerPoints, ')
          ..write('runnerUpPoints: $runnerUpPoints, ')
          ..write('semiPoints: $semiPoints, ')
          ..write('quarterPoints: $quarterPoints, ')
          ..write('roundOf16Points: $roundOf16Points, ')
          ..write('roundOf32Points: $roundOf32Points, ')
          ..write('roundOf64Points: $roundOf64Points')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tierLabel,
    winnerPoints,
    runnerUpPoints,
    semiPoints,
    quarterPoints,
    roundOf16Points,
    roundOf32Points,
    roundOf64Points,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TierPointValue &&
          other.id == this.id &&
          other.tierLabel == this.tierLabel &&
          other.winnerPoints == this.winnerPoints &&
          other.runnerUpPoints == this.runnerUpPoints &&
          other.semiPoints == this.semiPoints &&
          other.quarterPoints == this.quarterPoints &&
          other.roundOf16Points == this.roundOf16Points &&
          other.roundOf32Points == this.roundOf32Points &&
          other.roundOf64Points == this.roundOf64Points);
}

class TierPointValuesCompanion extends UpdateCompanion<TierPointValue> {
  final Value<int> id;
  final Value<String> tierLabel;
  final Value<int> winnerPoints;
  final Value<int> runnerUpPoints;
  final Value<int> semiPoints;
  final Value<int> quarterPoints;
  final Value<int> roundOf16Points;
  final Value<int> roundOf32Points;
  final Value<int> roundOf64Points;
  const TierPointValuesCompanion({
    this.id = const Value.absent(),
    this.tierLabel = const Value.absent(),
    this.winnerPoints = const Value.absent(),
    this.runnerUpPoints = const Value.absent(),
    this.semiPoints = const Value.absent(),
    this.quarterPoints = const Value.absent(),
    this.roundOf16Points = const Value.absent(),
    this.roundOf32Points = const Value.absent(),
    this.roundOf64Points = const Value.absent(),
  });
  TierPointValuesCompanion.insert({
    this.id = const Value.absent(),
    required String tierLabel,
    required int winnerPoints,
    required int runnerUpPoints,
    required int semiPoints,
    required int quarterPoints,
    required int roundOf16Points,
    required int roundOf32Points,
    required int roundOf64Points,
  }) : tierLabel = Value(tierLabel),
       winnerPoints = Value(winnerPoints),
       runnerUpPoints = Value(runnerUpPoints),
       semiPoints = Value(semiPoints),
       quarterPoints = Value(quarterPoints),
       roundOf16Points = Value(roundOf16Points),
       roundOf32Points = Value(roundOf32Points),
       roundOf64Points = Value(roundOf64Points);
  static Insertable<TierPointValue> custom({
    Expression<int>? id,
    Expression<String>? tierLabel,
    Expression<int>? winnerPoints,
    Expression<int>? runnerUpPoints,
    Expression<int>? semiPoints,
    Expression<int>? quarterPoints,
    Expression<int>? roundOf16Points,
    Expression<int>? roundOf32Points,
    Expression<int>? roundOf64Points,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tierLabel != null) 'tier_label': tierLabel,
      if (winnerPoints != null) 'winner_points': winnerPoints,
      if (runnerUpPoints != null) 'runner_up_points': runnerUpPoints,
      if (semiPoints != null) 'semi_points': semiPoints,
      if (quarterPoints != null) 'quarter_points': quarterPoints,
      if (roundOf16Points != null) 'round_of16_points': roundOf16Points,
      if (roundOf32Points != null) 'round_of32_points': roundOf32Points,
      if (roundOf64Points != null) 'round_of64_points': roundOf64Points,
    });
  }

  TierPointValuesCompanion copyWith({
    Value<int>? id,
    Value<String>? tierLabel,
    Value<int>? winnerPoints,
    Value<int>? runnerUpPoints,
    Value<int>? semiPoints,
    Value<int>? quarterPoints,
    Value<int>? roundOf16Points,
    Value<int>? roundOf32Points,
    Value<int>? roundOf64Points,
  }) {
    return TierPointValuesCompanion(
      id: id ?? this.id,
      tierLabel: tierLabel ?? this.tierLabel,
      winnerPoints: winnerPoints ?? this.winnerPoints,
      runnerUpPoints: runnerUpPoints ?? this.runnerUpPoints,
      semiPoints: semiPoints ?? this.semiPoints,
      quarterPoints: quarterPoints ?? this.quarterPoints,
      roundOf16Points: roundOf16Points ?? this.roundOf16Points,
      roundOf32Points: roundOf32Points ?? this.roundOf32Points,
      roundOf64Points: roundOf64Points ?? this.roundOf64Points,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tierLabel.present) {
      map['tier_label'] = Variable<String>(tierLabel.value);
    }
    if (winnerPoints.present) {
      map['winner_points'] = Variable<int>(winnerPoints.value);
    }
    if (runnerUpPoints.present) {
      map['runner_up_points'] = Variable<int>(runnerUpPoints.value);
    }
    if (semiPoints.present) {
      map['semi_points'] = Variable<int>(semiPoints.value);
    }
    if (quarterPoints.present) {
      map['quarter_points'] = Variable<int>(quarterPoints.value);
    }
    if (roundOf16Points.present) {
      map['round_of16_points'] = Variable<int>(roundOf16Points.value);
    }
    if (roundOf32Points.present) {
      map['round_of32_points'] = Variable<int>(roundOf32Points.value);
    }
    if (roundOf64Points.present) {
      map['round_of64_points'] = Variable<int>(roundOf64Points.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TierPointValuesCompanion(')
          ..write('id: $id, ')
          ..write('tierLabel: $tierLabel, ')
          ..write('winnerPoints: $winnerPoints, ')
          ..write('runnerUpPoints: $runnerUpPoints, ')
          ..write('semiPoints: $semiPoints, ')
          ..write('quarterPoints: $quarterPoints, ')
          ..write('roundOf16Points: $roundOf16Points, ')
          ..write('roundOf32Points: $roundOf32Points, ')
          ..write('roundOf64Points: $roundOf64Points')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlayersTable players = $PlayersTable(this);
  late final $IndividualTeamsTable individualTeams = $IndividualTeamsTable(
    this,
  );
  late final $CompetitionTeamsTable competitionTeams = $CompetitionTeamsTable(
    this,
  );
  late final $CompetitionTeamMembersTable competitionTeamMembers =
      $CompetitionTeamMembersTable(this);
  late final $TournamentsTable tournaments = $TournamentsTable(this);
  late final $TournamentEventsTable tournamentEvents = $TournamentEventsTable(
    this,
  );
  late final $GroupKnockoutSettingsTable groupKnockoutSettings =
      $GroupKnockoutSettingsTable(this);
  late final $TournamentParticipantsTable tournamentParticipants =
      $TournamentParticipantsTable(this);
  late final $TeamEventAssignmentsTable teamEventAssignments =
      $TeamEventAssignmentsTable(this);
  late final $GroupsTable groups = $GroupsTable(this);
  late final $GroupParticipantsTable groupParticipants =
      $GroupParticipantsTable(this);
  late final $FixturesTable fixtures = $FixturesTable(this);
  late final $FixtureSetsTable fixtureSets = $FixtureSetsTable(this);
  late final $ExternalResultsTable externalResults = $ExternalResultsTable(
    this,
  );
  late final $TierPointValuesTable tierPointValues = $TierPointValuesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    players,
    individualTeams,
    competitionTeams,
    competitionTeamMembers,
    tournaments,
    tournamentEvents,
    groupKnockoutSettings,
    tournamentParticipants,
    teamEventAssignments,
    groups,
    groupParticipants,
    fixtures,
    fixtureSets,
    externalResults,
    tierPointValues,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tournaments',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tournament_events', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tournaments',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('group_knockout_settings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tournaments',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tournament_participants', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tournament_participants',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('team_event_assignments', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'team_event_assignments',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('team_event_assignments', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tournaments',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('groups', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'groups',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('group_participants', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tournament_participants',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('group_participants', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tournaments',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fixtures', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tournament_participants',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fixtures', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tournament_participants',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fixtures', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tournament_participants',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fixtures', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'fixtures',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fixtures', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'fixtures',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fixtures', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'groups',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fixtures', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'fixtures',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fixture_sets', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'players',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('external_results', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$PlayersTableCreateCompanionBuilder =
    PlayersCompanion Function({
      Value<int> id,
      required String fullName,
      required String gender,
      required DateTime dateOfBirth,
      Value<String?> clubOrSchool,
      Value<String?> phoneNumber,
      Value<int> matchesPlayed,
      Value<int> matchesWon,
      Value<int> matchesLost,
      Value<int> titlesWon,
      Value<DateTime> createdAt,
    });
typedef $$PlayersTableUpdateCompanionBuilder =
    PlayersCompanion Function({
      Value<int> id,
      Value<String> fullName,
      Value<String> gender,
      Value<DateTime> dateOfBirth,
      Value<String?> clubOrSchool,
      Value<String?> phoneNumber,
      Value<int> matchesPlayed,
      Value<int> matchesWon,
      Value<int> matchesLost,
      Value<int> titlesWon,
      Value<DateTime> createdAt,
    });

final class $$PlayersTableReferences
    extends BaseReferences<_$AppDatabase, $PlayersTable, Player> {
  $$PlayersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$IndividualTeamsTable, List<IndividualTeam>>
  _pairsAsPlayer1Table(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.individualTeams,
    aliasName: $_aliasNameGenerator(
      db.players.id,
      db.individualTeams.player1Id,
    ),
  );

  $$IndividualTeamsTableProcessedTableManager get pairsAsPlayer1 {
    final manager = $$IndividualTeamsTableTableManager(
      $_db,
      $_db.individualTeams,
    ).filter((f) => f.player1Id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pairsAsPlayer1Table($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$IndividualTeamsTable, List<IndividualTeam>>
  _pairsAsPlayer2Table(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.individualTeams,
    aliasName: $_aliasNameGenerator(
      db.players.id,
      db.individualTeams.player2Id,
    ),
  );

  $$IndividualTeamsTableProcessedTableManager get pairsAsPlayer2 {
    final manager = $$IndividualTeamsTableTableManager(
      $_db,
      $_db.individualTeams,
    ).filter((f) => f.player2Id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pairsAsPlayer2Table($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CompetitionTeamMembersTable,
    List<CompetitionTeamMember>
  >
  _competitionTeamMembersRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.competitionTeamMembers,
        aliasName: $_aliasNameGenerator(
          db.players.id,
          db.competitionTeamMembers.playerId,
        ),
      );

  $$CompetitionTeamMembersTableProcessedTableManager
  get competitionTeamMembersRefs {
    final manager = $$CompetitionTeamMembersTableTableManager(
      $_db,
      $_db.competitionTeamMembers,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _competitionTeamMembersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $TournamentParticipantsTable,
    List<TournamentParticipant>
  >
  _playerRegistrationsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.tournamentParticipants,
    aliasName: $_aliasNameGenerator(
      db.players.id,
      db.tournamentParticipants.playerId,
    ),
  );

  $$TournamentParticipantsTableProcessedTableManager get playerRegistrations {
    final manager = $$TournamentParticipantsTableTableManager(
      $_db,
      $_db.tournamentParticipants,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _playerRegistrationsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $TeamEventAssignmentsTable,
    List<TeamEventAssignment>
  >
  _teamEventAssignmentsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.teamEventAssignments,
    aliasName: $_aliasNameGenerator(
      db.players.id,
      db.teamEventAssignments.playerId,
    ),
  );

  $$TeamEventAssignmentsTableProcessedTableManager get teamEventAssignments {
    final manager = $$TeamEventAssignmentsTableTableManager(
      $_db,
      $_db.teamEventAssignments,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _teamEventAssignmentsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExternalResultsTable, List<ExternalResult>>
  _externalResultsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.externalResults,
    aliasName: $_aliasNameGenerator(db.players.id, db.externalResults.playerId),
  );

  $$ExternalResultsTableProcessedTableManager get externalResultsRefs {
    final manager = $$ExternalResultsTableTableManager(
      $_db,
      $_db.externalResults,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _externalResultsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlayersTableFilterComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clubOrSchool => $composableBuilder(
    column: $table.clubOrSchool,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get matchesPlayed => $composableBuilder(
    column: $table.matchesPlayed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get matchesWon => $composableBuilder(
    column: $table.matchesWon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get matchesLost => $composableBuilder(
    column: $table.matchesLost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get titlesWon => $composableBuilder(
    column: $table.titlesWon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pairsAsPlayer1(
    Expression<bool> Function($$IndividualTeamsTableFilterComposer f) f,
  ) {
    final $$IndividualTeamsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.individualTeams,
      getReferencedColumn: (t) => t.player1Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IndividualTeamsTableFilterComposer(
            $db: $db,
            $table: $db.individualTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pairsAsPlayer2(
    Expression<bool> Function($$IndividualTeamsTableFilterComposer f) f,
  ) {
    final $$IndividualTeamsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.individualTeams,
      getReferencedColumn: (t) => t.player2Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IndividualTeamsTableFilterComposer(
            $db: $db,
            $table: $db.individualTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> competitionTeamMembersRefs(
    Expression<bool> Function($$CompetitionTeamMembersTableFilterComposer f) f,
  ) {
    final $$CompetitionTeamMembersTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.competitionTeamMembers,
          getReferencedColumn: (t) => t.playerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CompetitionTeamMembersTableFilterComposer(
                $db: $db,
                $table: $db.competitionTeamMembers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> playerRegistrations(
    Expression<bool> Function($$TournamentParticipantsTableFilterComposer f) f,
  ) {
    final $$TournamentParticipantsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.playerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableFilterComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> teamEventAssignments(
    Expression<bool> Function($$TeamEventAssignmentsTableFilterComposer f) f,
  ) {
    final $$TeamEventAssignmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamEventAssignments,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamEventAssignmentsTableFilterComposer(
            $db: $db,
            $table: $db.teamEventAssignments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> externalResultsRefs(
    Expression<bool> Function($$ExternalResultsTableFilterComposer f) f,
  ) {
    final $$ExternalResultsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.externalResults,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExternalResultsTableFilterComposer(
            $db: $db,
            $table: $db.externalResults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clubOrSchool => $composableBuilder(
    column: $table.clubOrSchool,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get matchesPlayed => $composableBuilder(
    column: $table.matchesPlayed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get matchesWon => $composableBuilder(
    column: $table.matchesWon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get matchesLost => $composableBuilder(
    column: $table.matchesLost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get titlesWon => $composableBuilder(
    column: $table.titlesWon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clubOrSchool => $composableBuilder(
    column: $table.clubOrSchool,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get matchesPlayed => $composableBuilder(
    column: $table.matchesPlayed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get matchesWon => $composableBuilder(
    column: $table.matchesWon,
    builder: (column) => column,
  );

  GeneratedColumn<int> get matchesLost => $composableBuilder(
    column: $table.matchesLost,
    builder: (column) => column,
  );

  GeneratedColumn<int> get titlesWon =>
      $composableBuilder(column: $table.titlesWon, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> pairsAsPlayer1<T extends Object>(
    Expression<T> Function($$IndividualTeamsTableAnnotationComposer a) f,
  ) {
    final $$IndividualTeamsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.individualTeams,
      getReferencedColumn: (t) => t.player1Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IndividualTeamsTableAnnotationComposer(
            $db: $db,
            $table: $db.individualTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pairsAsPlayer2<T extends Object>(
    Expression<T> Function($$IndividualTeamsTableAnnotationComposer a) f,
  ) {
    final $$IndividualTeamsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.individualTeams,
      getReferencedColumn: (t) => t.player2Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IndividualTeamsTableAnnotationComposer(
            $db: $db,
            $table: $db.individualTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> competitionTeamMembersRefs<T extends Object>(
    Expression<T> Function($$CompetitionTeamMembersTableAnnotationComposer a) f,
  ) {
    final $$CompetitionTeamMembersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.competitionTeamMembers,
          getReferencedColumn: (t) => t.playerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CompetitionTeamMembersTableAnnotationComposer(
                $db: $db,
                $table: $db.competitionTeamMembers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> playerRegistrations<T extends Object>(
    Expression<T> Function($$TournamentParticipantsTableAnnotationComposer a) f,
  ) {
    final $$TournamentParticipantsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.playerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableAnnotationComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> teamEventAssignments<T extends Object>(
    Expression<T> Function($$TeamEventAssignmentsTableAnnotationComposer a) f,
  ) {
    final $$TeamEventAssignmentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.teamEventAssignments,
          getReferencedColumn: (t) => t.playerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TeamEventAssignmentsTableAnnotationComposer(
                $db: $db,
                $table: $db.teamEventAssignments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> externalResultsRefs<T extends Object>(
    Expression<T> Function($$ExternalResultsTableAnnotationComposer a) f,
  ) {
    final $$ExternalResultsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.externalResults,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExternalResultsTableAnnotationComposer(
            $db: $db,
            $table: $db.externalResults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayersTable,
          Player,
          $$PlayersTableFilterComposer,
          $$PlayersTableOrderingComposer,
          $$PlayersTableAnnotationComposer,
          $$PlayersTableCreateCompanionBuilder,
          $$PlayersTableUpdateCompanionBuilder,
          (Player, $$PlayersTableReferences),
          Player,
          PrefetchHooks Function({
            bool pairsAsPlayer1,
            bool pairsAsPlayer2,
            bool competitionTeamMembersRefs,
            bool playerRegistrations,
            bool teamEventAssignments,
            bool externalResultsRefs,
          })
        > {
  $$PlayersTableTableManager(_$AppDatabase db, $PlayersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String> gender = const Value.absent(),
                Value<DateTime> dateOfBirth = const Value.absent(),
                Value<String?> clubOrSchool = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<int> matchesPlayed = const Value.absent(),
                Value<int> matchesWon = const Value.absent(),
                Value<int> matchesLost = const Value.absent(),
                Value<int> titlesWon = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PlayersCompanion(
                id: id,
                fullName: fullName,
                gender: gender,
                dateOfBirth: dateOfBirth,
                clubOrSchool: clubOrSchool,
                phoneNumber: phoneNumber,
                matchesPlayed: matchesPlayed,
                matchesWon: matchesWon,
                matchesLost: matchesLost,
                titlesWon: titlesWon,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String fullName,
                required String gender,
                required DateTime dateOfBirth,
                Value<String?> clubOrSchool = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<int> matchesPlayed = const Value.absent(),
                Value<int> matchesWon = const Value.absent(),
                Value<int> matchesLost = const Value.absent(),
                Value<int> titlesWon = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PlayersCompanion.insert(
                id: id,
                fullName: fullName,
                gender: gender,
                dateOfBirth: dateOfBirth,
                clubOrSchool: clubOrSchool,
                phoneNumber: phoneNumber,
                matchesPlayed: matchesPlayed,
                matchesWon: matchesWon,
                matchesLost: matchesLost,
                titlesWon: titlesWon,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlayersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                pairsAsPlayer1 = false,
                pairsAsPlayer2 = false,
                competitionTeamMembersRefs = false,
                playerRegistrations = false,
                teamEventAssignments = false,
                externalResultsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pairsAsPlayer1) db.individualTeams,
                    if (pairsAsPlayer2) db.individualTeams,
                    if (competitionTeamMembersRefs) db.competitionTeamMembers,
                    if (playerRegistrations) db.tournamentParticipants,
                    if (teamEventAssignments) db.teamEventAssignments,
                    if (externalResultsRefs) db.externalResults,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pairsAsPlayer1)
                        await $_getPrefetchedData<
                          Player,
                          $PlayersTable,
                          IndividualTeam
                        >(
                          currentTable: table,
                          referencedTable: $$PlayersTableReferences
                              ._pairsAsPlayer1Table(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).pairsAsPlayer1,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.player1Id == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pairsAsPlayer2)
                        await $_getPrefetchedData<
                          Player,
                          $PlayersTable,
                          IndividualTeam
                        >(
                          currentTable: table,
                          referencedTable: $$PlayersTableReferences
                              ._pairsAsPlayer2Table(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).pairsAsPlayer2,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.player2Id == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (competitionTeamMembersRefs)
                        await $_getPrefetchedData<
                          Player,
                          $PlayersTable,
                          CompetitionTeamMember
                        >(
                          currentTable: table,
                          referencedTable: $$PlayersTableReferences
                              ._competitionTeamMembersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).competitionTeamMembersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.playerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (playerRegistrations)
                        await $_getPrefetchedData<
                          Player,
                          $PlayersTable,
                          TournamentParticipant
                        >(
                          currentTable: table,
                          referencedTable: $$PlayersTableReferences
                              ._playerRegistrationsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).playerRegistrations,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.playerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (teamEventAssignments)
                        await $_getPrefetchedData<
                          Player,
                          $PlayersTable,
                          TeamEventAssignment
                        >(
                          currentTable: table,
                          referencedTable: $$PlayersTableReferences
                              ._teamEventAssignmentsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).teamEventAssignments,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.playerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (externalResultsRefs)
                        await $_getPrefetchedData<
                          Player,
                          $PlayersTable,
                          ExternalResult
                        >(
                          currentTable: table,
                          referencedTable: $$PlayersTableReferences
                              ._externalResultsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayersTableReferences(
                                db,
                                table,
                                p0,
                              ).externalResultsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.playerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PlayersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayersTable,
      Player,
      $$PlayersTableFilterComposer,
      $$PlayersTableOrderingComposer,
      $$PlayersTableAnnotationComposer,
      $$PlayersTableCreateCompanionBuilder,
      $$PlayersTableUpdateCompanionBuilder,
      (Player, $$PlayersTableReferences),
      Player,
      PrefetchHooks Function({
        bool pairsAsPlayer1,
        bool pairsAsPlayer2,
        bool competitionTeamMembersRefs,
        bool playerRegistrations,
        bool teamEventAssignments,
        bool externalResultsRefs,
      })
    >;
typedef $$IndividualTeamsTableCreateCompanionBuilder =
    IndividualTeamsCompanion Function({
      Value<int> id,
      required int player1Id,
      required int player2Id,
      required String eventType,
      Value<DateTime> createdAt,
    });
typedef $$IndividualTeamsTableUpdateCompanionBuilder =
    IndividualTeamsCompanion Function({
      Value<int> id,
      Value<int> player1Id,
      Value<int> player2Id,
      Value<String> eventType,
      Value<DateTime> createdAt,
    });

final class $$IndividualTeamsTableReferences
    extends
        BaseReferences<_$AppDatabase, $IndividualTeamsTable, IndividualTeam> {
  $$IndividualTeamsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PlayersTable _player1IdTable(_$AppDatabase db) =>
      db.players.createAlias(
        $_aliasNameGenerator(db.individualTeams.player1Id, db.players.id),
      );

  $$PlayersTableProcessedTableManager get player1Id {
    final $_column = $_itemColumn<int>('player1_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_player1IdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PlayersTable _player2IdTable(_$AppDatabase db) =>
      db.players.createAlias(
        $_aliasNameGenerator(db.individualTeams.player2Id, db.players.id),
      );

  $$PlayersTableProcessedTableManager get player2Id {
    final $_column = $_itemColumn<int>('player2_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_player2IdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $TournamentParticipantsTable,
    List<TournamentParticipant>
  >
  _pairRegistrationsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.tournamentParticipants,
    aliasName: $_aliasNameGenerator(
      db.individualTeams.id,
      db.tournamentParticipants.individualTeamId,
    ),
  );

  $$TournamentParticipantsTableProcessedTableManager get pairRegistrations {
    final manager = $$TournamentParticipantsTableTableManager(
      $_db,
      $_db.tournamentParticipants,
    ).filter((f) => f.individualTeamId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pairRegistrationsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$IndividualTeamsTableFilterComposer
    extends Composer<_$AppDatabase, $IndividualTeamsTable> {
  $$IndividualTeamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PlayersTableFilterComposer get player1Id {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.player1Id,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableFilterComposer get player2Id {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.player2Id,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> pairRegistrations(
    Expression<bool> Function($$TournamentParticipantsTableFilterComposer f) f,
  ) {
    final $$TournamentParticipantsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.individualTeamId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableFilterComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$IndividualTeamsTableOrderingComposer
    extends Composer<_$AppDatabase, $IndividualTeamsTable> {
  $$IndividualTeamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlayersTableOrderingComposer get player1Id {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.player1Id,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableOrderingComposer get player2Id {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.player2Id,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IndividualTeamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IndividualTeamsTable> {
  $$IndividualTeamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PlayersTableAnnotationComposer get player1Id {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.player1Id,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableAnnotationComposer get player2Id {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.player2Id,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> pairRegistrations<T extends Object>(
    Expression<T> Function($$TournamentParticipantsTableAnnotationComposer a) f,
  ) {
    final $$TournamentParticipantsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.individualTeamId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableAnnotationComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$IndividualTeamsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IndividualTeamsTable,
          IndividualTeam,
          $$IndividualTeamsTableFilterComposer,
          $$IndividualTeamsTableOrderingComposer,
          $$IndividualTeamsTableAnnotationComposer,
          $$IndividualTeamsTableCreateCompanionBuilder,
          $$IndividualTeamsTableUpdateCompanionBuilder,
          (IndividualTeam, $$IndividualTeamsTableReferences),
          IndividualTeam,
          PrefetchHooks Function({
            bool player1Id,
            bool player2Id,
            bool pairRegistrations,
          })
        > {
  $$IndividualTeamsTableTableManager(
    _$AppDatabase db,
    $IndividualTeamsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IndividualTeamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IndividualTeamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IndividualTeamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> player1Id = const Value.absent(),
                Value<int> player2Id = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => IndividualTeamsCompanion(
                id: id,
                player1Id: player1Id,
                player2Id: player2Id,
                eventType: eventType,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int player1Id,
                required int player2Id,
                required String eventType,
                Value<DateTime> createdAt = const Value.absent(),
              }) => IndividualTeamsCompanion.insert(
                id: id,
                player1Id: player1Id,
                player2Id: player2Id,
                eventType: eventType,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$IndividualTeamsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                player1Id = false,
                player2Id = false,
                pairRegistrations = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pairRegistrations) db.tournamentParticipants,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (player1Id) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.player1Id,
                                    referencedTable:
                                        $$IndividualTeamsTableReferences
                                            ._player1IdTable(db),
                                    referencedColumn:
                                        $$IndividualTeamsTableReferences
                                            ._player1IdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (player2Id) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.player2Id,
                                    referencedTable:
                                        $$IndividualTeamsTableReferences
                                            ._player2IdTable(db),
                                    referencedColumn:
                                        $$IndividualTeamsTableReferences
                                            ._player2IdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pairRegistrations)
                        await $_getPrefetchedData<
                          IndividualTeam,
                          $IndividualTeamsTable,
                          TournamentParticipant
                        >(
                          currentTable: table,
                          referencedTable: $$IndividualTeamsTableReferences
                              ._pairRegistrationsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IndividualTeamsTableReferences(
                                db,
                                table,
                                p0,
                              ).pairRegistrations,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.individualTeamId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$IndividualTeamsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IndividualTeamsTable,
      IndividualTeam,
      $$IndividualTeamsTableFilterComposer,
      $$IndividualTeamsTableOrderingComposer,
      $$IndividualTeamsTableAnnotationComposer,
      $$IndividualTeamsTableCreateCompanionBuilder,
      $$IndividualTeamsTableUpdateCompanionBuilder,
      (IndividualTeam, $$IndividualTeamsTableReferences),
      IndividualTeam,
      PrefetchHooks Function({
        bool player1Id,
        bool player2Id,
        bool pairRegistrations,
      })
    >;
typedef $$CompetitionTeamsTableCreateCompanionBuilder =
    CompetitionTeamsCompanion Function({
      Value<int> id,
      required String teamName,
      Value<String?> clubOrSchool,
      Value<DateTime> createdAt,
    });
typedef $$CompetitionTeamsTableUpdateCompanionBuilder =
    CompetitionTeamsCompanion Function({
      Value<int> id,
      Value<String> teamName,
      Value<String?> clubOrSchool,
      Value<DateTime> createdAt,
    });

final class $$CompetitionTeamsTableReferences
    extends
        BaseReferences<_$AppDatabase, $CompetitionTeamsTable, CompetitionTeam> {
  $$CompetitionTeamsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $CompetitionTeamMembersTable,
    List<CompetitionTeamMember>
  >
  _competitionTeamMembersRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.competitionTeamMembers,
        aliasName: $_aliasNameGenerator(
          db.competitionTeams.id,
          db.competitionTeamMembers.competitionTeamId,
        ),
      );

  $$CompetitionTeamMembersTableProcessedTableManager
  get competitionTeamMembersRefs {
    final manager = $$CompetitionTeamMembersTableTableManager(
      $_db,
      $_db.competitionTeamMembers,
    ).filter((f) => f.competitionTeamId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _competitionTeamMembersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $TournamentParticipantsTable,
    List<TournamentParticipant>
  >
  _competitionTeamRegistrationsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.tournamentParticipants,
        aliasName: $_aliasNameGenerator(
          db.competitionTeams.id,
          db.tournamentParticipants.competitionTeamId,
        ),
      );

  $$TournamentParticipantsTableProcessedTableManager
  get competitionTeamRegistrations {
    final manager = $$TournamentParticipantsTableTableManager(
      $_db,
      $_db.tournamentParticipants,
    ).filter((f) => f.competitionTeamId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _competitionTeamRegistrationsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CompetitionTeamsTableFilterComposer
    extends Composer<_$AppDatabase, $CompetitionTeamsTable> {
  $$CompetitionTeamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamName => $composableBuilder(
    column: $table.teamName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clubOrSchool => $composableBuilder(
    column: $table.clubOrSchool,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> competitionTeamMembersRefs(
    Expression<bool> Function($$CompetitionTeamMembersTableFilterComposer f) f,
  ) {
    final $$CompetitionTeamMembersTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.competitionTeamMembers,
          getReferencedColumn: (t) => t.competitionTeamId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CompetitionTeamMembersTableFilterComposer(
                $db: $db,
                $table: $db.competitionTeamMembers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> competitionTeamRegistrations(
    Expression<bool> Function($$TournamentParticipantsTableFilterComposer f) f,
  ) {
    final $$TournamentParticipantsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.competitionTeamId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableFilterComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CompetitionTeamsTableOrderingComposer
    extends Composer<_$AppDatabase, $CompetitionTeamsTable> {
  $$CompetitionTeamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamName => $composableBuilder(
    column: $table.teamName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clubOrSchool => $composableBuilder(
    column: $table.clubOrSchool,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CompetitionTeamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompetitionTeamsTable> {
  $$CompetitionTeamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get teamName =>
      $composableBuilder(column: $table.teamName, builder: (column) => column);

  GeneratedColumn<String> get clubOrSchool => $composableBuilder(
    column: $table.clubOrSchool,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> competitionTeamMembersRefs<T extends Object>(
    Expression<T> Function($$CompetitionTeamMembersTableAnnotationComposer a) f,
  ) {
    final $$CompetitionTeamMembersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.competitionTeamMembers,
          getReferencedColumn: (t) => t.competitionTeamId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CompetitionTeamMembersTableAnnotationComposer(
                $db: $db,
                $table: $db.competitionTeamMembers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> competitionTeamRegistrations<T extends Object>(
    Expression<T> Function($$TournamentParticipantsTableAnnotationComposer a) f,
  ) {
    final $$TournamentParticipantsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.competitionTeamId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableAnnotationComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CompetitionTeamsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompetitionTeamsTable,
          CompetitionTeam,
          $$CompetitionTeamsTableFilterComposer,
          $$CompetitionTeamsTableOrderingComposer,
          $$CompetitionTeamsTableAnnotationComposer,
          $$CompetitionTeamsTableCreateCompanionBuilder,
          $$CompetitionTeamsTableUpdateCompanionBuilder,
          (CompetitionTeam, $$CompetitionTeamsTableReferences),
          CompetitionTeam,
          PrefetchHooks Function({
            bool competitionTeamMembersRefs,
            bool competitionTeamRegistrations,
          })
        > {
  $$CompetitionTeamsTableTableManager(
    _$AppDatabase db,
    $CompetitionTeamsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompetitionTeamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompetitionTeamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompetitionTeamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> teamName = const Value.absent(),
                Value<String?> clubOrSchool = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CompetitionTeamsCompanion(
                id: id,
                teamName: teamName,
                clubOrSchool: clubOrSchool,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String teamName,
                Value<String?> clubOrSchool = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CompetitionTeamsCompanion.insert(
                id: id,
                teamName: teamName,
                clubOrSchool: clubOrSchool,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CompetitionTeamsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                competitionTeamMembersRefs = false,
                competitionTeamRegistrations = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (competitionTeamMembersRefs) db.competitionTeamMembers,
                    if (competitionTeamRegistrations) db.tournamentParticipants,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (competitionTeamMembersRefs)
                        await $_getPrefetchedData<
                          CompetitionTeam,
                          $CompetitionTeamsTable,
                          CompetitionTeamMember
                        >(
                          currentTable: table,
                          referencedTable: $$CompetitionTeamsTableReferences
                              ._competitionTeamMembersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CompetitionTeamsTableReferences(
                                db,
                                table,
                                p0,
                              ).competitionTeamMembersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.competitionTeamId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (competitionTeamRegistrations)
                        await $_getPrefetchedData<
                          CompetitionTeam,
                          $CompetitionTeamsTable,
                          TournamentParticipant
                        >(
                          currentTable: table,
                          referencedTable: $$CompetitionTeamsTableReferences
                              ._competitionTeamRegistrationsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CompetitionTeamsTableReferences(
                                db,
                                table,
                                p0,
                              ).competitionTeamRegistrations,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.competitionTeamId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CompetitionTeamsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompetitionTeamsTable,
      CompetitionTeam,
      $$CompetitionTeamsTableFilterComposer,
      $$CompetitionTeamsTableOrderingComposer,
      $$CompetitionTeamsTableAnnotationComposer,
      $$CompetitionTeamsTableCreateCompanionBuilder,
      $$CompetitionTeamsTableUpdateCompanionBuilder,
      (CompetitionTeam, $$CompetitionTeamsTableReferences),
      CompetitionTeam,
      PrefetchHooks Function({
        bool competitionTeamMembersRefs,
        bool competitionTeamRegistrations,
      })
    >;
typedef $$CompetitionTeamMembersTableCreateCompanionBuilder =
    CompetitionTeamMembersCompanion Function({
      Value<int> id,
      required int competitionTeamId,
      required int playerId,
      Value<DateTime> createdAt,
    });
typedef $$CompetitionTeamMembersTableUpdateCompanionBuilder =
    CompetitionTeamMembersCompanion Function({
      Value<int> id,
      Value<int> competitionTeamId,
      Value<int> playerId,
      Value<DateTime> createdAt,
    });

final class $$CompetitionTeamMembersTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CompetitionTeamMembersTable,
          CompetitionTeamMember
        > {
  $$CompetitionTeamMembersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CompetitionTeamsTable _competitionTeamIdTable(_$AppDatabase db) =>
      db.competitionTeams.createAlias(
        $_aliasNameGenerator(
          db.competitionTeamMembers.competitionTeamId,
          db.competitionTeams.id,
        ),
      );

  $$CompetitionTeamsTableProcessedTableManager get competitionTeamId {
    final $_column = $_itemColumn<int>('competition_team_id')!;

    final manager = $$CompetitionTeamsTableTableManager(
      $_db,
      $_db.competitionTeams,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_competitionTeamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PlayersTable _playerIdTable(_$AppDatabase db) =>
      db.players.createAlias(
        $_aliasNameGenerator(db.competitionTeamMembers.playerId, db.players.id),
      );

  $$PlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<int>('player_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CompetitionTeamMembersTableFilterComposer
    extends Composer<_$AppDatabase, $CompetitionTeamMembersTable> {
  $$CompetitionTeamMembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CompetitionTeamsTableFilterComposer get competitionTeamId {
    final $$CompetitionTeamsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.competitionTeamId,
      referencedTable: $db.competitionTeams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompetitionTeamsTableFilterComposer(
            $db: $db,
            $table: $db.competitionTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CompetitionTeamMembersTableOrderingComposer
    extends Composer<_$AppDatabase, $CompetitionTeamMembersTable> {
  $$CompetitionTeamMembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CompetitionTeamsTableOrderingComposer get competitionTeamId {
    final $$CompetitionTeamsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.competitionTeamId,
      referencedTable: $db.competitionTeams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompetitionTeamsTableOrderingComposer(
            $db: $db,
            $table: $db.competitionTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CompetitionTeamMembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompetitionTeamMembersTable> {
  $$CompetitionTeamMembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CompetitionTeamsTableAnnotationComposer get competitionTeamId {
    final $$CompetitionTeamsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.competitionTeamId,
      referencedTable: $db.competitionTeams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompetitionTeamsTableAnnotationComposer(
            $db: $db,
            $table: $db.competitionTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CompetitionTeamMembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompetitionTeamMembersTable,
          CompetitionTeamMember,
          $$CompetitionTeamMembersTableFilterComposer,
          $$CompetitionTeamMembersTableOrderingComposer,
          $$CompetitionTeamMembersTableAnnotationComposer,
          $$CompetitionTeamMembersTableCreateCompanionBuilder,
          $$CompetitionTeamMembersTableUpdateCompanionBuilder,
          (CompetitionTeamMember, $$CompetitionTeamMembersTableReferences),
          CompetitionTeamMember,
          PrefetchHooks Function({bool competitionTeamId, bool playerId})
        > {
  $$CompetitionTeamMembersTableTableManager(
    _$AppDatabase db,
    $CompetitionTeamMembersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompetitionTeamMembersTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CompetitionTeamMembersTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CompetitionTeamMembersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> competitionTeamId = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CompetitionTeamMembersCompanion(
                id: id,
                competitionTeamId: competitionTeamId,
                playerId: playerId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int competitionTeamId,
                required int playerId,
                Value<DateTime> createdAt = const Value.absent(),
              }) => CompetitionTeamMembersCompanion.insert(
                id: id,
                competitionTeamId: competitionTeamId,
                playerId: playerId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CompetitionTeamMembersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({competitionTeamId = false, playerId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (competitionTeamId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.competitionTeamId,
                                    referencedTable:
                                        $$CompetitionTeamMembersTableReferences
                                            ._competitionTeamIdTable(db),
                                    referencedColumn:
                                        $$CompetitionTeamMembersTableReferences
                                            ._competitionTeamIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (playerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.playerId,
                                    referencedTable:
                                        $$CompetitionTeamMembersTableReferences
                                            ._playerIdTable(db),
                                    referencedColumn:
                                        $$CompetitionTeamMembersTableReferences
                                            ._playerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$CompetitionTeamMembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompetitionTeamMembersTable,
      CompetitionTeamMember,
      $$CompetitionTeamMembersTableFilterComposer,
      $$CompetitionTeamMembersTableOrderingComposer,
      $$CompetitionTeamMembersTableAnnotationComposer,
      $$CompetitionTeamMembersTableCreateCompanionBuilder,
      $$CompetitionTeamMembersTableUpdateCompanionBuilder,
      (CompetitionTeamMember, $$CompetitionTeamMembersTableReferences),
      CompetitionTeamMember,
      PrefetchHooks Function({bool competitionTeamId, bool playerId})
    >;
typedef $$TournamentsTableCreateCompanionBuilder =
    TournamentsCompanion Function({
      Value<int> id,
      required String name,
      required DateTime date,
      Value<String?> venue,
      required String tier,
      required String category,
      required String format,
      required int numberOfCourts,
      Value<bool> hasBronzeMedalMatch,
      Value<DateTime> createdAt,
    });
typedef $$TournamentsTableUpdateCompanionBuilder =
    TournamentsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<DateTime> date,
      Value<String?> venue,
      Value<String> tier,
      Value<String> category,
      Value<String> format,
      Value<int> numberOfCourts,
      Value<bool> hasBronzeMedalMatch,
      Value<DateTime> createdAt,
    });

final class $$TournamentsTableReferences
    extends BaseReferences<_$AppDatabase, $TournamentsTable, Tournament> {
  $$TournamentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TournamentEventsTable, List<TournamentEvent>>
  _tournamentEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.tournamentEvents,
    aliasName: $_aliasNameGenerator(
      db.tournaments.id,
      db.tournamentEvents.tournamentId,
    ),
  );

  $$TournamentEventsTableProcessedTableManager get tournamentEventsRefs {
    final manager = $$TournamentEventsTableTableManager(
      $_db,
      $_db.tournamentEvents,
    ).filter((f) => f.tournamentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _tournamentEventsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $GroupKnockoutSettingsTable,
    List<GroupKnockoutSetting>
  >
  _groupKnockoutSettingsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.groupKnockoutSettings,
        aliasName: $_aliasNameGenerator(
          db.tournaments.id,
          db.groupKnockoutSettings.tournamentId,
        ),
      );

  $$GroupKnockoutSettingsTableProcessedTableManager
  get groupKnockoutSettingsRefs {
    final manager = $$GroupKnockoutSettingsTableTableManager(
      $_db,
      $_db.groupKnockoutSettings,
    ).filter((f) => f.tournamentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _groupKnockoutSettingsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $TournamentParticipantsTable,
    List<TournamentParticipant>
  >
  _participantsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.tournamentParticipants,
    aliasName: $_aliasNameGenerator(
      db.tournaments.id,
      db.tournamentParticipants.tournamentId,
    ),
  );

  $$TournamentParticipantsTableProcessedTableManager get participants {
    final manager = $$TournamentParticipantsTableTableManager(
      $_db,
      $_db.tournamentParticipants,
    ).filter((f) => f.tournamentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_participantsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GroupsTable, List<Group>> _groupsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.groups,
    aliasName: $_aliasNameGenerator(db.tournaments.id, db.groups.tournamentId),
  );

  $$GroupsTableProcessedTableManager get groupsRefs {
    final manager = $$GroupsTableTableManager(
      $_db,
      $_db.groups,
    ).filter((f) => f.tournamentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_groupsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FixturesTable, List<Fixture>> _fixturesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.fixtures,
    aliasName: $_aliasNameGenerator(
      db.tournaments.id,
      db.fixtures.tournamentId,
    ),
  );

  $$FixturesTableProcessedTableManager get fixturesRefs {
    final manager = $$FixturesTableTableManager(
      $_db,
      $_db.fixtures,
    ).filter((f) => f.tournamentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_fixturesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TournamentsTableFilterComposer
    extends Composer<_$AppDatabase, $TournamentsTable> {
  $$TournamentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venue => $composableBuilder(
    column: $table.venue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberOfCourts => $composableBuilder(
    column: $table.numberOfCourts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasBronzeMedalMatch => $composableBuilder(
    column: $table.hasBronzeMedalMatch,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> tournamentEventsRefs(
    Expression<bool> Function($$TournamentEventsTableFilterComposer f) f,
  ) {
    final $$TournamentEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tournamentEvents,
      getReferencedColumn: (t) => t.tournamentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentEventsTableFilterComposer(
            $db: $db,
            $table: $db.tournamentEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> groupKnockoutSettingsRefs(
    Expression<bool> Function($$GroupKnockoutSettingsTableFilterComposer f) f,
  ) {
    final $$GroupKnockoutSettingsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.groupKnockoutSettings,
          getReferencedColumn: (t) => t.tournamentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GroupKnockoutSettingsTableFilterComposer(
                $db: $db,
                $table: $db.groupKnockoutSettings,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> participants(
    Expression<bool> Function($$TournamentParticipantsTableFilterComposer f) f,
  ) {
    final $$TournamentParticipantsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.tournamentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableFilterComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> groupsRefs(
    Expression<bool> Function($$GroupsTableFilterComposer f) f,
  ) {
    final $$GroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.tournamentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableFilterComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fixturesRefs(
    Expression<bool> Function($$FixturesTableFilterComposer f) f,
  ) {
    final $$FixturesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixtures,
      getReferencedColumn: (t) => t.tournamentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixturesTableFilterComposer(
            $db: $db,
            $table: $db.fixtures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TournamentsTableOrderingComposer
    extends Composer<_$AppDatabase, $TournamentsTable> {
  $$TournamentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venue => $composableBuilder(
    column: $table.venue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberOfCourts => $composableBuilder(
    column: $table.numberOfCourts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasBronzeMedalMatch => $composableBuilder(
    column: $table.hasBronzeMedalMatch,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TournamentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TournamentsTable> {
  $$TournamentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get venue =>
      $composableBuilder(column: $table.venue, builder: (column) => column);

  GeneratedColumn<String> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  GeneratedColumn<int> get numberOfCourts => $composableBuilder(
    column: $table.numberOfCourts,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasBronzeMedalMatch => $composableBuilder(
    column: $table.hasBronzeMedalMatch,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> tournamentEventsRefs<T extends Object>(
    Expression<T> Function($$TournamentEventsTableAnnotationComposer a) f,
  ) {
    final $$TournamentEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tournamentEvents,
      getReferencedColumn: (t) => t.tournamentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.tournamentEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> groupKnockoutSettingsRefs<T extends Object>(
    Expression<T> Function($$GroupKnockoutSettingsTableAnnotationComposer a) f,
  ) {
    final $$GroupKnockoutSettingsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.groupKnockoutSettings,
          getReferencedColumn: (t) => t.tournamentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GroupKnockoutSettingsTableAnnotationComposer(
                $db: $db,
                $table: $db.groupKnockoutSettings,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> participants<T extends Object>(
    Expression<T> Function($$TournamentParticipantsTableAnnotationComposer a) f,
  ) {
    final $$TournamentParticipantsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.tournamentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableAnnotationComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> groupsRefs<T extends Object>(
    Expression<T> Function($$GroupsTableAnnotationComposer a) f,
  ) {
    final $$GroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.tournamentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> fixturesRefs<T extends Object>(
    Expression<T> Function($$FixturesTableAnnotationComposer a) f,
  ) {
    final $$FixturesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixtures,
      getReferencedColumn: (t) => t.tournamentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixturesTableAnnotationComposer(
            $db: $db,
            $table: $db.fixtures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TournamentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TournamentsTable,
          Tournament,
          $$TournamentsTableFilterComposer,
          $$TournamentsTableOrderingComposer,
          $$TournamentsTableAnnotationComposer,
          $$TournamentsTableCreateCompanionBuilder,
          $$TournamentsTableUpdateCompanionBuilder,
          (Tournament, $$TournamentsTableReferences),
          Tournament,
          PrefetchHooks Function({
            bool tournamentEventsRefs,
            bool groupKnockoutSettingsRefs,
            bool participants,
            bool groupsRefs,
            bool fixturesRefs,
          })
        > {
  $$TournamentsTableTableManager(_$AppDatabase db, $TournamentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TournamentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TournamentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TournamentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> venue = const Value.absent(),
                Value<String> tier = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> format = const Value.absent(),
                Value<int> numberOfCourts = const Value.absent(),
                Value<bool> hasBronzeMedalMatch = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TournamentsCompanion(
                id: id,
                name: name,
                date: date,
                venue: venue,
                tier: tier,
                category: category,
                format: format,
                numberOfCourts: numberOfCourts,
                hasBronzeMedalMatch: hasBronzeMedalMatch,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required DateTime date,
                Value<String?> venue = const Value.absent(),
                required String tier,
                required String category,
                required String format,
                required int numberOfCourts,
                Value<bool> hasBronzeMedalMatch = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TournamentsCompanion.insert(
                id: id,
                name: name,
                date: date,
                venue: venue,
                tier: tier,
                category: category,
                format: format,
                numberOfCourts: numberOfCourts,
                hasBronzeMedalMatch: hasBronzeMedalMatch,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TournamentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                tournamentEventsRefs = false,
                groupKnockoutSettingsRefs = false,
                participants = false,
                groupsRefs = false,
                fixturesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (tournamentEventsRefs) db.tournamentEvents,
                    if (groupKnockoutSettingsRefs) db.groupKnockoutSettings,
                    if (participants) db.tournamentParticipants,
                    if (groupsRefs) db.groups,
                    if (fixturesRefs) db.fixtures,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (tournamentEventsRefs)
                        await $_getPrefetchedData<
                          Tournament,
                          $TournamentsTable,
                          TournamentEvent
                        >(
                          currentTable: table,
                          referencedTable: $$TournamentsTableReferences
                              ._tournamentEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TournamentsTableReferences(
                                db,
                                table,
                                p0,
                              ).tournamentEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tournamentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (groupKnockoutSettingsRefs)
                        await $_getPrefetchedData<
                          Tournament,
                          $TournamentsTable,
                          GroupKnockoutSetting
                        >(
                          currentTable: table,
                          referencedTable: $$TournamentsTableReferences
                              ._groupKnockoutSettingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TournamentsTableReferences(
                                db,
                                table,
                                p0,
                              ).groupKnockoutSettingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tournamentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (participants)
                        await $_getPrefetchedData<
                          Tournament,
                          $TournamentsTable,
                          TournamentParticipant
                        >(
                          currentTable: table,
                          referencedTable: $$TournamentsTableReferences
                              ._participantsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TournamentsTableReferences(
                                db,
                                table,
                                p0,
                              ).participants,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tournamentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (groupsRefs)
                        await $_getPrefetchedData<
                          Tournament,
                          $TournamentsTable,
                          Group
                        >(
                          currentTable: table,
                          referencedTable: $$TournamentsTableReferences
                              ._groupsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TournamentsTableReferences(
                                db,
                                table,
                                p0,
                              ).groupsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tournamentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fixturesRefs)
                        await $_getPrefetchedData<
                          Tournament,
                          $TournamentsTable,
                          Fixture
                        >(
                          currentTable: table,
                          referencedTable: $$TournamentsTableReferences
                              ._fixturesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TournamentsTableReferences(
                                db,
                                table,
                                p0,
                              ).fixturesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tournamentId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TournamentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TournamentsTable,
      Tournament,
      $$TournamentsTableFilterComposer,
      $$TournamentsTableOrderingComposer,
      $$TournamentsTableAnnotationComposer,
      $$TournamentsTableCreateCompanionBuilder,
      $$TournamentsTableUpdateCompanionBuilder,
      (Tournament, $$TournamentsTableReferences),
      Tournament,
      PrefetchHooks Function({
        bool tournamentEventsRefs,
        bool groupKnockoutSettingsRefs,
        bool participants,
        bool groupsRefs,
        bool fixturesRefs,
      })
    >;
typedef $$TournamentEventsTableCreateCompanionBuilder =
    TournamentEventsCompanion Function({
      Value<int> id,
      required int tournamentId,
      required String eventType,
    });
typedef $$TournamentEventsTableUpdateCompanionBuilder =
    TournamentEventsCompanion Function({
      Value<int> id,
      Value<int> tournamentId,
      Value<String> eventType,
    });

final class $$TournamentEventsTableReferences
    extends
        BaseReferences<_$AppDatabase, $TournamentEventsTable, TournamentEvent> {
  $$TournamentEventsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TournamentsTable _tournamentIdTable(_$AppDatabase db) =>
      db.tournaments.createAlias(
        $_aliasNameGenerator(
          db.tournamentEvents.tournamentId,
          db.tournaments.id,
        ),
      );

  $$TournamentsTableProcessedTableManager get tournamentId {
    final $_column = $_itemColumn<int>('tournament_id')!;

    final manager = $$TournamentsTableTableManager(
      $_db,
      $_db.tournaments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tournamentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TournamentEventsTableFilterComposer
    extends Composer<_$AppDatabase, $TournamentEventsTable> {
  $$TournamentEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  $$TournamentsTableFilterComposer get tournamentId {
    final $$TournamentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableFilterComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TournamentEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $TournamentEventsTable> {
  $$TournamentEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  $$TournamentsTableOrderingComposer get tournamentId {
    final $$TournamentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableOrderingComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TournamentEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TournamentEventsTable> {
  $$TournamentEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  $$TournamentsTableAnnotationComposer get tournamentId {
    final $$TournamentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableAnnotationComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TournamentEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TournamentEventsTable,
          TournamentEvent,
          $$TournamentEventsTableFilterComposer,
          $$TournamentEventsTableOrderingComposer,
          $$TournamentEventsTableAnnotationComposer,
          $$TournamentEventsTableCreateCompanionBuilder,
          $$TournamentEventsTableUpdateCompanionBuilder,
          (TournamentEvent, $$TournamentEventsTableReferences),
          TournamentEvent,
          PrefetchHooks Function({bool tournamentId})
        > {
  $$TournamentEventsTableTableManager(
    _$AppDatabase db,
    $TournamentEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TournamentEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TournamentEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TournamentEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tournamentId = const Value.absent(),
                Value<String> eventType = const Value.absent(),
              }) => TournamentEventsCompanion(
                id: id,
                tournamentId: tournamentId,
                eventType: eventType,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tournamentId,
                required String eventType,
              }) => TournamentEventsCompanion.insert(
                id: id,
                tournamentId: tournamentId,
                eventType: eventType,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TournamentEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tournamentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tournamentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tournamentId,
                                referencedTable:
                                    $$TournamentEventsTableReferences
                                        ._tournamentIdTable(db),
                                referencedColumn:
                                    $$TournamentEventsTableReferences
                                        ._tournamentIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TournamentEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TournamentEventsTable,
      TournamentEvent,
      $$TournamentEventsTableFilterComposer,
      $$TournamentEventsTableOrderingComposer,
      $$TournamentEventsTableAnnotationComposer,
      $$TournamentEventsTableCreateCompanionBuilder,
      $$TournamentEventsTableUpdateCompanionBuilder,
      (TournamentEvent, $$TournamentEventsTableReferences),
      TournamentEvent,
      PrefetchHooks Function({bool tournamentId})
    >;
typedef $$GroupKnockoutSettingsTableCreateCompanionBuilder =
    GroupKnockoutSettingsCompanion Function({
      Value<int> id,
      required int tournamentId,
      required int numberOfGroups,
      required String knockoutStartStage,
      required int qualifiersPerGroup,
    });
typedef $$GroupKnockoutSettingsTableUpdateCompanionBuilder =
    GroupKnockoutSettingsCompanion Function({
      Value<int> id,
      Value<int> tournamentId,
      Value<int> numberOfGroups,
      Value<String> knockoutStartStage,
      Value<int> qualifiersPerGroup,
    });

final class $$GroupKnockoutSettingsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GroupKnockoutSettingsTable,
          GroupKnockoutSetting
        > {
  $$GroupKnockoutSettingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TournamentsTable _tournamentIdTable(_$AppDatabase db) =>
      db.tournaments.createAlias(
        $_aliasNameGenerator(
          db.groupKnockoutSettings.tournamentId,
          db.tournaments.id,
        ),
      );

  $$TournamentsTableProcessedTableManager get tournamentId {
    final $_column = $_itemColumn<int>('tournament_id')!;

    final manager = $$TournamentsTableTableManager(
      $_db,
      $_db.tournaments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tournamentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GroupKnockoutSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $GroupKnockoutSettingsTable> {
  $$GroupKnockoutSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberOfGroups => $composableBuilder(
    column: $table.numberOfGroups,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get knockoutStartStage => $composableBuilder(
    column: $table.knockoutStartStage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get qualifiersPerGroup => $composableBuilder(
    column: $table.qualifiersPerGroup,
    builder: (column) => ColumnFilters(column),
  );

  $$TournamentsTableFilterComposer get tournamentId {
    final $$TournamentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableFilterComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupKnockoutSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $GroupKnockoutSettingsTable> {
  $$GroupKnockoutSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberOfGroups => $composableBuilder(
    column: $table.numberOfGroups,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get knockoutStartStage => $composableBuilder(
    column: $table.knockoutStartStage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get qualifiersPerGroup => $composableBuilder(
    column: $table.qualifiersPerGroup,
    builder: (column) => ColumnOrderings(column),
  );

  $$TournamentsTableOrderingComposer get tournamentId {
    final $$TournamentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableOrderingComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupKnockoutSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GroupKnockoutSettingsTable> {
  $$GroupKnockoutSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get numberOfGroups => $composableBuilder(
    column: $table.numberOfGroups,
    builder: (column) => column,
  );

  GeneratedColumn<String> get knockoutStartStage => $composableBuilder(
    column: $table.knockoutStartStage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get qualifiersPerGroup => $composableBuilder(
    column: $table.qualifiersPerGroup,
    builder: (column) => column,
  );

  $$TournamentsTableAnnotationComposer get tournamentId {
    final $$TournamentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableAnnotationComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupKnockoutSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GroupKnockoutSettingsTable,
          GroupKnockoutSetting,
          $$GroupKnockoutSettingsTableFilterComposer,
          $$GroupKnockoutSettingsTableOrderingComposer,
          $$GroupKnockoutSettingsTableAnnotationComposer,
          $$GroupKnockoutSettingsTableCreateCompanionBuilder,
          $$GroupKnockoutSettingsTableUpdateCompanionBuilder,
          (GroupKnockoutSetting, $$GroupKnockoutSettingsTableReferences),
          GroupKnockoutSetting,
          PrefetchHooks Function({bool tournamentId})
        > {
  $$GroupKnockoutSettingsTableTableManager(
    _$AppDatabase db,
    $GroupKnockoutSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupKnockoutSettingsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$GroupKnockoutSettingsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$GroupKnockoutSettingsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tournamentId = const Value.absent(),
                Value<int> numberOfGroups = const Value.absent(),
                Value<String> knockoutStartStage = const Value.absent(),
                Value<int> qualifiersPerGroup = const Value.absent(),
              }) => GroupKnockoutSettingsCompanion(
                id: id,
                tournamentId: tournamentId,
                numberOfGroups: numberOfGroups,
                knockoutStartStage: knockoutStartStage,
                qualifiersPerGroup: qualifiersPerGroup,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tournamentId,
                required int numberOfGroups,
                required String knockoutStartStage,
                required int qualifiersPerGroup,
              }) => GroupKnockoutSettingsCompanion.insert(
                id: id,
                tournamentId: tournamentId,
                numberOfGroups: numberOfGroups,
                knockoutStartStage: knockoutStartStage,
                qualifiersPerGroup: qualifiersPerGroup,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GroupKnockoutSettingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tournamentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tournamentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tournamentId,
                                referencedTable:
                                    $$GroupKnockoutSettingsTableReferences
                                        ._tournamentIdTable(db),
                                referencedColumn:
                                    $$GroupKnockoutSettingsTableReferences
                                        ._tournamentIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GroupKnockoutSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GroupKnockoutSettingsTable,
      GroupKnockoutSetting,
      $$GroupKnockoutSettingsTableFilterComposer,
      $$GroupKnockoutSettingsTableOrderingComposer,
      $$GroupKnockoutSettingsTableAnnotationComposer,
      $$GroupKnockoutSettingsTableCreateCompanionBuilder,
      $$GroupKnockoutSettingsTableUpdateCompanionBuilder,
      (GroupKnockoutSetting, $$GroupKnockoutSettingsTableReferences),
      GroupKnockoutSetting,
      PrefetchHooks Function({bool tournamentId})
    >;
typedef $$TournamentParticipantsTableCreateCompanionBuilder =
    TournamentParticipantsCompanion Function({
      Value<int> id,
      required int tournamentId,
      required String eventType,
      required String participantType,
      Value<int?> playerId,
      Value<int?> individualTeamId,
      Value<int?> competitionTeamId,
      Value<int?> seed,
      Value<bool> withdrawn,
      Value<DateTime> createdAt,
    });
typedef $$TournamentParticipantsTableUpdateCompanionBuilder =
    TournamentParticipantsCompanion Function({
      Value<int> id,
      Value<int> tournamentId,
      Value<String> eventType,
      Value<String> participantType,
      Value<int?> playerId,
      Value<int?> individualTeamId,
      Value<int?> competitionTeamId,
      Value<int?> seed,
      Value<bool> withdrawn,
      Value<DateTime> createdAt,
    });

final class $$TournamentParticipantsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TournamentParticipantsTable,
          TournamentParticipant
        > {
  $$TournamentParticipantsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TournamentsTable _tournamentIdTable(_$AppDatabase db) =>
      db.tournaments.createAlias(
        $_aliasNameGenerator(
          db.tournamentParticipants.tournamentId,
          db.tournaments.id,
        ),
      );

  $$TournamentsTableProcessedTableManager get tournamentId {
    final $_column = $_itemColumn<int>('tournament_id')!;

    final manager = $$TournamentsTableTableManager(
      $_db,
      $_db.tournaments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tournamentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PlayersTable _playerIdTable(_$AppDatabase db) =>
      db.players.createAlias(
        $_aliasNameGenerator(db.tournamentParticipants.playerId, db.players.id),
      );

  $$PlayersTableProcessedTableManager? get playerId {
    final $_column = $_itemColumn<int>('player_id');
    if ($_column == null) return null;
    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $IndividualTeamsTable _individualTeamIdTable(_$AppDatabase db) =>
      db.individualTeams.createAlias(
        $_aliasNameGenerator(
          db.tournamentParticipants.individualTeamId,
          db.individualTeams.id,
        ),
      );

  $$IndividualTeamsTableProcessedTableManager? get individualTeamId {
    final $_column = $_itemColumn<int>('individual_team_id');
    if ($_column == null) return null;
    final manager = $$IndividualTeamsTableTableManager(
      $_db,
      $_db.individualTeams,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_individualTeamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CompetitionTeamsTable _competitionTeamIdTable(_$AppDatabase db) =>
      db.competitionTeams.createAlias(
        $_aliasNameGenerator(
          db.tournamentParticipants.competitionTeamId,
          db.competitionTeams.id,
        ),
      );

  $$CompetitionTeamsTableProcessedTableManager? get competitionTeamId {
    final $_column = $_itemColumn<int>('competition_team_id');
    if ($_column == null) return null;
    final manager = $$CompetitionTeamsTableTableManager(
      $_db,
      $_db.competitionTeams,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_competitionTeamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $TeamEventAssignmentsTable,
    List<TeamEventAssignment>
  >
  _teamEventAssignmentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.teamEventAssignments,
        aliasName: $_aliasNameGenerator(
          db.tournamentParticipants.id,
          db.teamEventAssignments.tournamentParticipantId,
        ),
      );

  $$TeamEventAssignmentsTableProcessedTableManager
  get teamEventAssignmentsRefs {
    final manager =
        $$TeamEventAssignmentsTableTableManager(
          $_db,
          $_db.teamEventAssignments,
        ).filter(
          (f) =>
              f.tournamentParticipantId.id.sqlEquals($_itemColumn<int>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _teamEventAssignmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GroupParticipantsTable, List<GroupParticipant>>
  _groupParticipantsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.groupParticipants,
        aliasName: $_aliasNameGenerator(
          db.tournamentParticipants.id,
          db.groupParticipants.tournamentParticipantId,
        ),
      );

  $$GroupParticipantsTableProcessedTableManager get groupParticipantsRefs {
    final manager =
        $$GroupParticipantsTableTableManager(
          $_db,
          $_db.groupParticipants,
        ).filter(
          (f) =>
              f.tournamentParticipantId.id.sqlEquals($_itemColumn<int>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _groupParticipantsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FixturesTable, List<Fixture>>
  _fixturesAsParticipant1Table(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.fixtures,
        aliasName: $_aliasNameGenerator(
          db.tournamentParticipants.id,
          db.fixtures.participant1Id,
        ),
      );

  $$FixturesTableProcessedTableManager get fixturesAsParticipant1 {
    final manager = $$FixturesTableTableManager(
      $_db,
      $_db.fixtures,
    ).filter((f) => f.participant1Id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _fixturesAsParticipant1Table($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FixturesTable, List<Fixture>>
  _fixturesAsParticipant2Table(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.fixtures,
        aliasName: $_aliasNameGenerator(
          db.tournamentParticipants.id,
          db.fixtures.participant2Id,
        ),
      );

  $$FixturesTableProcessedTableManager get fixturesAsParticipant2 {
    final manager = $$FixturesTableTableManager(
      $_db,
      $_db.fixtures,
    ).filter((f) => f.participant2Id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _fixturesAsParticipant2Table($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FixturesTable, List<Fixture>> _fixturesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.fixtures,
    aliasName: $_aliasNameGenerator(
      db.tournamentParticipants.id,
      db.fixtures.winnerParticipantId,
    ),
  );

  $$FixturesTableProcessedTableManager get fixturesRefs {
    final manager = $$FixturesTableTableManager($_db, $_db.fixtures).filter(
      (f) => f.winnerParticipantId.id.sqlEquals($_itemColumn<int>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_fixturesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TournamentParticipantsTableFilterComposer
    extends Composer<_$AppDatabase, $TournamentParticipantsTable> {
  $$TournamentParticipantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get participantType => $composableBuilder(
    column: $table.participantType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seed => $composableBuilder(
    column: $table.seed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get withdrawn => $composableBuilder(
    column: $table.withdrawn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TournamentsTableFilterComposer get tournamentId {
    final $$TournamentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableFilterComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IndividualTeamsTableFilterComposer get individualTeamId {
    final $$IndividualTeamsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.individualTeamId,
      referencedTable: $db.individualTeams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IndividualTeamsTableFilterComposer(
            $db: $db,
            $table: $db.individualTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CompetitionTeamsTableFilterComposer get competitionTeamId {
    final $$CompetitionTeamsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.competitionTeamId,
      referencedTable: $db.competitionTeams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompetitionTeamsTableFilterComposer(
            $db: $db,
            $table: $db.competitionTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> teamEventAssignmentsRefs(
    Expression<bool> Function($$TeamEventAssignmentsTableFilterComposer f) f,
  ) {
    final $$TeamEventAssignmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamEventAssignments,
      getReferencedColumn: (t) => t.tournamentParticipantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamEventAssignmentsTableFilterComposer(
            $db: $db,
            $table: $db.teamEventAssignments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> groupParticipantsRefs(
    Expression<bool> Function($$GroupParticipantsTableFilterComposer f) f,
  ) {
    final $$GroupParticipantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.groupParticipants,
      getReferencedColumn: (t) => t.tournamentParticipantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupParticipantsTableFilterComposer(
            $db: $db,
            $table: $db.groupParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fixturesAsParticipant1(
    Expression<bool> Function($$FixturesTableFilterComposer f) f,
  ) {
    final $$FixturesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixtures,
      getReferencedColumn: (t) => t.participant1Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixturesTableFilterComposer(
            $db: $db,
            $table: $db.fixtures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fixturesAsParticipant2(
    Expression<bool> Function($$FixturesTableFilterComposer f) f,
  ) {
    final $$FixturesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixtures,
      getReferencedColumn: (t) => t.participant2Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixturesTableFilterComposer(
            $db: $db,
            $table: $db.fixtures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fixturesRefs(
    Expression<bool> Function($$FixturesTableFilterComposer f) f,
  ) {
    final $$FixturesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixtures,
      getReferencedColumn: (t) => t.winnerParticipantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixturesTableFilterComposer(
            $db: $db,
            $table: $db.fixtures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TournamentParticipantsTableOrderingComposer
    extends Composer<_$AppDatabase, $TournamentParticipantsTable> {
  $$TournamentParticipantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get participantType => $composableBuilder(
    column: $table.participantType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seed => $composableBuilder(
    column: $table.seed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get withdrawn => $composableBuilder(
    column: $table.withdrawn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TournamentsTableOrderingComposer get tournamentId {
    final $$TournamentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableOrderingComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IndividualTeamsTableOrderingComposer get individualTeamId {
    final $$IndividualTeamsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.individualTeamId,
      referencedTable: $db.individualTeams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IndividualTeamsTableOrderingComposer(
            $db: $db,
            $table: $db.individualTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CompetitionTeamsTableOrderingComposer get competitionTeamId {
    final $$CompetitionTeamsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.competitionTeamId,
      referencedTable: $db.competitionTeams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompetitionTeamsTableOrderingComposer(
            $db: $db,
            $table: $db.competitionTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TournamentParticipantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TournamentParticipantsTable> {
  $$TournamentParticipantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<String> get participantType => $composableBuilder(
    column: $table.participantType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get seed =>
      $composableBuilder(column: $table.seed, builder: (column) => column);

  GeneratedColumn<bool> get withdrawn =>
      $composableBuilder(column: $table.withdrawn, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$TournamentsTableAnnotationComposer get tournamentId {
    final $$TournamentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableAnnotationComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IndividualTeamsTableAnnotationComposer get individualTeamId {
    final $$IndividualTeamsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.individualTeamId,
      referencedTable: $db.individualTeams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IndividualTeamsTableAnnotationComposer(
            $db: $db,
            $table: $db.individualTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CompetitionTeamsTableAnnotationComposer get competitionTeamId {
    final $$CompetitionTeamsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.competitionTeamId,
      referencedTable: $db.competitionTeams,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompetitionTeamsTableAnnotationComposer(
            $db: $db,
            $table: $db.competitionTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> teamEventAssignmentsRefs<T extends Object>(
    Expression<T> Function($$TeamEventAssignmentsTableAnnotationComposer a) f,
  ) {
    final $$TeamEventAssignmentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.teamEventAssignments,
          getReferencedColumn: (t) => t.tournamentParticipantId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TeamEventAssignmentsTableAnnotationComposer(
                $db: $db,
                $table: $db.teamEventAssignments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> groupParticipantsRefs<T extends Object>(
    Expression<T> Function($$GroupParticipantsTableAnnotationComposer a) f,
  ) {
    final $$GroupParticipantsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.groupParticipants,
          getReferencedColumn: (t) => t.tournamentParticipantId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GroupParticipantsTableAnnotationComposer(
                $db: $db,
                $table: $db.groupParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> fixturesAsParticipant1<T extends Object>(
    Expression<T> Function($$FixturesTableAnnotationComposer a) f,
  ) {
    final $$FixturesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixtures,
      getReferencedColumn: (t) => t.participant1Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixturesTableAnnotationComposer(
            $db: $db,
            $table: $db.fixtures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> fixturesAsParticipant2<T extends Object>(
    Expression<T> Function($$FixturesTableAnnotationComposer a) f,
  ) {
    final $$FixturesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixtures,
      getReferencedColumn: (t) => t.participant2Id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixturesTableAnnotationComposer(
            $db: $db,
            $table: $db.fixtures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> fixturesRefs<T extends Object>(
    Expression<T> Function($$FixturesTableAnnotationComposer a) f,
  ) {
    final $$FixturesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixtures,
      getReferencedColumn: (t) => t.winnerParticipantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixturesTableAnnotationComposer(
            $db: $db,
            $table: $db.fixtures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TournamentParticipantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TournamentParticipantsTable,
          TournamentParticipant,
          $$TournamentParticipantsTableFilterComposer,
          $$TournamentParticipantsTableOrderingComposer,
          $$TournamentParticipantsTableAnnotationComposer,
          $$TournamentParticipantsTableCreateCompanionBuilder,
          $$TournamentParticipantsTableUpdateCompanionBuilder,
          (TournamentParticipant, $$TournamentParticipantsTableReferences),
          TournamentParticipant,
          PrefetchHooks Function({
            bool tournamentId,
            bool playerId,
            bool individualTeamId,
            bool competitionTeamId,
            bool teamEventAssignmentsRefs,
            bool groupParticipantsRefs,
            bool fixturesAsParticipant1,
            bool fixturesAsParticipant2,
            bool fixturesRefs,
          })
        > {
  $$TournamentParticipantsTableTableManager(
    _$AppDatabase db,
    $TournamentParticipantsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TournamentParticipantsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TournamentParticipantsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TournamentParticipantsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tournamentId = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<String> participantType = const Value.absent(),
                Value<int?> playerId = const Value.absent(),
                Value<int?> individualTeamId = const Value.absent(),
                Value<int?> competitionTeamId = const Value.absent(),
                Value<int?> seed = const Value.absent(),
                Value<bool> withdrawn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TournamentParticipantsCompanion(
                id: id,
                tournamentId: tournamentId,
                eventType: eventType,
                participantType: participantType,
                playerId: playerId,
                individualTeamId: individualTeamId,
                competitionTeamId: competitionTeamId,
                seed: seed,
                withdrawn: withdrawn,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tournamentId,
                required String eventType,
                required String participantType,
                Value<int?> playerId = const Value.absent(),
                Value<int?> individualTeamId = const Value.absent(),
                Value<int?> competitionTeamId = const Value.absent(),
                Value<int?> seed = const Value.absent(),
                Value<bool> withdrawn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TournamentParticipantsCompanion.insert(
                id: id,
                tournamentId: tournamentId,
                eventType: eventType,
                participantType: participantType,
                playerId: playerId,
                individualTeamId: individualTeamId,
                competitionTeamId: competitionTeamId,
                seed: seed,
                withdrawn: withdrawn,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TournamentParticipantsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                tournamentId = false,
                playerId = false,
                individualTeamId = false,
                competitionTeamId = false,
                teamEventAssignmentsRefs = false,
                groupParticipantsRefs = false,
                fixturesAsParticipant1 = false,
                fixturesAsParticipant2 = false,
                fixturesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (teamEventAssignmentsRefs) db.teamEventAssignments,
                    if (groupParticipantsRefs) db.groupParticipants,
                    if (fixturesAsParticipant1) db.fixtures,
                    if (fixturesAsParticipant2) db.fixtures,
                    if (fixturesRefs) db.fixtures,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (tournamentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.tournamentId,
                                    referencedTable:
                                        $$TournamentParticipantsTableReferences
                                            ._tournamentIdTable(db),
                                    referencedColumn:
                                        $$TournamentParticipantsTableReferences
                                            ._tournamentIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (playerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.playerId,
                                    referencedTable:
                                        $$TournamentParticipantsTableReferences
                                            ._playerIdTable(db),
                                    referencedColumn:
                                        $$TournamentParticipantsTableReferences
                                            ._playerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (individualTeamId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.individualTeamId,
                                    referencedTable:
                                        $$TournamentParticipantsTableReferences
                                            ._individualTeamIdTable(db),
                                    referencedColumn:
                                        $$TournamentParticipantsTableReferences
                                            ._individualTeamIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (competitionTeamId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.competitionTeamId,
                                    referencedTable:
                                        $$TournamentParticipantsTableReferences
                                            ._competitionTeamIdTable(db),
                                    referencedColumn:
                                        $$TournamentParticipantsTableReferences
                                            ._competitionTeamIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (teamEventAssignmentsRefs)
                        await $_getPrefetchedData<
                          TournamentParticipant,
                          $TournamentParticipantsTable,
                          TeamEventAssignment
                        >(
                          currentTable: table,
                          referencedTable:
                              $$TournamentParticipantsTableReferences
                                  ._teamEventAssignmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TournamentParticipantsTableReferences(
                                db,
                                table,
                                p0,
                              ).teamEventAssignmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tournamentParticipantId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (groupParticipantsRefs)
                        await $_getPrefetchedData<
                          TournamentParticipant,
                          $TournamentParticipantsTable,
                          GroupParticipant
                        >(
                          currentTable: table,
                          referencedTable:
                              $$TournamentParticipantsTableReferences
                                  ._groupParticipantsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TournamentParticipantsTableReferences(
                                db,
                                table,
                                p0,
                              ).groupParticipantsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tournamentParticipantId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fixturesAsParticipant1)
                        await $_getPrefetchedData<
                          TournamentParticipant,
                          $TournamentParticipantsTable,
                          Fixture
                        >(
                          currentTable: table,
                          referencedTable:
                              $$TournamentParticipantsTableReferences
                                  ._fixturesAsParticipant1Table(db),
                          managerFromTypedResult: (p0) =>
                              $$TournamentParticipantsTableReferences(
                                db,
                                table,
                                p0,
                              ).fixturesAsParticipant1,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.participant1Id == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fixturesAsParticipant2)
                        await $_getPrefetchedData<
                          TournamentParticipant,
                          $TournamentParticipantsTable,
                          Fixture
                        >(
                          currentTable: table,
                          referencedTable:
                              $$TournamentParticipantsTableReferences
                                  ._fixturesAsParticipant2Table(db),
                          managerFromTypedResult: (p0) =>
                              $$TournamentParticipantsTableReferences(
                                db,
                                table,
                                p0,
                              ).fixturesAsParticipant2,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.participant2Id == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fixturesRefs)
                        await $_getPrefetchedData<
                          TournamentParticipant,
                          $TournamentParticipantsTable,
                          Fixture
                        >(
                          currentTable: table,
                          referencedTable:
                              $$TournamentParticipantsTableReferences
                                  ._fixturesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TournamentParticipantsTableReferences(
                                db,
                                table,
                                p0,
                              ).fixturesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.winnerParticipantId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TournamentParticipantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TournamentParticipantsTable,
      TournamentParticipant,
      $$TournamentParticipantsTableFilterComposer,
      $$TournamentParticipantsTableOrderingComposer,
      $$TournamentParticipantsTableAnnotationComposer,
      $$TournamentParticipantsTableCreateCompanionBuilder,
      $$TournamentParticipantsTableUpdateCompanionBuilder,
      (TournamentParticipant, $$TournamentParticipantsTableReferences),
      TournamentParticipant,
      PrefetchHooks Function({
        bool tournamentId,
        bool playerId,
        bool individualTeamId,
        bool competitionTeamId,
        bool teamEventAssignmentsRefs,
        bool groupParticipantsRefs,
        bool fixturesAsParticipant1,
        bool fixturesAsParticipant2,
        bool fixturesRefs,
      })
    >;
typedef $$TeamEventAssignmentsTableCreateCompanionBuilder =
    TeamEventAssignmentsCompanion Function({
      Value<int> id,
      required int tournamentParticipantId,
      required int playerId,
      required String assignedEvent,
      Value<int?> partnerAssignmentId,
    });
typedef $$TeamEventAssignmentsTableUpdateCompanionBuilder =
    TeamEventAssignmentsCompanion Function({
      Value<int> id,
      Value<int> tournamentParticipantId,
      Value<int> playerId,
      Value<String> assignedEvent,
      Value<int?> partnerAssignmentId,
    });

final class $$TeamEventAssignmentsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TeamEventAssignmentsTable,
          TeamEventAssignment
        > {
  $$TeamEventAssignmentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TournamentParticipantsTable _tournamentParticipantIdTable(
    _$AppDatabase db,
  ) => db.tournamentParticipants.createAlias(
    $_aliasNameGenerator(
      db.teamEventAssignments.tournamentParticipantId,
      db.tournamentParticipants.id,
    ),
  );

  $$TournamentParticipantsTableProcessedTableManager
  get tournamentParticipantId {
    final $_column = $_itemColumn<int>('tournament_participant_id')!;

    final manager = $$TournamentParticipantsTableTableManager(
      $_db,
      $_db.tournamentParticipants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _tournamentParticipantIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PlayersTable _playerIdTable(_$AppDatabase db) =>
      db.players.createAlias(
        $_aliasNameGenerator(db.teamEventAssignments.playerId, db.players.id),
      );

  $$PlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<int>('player_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TeamEventAssignmentsTable _partnerAssignmentIdTable(
    _$AppDatabase db,
  ) => db.teamEventAssignments.createAlias(
    $_aliasNameGenerator(
      db.teamEventAssignments.partnerAssignmentId,
      db.teamEventAssignments.id,
    ),
  );

  $$TeamEventAssignmentsTableProcessedTableManager? get partnerAssignmentId {
    final $_column = $_itemColumn<int>('partner_assignment_id');
    if ($_column == null) return null;
    final manager = $$TeamEventAssignmentsTableTableManager(
      $_db,
      $_db.teamEventAssignments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partnerAssignmentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TeamEventAssignmentsTableFilterComposer
    extends Composer<_$AppDatabase, $TeamEventAssignmentsTable> {
  $$TeamEventAssignmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assignedEvent => $composableBuilder(
    column: $table.assignedEvent,
    builder: (column) => ColumnFilters(column),
  );

  $$TournamentParticipantsTableFilterComposer get tournamentParticipantId {
    final $$TournamentParticipantsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.tournamentParticipantId,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableFilterComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamEventAssignmentsTableFilterComposer get partnerAssignmentId {
    final $$TeamEventAssignmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partnerAssignmentId,
      referencedTable: $db.teamEventAssignments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamEventAssignmentsTableFilterComposer(
            $db: $db,
            $table: $db.teamEventAssignments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TeamEventAssignmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $TeamEventAssignmentsTable> {
  $$TeamEventAssignmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assignedEvent => $composableBuilder(
    column: $table.assignedEvent,
    builder: (column) => ColumnOrderings(column),
  );

  $$TournamentParticipantsTableOrderingComposer get tournamentParticipantId {
    final $$TournamentParticipantsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.tournamentParticipantId,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableOrderingComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamEventAssignmentsTableOrderingComposer get partnerAssignmentId {
    final $$TeamEventAssignmentsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.partnerAssignmentId,
          referencedTable: $db.teamEventAssignments,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TeamEventAssignmentsTableOrderingComposer(
                $db: $db,
                $table: $db.teamEventAssignments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$TeamEventAssignmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeamEventAssignmentsTable> {
  $$TeamEventAssignmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get assignedEvent => $composableBuilder(
    column: $table.assignedEvent,
    builder: (column) => column,
  );

  $$TournamentParticipantsTableAnnotationComposer get tournamentParticipantId {
    final $$TournamentParticipantsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.tournamentParticipantId,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableAnnotationComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamEventAssignmentsTableAnnotationComposer get partnerAssignmentId {
    final $$TeamEventAssignmentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.partnerAssignmentId,
          referencedTable: $db.teamEventAssignments,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TeamEventAssignmentsTableAnnotationComposer(
                $db: $db,
                $table: $db.teamEventAssignments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$TeamEventAssignmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeamEventAssignmentsTable,
          TeamEventAssignment,
          $$TeamEventAssignmentsTableFilterComposer,
          $$TeamEventAssignmentsTableOrderingComposer,
          $$TeamEventAssignmentsTableAnnotationComposer,
          $$TeamEventAssignmentsTableCreateCompanionBuilder,
          $$TeamEventAssignmentsTableUpdateCompanionBuilder,
          (TeamEventAssignment, $$TeamEventAssignmentsTableReferences),
          TeamEventAssignment,
          PrefetchHooks Function({
            bool tournamentParticipantId,
            bool playerId,
            bool partnerAssignmentId,
          })
        > {
  $$TeamEventAssignmentsTableTableManager(
    _$AppDatabase db,
    $TeamEventAssignmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamEventAssignmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamEventAssignmentsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TeamEventAssignmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tournamentParticipantId = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<String> assignedEvent = const Value.absent(),
                Value<int?> partnerAssignmentId = const Value.absent(),
              }) => TeamEventAssignmentsCompanion(
                id: id,
                tournamentParticipantId: tournamentParticipantId,
                playerId: playerId,
                assignedEvent: assignedEvent,
                partnerAssignmentId: partnerAssignmentId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tournamentParticipantId,
                required int playerId,
                required String assignedEvent,
                Value<int?> partnerAssignmentId = const Value.absent(),
              }) => TeamEventAssignmentsCompanion.insert(
                id: id,
                tournamentParticipantId: tournamentParticipantId,
                playerId: playerId,
                assignedEvent: assignedEvent,
                partnerAssignmentId: partnerAssignmentId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TeamEventAssignmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                tournamentParticipantId = false,
                playerId = false,
                partnerAssignmentId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (tournamentParticipantId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn:
                                        table.tournamentParticipantId,
                                    referencedTable:
                                        $$TeamEventAssignmentsTableReferences
                                            ._tournamentParticipantIdTable(db),
                                    referencedColumn:
                                        $$TeamEventAssignmentsTableReferences
                                            ._tournamentParticipantIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (playerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.playerId,
                                    referencedTable:
                                        $$TeamEventAssignmentsTableReferences
                                            ._playerIdTable(db),
                                    referencedColumn:
                                        $$TeamEventAssignmentsTableReferences
                                            ._playerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (partnerAssignmentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.partnerAssignmentId,
                                    referencedTable:
                                        $$TeamEventAssignmentsTableReferences
                                            ._partnerAssignmentIdTable(db),
                                    referencedColumn:
                                        $$TeamEventAssignmentsTableReferences
                                            ._partnerAssignmentIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$TeamEventAssignmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeamEventAssignmentsTable,
      TeamEventAssignment,
      $$TeamEventAssignmentsTableFilterComposer,
      $$TeamEventAssignmentsTableOrderingComposer,
      $$TeamEventAssignmentsTableAnnotationComposer,
      $$TeamEventAssignmentsTableCreateCompanionBuilder,
      $$TeamEventAssignmentsTableUpdateCompanionBuilder,
      (TeamEventAssignment, $$TeamEventAssignmentsTableReferences),
      TeamEventAssignment,
      PrefetchHooks Function({
        bool tournamentParticipantId,
        bool playerId,
        bool partnerAssignmentId,
      })
    >;
typedef $$GroupsTableCreateCompanionBuilder =
    GroupsCompanion Function({
      Value<int> id,
      required int tournamentId,
      required String eventType,
      required int groupNumber,
    });
typedef $$GroupsTableUpdateCompanionBuilder =
    GroupsCompanion Function({
      Value<int> id,
      Value<int> tournamentId,
      Value<String> eventType,
      Value<int> groupNumber,
    });

final class $$GroupsTableReferences
    extends BaseReferences<_$AppDatabase, $GroupsTable, Group> {
  $$GroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TournamentsTable _tournamentIdTable(_$AppDatabase db) =>
      db.tournaments.createAlias(
        $_aliasNameGenerator(db.groups.tournamentId, db.tournaments.id),
      );

  $$TournamentsTableProcessedTableManager get tournamentId {
    final $_column = $_itemColumn<int>('tournament_id')!;

    final manager = $$TournamentsTableTableManager(
      $_db,
      $_db.tournaments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tournamentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$GroupParticipantsTable, List<GroupParticipant>>
  _groupParticipantsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.groupParticipants,
        aliasName: $_aliasNameGenerator(
          db.groups.id,
          db.groupParticipants.groupId,
        ),
      );

  $$GroupParticipantsTableProcessedTableManager get groupParticipantsRefs {
    final manager = $$GroupParticipantsTableTableManager(
      $_db,
      $_db.groupParticipants,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _groupParticipantsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FixturesTable, List<Fixture>> _fixturesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.fixtures,
    aliasName: $_aliasNameGenerator(db.groups.id, db.fixtures.groupId),
  );

  $$FixturesTableProcessedTableManager get fixturesRefs {
    final manager = $$FixturesTableTableManager(
      $_db,
      $_db.fixtures,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_fixturesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GroupsTableFilterComposer
    extends Composer<_$AppDatabase, $GroupsTable> {
  $$GroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get groupNumber => $composableBuilder(
    column: $table.groupNumber,
    builder: (column) => ColumnFilters(column),
  );

  $$TournamentsTableFilterComposer get tournamentId {
    final $$TournamentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableFilterComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> groupParticipantsRefs(
    Expression<bool> Function($$GroupParticipantsTableFilterComposer f) f,
  ) {
    final $$GroupParticipantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.groupParticipants,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupParticipantsTableFilterComposer(
            $db: $db,
            $table: $db.groupParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fixturesRefs(
    Expression<bool> Function($$FixturesTableFilterComposer f) f,
  ) {
    final $$FixturesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixtures,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixturesTableFilterComposer(
            $db: $db,
            $table: $db.fixtures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $GroupsTable> {
  $$GroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get groupNumber => $composableBuilder(
    column: $table.groupNumber,
    builder: (column) => ColumnOrderings(column),
  );

  $$TournamentsTableOrderingComposer get tournamentId {
    final $$TournamentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableOrderingComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GroupsTable> {
  $$GroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<int> get groupNumber => $composableBuilder(
    column: $table.groupNumber,
    builder: (column) => column,
  );

  $$TournamentsTableAnnotationComposer get tournamentId {
    final $$TournamentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableAnnotationComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> groupParticipantsRefs<T extends Object>(
    Expression<T> Function($$GroupParticipantsTableAnnotationComposer a) f,
  ) {
    final $$GroupParticipantsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.groupParticipants,
          getReferencedColumn: (t) => t.groupId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GroupParticipantsTableAnnotationComposer(
                $db: $db,
                $table: $db.groupParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> fixturesRefs<T extends Object>(
    Expression<T> Function($$FixturesTableAnnotationComposer a) f,
  ) {
    final $$FixturesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixtures,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixturesTableAnnotationComposer(
            $db: $db,
            $table: $db.fixtures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GroupsTable,
          Group,
          $$GroupsTableFilterComposer,
          $$GroupsTableOrderingComposer,
          $$GroupsTableAnnotationComposer,
          $$GroupsTableCreateCompanionBuilder,
          $$GroupsTableUpdateCompanionBuilder,
          (Group, $$GroupsTableReferences),
          Group,
          PrefetchHooks Function({
            bool tournamentId,
            bool groupParticipantsRefs,
            bool fixturesRefs,
          })
        > {
  $$GroupsTableTableManager(_$AppDatabase db, $GroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tournamentId = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<int> groupNumber = const Value.absent(),
              }) => GroupsCompanion(
                id: id,
                tournamentId: tournamentId,
                eventType: eventType,
                groupNumber: groupNumber,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tournamentId,
                required String eventType,
                required int groupNumber,
              }) => GroupsCompanion.insert(
                id: id,
                tournamentId: tournamentId,
                eventType: eventType,
                groupNumber: groupNumber,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$GroupsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                tournamentId = false,
                groupParticipantsRefs = false,
                fixturesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (groupParticipantsRefs) db.groupParticipants,
                    if (fixturesRefs) db.fixtures,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (tournamentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.tournamentId,
                                    referencedTable: $$GroupsTableReferences
                                        ._tournamentIdTable(db),
                                    referencedColumn: $$GroupsTableReferences
                                        ._tournamentIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (groupParticipantsRefs)
                        await $_getPrefetchedData<
                          Group,
                          $GroupsTable,
                          GroupParticipant
                        >(
                          currentTable: table,
                          referencedTable: $$GroupsTableReferences
                              ._groupParticipantsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GroupsTableReferences(
                                db,
                                table,
                                p0,
                              ).groupParticipantsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.groupId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fixturesRefs)
                        await $_getPrefetchedData<Group, $GroupsTable, Fixture>(
                          currentTable: table,
                          referencedTable: $$GroupsTableReferences
                              ._fixturesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GroupsTableReferences(
                                db,
                                table,
                                p0,
                              ).fixturesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.groupId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GroupsTable,
      Group,
      $$GroupsTableFilterComposer,
      $$GroupsTableOrderingComposer,
      $$GroupsTableAnnotationComposer,
      $$GroupsTableCreateCompanionBuilder,
      $$GroupsTableUpdateCompanionBuilder,
      (Group, $$GroupsTableReferences),
      Group,
      PrefetchHooks Function({
        bool tournamentId,
        bool groupParticipantsRefs,
        bool fixturesRefs,
      })
    >;
typedef $$GroupParticipantsTableCreateCompanionBuilder =
    GroupParticipantsCompanion Function({
      Value<int> id,
      required int groupId,
      required int tournamentParticipantId,
    });
typedef $$GroupParticipantsTableUpdateCompanionBuilder =
    GroupParticipantsCompanion Function({
      Value<int> id,
      Value<int> groupId,
      Value<int> tournamentParticipantId,
    });

final class $$GroupParticipantsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GroupParticipantsTable,
          GroupParticipant
        > {
  $$GroupParticipantsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GroupsTable _groupIdTable(_$AppDatabase db) => db.groups.createAlias(
    $_aliasNameGenerator(db.groupParticipants.groupId, db.groups.id),
  );

  $$GroupsTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<int>('group_id')!;

    final manager = $$GroupsTableTableManager(
      $_db,
      $_db.groups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TournamentParticipantsTable _tournamentParticipantIdTable(
    _$AppDatabase db,
  ) => db.tournamentParticipants.createAlias(
    $_aliasNameGenerator(
      db.groupParticipants.tournamentParticipantId,
      db.tournamentParticipants.id,
    ),
  );

  $$TournamentParticipantsTableProcessedTableManager
  get tournamentParticipantId {
    final $_column = $_itemColumn<int>('tournament_participant_id')!;

    final manager = $$TournamentParticipantsTableTableManager(
      $_db,
      $_db.tournamentParticipants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _tournamentParticipantIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GroupParticipantsTableFilterComposer
    extends Composer<_$AppDatabase, $GroupParticipantsTable> {
  $$GroupParticipantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  $$GroupsTableFilterComposer get groupId {
    final $$GroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableFilterComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TournamentParticipantsTableFilterComposer get tournamentParticipantId {
    final $$TournamentParticipantsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.tournamentParticipantId,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableFilterComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$GroupParticipantsTableOrderingComposer
    extends Composer<_$AppDatabase, $GroupParticipantsTable> {
  $$GroupParticipantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  $$GroupsTableOrderingComposer get groupId {
    final $$GroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableOrderingComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TournamentParticipantsTableOrderingComposer get tournamentParticipantId {
    final $$TournamentParticipantsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.tournamentParticipantId,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableOrderingComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$GroupParticipantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GroupParticipantsTable> {
  $$GroupParticipantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$GroupsTableAnnotationComposer get groupId {
    final $$GroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TournamentParticipantsTableAnnotationComposer get tournamentParticipantId {
    final $$TournamentParticipantsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.tournamentParticipantId,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableAnnotationComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$GroupParticipantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GroupParticipantsTable,
          GroupParticipant,
          $$GroupParticipantsTableFilterComposer,
          $$GroupParticipantsTableOrderingComposer,
          $$GroupParticipantsTableAnnotationComposer,
          $$GroupParticipantsTableCreateCompanionBuilder,
          $$GroupParticipantsTableUpdateCompanionBuilder,
          (GroupParticipant, $$GroupParticipantsTableReferences),
          GroupParticipant,
          PrefetchHooks Function({bool groupId, bool tournamentParticipantId})
        > {
  $$GroupParticipantsTableTableManager(
    _$AppDatabase db,
    $GroupParticipantsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupParticipantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupParticipantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupParticipantsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> groupId = const Value.absent(),
                Value<int> tournamentParticipantId = const Value.absent(),
              }) => GroupParticipantsCompanion(
                id: id,
                groupId: groupId,
                tournamentParticipantId: tournamentParticipantId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int groupId,
                required int tournamentParticipantId,
              }) => GroupParticipantsCompanion.insert(
                id: id,
                groupId: groupId,
                tournamentParticipantId: tournamentParticipantId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GroupParticipantsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({groupId = false, tournamentParticipantId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (groupId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.groupId,
                                    referencedTable:
                                        $$GroupParticipantsTableReferences
                                            ._groupIdTable(db),
                                    referencedColumn:
                                        $$GroupParticipantsTableReferences
                                            ._groupIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (tournamentParticipantId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn:
                                        table.tournamentParticipantId,
                                    referencedTable:
                                        $$GroupParticipantsTableReferences
                                            ._tournamentParticipantIdTable(db),
                                    referencedColumn:
                                        $$GroupParticipantsTableReferences
                                            ._tournamentParticipantIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$GroupParticipantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GroupParticipantsTable,
      GroupParticipant,
      $$GroupParticipantsTableFilterComposer,
      $$GroupParticipantsTableOrderingComposer,
      $$GroupParticipantsTableAnnotationComposer,
      $$GroupParticipantsTableCreateCompanionBuilder,
      $$GroupParticipantsTableUpdateCompanionBuilder,
      (GroupParticipant, $$GroupParticipantsTableReferences),
      GroupParticipant,
      PrefetchHooks Function({bool groupId, bool tournamentParticipantId})
    >;
typedef $$FixturesTableCreateCompanionBuilder =
    FixturesCompanion Function({
      Value<int> id,
      required int tournamentId,
      required String eventType,
      Value<int?> participant1Id,
      Value<int?> participant2Id,
      Value<int?> courtNumber,
      required int roundNumber,
      Value<String> status,
      Value<int?> winnerParticipantId,
      Value<DateTime> createdAt,
      Value<String?> bracketRound,
      Value<int?> nextFixtureId,
      Value<int?> nextFixtureSlot,
      Value<bool> isBye,
      Value<int?> loserNextFixtureId,
      Value<int?> loserNextFixtureSlot,
      Value<int?> groupId,
    });
typedef $$FixturesTableUpdateCompanionBuilder =
    FixturesCompanion Function({
      Value<int> id,
      Value<int> tournamentId,
      Value<String> eventType,
      Value<int?> participant1Id,
      Value<int?> participant2Id,
      Value<int?> courtNumber,
      Value<int> roundNumber,
      Value<String> status,
      Value<int?> winnerParticipantId,
      Value<DateTime> createdAt,
      Value<String?> bracketRound,
      Value<int?> nextFixtureId,
      Value<int?> nextFixtureSlot,
      Value<bool> isBye,
      Value<int?> loserNextFixtureId,
      Value<int?> loserNextFixtureSlot,
      Value<int?> groupId,
    });

final class $$FixturesTableReferences
    extends BaseReferences<_$AppDatabase, $FixturesTable, Fixture> {
  $$FixturesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TournamentsTable _tournamentIdTable(_$AppDatabase db) =>
      db.tournaments.createAlias(
        $_aliasNameGenerator(db.fixtures.tournamentId, db.tournaments.id),
      );

  $$TournamentsTableProcessedTableManager get tournamentId {
    final $_column = $_itemColumn<int>('tournament_id')!;

    final manager = $$TournamentsTableTableManager(
      $_db,
      $_db.tournaments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tournamentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TournamentParticipantsTable _participant1IdTable(_$AppDatabase db) =>
      db.tournamentParticipants.createAlias(
        $_aliasNameGenerator(
          db.fixtures.participant1Id,
          db.tournamentParticipants.id,
        ),
      );

  $$TournamentParticipantsTableProcessedTableManager? get participant1Id {
    final $_column = $_itemColumn<int>('participant1_id');
    if ($_column == null) return null;
    final manager = $$TournamentParticipantsTableTableManager(
      $_db,
      $_db.tournamentParticipants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_participant1IdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TournamentParticipantsTable _participant2IdTable(_$AppDatabase db) =>
      db.tournamentParticipants.createAlias(
        $_aliasNameGenerator(
          db.fixtures.participant2Id,
          db.tournamentParticipants.id,
        ),
      );

  $$TournamentParticipantsTableProcessedTableManager? get participant2Id {
    final $_column = $_itemColumn<int>('participant2_id');
    if ($_column == null) return null;
    final manager = $$TournamentParticipantsTableTableManager(
      $_db,
      $_db.tournamentParticipants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_participant2IdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TournamentParticipantsTable _winnerParticipantIdTable(
    _$AppDatabase db,
  ) => db.tournamentParticipants.createAlias(
    $_aliasNameGenerator(
      db.fixtures.winnerParticipantId,
      db.tournamentParticipants.id,
    ),
  );

  $$TournamentParticipantsTableProcessedTableManager? get winnerParticipantId {
    final $_column = $_itemColumn<int>('winner_participant_id');
    if ($_column == null) return null;
    final manager = $$TournamentParticipantsTableTableManager(
      $_db,
      $_db.tournamentParticipants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_winnerParticipantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FixturesTable _nextFixtureIdTable(_$AppDatabase db) =>
      db.fixtures.createAlias(
        $_aliasNameGenerator(db.fixtures.nextFixtureId, db.fixtures.id),
      );

  $$FixturesTableProcessedTableManager? get nextFixtureId {
    final $_column = $_itemColumn<int>('next_fixture_id');
    if ($_column == null) return null;
    final manager = $$FixturesTableTableManager(
      $_db,
      $_db.fixtures,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_nextFixtureIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FixturesTable _loserNextFixtureIdTable(_$AppDatabase db) =>
      db.fixtures.createAlias(
        $_aliasNameGenerator(db.fixtures.loserNextFixtureId, db.fixtures.id),
      );

  $$FixturesTableProcessedTableManager? get loserNextFixtureId {
    final $_column = $_itemColumn<int>('loser_next_fixture_id');
    if ($_column == null) return null;
    final manager = $$FixturesTableTableManager(
      $_db,
      $_db.fixtures,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_loserNextFixtureIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GroupsTable _groupIdTable(_$AppDatabase db) => db.groups.createAlias(
    $_aliasNameGenerator(db.fixtures.groupId, db.groups.id),
  );

  $$GroupsTableProcessedTableManager? get groupId {
    final $_column = $_itemColumn<int>('group_id');
    if ($_column == null) return null;
    final manager = $$GroupsTableTableManager(
      $_db,
      $_db.groups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FixtureSetsTable, List<FixtureSet>>
  _fixtureSetsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fixtureSets,
    aliasName: $_aliasNameGenerator(db.fixtures.id, db.fixtureSets.fixtureId),
  );

  $$FixtureSetsTableProcessedTableManager get fixtureSetsRefs {
    final manager = $$FixtureSetsTableTableManager(
      $_db,
      $_db.fixtureSets,
    ).filter((f) => f.fixtureId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_fixtureSetsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FixturesTableFilterComposer
    extends Composer<_$AppDatabase, $FixturesTable> {
  $$FixturesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get courtNumber => $composableBuilder(
    column: $table.courtNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get roundNumber => $composableBuilder(
    column: $table.roundNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bracketRound => $composableBuilder(
    column: $table.bracketRound,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextFixtureSlot => $composableBuilder(
    column: $table.nextFixtureSlot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBye => $composableBuilder(
    column: $table.isBye,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get loserNextFixtureSlot => $composableBuilder(
    column: $table.loserNextFixtureSlot,
    builder: (column) => ColumnFilters(column),
  );

  $$TournamentsTableFilterComposer get tournamentId {
    final $$TournamentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableFilterComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TournamentParticipantsTableFilterComposer get participant1Id {
    final $$TournamentParticipantsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.participant1Id,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableFilterComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$TournamentParticipantsTableFilterComposer get participant2Id {
    final $$TournamentParticipantsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.participant2Id,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableFilterComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$TournamentParticipantsTableFilterComposer get winnerParticipantId {
    final $$TournamentParticipantsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.winnerParticipantId,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableFilterComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$FixturesTableFilterComposer get nextFixtureId {
    final $$FixturesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nextFixtureId,
      referencedTable: $db.fixtures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixturesTableFilterComposer(
            $db: $db,
            $table: $db.fixtures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FixturesTableFilterComposer get loserNextFixtureId {
    final $$FixturesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.loserNextFixtureId,
      referencedTable: $db.fixtures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixturesTableFilterComposer(
            $db: $db,
            $table: $db.fixtures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GroupsTableFilterComposer get groupId {
    final $$GroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableFilterComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> fixtureSetsRefs(
    Expression<bool> Function($$FixtureSetsTableFilterComposer f) f,
  ) {
    final $$FixtureSetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixtureSets,
      getReferencedColumn: (t) => t.fixtureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixtureSetsTableFilterComposer(
            $db: $db,
            $table: $db.fixtureSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FixturesTableOrderingComposer
    extends Composer<_$AppDatabase, $FixturesTable> {
  $$FixturesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get courtNumber => $composableBuilder(
    column: $table.courtNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get roundNumber => $composableBuilder(
    column: $table.roundNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bracketRound => $composableBuilder(
    column: $table.bracketRound,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextFixtureSlot => $composableBuilder(
    column: $table.nextFixtureSlot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBye => $composableBuilder(
    column: $table.isBye,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get loserNextFixtureSlot => $composableBuilder(
    column: $table.loserNextFixtureSlot,
    builder: (column) => ColumnOrderings(column),
  );

  $$TournamentsTableOrderingComposer get tournamentId {
    final $$TournamentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableOrderingComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TournamentParticipantsTableOrderingComposer get participant1Id {
    final $$TournamentParticipantsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.participant1Id,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableOrderingComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$TournamentParticipantsTableOrderingComposer get participant2Id {
    final $$TournamentParticipantsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.participant2Id,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableOrderingComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$TournamentParticipantsTableOrderingComposer get winnerParticipantId {
    final $$TournamentParticipantsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.winnerParticipantId,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableOrderingComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$FixturesTableOrderingComposer get nextFixtureId {
    final $$FixturesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nextFixtureId,
      referencedTable: $db.fixtures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixturesTableOrderingComposer(
            $db: $db,
            $table: $db.fixtures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FixturesTableOrderingComposer get loserNextFixtureId {
    final $$FixturesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.loserNextFixtureId,
      referencedTable: $db.fixtures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixturesTableOrderingComposer(
            $db: $db,
            $table: $db.fixtures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GroupsTableOrderingComposer get groupId {
    final $$GroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableOrderingComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FixturesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FixturesTable> {
  $$FixturesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<int> get courtNumber => $composableBuilder(
    column: $table.courtNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get roundNumber => $composableBuilder(
    column: $table.roundNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get bracketRound => $composableBuilder(
    column: $table.bracketRound,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextFixtureSlot => $composableBuilder(
    column: $table.nextFixtureSlot,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isBye =>
      $composableBuilder(column: $table.isBye, builder: (column) => column);

  GeneratedColumn<int> get loserNextFixtureSlot => $composableBuilder(
    column: $table.loserNextFixtureSlot,
    builder: (column) => column,
  );

  $$TournamentsTableAnnotationComposer get tournamentId {
    final $$TournamentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tournamentId,
      referencedTable: $db.tournaments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TournamentsTableAnnotationComposer(
            $db: $db,
            $table: $db.tournaments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TournamentParticipantsTableAnnotationComposer get participant1Id {
    final $$TournamentParticipantsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.participant1Id,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableAnnotationComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$TournamentParticipantsTableAnnotationComposer get participant2Id {
    final $$TournamentParticipantsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.participant2Id,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableAnnotationComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$TournamentParticipantsTableAnnotationComposer get winnerParticipantId {
    final $$TournamentParticipantsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.winnerParticipantId,
          referencedTable: $db.tournamentParticipants,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TournamentParticipantsTableAnnotationComposer(
                $db: $db,
                $table: $db.tournamentParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$FixturesTableAnnotationComposer get nextFixtureId {
    final $$FixturesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nextFixtureId,
      referencedTable: $db.fixtures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixturesTableAnnotationComposer(
            $db: $db,
            $table: $db.fixtures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FixturesTableAnnotationComposer get loserNextFixtureId {
    final $$FixturesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.loserNextFixtureId,
      referencedTable: $db.fixtures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixturesTableAnnotationComposer(
            $db: $db,
            $table: $db.fixtures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GroupsTableAnnotationComposer get groupId {
    final $$GroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> fixtureSetsRefs<T extends Object>(
    Expression<T> Function($$FixtureSetsTableAnnotationComposer a) f,
  ) {
    final $$FixtureSetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixtureSets,
      getReferencedColumn: (t) => t.fixtureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixtureSetsTableAnnotationComposer(
            $db: $db,
            $table: $db.fixtureSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FixturesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FixturesTable,
          Fixture,
          $$FixturesTableFilterComposer,
          $$FixturesTableOrderingComposer,
          $$FixturesTableAnnotationComposer,
          $$FixturesTableCreateCompanionBuilder,
          $$FixturesTableUpdateCompanionBuilder,
          (Fixture, $$FixturesTableReferences),
          Fixture,
          PrefetchHooks Function({
            bool tournamentId,
            bool participant1Id,
            bool participant2Id,
            bool winnerParticipantId,
            bool nextFixtureId,
            bool loserNextFixtureId,
            bool groupId,
            bool fixtureSetsRefs,
          })
        > {
  $$FixturesTableTableManager(_$AppDatabase db, $FixturesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FixturesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FixturesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FixturesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tournamentId = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<int?> participant1Id = const Value.absent(),
                Value<int?> participant2Id = const Value.absent(),
                Value<int?> courtNumber = const Value.absent(),
                Value<int> roundNumber = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> winnerParticipantId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> bracketRound = const Value.absent(),
                Value<int?> nextFixtureId = const Value.absent(),
                Value<int?> nextFixtureSlot = const Value.absent(),
                Value<bool> isBye = const Value.absent(),
                Value<int?> loserNextFixtureId = const Value.absent(),
                Value<int?> loserNextFixtureSlot = const Value.absent(),
                Value<int?> groupId = const Value.absent(),
              }) => FixturesCompanion(
                id: id,
                tournamentId: tournamentId,
                eventType: eventType,
                participant1Id: participant1Id,
                participant2Id: participant2Id,
                courtNumber: courtNumber,
                roundNumber: roundNumber,
                status: status,
                winnerParticipantId: winnerParticipantId,
                createdAt: createdAt,
                bracketRound: bracketRound,
                nextFixtureId: nextFixtureId,
                nextFixtureSlot: nextFixtureSlot,
                isBye: isBye,
                loserNextFixtureId: loserNextFixtureId,
                loserNextFixtureSlot: loserNextFixtureSlot,
                groupId: groupId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tournamentId,
                required String eventType,
                Value<int?> participant1Id = const Value.absent(),
                Value<int?> participant2Id = const Value.absent(),
                Value<int?> courtNumber = const Value.absent(),
                required int roundNumber,
                Value<String> status = const Value.absent(),
                Value<int?> winnerParticipantId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> bracketRound = const Value.absent(),
                Value<int?> nextFixtureId = const Value.absent(),
                Value<int?> nextFixtureSlot = const Value.absent(),
                Value<bool> isBye = const Value.absent(),
                Value<int?> loserNextFixtureId = const Value.absent(),
                Value<int?> loserNextFixtureSlot = const Value.absent(),
                Value<int?> groupId = const Value.absent(),
              }) => FixturesCompanion.insert(
                id: id,
                tournamentId: tournamentId,
                eventType: eventType,
                participant1Id: participant1Id,
                participant2Id: participant2Id,
                courtNumber: courtNumber,
                roundNumber: roundNumber,
                status: status,
                winnerParticipantId: winnerParticipantId,
                createdAt: createdAt,
                bracketRound: bracketRound,
                nextFixtureId: nextFixtureId,
                nextFixtureSlot: nextFixtureSlot,
                isBye: isBye,
                loserNextFixtureId: loserNextFixtureId,
                loserNextFixtureSlot: loserNextFixtureSlot,
                groupId: groupId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FixturesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                tournamentId = false,
                participant1Id = false,
                participant2Id = false,
                winnerParticipantId = false,
                nextFixtureId = false,
                loserNextFixtureId = false,
                groupId = false,
                fixtureSetsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (fixtureSetsRefs) db.fixtureSets,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (tournamentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.tournamentId,
                                    referencedTable: $$FixturesTableReferences
                                        ._tournamentIdTable(db),
                                    referencedColumn: $$FixturesTableReferences
                                        ._tournamentIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (participant1Id) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.participant1Id,
                                    referencedTable: $$FixturesTableReferences
                                        ._participant1IdTable(db),
                                    referencedColumn: $$FixturesTableReferences
                                        ._participant1IdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (participant2Id) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.participant2Id,
                                    referencedTable: $$FixturesTableReferences
                                        ._participant2IdTable(db),
                                    referencedColumn: $$FixturesTableReferences
                                        ._participant2IdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (winnerParticipantId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.winnerParticipantId,
                                    referencedTable: $$FixturesTableReferences
                                        ._winnerParticipantIdTable(db),
                                    referencedColumn: $$FixturesTableReferences
                                        ._winnerParticipantIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (nextFixtureId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.nextFixtureId,
                                    referencedTable: $$FixturesTableReferences
                                        ._nextFixtureIdTable(db),
                                    referencedColumn: $$FixturesTableReferences
                                        ._nextFixtureIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (loserNextFixtureId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.loserNextFixtureId,
                                    referencedTable: $$FixturesTableReferences
                                        ._loserNextFixtureIdTable(db),
                                    referencedColumn: $$FixturesTableReferences
                                        ._loserNextFixtureIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (groupId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.groupId,
                                    referencedTable: $$FixturesTableReferences
                                        ._groupIdTable(db),
                                    referencedColumn: $$FixturesTableReferences
                                        ._groupIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (fixtureSetsRefs)
                        await $_getPrefetchedData<
                          Fixture,
                          $FixturesTable,
                          FixtureSet
                        >(
                          currentTable: table,
                          referencedTable: $$FixturesTableReferences
                              ._fixtureSetsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FixturesTableReferences(
                                db,
                                table,
                                p0,
                              ).fixtureSetsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fixtureId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FixturesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FixturesTable,
      Fixture,
      $$FixturesTableFilterComposer,
      $$FixturesTableOrderingComposer,
      $$FixturesTableAnnotationComposer,
      $$FixturesTableCreateCompanionBuilder,
      $$FixturesTableUpdateCompanionBuilder,
      (Fixture, $$FixturesTableReferences),
      Fixture,
      PrefetchHooks Function({
        bool tournamentId,
        bool participant1Id,
        bool participant2Id,
        bool winnerParticipantId,
        bool nextFixtureId,
        bool loserNextFixtureId,
        bool groupId,
        bool fixtureSetsRefs,
      })
    >;
typedef $$FixtureSetsTableCreateCompanionBuilder =
    FixtureSetsCompanion Function({
      Value<int> id,
      required int fixtureId,
      required int setNumber,
      required int participant1Score,
      required int participant2Score,
    });
typedef $$FixtureSetsTableUpdateCompanionBuilder =
    FixtureSetsCompanion Function({
      Value<int> id,
      Value<int> fixtureId,
      Value<int> setNumber,
      Value<int> participant1Score,
      Value<int> participant2Score,
    });

final class $$FixtureSetsTableReferences
    extends BaseReferences<_$AppDatabase, $FixtureSetsTable, FixtureSet> {
  $$FixtureSetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FixturesTable _fixtureIdTable(_$AppDatabase db) =>
      db.fixtures.createAlias(
        $_aliasNameGenerator(db.fixtureSets.fixtureId, db.fixtures.id),
      );

  $$FixturesTableProcessedTableManager get fixtureId {
    final $_column = $_itemColumn<int>('fixture_id')!;

    final manager = $$FixturesTableTableManager(
      $_db,
      $_db.fixtures,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fixtureIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FixtureSetsTableFilterComposer
    extends Composer<_$AppDatabase, $FixtureSetsTable> {
  $$FixtureSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get participant1Score => $composableBuilder(
    column: $table.participant1Score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get participant2Score => $composableBuilder(
    column: $table.participant2Score,
    builder: (column) => ColumnFilters(column),
  );

  $$FixturesTableFilterComposer get fixtureId {
    final $$FixturesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixtureId,
      referencedTable: $db.fixtures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixturesTableFilterComposer(
            $db: $db,
            $table: $db.fixtures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FixtureSetsTableOrderingComposer
    extends Composer<_$AppDatabase, $FixtureSetsTable> {
  $$FixtureSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get participant1Score => $composableBuilder(
    column: $table.participant1Score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get participant2Score => $composableBuilder(
    column: $table.participant2Score,
    builder: (column) => ColumnOrderings(column),
  );

  $$FixturesTableOrderingComposer get fixtureId {
    final $$FixturesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixtureId,
      referencedTable: $db.fixtures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixturesTableOrderingComposer(
            $db: $db,
            $table: $db.fixtures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FixtureSetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FixtureSetsTable> {
  $$FixtureSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get setNumber =>
      $composableBuilder(column: $table.setNumber, builder: (column) => column);

  GeneratedColumn<int> get participant1Score => $composableBuilder(
    column: $table.participant1Score,
    builder: (column) => column,
  );

  GeneratedColumn<int> get participant2Score => $composableBuilder(
    column: $table.participant2Score,
    builder: (column) => column,
  );

  $$FixturesTableAnnotationComposer get fixtureId {
    final $$FixturesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixtureId,
      referencedTable: $db.fixtures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixturesTableAnnotationComposer(
            $db: $db,
            $table: $db.fixtures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FixtureSetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FixtureSetsTable,
          FixtureSet,
          $$FixtureSetsTableFilterComposer,
          $$FixtureSetsTableOrderingComposer,
          $$FixtureSetsTableAnnotationComposer,
          $$FixtureSetsTableCreateCompanionBuilder,
          $$FixtureSetsTableUpdateCompanionBuilder,
          (FixtureSet, $$FixtureSetsTableReferences),
          FixtureSet,
          PrefetchHooks Function({bool fixtureId})
        > {
  $$FixtureSetsTableTableManager(_$AppDatabase db, $FixtureSetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FixtureSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FixtureSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FixtureSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> fixtureId = const Value.absent(),
                Value<int> setNumber = const Value.absent(),
                Value<int> participant1Score = const Value.absent(),
                Value<int> participant2Score = const Value.absent(),
              }) => FixtureSetsCompanion(
                id: id,
                fixtureId: fixtureId,
                setNumber: setNumber,
                participant1Score: participant1Score,
                participant2Score: participant2Score,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int fixtureId,
                required int setNumber,
                required int participant1Score,
                required int participant2Score,
              }) => FixtureSetsCompanion.insert(
                id: id,
                fixtureId: fixtureId,
                setNumber: setNumber,
                participant1Score: participant1Score,
                participant2Score: participant2Score,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FixtureSetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fixtureId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (fixtureId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fixtureId,
                                referencedTable: $$FixtureSetsTableReferences
                                    ._fixtureIdTable(db),
                                referencedColumn: $$FixtureSetsTableReferences
                                    ._fixtureIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FixtureSetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FixtureSetsTable,
      FixtureSet,
      $$FixtureSetsTableFilterComposer,
      $$FixtureSetsTableOrderingComposer,
      $$FixtureSetsTableAnnotationComposer,
      $$FixtureSetsTableCreateCompanionBuilder,
      $$FixtureSetsTableUpdateCompanionBuilder,
      (FixtureSet, $$FixtureSetsTableReferences),
      FixtureSet,
      PrefetchHooks Function({bool fixtureId})
    >;
typedef $$ExternalResultsTableCreateCompanionBuilder =
    ExternalResultsCompanion Function({
      Value<int> id,
      required int playerId,
      required String tournamentName,
      Value<String?> tournamentOrganiser,
      required DateTime date,
      required String eventType,
      Value<String?> partnerName,
      required String stageReached,
      required int rankingPointsAwarded,
      Value<DateTime> createdAt,
    });
typedef $$ExternalResultsTableUpdateCompanionBuilder =
    ExternalResultsCompanion Function({
      Value<int> id,
      Value<int> playerId,
      Value<String> tournamentName,
      Value<String?> tournamentOrganiser,
      Value<DateTime> date,
      Value<String> eventType,
      Value<String?> partnerName,
      Value<String> stageReached,
      Value<int> rankingPointsAwarded,
      Value<DateTime> createdAt,
    });

final class $$ExternalResultsTableReferences
    extends
        BaseReferences<_$AppDatabase, $ExternalResultsTable, ExternalResult> {
  $$ExternalResultsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PlayersTable _playerIdTable(_$AppDatabase db) =>
      db.players.createAlias(
        $_aliasNameGenerator(db.externalResults.playerId, db.players.id),
      );

  $$PlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<int>('player_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExternalResultsTableFilterComposer
    extends Composer<_$AppDatabase, $ExternalResultsTable> {
  $$ExternalResultsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tournamentName => $composableBuilder(
    column: $table.tournamentName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tournamentOrganiser => $composableBuilder(
    column: $table.tournamentOrganiser,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partnerName => $composableBuilder(
    column: $table.partnerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stageReached => $composableBuilder(
    column: $table.stageReached,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rankingPointsAwarded => $composableBuilder(
    column: $table.rankingPointsAwarded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExternalResultsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExternalResultsTable> {
  $$ExternalResultsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tournamentName => $composableBuilder(
    column: $table.tournamentName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tournamentOrganiser => $composableBuilder(
    column: $table.tournamentOrganiser,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partnerName => $composableBuilder(
    column: $table.partnerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stageReached => $composableBuilder(
    column: $table.stageReached,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rankingPointsAwarded => $composableBuilder(
    column: $table.rankingPointsAwarded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExternalResultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExternalResultsTable> {
  $$ExternalResultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tournamentName => $composableBuilder(
    column: $table.tournamentName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tournamentOrganiser => $composableBuilder(
    column: $table.tournamentOrganiser,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<String> get partnerName => $composableBuilder(
    column: $table.partnerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stageReached => $composableBuilder(
    column: $table.stageReached,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rankingPointsAwarded => $composableBuilder(
    column: $table.rankingPointsAwarded,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExternalResultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExternalResultsTable,
          ExternalResult,
          $$ExternalResultsTableFilterComposer,
          $$ExternalResultsTableOrderingComposer,
          $$ExternalResultsTableAnnotationComposer,
          $$ExternalResultsTableCreateCompanionBuilder,
          $$ExternalResultsTableUpdateCompanionBuilder,
          (ExternalResult, $$ExternalResultsTableReferences),
          ExternalResult,
          PrefetchHooks Function({bool playerId})
        > {
  $$ExternalResultsTableTableManager(
    _$AppDatabase db,
    $ExternalResultsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExternalResultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExternalResultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExternalResultsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<String> tournamentName = const Value.absent(),
                Value<String?> tournamentOrganiser = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<String?> partnerName = const Value.absent(),
                Value<String> stageReached = const Value.absent(),
                Value<int> rankingPointsAwarded = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExternalResultsCompanion(
                id: id,
                playerId: playerId,
                tournamentName: tournamentName,
                tournamentOrganiser: tournamentOrganiser,
                date: date,
                eventType: eventType,
                partnerName: partnerName,
                stageReached: stageReached,
                rankingPointsAwarded: rankingPointsAwarded,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int playerId,
                required String tournamentName,
                Value<String?> tournamentOrganiser = const Value.absent(),
                required DateTime date,
                required String eventType,
                Value<String?> partnerName = const Value.absent(),
                required String stageReached,
                required int rankingPointsAwarded,
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExternalResultsCompanion.insert(
                id: id,
                playerId: playerId,
                tournamentName: tournamentName,
                tournamentOrganiser: tournamentOrganiser,
                date: date,
                eventType: eventType,
                partnerName: partnerName,
                stageReached: stageReached,
                rankingPointsAwarded: rankingPointsAwarded,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExternalResultsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (playerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.playerId,
                                referencedTable:
                                    $$ExternalResultsTableReferences
                                        ._playerIdTable(db),
                                referencedColumn:
                                    $$ExternalResultsTableReferences
                                        ._playerIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExternalResultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExternalResultsTable,
      ExternalResult,
      $$ExternalResultsTableFilterComposer,
      $$ExternalResultsTableOrderingComposer,
      $$ExternalResultsTableAnnotationComposer,
      $$ExternalResultsTableCreateCompanionBuilder,
      $$ExternalResultsTableUpdateCompanionBuilder,
      (ExternalResult, $$ExternalResultsTableReferences),
      ExternalResult,
      PrefetchHooks Function({bool playerId})
    >;
typedef $$TierPointValuesTableCreateCompanionBuilder =
    TierPointValuesCompanion Function({
      Value<int> id,
      required String tierLabel,
      required int winnerPoints,
      required int runnerUpPoints,
      required int semiPoints,
      required int quarterPoints,
      required int roundOf16Points,
      required int roundOf32Points,
      required int roundOf64Points,
    });
typedef $$TierPointValuesTableUpdateCompanionBuilder =
    TierPointValuesCompanion Function({
      Value<int> id,
      Value<String> tierLabel,
      Value<int> winnerPoints,
      Value<int> runnerUpPoints,
      Value<int> semiPoints,
      Value<int> quarterPoints,
      Value<int> roundOf16Points,
      Value<int> roundOf32Points,
      Value<int> roundOf64Points,
    });

class $$TierPointValuesTableFilterComposer
    extends Composer<_$AppDatabase, $TierPointValuesTable> {
  $$TierPointValuesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tierLabel => $composableBuilder(
    column: $table.tierLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get winnerPoints => $composableBuilder(
    column: $table.winnerPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get runnerUpPoints => $composableBuilder(
    column: $table.runnerUpPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get semiPoints => $composableBuilder(
    column: $table.semiPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quarterPoints => $composableBuilder(
    column: $table.quarterPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get roundOf16Points => $composableBuilder(
    column: $table.roundOf16Points,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get roundOf32Points => $composableBuilder(
    column: $table.roundOf32Points,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get roundOf64Points => $composableBuilder(
    column: $table.roundOf64Points,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TierPointValuesTableOrderingComposer
    extends Composer<_$AppDatabase, $TierPointValuesTable> {
  $$TierPointValuesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tierLabel => $composableBuilder(
    column: $table.tierLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get winnerPoints => $composableBuilder(
    column: $table.winnerPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get runnerUpPoints => $composableBuilder(
    column: $table.runnerUpPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get semiPoints => $composableBuilder(
    column: $table.semiPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quarterPoints => $composableBuilder(
    column: $table.quarterPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get roundOf16Points => $composableBuilder(
    column: $table.roundOf16Points,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get roundOf32Points => $composableBuilder(
    column: $table.roundOf32Points,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get roundOf64Points => $composableBuilder(
    column: $table.roundOf64Points,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TierPointValuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TierPointValuesTable> {
  $$TierPointValuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tierLabel =>
      $composableBuilder(column: $table.tierLabel, builder: (column) => column);

  GeneratedColumn<int> get winnerPoints => $composableBuilder(
    column: $table.winnerPoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get runnerUpPoints => $composableBuilder(
    column: $table.runnerUpPoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get semiPoints => $composableBuilder(
    column: $table.semiPoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quarterPoints => $composableBuilder(
    column: $table.quarterPoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get roundOf16Points => $composableBuilder(
    column: $table.roundOf16Points,
    builder: (column) => column,
  );

  GeneratedColumn<int> get roundOf32Points => $composableBuilder(
    column: $table.roundOf32Points,
    builder: (column) => column,
  );

  GeneratedColumn<int> get roundOf64Points => $composableBuilder(
    column: $table.roundOf64Points,
    builder: (column) => column,
  );
}

class $$TierPointValuesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TierPointValuesTable,
          TierPointValue,
          $$TierPointValuesTableFilterComposer,
          $$TierPointValuesTableOrderingComposer,
          $$TierPointValuesTableAnnotationComposer,
          $$TierPointValuesTableCreateCompanionBuilder,
          $$TierPointValuesTableUpdateCompanionBuilder,
          (
            TierPointValue,
            BaseReferences<
              _$AppDatabase,
              $TierPointValuesTable,
              TierPointValue
            >,
          ),
          TierPointValue,
          PrefetchHooks Function()
        > {
  $$TierPointValuesTableTableManager(
    _$AppDatabase db,
    $TierPointValuesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TierPointValuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TierPointValuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TierPointValuesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tierLabel = const Value.absent(),
                Value<int> winnerPoints = const Value.absent(),
                Value<int> runnerUpPoints = const Value.absent(),
                Value<int> semiPoints = const Value.absent(),
                Value<int> quarterPoints = const Value.absent(),
                Value<int> roundOf16Points = const Value.absent(),
                Value<int> roundOf32Points = const Value.absent(),
                Value<int> roundOf64Points = const Value.absent(),
              }) => TierPointValuesCompanion(
                id: id,
                tierLabel: tierLabel,
                winnerPoints: winnerPoints,
                runnerUpPoints: runnerUpPoints,
                semiPoints: semiPoints,
                quarterPoints: quarterPoints,
                roundOf16Points: roundOf16Points,
                roundOf32Points: roundOf32Points,
                roundOf64Points: roundOf64Points,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String tierLabel,
                required int winnerPoints,
                required int runnerUpPoints,
                required int semiPoints,
                required int quarterPoints,
                required int roundOf16Points,
                required int roundOf32Points,
                required int roundOf64Points,
              }) => TierPointValuesCompanion.insert(
                id: id,
                tierLabel: tierLabel,
                winnerPoints: winnerPoints,
                runnerUpPoints: runnerUpPoints,
                semiPoints: semiPoints,
                quarterPoints: quarterPoints,
                roundOf16Points: roundOf16Points,
                roundOf32Points: roundOf32Points,
                roundOf64Points: roundOf64Points,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TierPointValuesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TierPointValuesTable,
      TierPointValue,
      $$TierPointValuesTableFilterComposer,
      $$TierPointValuesTableOrderingComposer,
      $$TierPointValuesTableAnnotationComposer,
      $$TierPointValuesTableCreateCompanionBuilder,
      $$TierPointValuesTableUpdateCompanionBuilder,
      (
        TierPointValue,
        BaseReferences<_$AppDatabase, $TierPointValuesTable, TierPointValue>,
      ),
      TierPointValue,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db, _db.players);
  $$IndividualTeamsTableTableManager get individualTeams =>
      $$IndividualTeamsTableTableManager(_db, _db.individualTeams);
  $$CompetitionTeamsTableTableManager get competitionTeams =>
      $$CompetitionTeamsTableTableManager(_db, _db.competitionTeams);
  $$CompetitionTeamMembersTableTableManager get competitionTeamMembers =>
      $$CompetitionTeamMembersTableTableManager(
        _db,
        _db.competitionTeamMembers,
      );
  $$TournamentsTableTableManager get tournaments =>
      $$TournamentsTableTableManager(_db, _db.tournaments);
  $$TournamentEventsTableTableManager get tournamentEvents =>
      $$TournamentEventsTableTableManager(_db, _db.tournamentEvents);
  $$GroupKnockoutSettingsTableTableManager get groupKnockoutSettings =>
      $$GroupKnockoutSettingsTableTableManager(_db, _db.groupKnockoutSettings);
  $$TournamentParticipantsTableTableManager get tournamentParticipants =>
      $$TournamentParticipantsTableTableManager(
        _db,
        _db.tournamentParticipants,
      );
  $$TeamEventAssignmentsTableTableManager get teamEventAssignments =>
      $$TeamEventAssignmentsTableTableManager(_db, _db.teamEventAssignments);
  $$GroupsTableTableManager get groups =>
      $$GroupsTableTableManager(_db, _db.groups);
  $$GroupParticipantsTableTableManager get groupParticipants =>
      $$GroupParticipantsTableTableManager(_db, _db.groupParticipants);
  $$FixturesTableTableManager get fixtures =>
      $$FixturesTableTableManager(_db, _db.fixtures);
  $$FixtureSetsTableTableManager get fixtureSets =>
      $$FixtureSetsTableTableManager(_db, _db.fixtureSets);
  $$ExternalResultsTableTableManager get externalResults =>
      $$ExternalResultsTableTableManager(_db, _db.externalResults);
  $$TierPointValuesTableTableManager get tierPointValues =>
      $$TierPointValuesTableTableManager(_db, _db.tierPointValues);
}
