// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppDatabase.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Mrfarmer extends DataClass implements Insertable<Mrfarmer> {
  final int id;
  final int? onlineid;
  final String? first_name;
  final String? last_name;
  final String? member_number;
  final String? gender;
  final String? phone_number;
  final String? email;
  final bool issettobeupdated;
  final bool deleted;
  Mrfarmer(
      {required this.id,
      this.onlineid,
      this.first_name,
      this.last_name,
      this.member_number,
      this.gender,
      this.phone_number,
      this.email,
      required this.issettobeupdated,
      required this.deleted});
  factory Mrfarmer.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Mrfarmer(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      onlineid: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}onlineid']),
      first_name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name']),
      last_name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name']),
      member_number: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}member_number']),
      gender: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gender']),
      phone_number: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}phone_number']),
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email']),
      issettobeupdated: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}issettobeupdated'])!,
      deleted: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || onlineid != null) {
      map['onlineid'] = Variable<int?>(onlineid);
    }
    if (!nullToAbsent || first_name != null) {
      map['first_name'] = Variable<String?>(first_name);
    }
    if (!nullToAbsent || last_name != null) {
      map['last_name'] = Variable<String?>(last_name);
    }
    if (!nullToAbsent || member_number != null) {
      map['member_number'] = Variable<String?>(member_number);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String?>(gender);
    }
    if (!nullToAbsent || phone_number != null) {
      map['phone_number'] = Variable<String?>(phone_number);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String?>(email);
    }
    map['issettobeupdated'] = Variable<bool>(issettobeupdated);
    map['deleted'] = Variable<bool>(deleted);
    return map;
  }

  MrfarmersCompanion toCompanion(bool nullToAbsent) {
    return MrfarmersCompanion(
      id: Value(id),
      onlineid: onlineid == null && nullToAbsent
          ? const Value.absent()
          : Value(onlineid),
      first_name: first_name == null && nullToAbsent
          ? const Value.absent()
          : Value(first_name),
      last_name: last_name == null && nullToAbsent
          ? const Value.absent()
          : Value(last_name),
      member_number: member_number == null && nullToAbsent
          ? const Value.absent()
          : Value(member_number),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      phone_number: phone_number == null && nullToAbsent
          ? const Value.absent()
          : Value(phone_number),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      issettobeupdated: Value(issettobeupdated),
      deleted: Value(deleted),
    );
  }

  factory Mrfarmer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Mrfarmer(
      id: serializer.fromJson<int>(json['id']),
      onlineid: serializer.fromJson<int?>(json['onlineid']),
      first_name: serializer.fromJson<String?>(json['first_name']),
      last_name: serializer.fromJson<String?>(json['last_name']),
      member_number: serializer.fromJson<String?>(json['member_number']),
      gender: serializer.fromJson<String?>(json['gender']),
      phone_number: serializer.fromJson<String?>(json['phone_number']),
      email: serializer.fromJson<String?>(json['email']),
      issettobeupdated: serializer.fromJson<bool>(json['issettobeupdated']),
      deleted: serializer.fromJson<bool>(json['deleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'onlineid': serializer.toJson<int?>(onlineid),
      'first_name': serializer.toJson<String?>(first_name),
      'last_name': serializer.toJson<String?>(last_name),
      'member_number': serializer.toJson<String?>(member_number),
      'gender': serializer.toJson<String?>(gender),
      'phone_number': serializer.toJson<String?>(phone_number),
      'email': serializer.toJson<String?>(email),
      'issettobeupdated': serializer.toJson<bool>(issettobeupdated),
      'deleted': serializer.toJson<bool>(deleted),
    };
  }

  Mrfarmer copyWith(
          {int? id,
          int? onlineid,
          String? first_name,
          String? last_name,
          String? member_number,
          String? gender,
          String? phone_number,
          String? email,
          bool? issettobeupdated,
          bool? deleted}) =>
      Mrfarmer(
        id: id ?? this.id,
        onlineid: onlineid ?? this.onlineid,
        first_name: first_name ?? this.first_name,
        last_name: last_name ?? this.last_name,
        member_number: member_number ?? this.member_number,
        gender: gender ?? this.gender,
        phone_number: phone_number ?? this.phone_number,
        email: email ?? this.email,
        issettobeupdated: issettobeupdated ?? this.issettobeupdated,
        deleted: deleted ?? this.deleted,
      );
  @override
  String toString() {
    return (StringBuffer('Mrfarmer(')
          ..write('id: $id, ')
          ..write('onlineid: $onlineid, ')
          ..write('first_name: $first_name, ')
          ..write('last_name: $last_name, ')
          ..write('member_number: $member_number, ')
          ..write('gender: $gender, ')
          ..write('phone_number: $phone_number, ')
          ..write('email: $email, ')
          ..write('issettobeupdated: $issettobeupdated, ')
          ..write('deleted: $deleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, onlineid, first_name, last_name,
      member_number, gender, phone_number, email, issettobeupdated, deleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Mrfarmer &&
          other.id == this.id &&
          other.onlineid == this.onlineid &&
          other.first_name == this.first_name &&
          other.last_name == this.last_name &&
          other.member_number == this.member_number &&
          other.gender == this.gender &&
          other.phone_number == this.phone_number &&
          other.email == this.email &&
          other.issettobeupdated == this.issettobeupdated &&
          other.deleted == this.deleted);
}

class MrfarmersCompanion extends UpdateCompanion<Mrfarmer> {
  final Value<int> id;
  final Value<int?> onlineid;
  final Value<String?> first_name;
  final Value<String?> last_name;
  final Value<String?> member_number;
  final Value<String?> gender;
  final Value<String?> phone_number;
  final Value<String?> email;
  final Value<bool> issettobeupdated;
  final Value<bool> deleted;
  const MrfarmersCompanion({
    this.id = const Value.absent(),
    this.onlineid = const Value.absent(),
    this.first_name = const Value.absent(),
    this.last_name = const Value.absent(),
    this.member_number = const Value.absent(),
    this.gender = const Value.absent(),
    this.phone_number = const Value.absent(),
    this.email = const Value.absent(),
    this.issettobeupdated = const Value.absent(),
    this.deleted = const Value.absent(),
  });
  MrfarmersCompanion.insert({
    this.id = const Value.absent(),
    this.onlineid = const Value.absent(),
    this.first_name = const Value.absent(),
    this.last_name = const Value.absent(),
    this.member_number = const Value.absent(),
    this.gender = const Value.absent(),
    this.phone_number = const Value.absent(),
    this.email = const Value.absent(),
    this.issettobeupdated = const Value.absent(),
    this.deleted = const Value.absent(),
  });
  static Insertable<Mrfarmer> custom({
    Expression<int>? id,
    Expression<int?>? onlineid,
    Expression<String?>? first_name,
    Expression<String?>? last_name,
    Expression<String?>? member_number,
    Expression<String?>? gender,
    Expression<String?>? phone_number,
    Expression<String?>? email,
    Expression<bool>? issettobeupdated,
    Expression<bool>? deleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (onlineid != null) 'onlineid': onlineid,
      if (first_name != null) 'first_name': first_name,
      if (last_name != null) 'last_name': last_name,
      if (member_number != null) 'member_number': member_number,
      if (gender != null) 'gender': gender,
      if (phone_number != null) 'phone_number': phone_number,
      if (email != null) 'email': email,
      if (issettobeupdated != null) 'issettobeupdated': issettobeupdated,
      if (deleted != null) 'deleted': deleted,
    });
  }

  MrfarmersCompanion copyWith(
      {Value<int>? id,
      Value<int?>? onlineid,
      Value<String?>? first_name,
      Value<String?>? last_name,
      Value<String?>? member_number,
      Value<String?>? gender,
      Value<String?>? phone_number,
      Value<String?>? email,
      Value<bool>? issettobeupdated,
      Value<bool>? deleted}) {
    return MrfarmersCompanion(
      id: id ?? this.id,
      onlineid: onlineid ?? this.onlineid,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      member_number: member_number ?? this.member_number,
      gender: gender ?? this.gender,
      phone_number: phone_number ?? this.phone_number,
      email: email ?? this.email,
      issettobeupdated: issettobeupdated ?? this.issettobeupdated,
      deleted: deleted ?? this.deleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (onlineid.present) {
      map['onlineid'] = Variable<int?>(onlineid.value);
    }
    if (first_name.present) {
      map['first_name'] = Variable<String?>(first_name.value);
    }
    if (last_name.present) {
      map['last_name'] = Variable<String?>(last_name.value);
    }
    if (member_number.present) {
      map['member_number'] = Variable<String?>(member_number.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String?>(gender.value);
    }
    if (phone_number.present) {
      map['phone_number'] = Variable<String?>(phone_number.value);
    }
    if (email.present) {
      map['email'] = Variable<String?>(email.value);
    }
    if (issettobeupdated.present) {
      map['issettobeupdated'] = Variable<bool>(issettobeupdated.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MrfarmersCompanion(')
          ..write('id: $id, ')
          ..write('onlineid: $onlineid, ')
          ..write('first_name: $first_name, ')
          ..write('last_name: $last_name, ')
          ..write('member_number: $member_number, ')
          ..write('gender: $gender, ')
          ..write('phone_number: $phone_number, ')
          ..write('email: $email, ')
          ..write('issettobeupdated: $issettobeupdated, ')
          ..write('deleted: $deleted')
          ..write(')'))
        .toString();
  }
}

class $MrfarmersTable extends Mrfarmers
    with TableInfo<$MrfarmersTable, Mrfarmer> {
  final GeneratedDatabase _db;
  final String? _alias;
  $MrfarmersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _onlineidMeta = const VerificationMeta('onlineid');
  late final GeneratedColumn<int?> onlineid = GeneratedColumn<int?>(
      'onlineid', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _first_nameMeta = const VerificationMeta('first_name');
  late final GeneratedColumn<String?> first_name = GeneratedColumn<String?>(
      'first_name', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _last_nameMeta = const VerificationMeta('last_name');
  late final GeneratedColumn<String?> last_name = GeneratedColumn<String?>(
      'last_name', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _member_numberMeta =
      const VerificationMeta('member_number');
  late final GeneratedColumn<String?> member_number = GeneratedColumn<String?>(
      'member_number', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _genderMeta = const VerificationMeta('gender');
  late final GeneratedColumn<String?> gender = GeneratedColumn<String?>(
      'gender', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _phone_numberMeta =
      const VerificationMeta('phone_number');
  late final GeneratedColumn<String?> phone_number = GeneratedColumn<String?>(
      'phone_number', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _issettobeupdatedMeta =
      const VerificationMeta('issettobeupdated');
  late final GeneratedColumn<bool?> issettobeupdated = GeneratedColumn<bool?>(
      'issettobeupdated', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (issettobeupdated IN (0, 1))',
      defaultValue: Constant(false));
  final VerificationMeta _deletedMeta = const VerificationMeta('deleted');
  late final GeneratedColumn<bool?> deleted = GeneratedColumn<bool?>(
      'deleted', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (deleted IN (0, 1))',
      defaultValue: Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        onlineid,
        first_name,
        last_name,
        member_number,
        gender,
        phone_number,
        email,
        issettobeupdated,
        deleted
      ];
  @override
  String get aliasedName => _alias ?? 'mrfarmers';
  @override
  String get actualTableName => 'mrfarmers';
  @override
  VerificationContext validateIntegrity(Insertable<Mrfarmer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('onlineid')) {
      context.handle(_onlineidMeta,
          onlineid.isAcceptableOrUnknown(data['onlineid']!, _onlineidMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(
          _first_nameMeta,
          first_name.isAcceptableOrUnknown(
              data['first_name']!, _first_nameMeta));
    }
    if (data.containsKey('last_name')) {
      context.handle(_last_nameMeta,
          last_name.isAcceptableOrUnknown(data['last_name']!, _last_nameMeta));
    }
    if (data.containsKey('member_number')) {
      context.handle(
          _member_numberMeta,
          member_number.isAcceptableOrUnknown(
              data['member_number']!, _member_numberMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phone_numberMeta,
          phone_number.isAcceptableOrUnknown(
              data['phone_number']!, _phone_numberMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('issettobeupdated')) {
      context.handle(
          _issettobeupdatedMeta,
          issettobeupdated.isAcceptableOrUnknown(
              data['issettobeupdated']!, _issettobeupdatedMeta));
    }
    if (data.containsKey('deleted')) {
      context.handle(_deletedMeta,
          deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Mrfarmer map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Mrfarmer.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MrfarmersTable createAlias(String alias) {
    return $MrfarmersTable(_db, alias);
  }
}

class Mrfarm extends DataClass implements Insertable<Mrfarm> {
  final int id;
  final int? onlineid;
  final String? farm_name;
  final String? farm_size;
  final int? farmer_online_id;
  final int? farmer;
  final bool issettobeupdated;
  final bool deleted;
  Mrfarm(
      {required this.id,
      this.onlineid,
      this.farm_name,
      this.farm_size,
      this.farmer_online_id,
      this.farmer,
      required this.issettobeupdated,
      required this.deleted});
  factory Mrfarm.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Mrfarm(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      onlineid: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}onlineid']),
      farm_name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}farm_name']),
      farm_size: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}farm_size']),
      farmer_online_id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}farmer_online_id']),
      farmer: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}farmer']),
      issettobeupdated: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}issettobeupdated'])!,
      deleted: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deleted'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || onlineid != null) {
      map['onlineid'] = Variable<int?>(onlineid);
    }
    if (!nullToAbsent || farm_name != null) {
      map['farm_name'] = Variable<String?>(farm_name);
    }
    if (!nullToAbsent || farm_size != null) {
      map['farm_size'] = Variable<String?>(farm_size);
    }
    if (!nullToAbsent || farmer_online_id != null) {
      map['farmer_online_id'] = Variable<int?>(farmer_online_id);
    }
    if (!nullToAbsent || farmer != null) {
      map['farmer'] = Variable<int?>(farmer);
    }
    map['issettobeupdated'] = Variable<bool>(issettobeupdated);
    map['deleted'] = Variable<bool>(deleted);
    return map;
  }

  MrfarmsCompanion toCompanion(bool nullToAbsent) {
    return MrfarmsCompanion(
      id: Value(id),
      onlineid: onlineid == null && nullToAbsent
          ? const Value.absent()
          : Value(onlineid),
      farm_name: farm_name == null && nullToAbsent
          ? const Value.absent()
          : Value(farm_name),
      farm_size: farm_size == null && nullToAbsent
          ? const Value.absent()
          : Value(farm_size),
      farmer_online_id: farmer_online_id == null && nullToAbsent
          ? const Value.absent()
          : Value(farmer_online_id),
      farmer:
          farmer == null && nullToAbsent ? const Value.absent() : Value(farmer),
      issettobeupdated: Value(issettobeupdated),
      deleted: Value(deleted),
    );
  }

  factory Mrfarm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Mrfarm(
      id: serializer.fromJson<int>(json['id']),
      onlineid: serializer.fromJson<int?>(json['onlineid']),
      farm_name: serializer.fromJson<String?>(json['farm_name']),
      farm_size: serializer.fromJson<String?>(json['farm_size']),
      farmer_online_id: serializer.fromJson<int?>(json['farmer_online_id']),
      farmer: serializer.fromJson<int?>(json['farmer']),
      issettobeupdated: serializer.fromJson<bool>(json['issettobeupdated']),
      deleted: serializer.fromJson<bool>(json['deleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'onlineid': serializer.toJson<int?>(onlineid),
      'farm_name': serializer.toJson<String?>(farm_name),
      'farm_size': serializer.toJson<String?>(farm_size),
      'farmer_online_id': serializer.toJson<int?>(farmer_online_id),
      'farmer': serializer.toJson<int?>(farmer),
      'issettobeupdated': serializer.toJson<bool>(issettobeupdated),
      'deleted': serializer.toJson<bool>(deleted),
    };
  }

  Mrfarm copyWith(
          {int? id,
          int? onlineid,
          String? farm_name,
          String? farm_size,
          int? farmer_online_id,
          int? farmer,
          bool? issettobeupdated,
          bool? deleted}) =>
      Mrfarm(
        id: id ?? this.id,
        onlineid: onlineid ?? this.onlineid,
        farm_name: farm_name ?? this.farm_name,
        farm_size: farm_size ?? this.farm_size,
        farmer_online_id: farmer_online_id ?? this.farmer_online_id,
        farmer: farmer ?? this.farmer,
        issettobeupdated: issettobeupdated ?? this.issettobeupdated,
        deleted: deleted ?? this.deleted,
      );
  @override
  String toString() {
    return (StringBuffer('Mrfarm(')
          ..write('id: $id, ')
          ..write('onlineid: $onlineid, ')
          ..write('farm_name: $farm_name, ')
          ..write('farm_size: $farm_size, ')
          ..write('farmer_online_id: $farmer_online_id, ')
          ..write('farmer: $farmer, ')
          ..write('issettobeupdated: $issettobeupdated, ')
          ..write('deleted: $deleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, onlineid, farm_name, farm_size,
      farmer_online_id, farmer, issettobeupdated, deleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Mrfarm &&
          other.id == this.id &&
          other.onlineid == this.onlineid &&
          other.farm_name == this.farm_name &&
          other.farm_size == this.farm_size &&
          other.farmer_online_id == this.farmer_online_id &&
          other.farmer == this.farmer &&
          other.issettobeupdated == this.issettobeupdated &&
          other.deleted == this.deleted);
}

class MrfarmsCompanion extends UpdateCompanion<Mrfarm> {
  final Value<int> id;
  final Value<int?> onlineid;
  final Value<String?> farm_name;
  final Value<String?> farm_size;
  final Value<int?> farmer_online_id;
  final Value<int?> farmer;
  final Value<bool> issettobeupdated;
  final Value<bool> deleted;
  const MrfarmsCompanion({
    this.id = const Value.absent(),
    this.onlineid = const Value.absent(),
    this.farm_name = const Value.absent(),
    this.farm_size = const Value.absent(),
    this.farmer_online_id = const Value.absent(),
    this.farmer = const Value.absent(),
    this.issettobeupdated = const Value.absent(),
    this.deleted = const Value.absent(),
  });
  MrfarmsCompanion.insert({
    this.id = const Value.absent(),
    this.onlineid = const Value.absent(),
    this.farm_name = const Value.absent(),
    this.farm_size = const Value.absent(),
    this.farmer_online_id = const Value.absent(),
    this.farmer = const Value.absent(),
    this.issettobeupdated = const Value.absent(),
    this.deleted = const Value.absent(),
  });
  static Insertable<Mrfarm> custom({
    Expression<int>? id,
    Expression<int?>? onlineid,
    Expression<String?>? farm_name,
    Expression<String?>? farm_size,
    Expression<int?>? farmer_online_id,
    Expression<int?>? farmer,
    Expression<bool>? issettobeupdated,
    Expression<bool>? deleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (onlineid != null) 'onlineid': onlineid,
      if (farm_name != null) 'farm_name': farm_name,
      if (farm_size != null) 'farm_size': farm_size,
      if (farmer_online_id != null) 'farmer_online_id': farmer_online_id,
      if (farmer != null) 'farmer': farmer,
      if (issettobeupdated != null) 'issettobeupdated': issettobeupdated,
      if (deleted != null) 'deleted': deleted,
    });
  }

  MrfarmsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? onlineid,
      Value<String?>? farm_name,
      Value<String?>? farm_size,
      Value<int?>? farmer_online_id,
      Value<int?>? farmer,
      Value<bool>? issettobeupdated,
      Value<bool>? deleted}) {
    return MrfarmsCompanion(
      id: id ?? this.id,
      onlineid: onlineid ?? this.onlineid,
      farm_name: farm_name ?? this.farm_name,
      farm_size: farm_size ?? this.farm_size,
      farmer_online_id: farmer_online_id ?? this.farmer_online_id,
      farmer: farmer ?? this.farmer,
      issettobeupdated: issettobeupdated ?? this.issettobeupdated,
      deleted: deleted ?? this.deleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (onlineid.present) {
      map['onlineid'] = Variable<int?>(onlineid.value);
    }
    if (farm_name.present) {
      map['farm_name'] = Variable<String?>(farm_name.value);
    }
    if (farm_size.present) {
      map['farm_size'] = Variable<String?>(farm_size.value);
    }
    if (farmer_online_id.present) {
      map['farmer_online_id'] = Variable<int?>(farmer_online_id.value);
    }
    if (farmer.present) {
      map['farmer'] = Variable<int?>(farmer.value);
    }
    if (issettobeupdated.present) {
      map['issettobeupdated'] = Variable<bool>(issettobeupdated.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MrfarmsCompanion(')
          ..write('id: $id, ')
          ..write('onlineid: $onlineid, ')
          ..write('farm_name: $farm_name, ')
          ..write('farm_size: $farm_size, ')
          ..write('farmer_online_id: $farmer_online_id, ')
          ..write('farmer: $farmer, ')
          ..write('issettobeupdated: $issettobeupdated, ')
          ..write('deleted: $deleted')
          ..write(')'))
        .toString();
  }
}

class $MrfarmsTable extends Mrfarms with TableInfo<$MrfarmsTable, Mrfarm> {
  final GeneratedDatabase _db;
  final String? _alias;
  $MrfarmsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _onlineidMeta = const VerificationMeta('onlineid');
  late final GeneratedColumn<int?> onlineid = GeneratedColumn<int?>(
      'onlineid', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _farm_nameMeta = const VerificationMeta('farm_name');
  late final GeneratedColumn<String?> farm_name = GeneratedColumn<String?>(
      'farm_name', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _farm_sizeMeta = const VerificationMeta('farm_size');
  late final GeneratedColumn<String?> farm_size = GeneratedColumn<String?>(
      'farm_size', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _farmer_online_idMeta =
      const VerificationMeta('farmer_online_id');
  late final GeneratedColumn<int?> farmer_online_id = GeneratedColumn<int?>(
      'farmer_online_id', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _farmerMeta = const VerificationMeta('farmer');
  late final GeneratedColumn<int?> farmer = GeneratedColumn<int?>(
      'farmer', aliasedName, true,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      $customConstraints: 'NULL REFERENCES mrfarmers(id)');
  final VerificationMeta _issettobeupdatedMeta =
      const VerificationMeta('issettobeupdated');
  late final GeneratedColumn<bool?> issettobeupdated = GeneratedColumn<bool?>(
      'issettobeupdated', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (issettobeupdated IN (0, 1))',
      defaultValue: Constant(false));
  final VerificationMeta _deletedMeta = const VerificationMeta('deleted');
  late final GeneratedColumn<bool?> deleted = GeneratedColumn<bool?>(
      'deleted', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (deleted IN (0, 1))',
      defaultValue: Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        onlineid,
        farm_name,
        farm_size,
        farmer_online_id,
        farmer,
        issettobeupdated,
        deleted
      ];
  @override
  String get aliasedName => _alias ?? 'mrfarms';
  @override
  String get actualTableName => 'mrfarms';
  @override
  VerificationContext validateIntegrity(Insertable<Mrfarm> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('onlineid')) {
      context.handle(_onlineidMeta,
          onlineid.isAcceptableOrUnknown(data['onlineid']!, _onlineidMeta));
    }
    if (data.containsKey('farm_name')) {
      context.handle(_farm_nameMeta,
          farm_name.isAcceptableOrUnknown(data['farm_name']!, _farm_nameMeta));
    }
    if (data.containsKey('farm_size')) {
      context.handle(_farm_sizeMeta,
          farm_size.isAcceptableOrUnknown(data['farm_size']!, _farm_sizeMeta));
    }
    if (data.containsKey('farmer_online_id')) {
      context.handle(
          _farmer_online_idMeta,
          farmer_online_id.isAcceptableOrUnknown(
              data['farmer_online_id']!, _farmer_online_idMeta));
    }
    if (data.containsKey('farmer')) {
      context.handle(_farmerMeta,
          farmer.isAcceptableOrUnknown(data['farmer']!, _farmerMeta));
    }
    if (data.containsKey('issettobeupdated')) {
      context.handle(
          _issettobeupdatedMeta,
          issettobeupdated.isAcceptableOrUnknown(
              data['issettobeupdated']!, _issettobeupdatedMeta));
    }
    if (data.containsKey('deleted')) {
      context.handle(_deletedMeta,
          deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Mrfarm map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Mrfarm.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MrfarmsTable createAlias(String alias) {
    return $MrfarmsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  _$AppDatabase.connect(DatabaseConnection c) : super.connect(c);
  late final $MrfarmersTable mrfarmers = $MrfarmersTable(this);
  late final $MrfarmsTable mrfarms = $MrfarmsTable(this);
  late final MrfarmerDao mrfarmerDao = MrfarmerDao(this as AppDatabase);
  late final MrfarmDao mrfarmDao = MrfarmDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [mrfarmers, mrfarms];
}
