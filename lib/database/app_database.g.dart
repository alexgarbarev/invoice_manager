// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DbContractorsTable extends DbContractors
    with TableInfo<$DbContractorsTable, DbContractor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbContractorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _abbrMeta = const VerificationMeta('abbr');
  @override
  late final GeneratedColumn<String> abbr = GeneratedColumn<String>(
    'abbr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _paymentInfoMeta = const VerificationMeta(
    'paymentInfo',
  );
  @override
  late final GeneratedColumn<String> paymentInfo = GeneratedColumn<String>(
    'payment_info',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contractorInfoMeta = const VerificationMeta(
    'contractorInfo',
  );
  @override
  late final GeneratedColumn<String> contractorInfo = GeneratedColumn<String>(
    'contractor_info',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _signatureMeta = const VerificationMeta(
    'signature',
  );
  @override
  late final GeneratedColumn<Uint8List> signature = GeneratedColumn<Uint8List>(
    'signature',
    aliasedName,
    true,
    type: DriftSqlType.blob,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    abbr,
    fullName,
    paymentInfo,
    contractorInfo,
    signature,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_contractors';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbContractor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('abbr')) {
      context.handle(
        _abbrMeta,
        abbr.isAcceptableOrUnknown(data['abbr']!, _abbrMeta),
      );
    } else if (isInserting) {
      context.missing(_abbrMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('payment_info')) {
      context.handle(
        _paymentInfoMeta,
        paymentInfo.isAcceptableOrUnknown(
          data['payment_info']!,
          _paymentInfoMeta,
        ),
      );
    }
    if (data.containsKey('contractor_info')) {
      context.handle(
        _contractorInfoMeta,
        contractorInfo.isAcceptableOrUnknown(
          data['contractor_info']!,
          _contractorInfoMeta,
        ),
      );
    }
    if (data.containsKey('signature')) {
      context.handle(
        _signatureMeta,
        signature.isAcceptableOrUnknown(data['signature']!, _signatureMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbContractor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbContractor(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      abbr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}abbr'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      paymentInfo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_info'],
      ),
      contractorInfo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contractor_info'],
      ),
      signature: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}signature'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DbContractorsTable createAlias(String alias) {
    return $DbContractorsTable(attachedDatabase, alias);
  }
}

class DbContractor extends DataClass implements Insertable<DbContractor> {
  final String id;
  final String abbr;
  final String fullName;
  final String? paymentInfo;
  final String? contractorInfo;
  final Uint8List? signature;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DbContractor({
    required this.id,
    required this.abbr,
    required this.fullName,
    this.paymentInfo,
    this.contractorInfo,
    this.signature,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['abbr'] = Variable<String>(abbr);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || paymentInfo != null) {
      map['payment_info'] = Variable<String>(paymentInfo);
    }
    if (!nullToAbsent || contractorInfo != null) {
      map['contractor_info'] = Variable<String>(contractorInfo);
    }
    if (!nullToAbsent || signature != null) {
      map['signature'] = Variable<Uint8List>(signature);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DbContractorsCompanion toCompanion(bool nullToAbsent) {
    return DbContractorsCompanion(
      id: Value(id),
      abbr: Value(abbr),
      fullName: Value(fullName),
      paymentInfo: paymentInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentInfo),
      contractorInfo: contractorInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(contractorInfo),
      signature: signature == null && nullToAbsent
          ? const Value.absent()
          : Value(signature),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DbContractor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbContractor(
      id: serializer.fromJson<String>(json['id']),
      abbr: serializer.fromJson<String>(json['abbr']),
      fullName: serializer.fromJson<String>(json['fullName']),
      paymentInfo: serializer.fromJson<String?>(json['paymentInfo']),
      contractorInfo: serializer.fromJson<String?>(json['contractorInfo']),
      signature: serializer.fromJson<Uint8List?>(json['signature']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'abbr': serializer.toJson<String>(abbr),
      'fullName': serializer.toJson<String>(fullName),
      'paymentInfo': serializer.toJson<String?>(paymentInfo),
      'contractorInfo': serializer.toJson<String?>(contractorInfo),
      'signature': serializer.toJson<Uint8List?>(signature),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DbContractor copyWith({
    String? id,
    String? abbr,
    String? fullName,
    Value<String?> paymentInfo = const Value.absent(),
    Value<String?> contractorInfo = const Value.absent(),
    Value<Uint8List?> signature = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => DbContractor(
    id: id ?? this.id,
    abbr: abbr ?? this.abbr,
    fullName: fullName ?? this.fullName,
    paymentInfo: paymentInfo.present ? paymentInfo.value : this.paymentInfo,
    contractorInfo: contractorInfo.present
        ? contractorInfo.value
        : this.contractorInfo,
    signature: signature.present ? signature.value : this.signature,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DbContractor copyWithCompanion(DbContractorsCompanion data) {
    return DbContractor(
      id: data.id.present ? data.id.value : this.id,
      abbr: data.abbr.present ? data.abbr.value : this.abbr,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      paymentInfo: data.paymentInfo.present
          ? data.paymentInfo.value
          : this.paymentInfo,
      contractorInfo: data.contractorInfo.present
          ? data.contractorInfo.value
          : this.contractorInfo,
      signature: data.signature.present ? data.signature.value : this.signature,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbContractor(')
          ..write('id: $id, ')
          ..write('abbr: $abbr, ')
          ..write('fullName: $fullName, ')
          ..write('paymentInfo: $paymentInfo, ')
          ..write('contractorInfo: $contractorInfo, ')
          ..write('signature: $signature, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    abbr,
    fullName,
    paymentInfo,
    contractorInfo,
    $driftBlobEquality.hash(signature),
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbContractor &&
          other.id == this.id &&
          other.abbr == this.abbr &&
          other.fullName == this.fullName &&
          other.paymentInfo == this.paymentInfo &&
          other.contractorInfo == this.contractorInfo &&
          $driftBlobEquality.equals(other.signature, this.signature) &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DbContractorsCompanion extends UpdateCompanion<DbContractor> {
  final Value<String> id;
  final Value<String> abbr;
  final Value<String> fullName;
  final Value<String?> paymentInfo;
  final Value<String?> contractorInfo;
  final Value<Uint8List?> signature;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DbContractorsCompanion({
    this.id = const Value.absent(),
    this.abbr = const Value.absent(),
    this.fullName = const Value.absent(),
    this.paymentInfo = const Value.absent(),
    this.contractorInfo = const Value.absent(),
    this.signature = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DbContractorsCompanion.insert({
    required String id,
    required String abbr,
    required String fullName,
    this.paymentInfo = const Value.absent(),
    this.contractorInfo = const Value.absent(),
    this.signature = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       abbr = Value(abbr),
       fullName = Value(fullName),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<DbContractor> custom({
    Expression<String>? id,
    Expression<String>? abbr,
    Expression<String>? fullName,
    Expression<String>? paymentInfo,
    Expression<String>? contractorInfo,
    Expression<Uint8List>? signature,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (abbr != null) 'abbr': abbr,
      if (fullName != null) 'full_name': fullName,
      if (paymentInfo != null) 'payment_info': paymentInfo,
      if (contractorInfo != null) 'contractor_info': contractorInfo,
      if (signature != null) 'signature': signature,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DbContractorsCompanion copyWith({
    Value<String>? id,
    Value<String>? abbr,
    Value<String>? fullName,
    Value<String?>? paymentInfo,
    Value<String?>? contractorInfo,
    Value<Uint8List?>? signature,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DbContractorsCompanion(
      id: id ?? this.id,
      abbr: abbr ?? this.abbr,
      fullName: fullName ?? this.fullName,
      paymentInfo: paymentInfo ?? this.paymentInfo,
      contractorInfo: contractorInfo ?? this.contractorInfo,
      signature: signature ?? this.signature,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (abbr.present) {
      map['abbr'] = Variable<String>(abbr.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (paymentInfo.present) {
      map['payment_info'] = Variable<String>(paymentInfo.value);
    }
    if (contractorInfo.present) {
      map['contractor_info'] = Variable<String>(contractorInfo.value);
    }
    if (signature.present) {
      map['signature'] = Variable<Uint8List>(signature.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbContractorsCompanion(')
          ..write('id: $id, ')
          ..write('abbr: $abbr, ')
          ..write('fullName: $fullName, ')
          ..write('paymentInfo: $paymentInfo, ')
          ..write('contractorInfo: $contractorInfo, ')
          ..write('signature: $signature, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DbCompaniesTable extends DbCompanies
    with TableInfo<$DbCompaniesTable, DbCompany> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbCompaniesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _abbrMeta = const VerificationMeta('abbr');
  @override
  late final GeneratedColumn<String> abbr = GeneratedColumn<String>(
    'abbr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentWeeksMeta = const VerificationMeta(
    'paymentWeeks',
  );
  @override
  late final GeneratedColumn<int> paymentWeeks = GeneratedColumn<int>(
    'payment_weeks',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _currencyPrefixMeta = const VerificationMeta(
    'currencyPrefix',
  );
  @override
  late final GeneratedColumn<String> currencyPrefix = GeneratedColumn<String>(
    'currency_prefix',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _companyInfoMeta = const VerificationMeta(
    'companyInfo',
  );
  @override
  late final GeneratedColumn<String> companyInfo = GeneratedColumn<String>(
    'company_info',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    abbr,
    paymentWeeks,
    currencyPrefix,
    companyInfo,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_companies';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbCompany> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('abbr')) {
      context.handle(
        _abbrMeta,
        abbr.isAcceptableOrUnknown(data['abbr']!, _abbrMeta),
      );
    } else if (isInserting) {
      context.missing(_abbrMeta);
    }
    if (data.containsKey('payment_weeks')) {
      context.handle(
        _paymentWeeksMeta,
        paymentWeeks.isAcceptableOrUnknown(
          data['payment_weeks']!,
          _paymentWeeksMeta,
        ),
      );
    }
    if (data.containsKey('currency_prefix')) {
      context.handle(
        _currencyPrefixMeta,
        currencyPrefix.isAcceptableOrUnknown(
          data['currency_prefix']!,
          _currencyPrefixMeta,
        ),
      );
    }
    if (data.containsKey('company_info')) {
      context.handle(
        _companyInfoMeta,
        companyInfo.isAcceptableOrUnknown(
          data['company_info']!,
          _companyInfoMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbCompany map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbCompany(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      abbr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}abbr'],
      )!,
      paymentWeeks: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payment_weeks'],
      )!,
      currencyPrefix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_prefix'],
      ),
      companyInfo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_info'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DbCompaniesTable createAlias(String alias) {
    return $DbCompaniesTable(attachedDatabase, alias);
  }
}

class DbCompany extends DataClass implements Insertable<DbCompany> {
  final String id;
  final String name;
  final String abbr;
  final int paymentWeeks;
  final String? currencyPrefix;
  final String? companyInfo;
  final DateTime updatedAt;
  const DbCompany({
    required this.id,
    required this.name,
    required this.abbr,
    required this.paymentWeeks,
    this.currencyPrefix,
    this.companyInfo,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['abbr'] = Variable<String>(abbr);
    map['payment_weeks'] = Variable<int>(paymentWeeks);
    if (!nullToAbsent || currencyPrefix != null) {
      map['currency_prefix'] = Variable<String>(currencyPrefix);
    }
    if (!nullToAbsent || companyInfo != null) {
      map['company_info'] = Variable<String>(companyInfo);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DbCompaniesCompanion toCompanion(bool nullToAbsent) {
    return DbCompaniesCompanion(
      id: Value(id),
      name: Value(name),
      abbr: Value(abbr),
      paymentWeeks: Value(paymentWeeks),
      currencyPrefix: currencyPrefix == null && nullToAbsent
          ? const Value.absent()
          : Value(currencyPrefix),
      companyInfo: companyInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(companyInfo),
      updatedAt: Value(updatedAt),
    );
  }

  factory DbCompany.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbCompany(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      abbr: serializer.fromJson<String>(json['abbr']),
      paymentWeeks: serializer.fromJson<int>(json['paymentWeeks']),
      currencyPrefix: serializer.fromJson<String?>(json['currencyPrefix']),
      companyInfo: serializer.fromJson<String?>(json['companyInfo']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'abbr': serializer.toJson<String>(abbr),
      'paymentWeeks': serializer.toJson<int>(paymentWeeks),
      'currencyPrefix': serializer.toJson<String?>(currencyPrefix),
      'companyInfo': serializer.toJson<String?>(companyInfo),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DbCompany copyWith({
    String? id,
    String? name,
    String? abbr,
    int? paymentWeeks,
    Value<String?> currencyPrefix = const Value.absent(),
    Value<String?> companyInfo = const Value.absent(),
    DateTime? updatedAt,
  }) => DbCompany(
    id: id ?? this.id,
    name: name ?? this.name,
    abbr: abbr ?? this.abbr,
    paymentWeeks: paymentWeeks ?? this.paymentWeeks,
    currencyPrefix: currencyPrefix.present
        ? currencyPrefix.value
        : this.currencyPrefix,
    companyInfo: companyInfo.present ? companyInfo.value : this.companyInfo,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DbCompany copyWithCompanion(DbCompaniesCompanion data) {
    return DbCompany(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      abbr: data.abbr.present ? data.abbr.value : this.abbr,
      paymentWeeks: data.paymentWeeks.present
          ? data.paymentWeeks.value
          : this.paymentWeeks,
      currencyPrefix: data.currencyPrefix.present
          ? data.currencyPrefix.value
          : this.currencyPrefix,
      companyInfo: data.companyInfo.present
          ? data.companyInfo.value
          : this.companyInfo,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbCompany(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('abbr: $abbr, ')
          ..write('paymentWeeks: $paymentWeeks, ')
          ..write('currencyPrefix: $currencyPrefix, ')
          ..write('companyInfo: $companyInfo, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    abbr,
    paymentWeeks,
    currencyPrefix,
    companyInfo,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbCompany &&
          other.id == this.id &&
          other.name == this.name &&
          other.abbr == this.abbr &&
          other.paymentWeeks == this.paymentWeeks &&
          other.currencyPrefix == this.currencyPrefix &&
          other.companyInfo == this.companyInfo &&
          other.updatedAt == this.updatedAt);
}

class DbCompaniesCompanion extends UpdateCompanion<DbCompany> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> abbr;
  final Value<int> paymentWeeks;
  final Value<String?> currencyPrefix;
  final Value<String?> companyInfo;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DbCompaniesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.abbr = const Value.absent(),
    this.paymentWeeks = const Value.absent(),
    this.currencyPrefix = const Value.absent(),
    this.companyInfo = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DbCompaniesCompanion.insert({
    required String id,
    required String name,
    required String abbr,
    this.paymentWeeks = const Value.absent(),
    this.currencyPrefix = const Value.absent(),
    this.companyInfo = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       abbr = Value(abbr),
       updatedAt = Value(updatedAt);
  static Insertable<DbCompany> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? abbr,
    Expression<int>? paymentWeeks,
    Expression<String>? currencyPrefix,
    Expression<String>? companyInfo,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (abbr != null) 'abbr': abbr,
      if (paymentWeeks != null) 'payment_weeks': paymentWeeks,
      if (currencyPrefix != null) 'currency_prefix': currencyPrefix,
      if (companyInfo != null) 'company_info': companyInfo,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DbCompaniesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? abbr,
    Value<int>? paymentWeeks,
    Value<String?>? currencyPrefix,
    Value<String?>? companyInfo,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DbCompaniesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      abbr: abbr ?? this.abbr,
      paymentWeeks: paymentWeeks ?? this.paymentWeeks,
      currencyPrefix: currencyPrefix ?? this.currencyPrefix,
      companyInfo: companyInfo ?? this.companyInfo,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (abbr.present) {
      map['abbr'] = Variable<String>(abbr.value);
    }
    if (paymentWeeks.present) {
      map['payment_weeks'] = Variable<int>(paymentWeeks.value);
    }
    if (currencyPrefix.present) {
      map['currency_prefix'] = Variable<String>(currencyPrefix.value);
    }
    if (companyInfo.present) {
      map['company_info'] = Variable<String>(companyInfo.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbCompaniesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('abbr: $abbr, ')
          ..write('paymentWeeks: $paymentWeeks, ')
          ..write('currencyPrefix: $currencyPrefix, ')
          ..write('companyInfo: $companyInfo, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DbContractsTable extends DbContracts
    with TableInfo<$DbContractsTable, DbContract> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbContractsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contractorIdMeta = const VerificationMeta(
    'contractorId',
  );
  @override
  late final GeneratedColumn<String> contractorId = GeneratedColumn<String>(
    'contractor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<String> companyId = GeneratedColumn<String>(
    'company_id',
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
  static const VerificationMeta _fixedMeta = const VerificationMeta('fixed');
  @override
  late final GeneratedColumn<bool> fixed = GeneratedColumn<bool>(
    'fixed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("fixed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _defaultPriceMeta = const VerificationMeta(
    'defaultPrice',
  );
  @override
  late final GeneratedColumn<double> defaultPrice = GeneratedColumn<double>(
    'default_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _showPeriodMeta = const VerificationMeta(
    'showPeriod',
  );
  @override
  late final GeneratedColumn<bool> showPeriod = GeneratedColumn<bool>(
    'show_period',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_period" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _qtyLabelMeta = const VerificationMeta(
    'qtyLabel',
  );
  @override
  late final GeneratedColumn<String> qtyLabel = GeneratedColumn<String>(
    'qty_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceLabelMeta = const VerificationMeta(
    'priceLabel',
  );
  @override
  late final GeneratedColumn<String> priceLabel = GeneratedColumn<String>(
    'price_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionLabelMeta = const VerificationMeta(
    'descriptionLabel',
  );
  @override
  late final GeneratedColumn<String> descriptionLabel = GeneratedColumn<String>(
    'description_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountLabelMeta = const VerificationMeta(
    'amountLabel',
  );
  @override
  late final GeneratedColumn<String> amountLabel = GeneratedColumn<String>(
    'amount_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _periodLabelMeta = const VerificationMeta(
    'periodLabel',
  );
  @override
  late final GeneratedColumn<String> periodLabel = GeneratedColumn<String>(
    'period_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalLabelMeta = const VerificationMeta(
    'totalLabel',
  );
  @override
  late final GeneratedColumn<String> totalLabel = GeneratedColumn<String>(
    'total_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueDateLabelMeta = const VerificationMeta(
    'dueDateLabel',
  );
  @override
  late final GeneratedColumn<String> dueDateLabel = GeneratedColumn<String>(
    'due_date_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateLabelMeta = const VerificationMeta(
    'dateLabel',
  );
  @override
  late final GeneratedColumn<String> dateLabel = GeneratedColumn<String>(
    'date_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _invoiceIdLblMeta = const VerificationMeta(
    'invoiceIdLbl',
  );
  @override
  late final GeneratedColumn<String> invoiceIdLbl = GeneratedColumn<String>(
    'invoice_id_lbl',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _invoiceTitleMeta = const VerificationMeta(
    'invoiceTitle',
  );
  @override
  late final GeneratedColumn<String> invoiceTitle = GeneratedColumn<String>(
    'invoice_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contractorRoleSublabelMeta =
      const VerificationMeta('contractorRoleSublabel');
  @override
  late final GeneratedColumn<String> contractorRoleSublabel =
      GeneratedColumn<String>(
        'contractor_role_sublabel',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _footnoteMeta = const VerificationMeta(
    'footnote',
  );
  @override
  late final GeneratedColumn<String> footnote = GeneratedColumn<String>(
    'footnote',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contractorAgreementLabelMeta =
      const VerificationMeta('contractorAgreementLabel');
  @override
  late final GeneratedColumn<String> contractorAgreementLabel =
      GeneratedColumn<String>(
        'contractor_agreement_label',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
    'locale',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    contractorId,
    companyId,
    date,
    fixed,
    defaultPrice,
    showPeriod,
    qtyLabel,
    priceLabel,
    descriptionLabel,
    amountLabel,
    periodLabel,
    totalLabel,
    dueDateLabel,
    dateLabel,
    invoiceIdLbl,
    invoiceTitle,
    description,
    contractorRoleSublabel,
    footnote,
    contractorAgreementLabel,
    locale,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_contracts';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbContract> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('contractor_id')) {
      context.handle(
        _contractorIdMeta,
        contractorId.isAcceptableOrUnknown(
          data['contractor_id']!,
          _contractorIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contractorIdMeta);
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('fixed')) {
      context.handle(
        _fixedMeta,
        fixed.isAcceptableOrUnknown(data['fixed']!, _fixedMeta),
      );
    }
    if (data.containsKey('default_price')) {
      context.handle(
        _defaultPriceMeta,
        defaultPrice.isAcceptableOrUnknown(
          data['default_price']!,
          _defaultPriceMeta,
        ),
      );
    }
    if (data.containsKey('show_period')) {
      context.handle(
        _showPeriodMeta,
        showPeriod.isAcceptableOrUnknown(data['show_period']!, _showPeriodMeta),
      );
    }
    if (data.containsKey('qty_label')) {
      context.handle(
        _qtyLabelMeta,
        qtyLabel.isAcceptableOrUnknown(data['qty_label']!, _qtyLabelMeta),
      );
    }
    if (data.containsKey('price_label')) {
      context.handle(
        _priceLabelMeta,
        priceLabel.isAcceptableOrUnknown(data['price_label']!, _priceLabelMeta),
      );
    }
    if (data.containsKey('description_label')) {
      context.handle(
        _descriptionLabelMeta,
        descriptionLabel.isAcceptableOrUnknown(
          data['description_label']!,
          _descriptionLabelMeta,
        ),
      );
    }
    if (data.containsKey('amount_label')) {
      context.handle(
        _amountLabelMeta,
        amountLabel.isAcceptableOrUnknown(
          data['amount_label']!,
          _amountLabelMeta,
        ),
      );
    }
    if (data.containsKey('period_label')) {
      context.handle(
        _periodLabelMeta,
        periodLabel.isAcceptableOrUnknown(
          data['period_label']!,
          _periodLabelMeta,
        ),
      );
    }
    if (data.containsKey('total_label')) {
      context.handle(
        _totalLabelMeta,
        totalLabel.isAcceptableOrUnknown(data['total_label']!, _totalLabelMeta),
      );
    }
    if (data.containsKey('due_date_label')) {
      context.handle(
        _dueDateLabelMeta,
        dueDateLabel.isAcceptableOrUnknown(
          data['due_date_label']!,
          _dueDateLabelMeta,
        ),
      );
    }
    if (data.containsKey('date_label')) {
      context.handle(
        _dateLabelMeta,
        dateLabel.isAcceptableOrUnknown(data['date_label']!, _dateLabelMeta),
      );
    }
    if (data.containsKey('invoice_id_lbl')) {
      context.handle(
        _invoiceIdLblMeta,
        invoiceIdLbl.isAcceptableOrUnknown(
          data['invoice_id_lbl']!,
          _invoiceIdLblMeta,
        ),
      );
    }
    if (data.containsKey('invoice_title')) {
      context.handle(
        _invoiceTitleMeta,
        invoiceTitle.isAcceptableOrUnknown(
          data['invoice_title']!,
          _invoiceTitleMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('contractor_role_sublabel')) {
      context.handle(
        _contractorRoleSublabelMeta,
        contractorRoleSublabel.isAcceptableOrUnknown(
          data['contractor_role_sublabel']!,
          _contractorRoleSublabelMeta,
        ),
      );
    }
    if (data.containsKey('footnote')) {
      context.handle(
        _footnoteMeta,
        footnote.isAcceptableOrUnknown(data['footnote']!, _footnoteMeta),
      );
    }
    if (data.containsKey('contractor_agreement_label')) {
      context.handle(
        _contractorAgreementLabelMeta,
        contractorAgreementLabel.isAcceptableOrUnknown(
          data['contractor_agreement_label']!,
          _contractorAgreementLabelMeta,
        ),
      );
    }
    if (data.containsKey('locale')) {
      context.handle(
        _localeMeta,
        locale.isAcceptableOrUnknown(data['locale']!, _localeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbContract map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbContract(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      contractorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contractor_id'],
      )!,
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      fixed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}fixed'],
      )!,
      defaultPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_price'],
      ),
      showPeriod: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_period'],
      )!,
      qtyLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qty_label'],
      ),
      priceLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}price_label'],
      ),
      descriptionLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_label'],
      ),
      amountLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}amount_label'],
      ),
      periodLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period_label'],
      ),
      totalLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}total_label'],
      ),
      dueDateLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}due_date_label'],
      ),
      dateLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_label'],
      ),
      invoiceIdLbl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id_lbl'],
      ),
      invoiceTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_title'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      contractorRoleSublabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contractor_role_sublabel'],
      ),
      footnote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}footnote'],
      ),
      contractorAgreementLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contractor_agreement_label'],
      ),
      locale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale'],
      ),
    );
  }

  @override
  $DbContractsTable createAlias(String alias) {
    return $DbContractsTable(attachedDatabase, alias);
  }
}

class DbContract extends DataClass implements Insertable<DbContract> {
  final String id;
  final String contractorId;
  final String companyId;
  final DateTime date;
  final bool fixed;
  final double? defaultPrice;
  final bool showPeriod;
  final String? qtyLabel;
  final String? priceLabel;
  final String? descriptionLabel;
  final String? amountLabel;
  final String? periodLabel;
  final String? totalLabel;
  final String? dueDateLabel;
  final String? dateLabel;
  final String? invoiceIdLbl;
  final String? invoiceTitle;
  final String? description;
  final String? contractorRoleSublabel;
  final String? footnote;
  final String? contractorAgreementLabel;
  final String? locale;
  const DbContract({
    required this.id,
    required this.contractorId,
    required this.companyId,
    required this.date,
    required this.fixed,
    this.defaultPrice,
    required this.showPeriod,
    this.qtyLabel,
    this.priceLabel,
    this.descriptionLabel,
    this.amountLabel,
    this.periodLabel,
    this.totalLabel,
    this.dueDateLabel,
    this.dateLabel,
    this.invoiceIdLbl,
    this.invoiceTitle,
    this.description,
    this.contractorRoleSublabel,
    this.footnote,
    this.contractorAgreementLabel,
    this.locale,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['contractor_id'] = Variable<String>(contractorId);
    map['company_id'] = Variable<String>(companyId);
    map['date'] = Variable<DateTime>(date);
    map['fixed'] = Variable<bool>(fixed);
    if (!nullToAbsent || defaultPrice != null) {
      map['default_price'] = Variable<double>(defaultPrice);
    }
    map['show_period'] = Variable<bool>(showPeriod);
    if (!nullToAbsent || qtyLabel != null) {
      map['qty_label'] = Variable<String>(qtyLabel);
    }
    if (!nullToAbsent || priceLabel != null) {
      map['price_label'] = Variable<String>(priceLabel);
    }
    if (!nullToAbsent || descriptionLabel != null) {
      map['description_label'] = Variable<String>(descriptionLabel);
    }
    if (!nullToAbsent || amountLabel != null) {
      map['amount_label'] = Variable<String>(amountLabel);
    }
    if (!nullToAbsent || periodLabel != null) {
      map['period_label'] = Variable<String>(periodLabel);
    }
    if (!nullToAbsent || totalLabel != null) {
      map['total_label'] = Variable<String>(totalLabel);
    }
    if (!nullToAbsent || dueDateLabel != null) {
      map['due_date_label'] = Variable<String>(dueDateLabel);
    }
    if (!nullToAbsent || dateLabel != null) {
      map['date_label'] = Variable<String>(dateLabel);
    }
    if (!nullToAbsent || invoiceIdLbl != null) {
      map['invoice_id_lbl'] = Variable<String>(invoiceIdLbl);
    }
    if (!nullToAbsent || invoiceTitle != null) {
      map['invoice_title'] = Variable<String>(invoiceTitle);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || contractorRoleSublabel != null) {
      map['contractor_role_sublabel'] = Variable<String>(
        contractorRoleSublabel,
      );
    }
    if (!nullToAbsent || footnote != null) {
      map['footnote'] = Variable<String>(footnote);
    }
    if (!nullToAbsent || contractorAgreementLabel != null) {
      map['contractor_agreement_label'] = Variable<String>(
        contractorAgreementLabel,
      );
    }
    if (!nullToAbsent || locale != null) {
      map['locale'] = Variable<String>(locale);
    }
    return map;
  }

  DbContractsCompanion toCompanion(bool nullToAbsent) {
    return DbContractsCompanion(
      id: Value(id),
      contractorId: Value(contractorId),
      companyId: Value(companyId),
      date: Value(date),
      fixed: Value(fixed),
      defaultPrice: defaultPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultPrice),
      showPeriod: Value(showPeriod),
      qtyLabel: qtyLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(qtyLabel),
      priceLabel: priceLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(priceLabel),
      descriptionLabel: descriptionLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionLabel),
      amountLabel: amountLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(amountLabel),
      periodLabel: periodLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(periodLabel),
      totalLabel: totalLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(totalLabel),
      dueDateLabel: dueDateLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDateLabel),
      dateLabel: dateLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(dateLabel),
      invoiceIdLbl: invoiceIdLbl == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceIdLbl),
      invoiceTitle: invoiceTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceTitle),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      contractorRoleSublabel: contractorRoleSublabel == null && nullToAbsent
          ? const Value.absent()
          : Value(contractorRoleSublabel),
      footnote: footnote == null && nullToAbsent
          ? const Value.absent()
          : Value(footnote),
      contractorAgreementLabel: contractorAgreementLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(contractorAgreementLabel),
      locale: locale == null && nullToAbsent
          ? const Value.absent()
          : Value(locale),
    );
  }

  factory DbContract.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbContract(
      id: serializer.fromJson<String>(json['id']),
      contractorId: serializer.fromJson<String>(json['contractorId']),
      companyId: serializer.fromJson<String>(json['companyId']),
      date: serializer.fromJson<DateTime>(json['date']),
      fixed: serializer.fromJson<bool>(json['fixed']),
      defaultPrice: serializer.fromJson<double?>(json['defaultPrice']),
      showPeriod: serializer.fromJson<bool>(json['showPeriod']),
      qtyLabel: serializer.fromJson<String?>(json['qtyLabel']),
      priceLabel: serializer.fromJson<String?>(json['priceLabel']),
      descriptionLabel: serializer.fromJson<String?>(json['descriptionLabel']),
      amountLabel: serializer.fromJson<String?>(json['amountLabel']),
      periodLabel: serializer.fromJson<String?>(json['periodLabel']),
      totalLabel: serializer.fromJson<String?>(json['totalLabel']),
      dueDateLabel: serializer.fromJson<String?>(json['dueDateLabel']),
      dateLabel: serializer.fromJson<String?>(json['dateLabel']),
      invoiceIdLbl: serializer.fromJson<String?>(json['invoiceIdLbl']),
      invoiceTitle: serializer.fromJson<String?>(json['invoiceTitle']),
      description: serializer.fromJson<String?>(json['description']),
      contractorRoleSublabel: serializer.fromJson<String?>(
        json['contractorRoleSublabel'],
      ),
      footnote: serializer.fromJson<String?>(json['footnote']),
      contractorAgreementLabel: serializer.fromJson<String?>(
        json['contractorAgreementLabel'],
      ),
      locale: serializer.fromJson<String?>(json['locale']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'contractorId': serializer.toJson<String>(contractorId),
      'companyId': serializer.toJson<String>(companyId),
      'date': serializer.toJson<DateTime>(date),
      'fixed': serializer.toJson<bool>(fixed),
      'defaultPrice': serializer.toJson<double?>(defaultPrice),
      'showPeriod': serializer.toJson<bool>(showPeriod),
      'qtyLabel': serializer.toJson<String?>(qtyLabel),
      'priceLabel': serializer.toJson<String?>(priceLabel),
      'descriptionLabel': serializer.toJson<String?>(descriptionLabel),
      'amountLabel': serializer.toJson<String?>(amountLabel),
      'periodLabel': serializer.toJson<String?>(periodLabel),
      'totalLabel': serializer.toJson<String?>(totalLabel),
      'dueDateLabel': serializer.toJson<String?>(dueDateLabel),
      'dateLabel': serializer.toJson<String?>(dateLabel),
      'invoiceIdLbl': serializer.toJson<String?>(invoiceIdLbl),
      'invoiceTitle': serializer.toJson<String?>(invoiceTitle),
      'description': serializer.toJson<String?>(description),
      'contractorRoleSublabel': serializer.toJson<String?>(
        contractorRoleSublabel,
      ),
      'footnote': serializer.toJson<String?>(footnote),
      'contractorAgreementLabel': serializer.toJson<String?>(
        contractorAgreementLabel,
      ),
      'locale': serializer.toJson<String?>(locale),
    };
  }

  DbContract copyWith({
    String? id,
    String? contractorId,
    String? companyId,
    DateTime? date,
    bool? fixed,
    Value<double?> defaultPrice = const Value.absent(),
    bool? showPeriod,
    Value<String?> qtyLabel = const Value.absent(),
    Value<String?> priceLabel = const Value.absent(),
    Value<String?> descriptionLabel = const Value.absent(),
    Value<String?> amountLabel = const Value.absent(),
    Value<String?> periodLabel = const Value.absent(),
    Value<String?> totalLabel = const Value.absent(),
    Value<String?> dueDateLabel = const Value.absent(),
    Value<String?> dateLabel = const Value.absent(),
    Value<String?> invoiceIdLbl = const Value.absent(),
    Value<String?> invoiceTitle = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> contractorRoleSublabel = const Value.absent(),
    Value<String?> footnote = const Value.absent(),
    Value<String?> contractorAgreementLabel = const Value.absent(),
    Value<String?> locale = const Value.absent(),
  }) => DbContract(
    id: id ?? this.id,
    contractorId: contractorId ?? this.contractorId,
    companyId: companyId ?? this.companyId,
    date: date ?? this.date,
    fixed: fixed ?? this.fixed,
    defaultPrice: defaultPrice.present ? defaultPrice.value : this.defaultPrice,
    showPeriod: showPeriod ?? this.showPeriod,
    qtyLabel: qtyLabel.present ? qtyLabel.value : this.qtyLabel,
    priceLabel: priceLabel.present ? priceLabel.value : this.priceLabel,
    descriptionLabel: descriptionLabel.present
        ? descriptionLabel.value
        : this.descriptionLabel,
    amountLabel: amountLabel.present ? amountLabel.value : this.amountLabel,
    periodLabel: periodLabel.present ? periodLabel.value : this.periodLabel,
    totalLabel: totalLabel.present ? totalLabel.value : this.totalLabel,
    dueDateLabel: dueDateLabel.present ? dueDateLabel.value : this.dueDateLabel,
    dateLabel: dateLabel.present ? dateLabel.value : this.dateLabel,
    invoiceIdLbl: invoiceIdLbl.present ? invoiceIdLbl.value : this.invoiceIdLbl,
    invoiceTitle: invoiceTitle.present ? invoiceTitle.value : this.invoiceTitle,
    description: description.present ? description.value : this.description,
    contractorRoleSublabel: contractorRoleSublabel.present
        ? contractorRoleSublabel.value
        : this.contractorRoleSublabel,
    footnote: footnote.present ? footnote.value : this.footnote,
    contractorAgreementLabel: contractorAgreementLabel.present
        ? contractorAgreementLabel.value
        : this.contractorAgreementLabel,
    locale: locale.present ? locale.value : this.locale,
  );
  DbContract copyWithCompanion(DbContractsCompanion data) {
    return DbContract(
      id: data.id.present ? data.id.value : this.id,
      contractorId: data.contractorId.present
          ? data.contractorId.value
          : this.contractorId,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      date: data.date.present ? data.date.value : this.date,
      fixed: data.fixed.present ? data.fixed.value : this.fixed,
      defaultPrice: data.defaultPrice.present
          ? data.defaultPrice.value
          : this.defaultPrice,
      showPeriod: data.showPeriod.present
          ? data.showPeriod.value
          : this.showPeriod,
      qtyLabel: data.qtyLabel.present ? data.qtyLabel.value : this.qtyLabel,
      priceLabel: data.priceLabel.present
          ? data.priceLabel.value
          : this.priceLabel,
      descriptionLabel: data.descriptionLabel.present
          ? data.descriptionLabel.value
          : this.descriptionLabel,
      amountLabel: data.amountLabel.present
          ? data.amountLabel.value
          : this.amountLabel,
      periodLabel: data.periodLabel.present
          ? data.periodLabel.value
          : this.periodLabel,
      totalLabel: data.totalLabel.present
          ? data.totalLabel.value
          : this.totalLabel,
      dueDateLabel: data.dueDateLabel.present
          ? data.dueDateLabel.value
          : this.dueDateLabel,
      dateLabel: data.dateLabel.present ? data.dateLabel.value : this.dateLabel,
      invoiceIdLbl: data.invoiceIdLbl.present
          ? data.invoiceIdLbl.value
          : this.invoiceIdLbl,
      invoiceTitle: data.invoiceTitle.present
          ? data.invoiceTitle.value
          : this.invoiceTitle,
      description: data.description.present
          ? data.description.value
          : this.description,
      contractorRoleSublabel: data.contractorRoleSublabel.present
          ? data.contractorRoleSublabel.value
          : this.contractorRoleSublabel,
      footnote: data.footnote.present ? data.footnote.value : this.footnote,
      contractorAgreementLabel: data.contractorAgreementLabel.present
          ? data.contractorAgreementLabel.value
          : this.contractorAgreementLabel,
      locale: data.locale.present ? data.locale.value : this.locale,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbContract(')
          ..write('id: $id, ')
          ..write('contractorId: $contractorId, ')
          ..write('companyId: $companyId, ')
          ..write('date: $date, ')
          ..write('fixed: $fixed, ')
          ..write('defaultPrice: $defaultPrice, ')
          ..write('showPeriod: $showPeriod, ')
          ..write('qtyLabel: $qtyLabel, ')
          ..write('priceLabel: $priceLabel, ')
          ..write('descriptionLabel: $descriptionLabel, ')
          ..write('amountLabel: $amountLabel, ')
          ..write('periodLabel: $periodLabel, ')
          ..write('totalLabel: $totalLabel, ')
          ..write('dueDateLabel: $dueDateLabel, ')
          ..write('dateLabel: $dateLabel, ')
          ..write('invoiceIdLbl: $invoiceIdLbl, ')
          ..write('invoiceTitle: $invoiceTitle, ')
          ..write('description: $description, ')
          ..write('contractorRoleSublabel: $contractorRoleSublabel, ')
          ..write('footnote: $footnote, ')
          ..write('contractorAgreementLabel: $contractorAgreementLabel, ')
          ..write('locale: $locale')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    contractorId,
    companyId,
    date,
    fixed,
    defaultPrice,
    showPeriod,
    qtyLabel,
    priceLabel,
    descriptionLabel,
    amountLabel,
    periodLabel,
    totalLabel,
    dueDateLabel,
    dateLabel,
    invoiceIdLbl,
    invoiceTitle,
    description,
    contractorRoleSublabel,
    footnote,
    contractorAgreementLabel,
    locale,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbContract &&
          other.id == this.id &&
          other.contractorId == this.contractorId &&
          other.companyId == this.companyId &&
          other.date == this.date &&
          other.fixed == this.fixed &&
          other.defaultPrice == this.defaultPrice &&
          other.showPeriod == this.showPeriod &&
          other.qtyLabel == this.qtyLabel &&
          other.priceLabel == this.priceLabel &&
          other.descriptionLabel == this.descriptionLabel &&
          other.amountLabel == this.amountLabel &&
          other.periodLabel == this.periodLabel &&
          other.totalLabel == this.totalLabel &&
          other.dueDateLabel == this.dueDateLabel &&
          other.dateLabel == this.dateLabel &&
          other.invoiceIdLbl == this.invoiceIdLbl &&
          other.invoiceTitle == this.invoiceTitle &&
          other.description == this.description &&
          other.contractorRoleSublabel == this.contractorRoleSublabel &&
          other.footnote == this.footnote &&
          other.contractorAgreementLabel == this.contractorAgreementLabel &&
          other.locale == this.locale);
}

class DbContractsCompanion extends UpdateCompanion<DbContract> {
  final Value<String> id;
  final Value<String> contractorId;
  final Value<String> companyId;
  final Value<DateTime> date;
  final Value<bool> fixed;
  final Value<double?> defaultPrice;
  final Value<bool> showPeriod;
  final Value<String?> qtyLabel;
  final Value<String?> priceLabel;
  final Value<String?> descriptionLabel;
  final Value<String?> amountLabel;
  final Value<String?> periodLabel;
  final Value<String?> totalLabel;
  final Value<String?> dueDateLabel;
  final Value<String?> dateLabel;
  final Value<String?> invoiceIdLbl;
  final Value<String?> invoiceTitle;
  final Value<String?> description;
  final Value<String?> contractorRoleSublabel;
  final Value<String?> footnote;
  final Value<String?> contractorAgreementLabel;
  final Value<String?> locale;
  final Value<int> rowid;
  const DbContractsCompanion({
    this.id = const Value.absent(),
    this.contractorId = const Value.absent(),
    this.companyId = const Value.absent(),
    this.date = const Value.absent(),
    this.fixed = const Value.absent(),
    this.defaultPrice = const Value.absent(),
    this.showPeriod = const Value.absent(),
    this.qtyLabel = const Value.absent(),
    this.priceLabel = const Value.absent(),
    this.descriptionLabel = const Value.absent(),
    this.amountLabel = const Value.absent(),
    this.periodLabel = const Value.absent(),
    this.totalLabel = const Value.absent(),
    this.dueDateLabel = const Value.absent(),
    this.dateLabel = const Value.absent(),
    this.invoiceIdLbl = const Value.absent(),
    this.invoiceTitle = const Value.absent(),
    this.description = const Value.absent(),
    this.contractorRoleSublabel = const Value.absent(),
    this.footnote = const Value.absent(),
    this.contractorAgreementLabel = const Value.absent(),
    this.locale = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DbContractsCompanion.insert({
    required String id,
    required String contractorId,
    required String companyId,
    required DateTime date,
    this.fixed = const Value.absent(),
    this.defaultPrice = const Value.absent(),
    this.showPeriod = const Value.absent(),
    this.qtyLabel = const Value.absent(),
    this.priceLabel = const Value.absent(),
    this.descriptionLabel = const Value.absent(),
    this.amountLabel = const Value.absent(),
    this.periodLabel = const Value.absent(),
    this.totalLabel = const Value.absent(),
    this.dueDateLabel = const Value.absent(),
    this.dateLabel = const Value.absent(),
    this.invoiceIdLbl = const Value.absent(),
    this.invoiceTitle = const Value.absent(),
    this.description = const Value.absent(),
    this.contractorRoleSublabel = const Value.absent(),
    this.footnote = const Value.absent(),
    this.contractorAgreementLabel = const Value.absent(),
    this.locale = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       contractorId = Value(contractorId),
       companyId = Value(companyId),
       date = Value(date);
  static Insertable<DbContract> custom({
    Expression<String>? id,
    Expression<String>? contractorId,
    Expression<String>? companyId,
    Expression<DateTime>? date,
    Expression<bool>? fixed,
    Expression<double>? defaultPrice,
    Expression<bool>? showPeriod,
    Expression<String>? qtyLabel,
    Expression<String>? priceLabel,
    Expression<String>? descriptionLabel,
    Expression<String>? amountLabel,
    Expression<String>? periodLabel,
    Expression<String>? totalLabel,
    Expression<String>? dueDateLabel,
    Expression<String>? dateLabel,
    Expression<String>? invoiceIdLbl,
    Expression<String>? invoiceTitle,
    Expression<String>? description,
    Expression<String>? contractorRoleSublabel,
    Expression<String>? footnote,
    Expression<String>? contractorAgreementLabel,
    Expression<String>? locale,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contractorId != null) 'contractor_id': contractorId,
      if (companyId != null) 'company_id': companyId,
      if (date != null) 'date': date,
      if (fixed != null) 'fixed': fixed,
      if (defaultPrice != null) 'default_price': defaultPrice,
      if (showPeriod != null) 'show_period': showPeriod,
      if (qtyLabel != null) 'qty_label': qtyLabel,
      if (priceLabel != null) 'price_label': priceLabel,
      if (descriptionLabel != null) 'description_label': descriptionLabel,
      if (amountLabel != null) 'amount_label': amountLabel,
      if (periodLabel != null) 'period_label': periodLabel,
      if (totalLabel != null) 'total_label': totalLabel,
      if (dueDateLabel != null) 'due_date_label': dueDateLabel,
      if (dateLabel != null) 'date_label': dateLabel,
      if (invoiceIdLbl != null) 'invoice_id_lbl': invoiceIdLbl,
      if (invoiceTitle != null) 'invoice_title': invoiceTitle,
      if (description != null) 'description': description,
      if (contractorRoleSublabel != null)
        'contractor_role_sublabel': contractorRoleSublabel,
      if (footnote != null) 'footnote': footnote,
      if (contractorAgreementLabel != null)
        'contractor_agreement_label': contractorAgreementLabel,
      if (locale != null) 'locale': locale,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DbContractsCompanion copyWith({
    Value<String>? id,
    Value<String>? contractorId,
    Value<String>? companyId,
    Value<DateTime>? date,
    Value<bool>? fixed,
    Value<double?>? defaultPrice,
    Value<bool>? showPeriod,
    Value<String?>? qtyLabel,
    Value<String?>? priceLabel,
    Value<String?>? descriptionLabel,
    Value<String?>? amountLabel,
    Value<String?>? periodLabel,
    Value<String?>? totalLabel,
    Value<String?>? dueDateLabel,
    Value<String?>? dateLabel,
    Value<String?>? invoiceIdLbl,
    Value<String?>? invoiceTitle,
    Value<String?>? description,
    Value<String?>? contractorRoleSublabel,
    Value<String?>? footnote,
    Value<String?>? contractorAgreementLabel,
    Value<String?>? locale,
    Value<int>? rowid,
  }) {
    return DbContractsCompanion(
      id: id ?? this.id,
      contractorId: contractorId ?? this.contractorId,
      companyId: companyId ?? this.companyId,
      date: date ?? this.date,
      fixed: fixed ?? this.fixed,
      defaultPrice: defaultPrice ?? this.defaultPrice,
      showPeriod: showPeriod ?? this.showPeriod,
      qtyLabel: qtyLabel ?? this.qtyLabel,
      priceLabel: priceLabel ?? this.priceLabel,
      descriptionLabel: descriptionLabel ?? this.descriptionLabel,
      amountLabel: amountLabel ?? this.amountLabel,
      periodLabel: periodLabel ?? this.periodLabel,
      totalLabel: totalLabel ?? this.totalLabel,
      dueDateLabel: dueDateLabel ?? this.dueDateLabel,
      dateLabel: dateLabel ?? this.dateLabel,
      invoiceIdLbl: invoiceIdLbl ?? this.invoiceIdLbl,
      invoiceTitle: invoiceTitle ?? this.invoiceTitle,
      description: description ?? this.description,
      contractorRoleSublabel:
          contractorRoleSublabel ?? this.contractorRoleSublabel,
      footnote: footnote ?? this.footnote,
      contractorAgreementLabel:
          contractorAgreementLabel ?? this.contractorAgreementLabel,
      locale: locale ?? this.locale,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (contractorId.present) {
      map['contractor_id'] = Variable<String>(contractorId.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<String>(companyId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (fixed.present) {
      map['fixed'] = Variable<bool>(fixed.value);
    }
    if (defaultPrice.present) {
      map['default_price'] = Variable<double>(defaultPrice.value);
    }
    if (showPeriod.present) {
      map['show_period'] = Variable<bool>(showPeriod.value);
    }
    if (qtyLabel.present) {
      map['qty_label'] = Variable<String>(qtyLabel.value);
    }
    if (priceLabel.present) {
      map['price_label'] = Variable<String>(priceLabel.value);
    }
    if (descriptionLabel.present) {
      map['description_label'] = Variable<String>(descriptionLabel.value);
    }
    if (amountLabel.present) {
      map['amount_label'] = Variable<String>(amountLabel.value);
    }
    if (periodLabel.present) {
      map['period_label'] = Variable<String>(periodLabel.value);
    }
    if (totalLabel.present) {
      map['total_label'] = Variable<String>(totalLabel.value);
    }
    if (dueDateLabel.present) {
      map['due_date_label'] = Variable<String>(dueDateLabel.value);
    }
    if (dateLabel.present) {
      map['date_label'] = Variable<String>(dateLabel.value);
    }
    if (invoiceIdLbl.present) {
      map['invoice_id_lbl'] = Variable<String>(invoiceIdLbl.value);
    }
    if (invoiceTitle.present) {
      map['invoice_title'] = Variable<String>(invoiceTitle.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (contractorRoleSublabel.present) {
      map['contractor_role_sublabel'] = Variable<String>(
        contractorRoleSublabel.value,
      );
    }
    if (footnote.present) {
      map['footnote'] = Variable<String>(footnote.value);
    }
    if (contractorAgreementLabel.present) {
      map['contractor_agreement_label'] = Variable<String>(
        contractorAgreementLabel.value,
      );
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbContractsCompanion(')
          ..write('id: $id, ')
          ..write('contractorId: $contractorId, ')
          ..write('companyId: $companyId, ')
          ..write('date: $date, ')
          ..write('fixed: $fixed, ')
          ..write('defaultPrice: $defaultPrice, ')
          ..write('showPeriod: $showPeriod, ')
          ..write('qtyLabel: $qtyLabel, ')
          ..write('priceLabel: $priceLabel, ')
          ..write('descriptionLabel: $descriptionLabel, ')
          ..write('amountLabel: $amountLabel, ')
          ..write('periodLabel: $periodLabel, ')
          ..write('totalLabel: $totalLabel, ')
          ..write('dueDateLabel: $dueDateLabel, ')
          ..write('dateLabel: $dateLabel, ')
          ..write('invoiceIdLbl: $invoiceIdLbl, ')
          ..write('invoiceTitle: $invoiceTitle, ')
          ..write('description: $description, ')
          ..write('contractorRoleSublabel: $contractorRoleSublabel, ')
          ..write('footnote: $footnote, ')
          ..write('contractorAgreementLabel: $contractorAgreementLabel, ')
          ..write('locale: $locale, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DbInvoicesTable extends DbInvoices
    with TableInfo<$DbInvoicesTable, DbInvoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbInvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _contractSnapshotMeta = const VerificationMeta(
    'contractSnapshot',
  );
  @override
  late final GeneratedColumn<String> contractSnapshot = GeneratedColumn<String>(
    'contract_snapshot',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contractorSnapshotMeta =
      const VerificationMeta('contractorSnapshot');
  @override
  late final GeneratedColumn<String> contractorSnapshot =
      GeneratedColumn<String>(
        'contractor_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _companySnapshotMeta = const VerificationMeta(
    'companySnapshot',
  );
  @override
  late final GeneratedColumn<String> companySnapshot = GeneratedColumn<String>(
    'company_snapshot',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    dueDate,
    status,
    contractSnapshot,
    contractorSnapshot,
    companySnapshot,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbInvoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('contract_snapshot')) {
      context.handle(
        _contractSnapshotMeta,
        contractSnapshot.isAcceptableOrUnknown(
          data['contract_snapshot']!,
          _contractSnapshotMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contractSnapshotMeta);
    }
    if (data.containsKey('contractor_snapshot')) {
      context.handle(
        _contractorSnapshotMeta,
        contractorSnapshot.isAcceptableOrUnknown(
          data['contractor_snapshot']!,
          _contractorSnapshotMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contractorSnapshotMeta);
    }
    if (data.containsKey('company_snapshot')) {
      context.handle(
        _companySnapshotMeta,
        companySnapshot.isAcceptableOrUnknown(
          data['company_snapshot']!,
          _companySnapshotMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_companySnapshotMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbInvoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbInvoice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      contractSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contract_snapshot'],
      )!,
      contractorSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contractor_snapshot'],
      )!,
      companySnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_snapshot'],
      )!,
    );
  }

  @override
  $DbInvoicesTable createAlias(String alias) {
    return $DbInvoicesTable(attachedDatabase, alias);
  }
}

class DbInvoice extends DataClass implements Insertable<DbInvoice> {
  final String id;
  final DateTime date;
  final DateTime dueDate;
  final int status;
  final String contractSnapshot;
  final String contractorSnapshot;
  final String companySnapshot;
  const DbInvoice({
    required this.id,
    required this.date,
    required this.dueDate,
    required this.status,
    required this.contractSnapshot,
    required this.contractorSnapshot,
    required this.companySnapshot,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['due_date'] = Variable<DateTime>(dueDate);
    map['status'] = Variable<int>(status);
    map['contract_snapshot'] = Variable<String>(contractSnapshot);
    map['contractor_snapshot'] = Variable<String>(contractorSnapshot);
    map['company_snapshot'] = Variable<String>(companySnapshot);
    return map;
  }

  DbInvoicesCompanion toCompanion(bool nullToAbsent) {
    return DbInvoicesCompanion(
      id: Value(id),
      date: Value(date),
      dueDate: Value(dueDate),
      status: Value(status),
      contractSnapshot: Value(contractSnapshot),
      contractorSnapshot: Value(contractorSnapshot),
      companySnapshot: Value(companySnapshot),
    );
  }

  factory DbInvoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbInvoice(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      status: serializer.fromJson<int>(json['status']),
      contractSnapshot: serializer.fromJson<String>(json['contractSnapshot']),
      contractorSnapshot: serializer.fromJson<String>(
        json['contractorSnapshot'],
      ),
      companySnapshot: serializer.fromJson<String>(json['companySnapshot']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'status': serializer.toJson<int>(status),
      'contractSnapshot': serializer.toJson<String>(contractSnapshot),
      'contractorSnapshot': serializer.toJson<String>(contractorSnapshot),
      'companySnapshot': serializer.toJson<String>(companySnapshot),
    };
  }

  DbInvoice copyWith({
    String? id,
    DateTime? date,
    DateTime? dueDate,
    int? status,
    String? contractSnapshot,
    String? contractorSnapshot,
    String? companySnapshot,
  }) => DbInvoice(
    id: id ?? this.id,
    date: date ?? this.date,
    dueDate: dueDate ?? this.dueDate,
    status: status ?? this.status,
    contractSnapshot: contractSnapshot ?? this.contractSnapshot,
    contractorSnapshot: contractorSnapshot ?? this.contractorSnapshot,
    companySnapshot: companySnapshot ?? this.companySnapshot,
  );
  DbInvoice copyWithCompanion(DbInvoicesCompanion data) {
    return DbInvoice(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      status: data.status.present ? data.status.value : this.status,
      contractSnapshot: data.contractSnapshot.present
          ? data.contractSnapshot.value
          : this.contractSnapshot,
      contractorSnapshot: data.contractorSnapshot.present
          ? data.contractorSnapshot.value
          : this.contractorSnapshot,
      companySnapshot: data.companySnapshot.present
          ? data.companySnapshot.value
          : this.companySnapshot,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbInvoice(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('dueDate: $dueDate, ')
          ..write('status: $status, ')
          ..write('contractSnapshot: $contractSnapshot, ')
          ..write('contractorSnapshot: $contractorSnapshot, ')
          ..write('companySnapshot: $companySnapshot')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    dueDate,
    status,
    contractSnapshot,
    contractorSnapshot,
    companySnapshot,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbInvoice &&
          other.id == this.id &&
          other.date == this.date &&
          other.dueDate == this.dueDate &&
          other.status == this.status &&
          other.contractSnapshot == this.contractSnapshot &&
          other.contractorSnapshot == this.contractorSnapshot &&
          other.companySnapshot == this.companySnapshot);
}

class DbInvoicesCompanion extends UpdateCompanion<DbInvoice> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<DateTime> dueDate;
  final Value<int> status;
  final Value<String> contractSnapshot;
  final Value<String> contractorSnapshot;
  final Value<String> companySnapshot;
  final Value<int> rowid;
  const DbInvoicesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.status = const Value.absent(),
    this.contractSnapshot = const Value.absent(),
    this.contractorSnapshot = const Value.absent(),
    this.companySnapshot = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DbInvoicesCompanion.insert({
    required String id,
    required DateTime date,
    required DateTime dueDate,
    this.status = const Value.absent(),
    required String contractSnapshot,
    required String contractorSnapshot,
    required String companySnapshot,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       dueDate = Value(dueDate),
       contractSnapshot = Value(contractSnapshot),
       contractorSnapshot = Value(contractorSnapshot),
       companySnapshot = Value(companySnapshot);
  static Insertable<DbInvoice> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<DateTime>? dueDate,
    Expression<int>? status,
    Expression<String>? contractSnapshot,
    Expression<String>? contractorSnapshot,
    Expression<String>? companySnapshot,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (dueDate != null) 'due_date': dueDate,
      if (status != null) 'status': status,
      if (contractSnapshot != null) 'contract_snapshot': contractSnapshot,
      if (contractorSnapshot != null) 'contractor_snapshot': contractorSnapshot,
      if (companySnapshot != null) 'company_snapshot': companySnapshot,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DbInvoicesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<DateTime>? dueDate,
    Value<int>? status,
    Value<String>? contractSnapshot,
    Value<String>? contractorSnapshot,
    Value<String>? companySnapshot,
    Value<int>? rowid,
  }) {
    return DbInvoicesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      contractSnapshot: contractSnapshot ?? this.contractSnapshot,
      contractorSnapshot: contractorSnapshot ?? this.contractorSnapshot,
      companySnapshot: companySnapshot ?? this.companySnapshot,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (contractSnapshot.present) {
      map['contract_snapshot'] = Variable<String>(contractSnapshot.value);
    }
    if (contractorSnapshot.present) {
      map['contractor_snapshot'] = Variable<String>(contractorSnapshot.value);
    }
    if (companySnapshot.present) {
      map['company_snapshot'] = Variable<String>(companySnapshot.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbInvoicesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('dueDate: $dueDate, ')
          ..write('status: $status, ')
          ..write('contractSnapshot: $contractSnapshot, ')
          ..write('contractorSnapshot: $contractorSnapshot, ')
          ..write('companySnapshot: $companySnapshot, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DbInvoiceItemsTable extends DbInvoiceItems
    with TableInfo<$DbInvoiceItemsTable, DbInvoiceItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbInvoiceItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _periodMeta = const VerificationMeta('period');
  @override
  late final GeneratedColumn<String> period = GeneratedColumn<String>(
    'period',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    description,
    period,
    quantity,
    price,
    amount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_invoice_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbInvoiceItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('period')) {
      context.handle(
        _periodMeta,
        period.isAcceptableOrUnknown(data['period']!, _periodMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbInvoiceItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbInvoiceItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      period: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      ),
    );
  }

  @override
  $DbInvoiceItemsTable createAlias(String alias) {
    return $DbInvoiceItemsTable(attachedDatabase, alias);
  }
}

class DbInvoiceItem extends DataClass implements Insertable<DbInvoiceItem> {
  final String id;
  final String invoiceId;
  final String description;
  final String? period;
  final int quantity;
  final double price;
  final double? amount;
  const DbInvoiceItem({
    required this.id,
    required this.invoiceId,
    required this.description,
    this.period,
    required this.quantity,
    required this.price,
    this.amount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['invoice_id'] = Variable<String>(invoiceId);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || period != null) {
      map['period'] = Variable<String>(period);
    }
    map['quantity'] = Variable<int>(quantity);
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<double>(amount);
    }
    return map;
  }

  DbInvoiceItemsCompanion toCompanion(bool nullToAbsent) {
    return DbInvoiceItemsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      description: Value(description),
      period: period == null && nullToAbsent
          ? const Value.absent()
          : Value(period),
      quantity: Value(quantity),
      price: Value(price),
      amount: amount == null && nullToAbsent
          ? const Value.absent()
          : Value(amount),
    );
  }

  factory DbInvoiceItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbInvoiceItem(
      id: serializer.fromJson<String>(json['id']),
      invoiceId: serializer.fromJson<String>(json['invoiceId']),
      description: serializer.fromJson<String>(json['description']),
      period: serializer.fromJson<String?>(json['period']),
      quantity: serializer.fromJson<int>(json['quantity']),
      price: serializer.fromJson<double>(json['price']),
      amount: serializer.fromJson<double?>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'invoiceId': serializer.toJson<String>(invoiceId),
      'description': serializer.toJson<String>(description),
      'period': serializer.toJson<String?>(period),
      'quantity': serializer.toJson<int>(quantity),
      'price': serializer.toJson<double>(price),
      'amount': serializer.toJson<double?>(amount),
    };
  }

  DbInvoiceItem copyWith({
    String? id,
    String? invoiceId,
    String? description,
    Value<String?> period = const Value.absent(),
    int? quantity,
    double? price,
    Value<double?> amount = const Value.absent(),
  }) => DbInvoiceItem(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    description: description ?? this.description,
    period: period.present ? period.value : this.period,
    quantity: quantity ?? this.quantity,
    price: price ?? this.price,
    amount: amount.present ? amount.value : this.amount,
  );
  DbInvoiceItem copyWithCompanion(DbInvoiceItemsCompanion data) {
    return DbInvoiceItem(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      description: data.description.present
          ? data.description.value
          : this.description,
      period: data.period.present ? data.period.value : this.period,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      price: data.price.present ? data.price.value : this.price,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbInvoiceItem(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('description: $description, ')
          ..write('period: $period, ')
          ..write('quantity: $quantity, ')
          ..write('price: $price, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, invoiceId, description, period, quantity, price, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbInvoiceItem &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.description == this.description &&
          other.period == this.period &&
          other.quantity == this.quantity &&
          other.price == this.price &&
          other.amount == this.amount);
}

class DbInvoiceItemsCompanion extends UpdateCompanion<DbInvoiceItem> {
  final Value<String> id;
  final Value<String> invoiceId;
  final Value<String> description;
  final Value<String?> period;
  final Value<int> quantity;
  final Value<double> price;
  final Value<double?> amount;
  final Value<int> rowid;
  const DbInvoiceItemsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.description = const Value.absent(),
    this.period = const Value.absent(),
    this.quantity = const Value.absent(),
    this.price = const Value.absent(),
    this.amount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DbInvoiceItemsCompanion.insert({
    required String id,
    required String invoiceId,
    required String description,
    this.period = const Value.absent(),
    this.quantity = const Value.absent(),
    this.price = const Value.absent(),
    this.amount = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       invoiceId = Value(invoiceId),
       description = Value(description);
  static Insertable<DbInvoiceItem> custom({
    Expression<String>? id,
    Expression<String>? invoiceId,
    Expression<String>? description,
    Expression<String>? period,
    Expression<int>? quantity,
    Expression<double>? price,
    Expression<double>? amount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (description != null) 'description': description,
      if (period != null) 'period': period,
      if (quantity != null) 'quantity': quantity,
      if (price != null) 'price': price,
      if (amount != null) 'amount': amount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DbInvoiceItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? invoiceId,
    Value<String>? description,
    Value<String?>? period,
    Value<int>? quantity,
    Value<double>? price,
    Value<double?>? amount,
    Value<int>? rowid,
  }) {
    return DbInvoiceItemsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      description: description ?? this.description,
      period: period ?? this.period,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      amount: amount ?? this.amount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (period.present) {
      map['period'] = Variable<String>(period.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbInvoiceItemsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('description: $description, ')
          ..write('period: $period, ')
          ..write('quantity: $quantity, ')
          ..write('price: $price, ')
          ..write('amount: $amount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DbContractorsTable dbContractors = $DbContractorsTable(this);
  late final $DbCompaniesTable dbCompanies = $DbCompaniesTable(this);
  late final $DbContractsTable dbContracts = $DbContractsTable(this);
  late final $DbInvoicesTable dbInvoices = $DbInvoicesTable(this);
  late final $DbInvoiceItemsTable dbInvoiceItems = $DbInvoiceItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    dbContractors,
    dbCompanies,
    dbContracts,
    dbInvoices,
    dbInvoiceItems,
  ];
}

typedef $$DbContractorsTableCreateCompanionBuilder =
    DbContractorsCompanion Function({
      required String id,
      required String abbr,
      required String fullName,
      Value<String?> paymentInfo,
      Value<String?> contractorInfo,
      Value<Uint8List?> signature,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$DbContractorsTableUpdateCompanionBuilder =
    DbContractorsCompanion Function({
      Value<String> id,
      Value<String> abbr,
      Value<String> fullName,
      Value<String?> paymentInfo,
      Value<String?> contractorInfo,
      Value<Uint8List?> signature,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$DbContractorsTableFilterComposer
    extends Composer<_$AppDatabase, $DbContractorsTable> {
  $$DbContractorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get abbr => $composableBuilder(
    column: $table.abbr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentInfo => $composableBuilder(
    column: $table.paymentInfo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contractorInfo => $composableBuilder(
    column: $table.contractorInfo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get signature => $composableBuilder(
    column: $table.signature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbContractorsTableOrderingComposer
    extends Composer<_$AppDatabase, $DbContractorsTable> {
  $$DbContractorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get abbr => $composableBuilder(
    column: $table.abbr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentInfo => $composableBuilder(
    column: $table.paymentInfo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contractorInfo => $composableBuilder(
    column: $table.contractorInfo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get signature => $composableBuilder(
    column: $table.signature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbContractorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbContractorsTable> {
  $$DbContractorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get abbr =>
      $composableBuilder(column: $table.abbr, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get paymentInfo => $composableBuilder(
    column: $table.paymentInfo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contractorInfo => $composableBuilder(
    column: $table.contractorInfo,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get signature =>
      $composableBuilder(column: $table.signature, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DbContractorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbContractorsTable,
          DbContractor,
          $$DbContractorsTableFilterComposer,
          $$DbContractorsTableOrderingComposer,
          $$DbContractorsTableAnnotationComposer,
          $$DbContractorsTableCreateCompanionBuilder,
          $$DbContractorsTableUpdateCompanionBuilder,
          (
            DbContractor,
            BaseReferences<_$AppDatabase, $DbContractorsTable, DbContractor>,
          ),
          DbContractor,
          PrefetchHooks Function()
        > {
  $$DbContractorsTableTableManager(_$AppDatabase db, $DbContractorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbContractorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbContractorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbContractorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> abbr = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String?> paymentInfo = const Value.absent(),
                Value<String?> contractorInfo = const Value.absent(),
                Value<Uint8List?> signature = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DbContractorsCompanion(
                id: id,
                abbr: abbr,
                fullName: fullName,
                paymentInfo: paymentInfo,
                contractorInfo: contractorInfo,
                signature: signature,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String abbr,
                required String fullName,
                Value<String?> paymentInfo = const Value.absent(),
                Value<String?> contractorInfo = const Value.absent(),
                Value<Uint8List?> signature = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DbContractorsCompanion.insert(
                id: id,
                abbr: abbr,
                fullName: fullName,
                paymentInfo: paymentInfo,
                contractorInfo: contractorInfo,
                signature: signature,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DbContractorsTable, DbContractor>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DbContractorsTable,
                    DbContractor
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbContractorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbContractorsTable,
      DbContractor,
      $$DbContractorsTableFilterComposer,
      $$DbContractorsTableOrderingComposer,
      $$DbContractorsTableAnnotationComposer,
      $$DbContractorsTableCreateCompanionBuilder,
      $$DbContractorsTableUpdateCompanionBuilder,
      (
        DbContractor,
        BaseReferences<_$AppDatabase, $DbContractorsTable, DbContractor>,
      ),
      DbContractor,
      PrefetchHooks Function()
    >;
typedef $$DbCompaniesTableCreateCompanionBuilder =
    DbCompaniesCompanion Function({
      required String id,
      required String name,
      required String abbr,
      Value<int> paymentWeeks,
      Value<String?> currencyPrefix,
      Value<String?> companyInfo,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$DbCompaniesTableUpdateCompanionBuilder =
    DbCompaniesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> abbr,
      Value<int> paymentWeeks,
      Value<String?> currencyPrefix,
      Value<String?> companyInfo,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$DbCompaniesTableFilterComposer
    extends Composer<_$AppDatabase, $DbCompaniesTable> {
  $$DbCompaniesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get abbr => $composableBuilder(
    column: $table.abbr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paymentWeeks => $composableBuilder(
    column: $table.paymentWeeks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyPrefix => $composableBuilder(
    column: $table.currencyPrefix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyInfo => $composableBuilder(
    column: $table.companyInfo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbCompaniesTableOrderingComposer
    extends Composer<_$AppDatabase, $DbCompaniesTable> {
  $$DbCompaniesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get abbr => $composableBuilder(
    column: $table.abbr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paymentWeeks => $composableBuilder(
    column: $table.paymentWeeks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyPrefix => $composableBuilder(
    column: $table.currencyPrefix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyInfo => $composableBuilder(
    column: $table.companyInfo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbCompaniesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbCompaniesTable> {
  $$DbCompaniesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get abbr =>
      $composableBuilder(column: $table.abbr, builder: (column) => column);

  GeneratedColumn<int> get paymentWeeks => $composableBuilder(
    column: $table.paymentWeeks,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyPrefix => $composableBuilder(
    column: $table.currencyPrefix,
    builder: (column) => column,
  );

  GeneratedColumn<String> get companyInfo => $composableBuilder(
    column: $table.companyInfo,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DbCompaniesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbCompaniesTable,
          DbCompany,
          $$DbCompaniesTableFilterComposer,
          $$DbCompaniesTableOrderingComposer,
          $$DbCompaniesTableAnnotationComposer,
          $$DbCompaniesTableCreateCompanionBuilder,
          $$DbCompaniesTableUpdateCompanionBuilder,
          (
            DbCompany,
            BaseReferences<_$AppDatabase, $DbCompaniesTable, DbCompany>,
          ),
          DbCompany,
          PrefetchHooks Function()
        > {
  $$DbCompaniesTableTableManager(_$AppDatabase db, $DbCompaniesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbCompaniesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbCompaniesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbCompaniesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> abbr = const Value.absent(),
                Value<int> paymentWeeks = const Value.absent(),
                Value<String?> currencyPrefix = const Value.absent(),
                Value<String?> companyInfo = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DbCompaniesCompanion(
                id: id,
                name: name,
                abbr: abbr,
                paymentWeeks: paymentWeeks,
                currencyPrefix: currencyPrefix,
                companyInfo: companyInfo,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String abbr,
                Value<int> paymentWeeks = const Value.absent(),
                Value<String?> currencyPrefix = const Value.absent(),
                Value<String?> companyInfo = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DbCompaniesCompanion.insert(
                id: id,
                name: name,
                abbr: abbr,
                paymentWeeks: paymentWeeks,
                currencyPrefix: currencyPrefix,
                companyInfo: companyInfo,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DbCompaniesTable, DbCompany>(table),
                  BaseReferences<_$AppDatabase, $DbCompaniesTable, DbCompany>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbCompaniesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbCompaniesTable,
      DbCompany,
      $$DbCompaniesTableFilterComposer,
      $$DbCompaniesTableOrderingComposer,
      $$DbCompaniesTableAnnotationComposer,
      $$DbCompaniesTableCreateCompanionBuilder,
      $$DbCompaniesTableUpdateCompanionBuilder,
      (DbCompany, BaseReferences<_$AppDatabase, $DbCompaniesTable, DbCompany>),
      DbCompany,
      PrefetchHooks Function()
    >;
typedef $$DbContractsTableCreateCompanionBuilder =
    DbContractsCompanion Function({
      required String id,
      required String contractorId,
      required String companyId,
      required DateTime date,
      Value<bool> fixed,
      Value<double?> defaultPrice,
      Value<bool> showPeriod,
      Value<String?> qtyLabel,
      Value<String?> priceLabel,
      Value<String?> descriptionLabel,
      Value<String?> amountLabel,
      Value<String?> periodLabel,
      Value<String?> totalLabel,
      Value<String?> dueDateLabel,
      Value<String?> dateLabel,
      Value<String?> invoiceIdLbl,
      Value<String?> invoiceTitle,
      Value<String?> description,
      Value<String?> contractorRoleSublabel,
      Value<String?> footnote,
      Value<String?> contractorAgreementLabel,
      Value<String?> locale,
      Value<int> rowid,
    });
typedef $$DbContractsTableUpdateCompanionBuilder =
    DbContractsCompanion Function({
      Value<String> id,
      Value<String> contractorId,
      Value<String> companyId,
      Value<DateTime> date,
      Value<bool> fixed,
      Value<double?> defaultPrice,
      Value<bool> showPeriod,
      Value<String?> qtyLabel,
      Value<String?> priceLabel,
      Value<String?> descriptionLabel,
      Value<String?> amountLabel,
      Value<String?> periodLabel,
      Value<String?> totalLabel,
      Value<String?> dueDateLabel,
      Value<String?> dateLabel,
      Value<String?> invoiceIdLbl,
      Value<String?> invoiceTitle,
      Value<String?> description,
      Value<String?> contractorRoleSublabel,
      Value<String?> footnote,
      Value<String?> contractorAgreementLabel,
      Value<String?> locale,
      Value<int> rowid,
    });

class $$DbContractsTableFilterComposer
    extends Composer<_$AppDatabase, $DbContractsTable> {
  $$DbContractsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contractorId => $composableBuilder(
    column: $table.contractorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get fixed => $composableBuilder(
    column: $table.fixed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultPrice => $composableBuilder(
    column: $table.defaultPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showPeriod => $composableBuilder(
    column: $table.showPeriod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qtyLabel => $composableBuilder(
    column: $table.qtyLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priceLabel => $composableBuilder(
    column: $table.priceLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionLabel => $composableBuilder(
    column: $table.descriptionLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get amountLabel => $composableBuilder(
    column: $table.amountLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get periodLabel => $composableBuilder(
    column: $table.periodLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get totalLabel => $composableBuilder(
    column: $table.totalLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dueDateLabel => $composableBuilder(
    column: $table.dueDateLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateLabel => $composableBuilder(
    column: $table.dateLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceIdLbl => $composableBuilder(
    column: $table.invoiceIdLbl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceTitle => $composableBuilder(
    column: $table.invoiceTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contractorRoleSublabel => $composableBuilder(
    column: $table.contractorRoleSublabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get footnote => $composableBuilder(
    column: $table.footnote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contractorAgreementLabel => $composableBuilder(
    column: $table.contractorAgreementLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbContractsTableOrderingComposer
    extends Composer<_$AppDatabase, $DbContractsTable> {
  $$DbContractsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contractorId => $composableBuilder(
    column: $table.contractorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get fixed => $composableBuilder(
    column: $table.fixed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultPrice => $composableBuilder(
    column: $table.defaultPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showPeriod => $composableBuilder(
    column: $table.showPeriod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qtyLabel => $composableBuilder(
    column: $table.qtyLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priceLabel => $composableBuilder(
    column: $table.priceLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionLabel => $composableBuilder(
    column: $table.descriptionLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get amountLabel => $composableBuilder(
    column: $table.amountLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get periodLabel => $composableBuilder(
    column: $table.periodLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get totalLabel => $composableBuilder(
    column: $table.totalLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dueDateLabel => $composableBuilder(
    column: $table.dueDateLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateLabel => $composableBuilder(
    column: $table.dateLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceIdLbl => $composableBuilder(
    column: $table.invoiceIdLbl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceTitle => $composableBuilder(
    column: $table.invoiceTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contractorRoleSublabel => $composableBuilder(
    column: $table.contractorRoleSublabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get footnote => $composableBuilder(
    column: $table.footnote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contractorAgreementLabel => $composableBuilder(
    column: $table.contractorAgreementLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbContractsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbContractsTable> {
  $$DbContractsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contractorId => $composableBuilder(
    column: $table.contractorId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get fixed =>
      $composableBuilder(column: $table.fixed, builder: (column) => column);

  GeneratedColumn<double> get defaultPrice => $composableBuilder(
    column: $table.defaultPrice,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showPeriod => $composableBuilder(
    column: $table.showPeriod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get qtyLabel =>
      $composableBuilder(column: $table.qtyLabel, builder: (column) => column);

  GeneratedColumn<String> get priceLabel => $composableBuilder(
    column: $table.priceLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descriptionLabel => $composableBuilder(
    column: $table.descriptionLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get amountLabel => $composableBuilder(
    column: $table.amountLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get periodLabel => $composableBuilder(
    column: $table.periodLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get totalLabel => $composableBuilder(
    column: $table.totalLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dueDateLabel => $composableBuilder(
    column: $table.dueDateLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dateLabel =>
      $composableBuilder(column: $table.dateLabel, builder: (column) => column);

  GeneratedColumn<String> get invoiceIdLbl => $composableBuilder(
    column: $table.invoiceIdLbl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invoiceTitle => $composableBuilder(
    column: $table.invoiceTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contractorRoleSublabel => $composableBuilder(
    column: $table.contractorRoleSublabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get footnote =>
      $composableBuilder(column: $table.footnote, builder: (column) => column);

  GeneratedColumn<String> get contractorAgreementLabel => $composableBuilder(
    column: $table.contractorAgreementLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);
}

class $$DbContractsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbContractsTable,
          DbContract,
          $$DbContractsTableFilterComposer,
          $$DbContractsTableOrderingComposer,
          $$DbContractsTableAnnotationComposer,
          $$DbContractsTableCreateCompanionBuilder,
          $$DbContractsTableUpdateCompanionBuilder,
          (
            DbContract,
            BaseReferences<_$AppDatabase, $DbContractsTable, DbContract>,
          ),
          DbContract,
          PrefetchHooks Function()
        > {
  $$DbContractsTableTableManager(_$AppDatabase db, $DbContractsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbContractsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbContractsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbContractsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> contractorId = const Value.absent(),
                Value<String> companyId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<bool> fixed = const Value.absent(),
                Value<double?> defaultPrice = const Value.absent(),
                Value<bool> showPeriod = const Value.absent(),
                Value<String?> qtyLabel = const Value.absent(),
                Value<String?> priceLabel = const Value.absent(),
                Value<String?> descriptionLabel = const Value.absent(),
                Value<String?> amountLabel = const Value.absent(),
                Value<String?> periodLabel = const Value.absent(),
                Value<String?> totalLabel = const Value.absent(),
                Value<String?> dueDateLabel = const Value.absent(),
                Value<String?> dateLabel = const Value.absent(),
                Value<String?> invoiceIdLbl = const Value.absent(),
                Value<String?> invoiceTitle = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> contractorRoleSublabel = const Value.absent(),
                Value<String?> footnote = const Value.absent(),
                Value<String?> contractorAgreementLabel = const Value.absent(),
                Value<String?> locale = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DbContractsCompanion(
                id: id,
                contractorId: contractorId,
                companyId: companyId,
                date: date,
                fixed: fixed,
                defaultPrice: defaultPrice,
                showPeriod: showPeriod,
                qtyLabel: qtyLabel,
                priceLabel: priceLabel,
                descriptionLabel: descriptionLabel,
                amountLabel: amountLabel,
                periodLabel: periodLabel,
                totalLabel: totalLabel,
                dueDateLabel: dueDateLabel,
                dateLabel: dateLabel,
                invoiceIdLbl: invoiceIdLbl,
                invoiceTitle: invoiceTitle,
                description: description,
                contractorRoleSublabel: contractorRoleSublabel,
                footnote: footnote,
                contractorAgreementLabel: contractorAgreementLabel,
                locale: locale,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String contractorId,
                required String companyId,
                required DateTime date,
                Value<bool> fixed = const Value.absent(),
                Value<double?> defaultPrice = const Value.absent(),
                Value<bool> showPeriod = const Value.absent(),
                Value<String?> qtyLabel = const Value.absent(),
                Value<String?> priceLabel = const Value.absent(),
                Value<String?> descriptionLabel = const Value.absent(),
                Value<String?> amountLabel = const Value.absent(),
                Value<String?> periodLabel = const Value.absent(),
                Value<String?> totalLabel = const Value.absent(),
                Value<String?> dueDateLabel = const Value.absent(),
                Value<String?> dateLabel = const Value.absent(),
                Value<String?> invoiceIdLbl = const Value.absent(),
                Value<String?> invoiceTitle = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> contractorRoleSublabel = const Value.absent(),
                Value<String?> footnote = const Value.absent(),
                Value<String?> contractorAgreementLabel = const Value.absent(),
                Value<String?> locale = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DbContractsCompanion.insert(
                id: id,
                contractorId: contractorId,
                companyId: companyId,
                date: date,
                fixed: fixed,
                defaultPrice: defaultPrice,
                showPeriod: showPeriod,
                qtyLabel: qtyLabel,
                priceLabel: priceLabel,
                descriptionLabel: descriptionLabel,
                amountLabel: amountLabel,
                periodLabel: periodLabel,
                totalLabel: totalLabel,
                dueDateLabel: dueDateLabel,
                dateLabel: dateLabel,
                invoiceIdLbl: invoiceIdLbl,
                invoiceTitle: invoiceTitle,
                description: description,
                contractorRoleSublabel: contractorRoleSublabel,
                footnote: footnote,
                contractorAgreementLabel: contractorAgreementLabel,
                locale: locale,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DbContractsTable, DbContract>(table),
                  BaseReferences<_$AppDatabase, $DbContractsTable, DbContract>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbContractsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbContractsTable,
      DbContract,
      $$DbContractsTableFilterComposer,
      $$DbContractsTableOrderingComposer,
      $$DbContractsTableAnnotationComposer,
      $$DbContractsTableCreateCompanionBuilder,
      $$DbContractsTableUpdateCompanionBuilder,
      (
        DbContract,
        BaseReferences<_$AppDatabase, $DbContractsTable, DbContract>,
      ),
      DbContract,
      PrefetchHooks Function()
    >;
typedef $$DbInvoicesTableCreateCompanionBuilder =
    DbInvoicesCompanion Function({
      required String id,
      required DateTime date,
      required DateTime dueDate,
      Value<int> status,
      required String contractSnapshot,
      required String contractorSnapshot,
      required String companySnapshot,
      Value<int> rowid,
    });
typedef $$DbInvoicesTableUpdateCompanionBuilder =
    DbInvoicesCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<DateTime> dueDate,
      Value<int> status,
      Value<String> contractSnapshot,
      Value<String> contractorSnapshot,
      Value<String> companySnapshot,
      Value<int> rowid,
    });

class $$DbInvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $DbInvoicesTable> {
  $$DbInvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contractSnapshot => $composableBuilder(
    column: $table.contractSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contractorSnapshot => $composableBuilder(
    column: $table.contractorSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companySnapshot => $composableBuilder(
    column: $table.companySnapshot,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbInvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $DbInvoicesTable> {
  $$DbInvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contractSnapshot => $composableBuilder(
    column: $table.contractSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contractorSnapshot => $composableBuilder(
    column: $table.contractorSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companySnapshot => $composableBuilder(
    column: $table.companySnapshot,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbInvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbInvoicesTable> {
  $$DbInvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get contractSnapshot => $composableBuilder(
    column: $table.contractSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contractorSnapshot => $composableBuilder(
    column: $table.contractorSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get companySnapshot => $composableBuilder(
    column: $table.companySnapshot,
    builder: (column) => column,
  );
}

class $$DbInvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbInvoicesTable,
          DbInvoice,
          $$DbInvoicesTableFilterComposer,
          $$DbInvoicesTableOrderingComposer,
          $$DbInvoicesTableAnnotationComposer,
          $$DbInvoicesTableCreateCompanionBuilder,
          $$DbInvoicesTableUpdateCompanionBuilder,
          (
            DbInvoice,
            BaseReferences<_$AppDatabase, $DbInvoicesTable, DbInvoice>,
          ),
          DbInvoice,
          PrefetchHooks Function()
        > {
  $$DbInvoicesTableTableManager(_$AppDatabase db, $DbInvoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbInvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbInvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbInvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<String> contractSnapshot = const Value.absent(),
                Value<String> contractorSnapshot = const Value.absent(),
                Value<String> companySnapshot = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DbInvoicesCompanion(
                id: id,
                date: date,
                dueDate: dueDate,
                status: status,
                contractSnapshot: contractSnapshot,
                contractorSnapshot: contractorSnapshot,
                companySnapshot: companySnapshot,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required DateTime dueDate,
                Value<int> status = const Value.absent(),
                required String contractSnapshot,
                required String contractorSnapshot,
                required String companySnapshot,
                Value<int> rowid = const Value.absent(),
              }) => DbInvoicesCompanion.insert(
                id: id,
                date: date,
                dueDate: dueDate,
                status: status,
                contractSnapshot: contractSnapshot,
                contractorSnapshot: contractorSnapshot,
                companySnapshot: companySnapshot,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DbInvoicesTable, DbInvoice>(table),
                  BaseReferences<_$AppDatabase, $DbInvoicesTable, DbInvoice>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbInvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbInvoicesTable,
      DbInvoice,
      $$DbInvoicesTableFilterComposer,
      $$DbInvoicesTableOrderingComposer,
      $$DbInvoicesTableAnnotationComposer,
      $$DbInvoicesTableCreateCompanionBuilder,
      $$DbInvoicesTableUpdateCompanionBuilder,
      (DbInvoice, BaseReferences<_$AppDatabase, $DbInvoicesTable, DbInvoice>),
      DbInvoice,
      PrefetchHooks Function()
    >;
typedef $$DbInvoiceItemsTableCreateCompanionBuilder =
    DbInvoiceItemsCompanion Function({
      required String id,
      required String invoiceId,
      required String description,
      Value<String?> period,
      Value<int> quantity,
      Value<double> price,
      Value<double?> amount,
      Value<int> rowid,
    });
typedef $$DbInvoiceItemsTableUpdateCompanionBuilder =
    DbInvoiceItemsCompanion Function({
      Value<String> id,
      Value<String> invoiceId,
      Value<String> description,
      Value<String?> period,
      Value<int> quantity,
      Value<double> price,
      Value<double?> amount,
      Value<int> rowid,
    });

class $$DbInvoiceItemsTableFilterComposer
    extends Composer<_$AppDatabase, $DbInvoiceItemsTable> {
  $$DbInvoiceItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbInvoiceItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $DbInvoiceItemsTable> {
  $$DbInvoiceItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbInvoiceItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbInvoiceItemsTable> {
  $$DbInvoiceItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoiceId =>
      $composableBuilder(column: $table.invoiceId, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get period =>
      $composableBuilder(column: $table.period, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);
}

class $$DbInvoiceItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbInvoiceItemsTable,
          DbInvoiceItem,
          $$DbInvoiceItemsTableFilterComposer,
          $$DbInvoiceItemsTableOrderingComposer,
          $$DbInvoiceItemsTableAnnotationComposer,
          $$DbInvoiceItemsTableCreateCompanionBuilder,
          $$DbInvoiceItemsTableUpdateCompanionBuilder,
          (
            DbInvoiceItem,
            BaseReferences<_$AppDatabase, $DbInvoiceItemsTable, DbInvoiceItem>,
          ),
          DbInvoiceItem,
          PrefetchHooks Function()
        > {
  $$DbInvoiceItemsTableTableManager(
    _$AppDatabase db,
    $DbInvoiceItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbInvoiceItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbInvoiceItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbInvoiceItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> invoiceId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> period = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<double?> amount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DbInvoiceItemsCompanion(
                id: id,
                invoiceId: invoiceId,
                description: description,
                period: period,
                quantity: quantity,
                price: price,
                amount: amount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String invoiceId,
                required String description,
                Value<String?> period = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<double?> amount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DbInvoiceItemsCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                description: description,
                period: period,
                quantity: quantity,
                price: price,
                amount: amount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DbInvoiceItemsTable, DbInvoiceItem>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DbInvoiceItemsTable,
                    DbInvoiceItem
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbInvoiceItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbInvoiceItemsTable,
      DbInvoiceItem,
      $$DbInvoiceItemsTableFilterComposer,
      $$DbInvoiceItemsTableOrderingComposer,
      $$DbInvoiceItemsTableAnnotationComposer,
      $$DbInvoiceItemsTableCreateCompanionBuilder,
      $$DbInvoiceItemsTableUpdateCompanionBuilder,
      (
        DbInvoiceItem,
        BaseReferences<_$AppDatabase, $DbInvoiceItemsTable, DbInvoiceItem>,
      ),
      DbInvoiceItem,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DbContractorsTableTableManager get dbContractors =>
      $$DbContractorsTableTableManager(_db, _db.dbContractors);
  $$DbCompaniesTableTableManager get dbCompanies =>
      $$DbCompaniesTableTableManager(_db, _db.dbCompanies);
  $$DbContractsTableTableManager get dbContracts =>
      $$DbContractsTableTableManager(_db, _db.dbContracts);
  $$DbInvoicesTableTableManager get dbInvoices =>
      $$DbInvoicesTableTableManager(_db, _db.dbInvoices);
  $$DbInvoiceItemsTableTableManager get dbInvoiceItems =>
      $$DbInvoiceItemsTableTableManager(_db, _db.dbInvoiceItems);
}
