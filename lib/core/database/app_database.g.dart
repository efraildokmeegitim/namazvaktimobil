// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PrayerTimesCacheTable extends PrayerTimesCache
    with TableInfo<$PrayerTimesCacheTable, PrayerTimesCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrayerTimesCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _locationIdMeta =
      const VerificationMeta('locationId');
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
      'location_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _gregorianDateMeta =
      const VerificationMeta('gregorianDate');
  @override
  late final GeneratedColumn<String> gregorianDate = GeneratedColumn<String>(
      'gregorian_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _hijriDateMeta =
      const VerificationMeta('hijriDate');
  @override
  late final GeneratedColumn<String> hijriDate = GeneratedColumn<String>(
      'hijri_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fajrMeta = const VerificationMeta('fajr');
  @override
  late final GeneratedColumn<String> fajr = GeneratedColumn<String>(
      'fajr', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sunriseMeta =
      const VerificationMeta('sunrise');
  @override
  late final GeneratedColumn<String> sunrise = GeneratedColumn<String>(
      'sunrise', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dhuhrMeta = const VerificationMeta('dhuhr');
  @override
  late final GeneratedColumn<String> dhuhr = GeneratedColumn<String>(
      'dhuhr', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _asrMeta = const VerificationMeta('asr');
  @override
  late final GeneratedColumn<String> asr = GeneratedColumn<String>(
      'asr', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _maghribMeta =
      const VerificationMeta('maghrib');
  @override
  late final GeneratedColumn<String> maghrib = GeneratedColumn<String>(
      'maghrib', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ishaMeta = const VerificationMeta('isha');
  @override
  late final GeneratedColumn<String> isha = GeneratedColumn<String>(
      'isha', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _calculationSourceMeta =
      const VerificationMeta('calculationSource');
  @override
  late final GeneratedColumn<String> calculationSource =
      GeneratedColumn<String>('calculation_source', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        locationId,
        gregorianDate,
        hijriDate,
        fajr,
        sunrise,
        dhuhr,
        asr,
        maghrib,
        isha,
        calculationSource
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prayer_times_cache';
  @override
  VerificationContext validateIntegrity(
      Insertable<PrayerTimesCacheData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('location_id')) {
      context.handle(
          _locationIdMeta,
          locationId.isAcceptableOrUnknown(
              data['location_id']!, _locationIdMeta));
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('gregorian_date')) {
      context.handle(
          _gregorianDateMeta,
          gregorianDate.isAcceptableOrUnknown(
              data['gregorian_date']!, _gregorianDateMeta));
    } else if (isInserting) {
      context.missing(_gregorianDateMeta);
    }
    if (data.containsKey('hijri_date')) {
      context.handle(_hijriDateMeta,
          hijriDate.isAcceptableOrUnknown(data['hijri_date']!, _hijriDateMeta));
    } else if (isInserting) {
      context.missing(_hijriDateMeta);
    }
    if (data.containsKey('fajr')) {
      context.handle(
          _fajrMeta, fajr.isAcceptableOrUnknown(data['fajr']!, _fajrMeta));
    } else if (isInserting) {
      context.missing(_fajrMeta);
    }
    if (data.containsKey('sunrise')) {
      context.handle(_sunriseMeta,
          sunrise.isAcceptableOrUnknown(data['sunrise']!, _sunriseMeta));
    } else if (isInserting) {
      context.missing(_sunriseMeta);
    }
    if (data.containsKey('dhuhr')) {
      context.handle(
          _dhuhrMeta, dhuhr.isAcceptableOrUnknown(data['dhuhr']!, _dhuhrMeta));
    } else if (isInserting) {
      context.missing(_dhuhrMeta);
    }
    if (data.containsKey('asr')) {
      context.handle(
          _asrMeta, asr.isAcceptableOrUnknown(data['asr']!, _asrMeta));
    } else if (isInserting) {
      context.missing(_asrMeta);
    }
    if (data.containsKey('maghrib')) {
      context.handle(_maghribMeta,
          maghrib.isAcceptableOrUnknown(data['maghrib']!, _maghribMeta));
    } else if (isInserting) {
      context.missing(_maghribMeta);
    }
    if (data.containsKey('isha')) {
      context.handle(
          _ishaMeta, isha.isAcceptableOrUnknown(data['isha']!, _ishaMeta));
    } else if (isInserting) {
      context.missing(_ishaMeta);
    }
    if (data.containsKey('calculation_source')) {
      context.handle(
          _calculationSourceMeta,
          calculationSource.isAcceptableOrUnknown(
              data['calculation_source']!, _calculationSourceMeta));
    } else if (isInserting) {
      context.missing(_calculationSourceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {locationId, gregorianDate},
      ];
  @override
  PrayerTimesCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrayerTimesCacheData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      locationId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_id'])!,
      gregorianDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gregorian_date'])!,
      hijriDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hijri_date'])!,
      fajr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fajr'])!,
      sunrise: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sunrise'])!,
      dhuhr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dhuhr'])!,
      asr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}asr'])!,
      maghrib: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}maghrib'])!,
      isha: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}isha'])!,
      calculationSource: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}calculation_source'])!,
    );
  }

  @override
  $PrayerTimesCacheTable createAlias(String alias) {
    return $PrayerTimesCacheTable(attachedDatabase, alias);
  }
}

class PrayerTimesCacheData extends DataClass
    implements Insertable<PrayerTimesCacheData> {
  final int id;
  final String locationId;
  final String gregorianDate;
  final String hijriDate;
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String calculationSource;
  const PrayerTimesCacheData(
      {required this.id,
      required this.locationId,
      required this.gregorianDate,
      required this.hijriDate,
      required this.fajr,
      required this.sunrise,
      required this.dhuhr,
      required this.asr,
      required this.maghrib,
      required this.isha,
      required this.calculationSource});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['location_id'] = Variable<String>(locationId);
    map['gregorian_date'] = Variable<String>(gregorianDate);
    map['hijri_date'] = Variable<String>(hijriDate);
    map['fajr'] = Variable<String>(fajr);
    map['sunrise'] = Variable<String>(sunrise);
    map['dhuhr'] = Variable<String>(dhuhr);
    map['asr'] = Variable<String>(asr);
    map['maghrib'] = Variable<String>(maghrib);
    map['isha'] = Variable<String>(isha);
    map['calculation_source'] = Variable<String>(calculationSource);
    return map;
  }

  PrayerTimesCacheCompanion toCompanion(bool nullToAbsent) {
    return PrayerTimesCacheCompanion(
      id: Value(id),
      locationId: Value(locationId),
      gregorianDate: Value(gregorianDate),
      hijriDate: Value(hijriDate),
      fajr: Value(fajr),
      sunrise: Value(sunrise),
      dhuhr: Value(dhuhr),
      asr: Value(asr),
      maghrib: Value(maghrib),
      isha: Value(isha),
      calculationSource: Value(calculationSource),
    );
  }

  factory PrayerTimesCacheData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrayerTimesCacheData(
      id: serializer.fromJson<int>(json['id']),
      locationId: serializer.fromJson<String>(json['locationId']),
      gregorianDate: serializer.fromJson<String>(json['gregorianDate']),
      hijriDate: serializer.fromJson<String>(json['hijriDate']),
      fajr: serializer.fromJson<String>(json['fajr']),
      sunrise: serializer.fromJson<String>(json['sunrise']),
      dhuhr: serializer.fromJson<String>(json['dhuhr']),
      asr: serializer.fromJson<String>(json['asr']),
      maghrib: serializer.fromJson<String>(json['maghrib']),
      isha: serializer.fromJson<String>(json['isha']),
      calculationSource: serializer.fromJson<String>(json['calculationSource']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'locationId': serializer.toJson<String>(locationId),
      'gregorianDate': serializer.toJson<String>(gregorianDate),
      'hijriDate': serializer.toJson<String>(hijriDate),
      'fajr': serializer.toJson<String>(fajr),
      'sunrise': serializer.toJson<String>(sunrise),
      'dhuhr': serializer.toJson<String>(dhuhr),
      'asr': serializer.toJson<String>(asr),
      'maghrib': serializer.toJson<String>(maghrib),
      'isha': serializer.toJson<String>(isha),
      'calculationSource': serializer.toJson<String>(calculationSource),
    };
  }

  PrayerTimesCacheData copyWith(
          {int? id,
          String? locationId,
          String? gregorianDate,
          String? hijriDate,
          String? fajr,
          String? sunrise,
          String? dhuhr,
          String? asr,
          String? maghrib,
          String? isha,
          String? calculationSource}) =>
      PrayerTimesCacheData(
        id: id ?? this.id,
        locationId: locationId ?? this.locationId,
        gregorianDate: gregorianDate ?? this.gregorianDate,
        hijriDate: hijriDate ?? this.hijriDate,
        fajr: fajr ?? this.fajr,
        sunrise: sunrise ?? this.sunrise,
        dhuhr: dhuhr ?? this.dhuhr,
        asr: asr ?? this.asr,
        maghrib: maghrib ?? this.maghrib,
        isha: isha ?? this.isha,
        calculationSource: calculationSource ?? this.calculationSource,
      );
  PrayerTimesCacheData copyWithCompanion(PrayerTimesCacheCompanion data) {
    return PrayerTimesCacheData(
      id: data.id.present ? data.id.value : this.id,
      locationId:
          data.locationId.present ? data.locationId.value : this.locationId,
      gregorianDate: data.gregorianDate.present
          ? data.gregorianDate.value
          : this.gregorianDate,
      hijriDate: data.hijriDate.present ? data.hijriDate.value : this.hijriDate,
      fajr: data.fajr.present ? data.fajr.value : this.fajr,
      sunrise: data.sunrise.present ? data.sunrise.value : this.sunrise,
      dhuhr: data.dhuhr.present ? data.dhuhr.value : this.dhuhr,
      asr: data.asr.present ? data.asr.value : this.asr,
      maghrib: data.maghrib.present ? data.maghrib.value : this.maghrib,
      isha: data.isha.present ? data.isha.value : this.isha,
      calculationSource: data.calculationSource.present
          ? data.calculationSource.value
          : this.calculationSource,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrayerTimesCacheData(')
          ..write('id: $id, ')
          ..write('locationId: $locationId, ')
          ..write('gregorianDate: $gregorianDate, ')
          ..write('hijriDate: $hijriDate, ')
          ..write('fajr: $fajr, ')
          ..write('sunrise: $sunrise, ')
          ..write('dhuhr: $dhuhr, ')
          ..write('asr: $asr, ')
          ..write('maghrib: $maghrib, ')
          ..write('isha: $isha, ')
          ..write('calculationSource: $calculationSource')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, locationId, gregorianDate, hijriDate,
      fajr, sunrise, dhuhr, asr, maghrib, isha, calculationSource);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrayerTimesCacheData &&
          other.id == this.id &&
          other.locationId == this.locationId &&
          other.gregorianDate == this.gregorianDate &&
          other.hijriDate == this.hijriDate &&
          other.fajr == this.fajr &&
          other.sunrise == this.sunrise &&
          other.dhuhr == this.dhuhr &&
          other.asr == this.asr &&
          other.maghrib == this.maghrib &&
          other.isha == this.isha &&
          other.calculationSource == this.calculationSource);
}

class PrayerTimesCacheCompanion extends UpdateCompanion<PrayerTimesCacheData> {
  final Value<int> id;
  final Value<String> locationId;
  final Value<String> gregorianDate;
  final Value<String> hijriDate;
  final Value<String> fajr;
  final Value<String> sunrise;
  final Value<String> dhuhr;
  final Value<String> asr;
  final Value<String> maghrib;
  final Value<String> isha;
  final Value<String> calculationSource;
  const PrayerTimesCacheCompanion({
    this.id = const Value.absent(),
    this.locationId = const Value.absent(),
    this.gregorianDate = const Value.absent(),
    this.hijriDate = const Value.absent(),
    this.fajr = const Value.absent(),
    this.sunrise = const Value.absent(),
    this.dhuhr = const Value.absent(),
    this.asr = const Value.absent(),
    this.maghrib = const Value.absent(),
    this.isha = const Value.absent(),
    this.calculationSource = const Value.absent(),
  });
  PrayerTimesCacheCompanion.insert({
    this.id = const Value.absent(),
    required String locationId,
    required String gregorianDate,
    required String hijriDate,
    required String fajr,
    required String sunrise,
    required String dhuhr,
    required String asr,
    required String maghrib,
    required String isha,
    required String calculationSource,
  })  : locationId = Value(locationId),
        gregorianDate = Value(gregorianDate),
        hijriDate = Value(hijriDate),
        fajr = Value(fajr),
        sunrise = Value(sunrise),
        dhuhr = Value(dhuhr),
        asr = Value(asr),
        maghrib = Value(maghrib),
        isha = Value(isha),
        calculationSource = Value(calculationSource);
  static Insertable<PrayerTimesCacheData> custom({
    Expression<int>? id,
    Expression<String>? locationId,
    Expression<String>? gregorianDate,
    Expression<String>? hijriDate,
    Expression<String>? fajr,
    Expression<String>? sunrise,
    Expression<String>? dhuhr,
    Expression<String>? asr,
    Expression<String>? maghrib,
    Expression<String>? isha,
    Expression<String>? calculationSource,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (locationId != null) 'location_id': locationId,
      if (gregorianDate != null) 'gregorian_date': gregorianDate,
      if (hijriDate != null) 'hijri_date': hijriDate,
      if (fajr != null) 'fajr': fajr,
      if (sunrise != null) 'sunrise': sunrise,
      if (dhuhr != null) 'dhuhr': dhuhr,
      if (asr != null) 'asr': asr,
      if (maghrib != null) 'maghrib': maghrib,
      if (isha != null) 'isha': isha,
      if (calculationSource != null) 'calculation_source': calculationSource,
    });
  }

  PrayerTimesCacheCompanion copyWith(
      {Value<int>? id,
      Value<String>? locationId,
      Value<String>? gregorianDate,
      Value<String>? hijriDate,
      Value<String>? fajr,
      Value<String>? sunrise,
      Value<String>? dhuhr,
      Value<String>? asr,
      Value<String>? maghrib,
      Value<String>? isha,
      Value<String>? calculationSource}) {
    return PrayerTimesCacheCompanion(
      id: id ?? this.id,
      locationId: locationId ?? this.locationId,
      gregorianDate: gregorianDate ?? this.gregorianDate,
      hijriDate: hijriDate ?? this.hijriDate,
      fajr: fajr ?? this.fajr,
      sunrise: sunrise ?? this.sunrise,
      dhuhr: dhuhr ?? this.dhuhr,
      asr: asr ?? this.asr,
      maghrib: maghrib ?? this.maghrib,
      isha: isha ?? this.isha,
      calculationSource: calculationSource ?? this.calculationSource,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (gregorianDate.present) {
      map['gregorian_date'] = Variable<String>(gregorianDate.value);
    }
    if (hijriDate.present) {
      map['hijri_date'] = Variable<String>(hijriDate.value);
    }
    if (fajr.present) {
      map['fajr'] = Variable<String>(fajr.value);
    }
    if (sunrise.present) {
      map['sunrise'] = Variable<String>(sunrise.value);
    }
    if (dhuhr.present) {
      map['dhuhr'] = Variable<String>(dhuhr.value);
    }
    if (asr.present) {
      map['asr'] = Variable<String>(asr.value);
    }
    if (maghrib.present) {
      map['maghrib'] = Variable<String>(maghrib.value);
    }
    if (isha.present) {
      map['isha'] = Variable<String>(isha.value);
    }
    if (calculationSource.present) {
      map['calculation_source'] = Variable<String>(calculationSource.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrayerTimesCacheCompanion(')
          ..write('id: $id, ')
          ..write('locationId: $locationId, ')
          ..write('gregorianDate: $gregorianDate, ')
          ..write('hijriDate: $hijriDate, ')
          ..write('fajr: $fajr, ')
          ..write('sunrise: $sunrise, ')
          ..write('dhuhr: $dhuhr, ')
          ..write('asr: $asr, ')
          ..write('maghrib: $maghrib, ')
          ..write('isha: $isha, ')
          ..write('calculationSource: $calculationSource')
          ..write(')'))
        .toString();
  }
}

class $IlmiFeedItemsTable extends IlmiFeedItems
    with TableInfo<$IlmiFeedItemsTable, IlmiFeedItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IlmiFeedItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _arabicTextMeta =
      const VerificationMeta('arabicText');
  @override
  late final GeneratedColumn<String> arabicText = GeneratedColumn<String>(
      'arabic_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _summaryBodyMeta =
      const VerificationMeta('summaryBody');
  @override
  late final GeneratedColumn<String> summaryBody = GeneratedColumn<String>(
      'summary_body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _detailedCommentaryMeta =
      const VerificationMeta('detailedCommentary');
  @override
  late final GeneratedColumn<String> detailedCommentary =
      GeneratedColumn<String>('detailed_commentary', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceReferenceMeta =
      const VerificationMeta('sourceReference');
  @override
  late final GeneratedColumn<String> sourceReference = GeneratedColumn<String>(
      'source_reference', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorOrScholarMeta =
      const VerificationMeta('authorOrScholar');
  @override
  late final GeneratedColumn<String> authorOrScholar = GeneratedColumn<String>(
      'author_or_scholar', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _bookPageRefMeta =
      const VerificationMeta('bookPageRef');
  @override
  late final GeneratedColumn<String> bookPageRef = GeneratedColumn<String>(
      'book_page_ref', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _readingTimeSecMeta =
      const VerificationMeta('readingTimeSec');
  @override
  late final GeneratedColumn<int> readingTimeSec = GeneratedColumn<int>(
      'reading_time_sec', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(30));
  static const VerificationMeta _isLikedMeta =
      const VerificationMeta('isLiked');
  @override
  late final GeneratedColumn<int> isLiked = GeneratedColumn<int>(
      'is_liked', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<int> isRead = GeneratedColumn<int>(
      'is_read', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _publishedAtMeta =
      const VerificationMeta('publishedAt');
  @override
  late final GeneratedColumn<int> publishedAt = GeneratedColumn<int>(
      'published_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        category,
        title,
        arabicText,
        summaryBody,
        detailedCommentary,
        sourceReference,
        authorOrScholar,
        bookPageRef,
        readingTimeSec,
        isLiked,
        isRead,
        publishedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ilmi_feed_items';
  @override
  VerificationContext validateIntegrity(Insertable<IlmiFeedItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('arabic_text')) {
      context.handle(
          _arabicTextMeta,
          arabicText.isAcceptableOrUnknown(
              data['arabic_text']!, _arabicTextMeta));
    }
    if (data.containsKey('summary_body')) {
      context.handle(
          _summaryBodyMeta,
          summaryBody.isAcceptableOrUnknown(
              data['summary_body']!, _summaryBodyMeta));
    } else if (isInserting) {
      context.missing(_summaryBodyMeta);
    }
    if (data.containsKey('detailed_commentary')) {
      context.handle(
          _detailedCommentaryMeta,
          detailedCommentary.isAcceptableOrUnknown(
              data['detailed_commentary']!, _detailedCommentaryMeta));
    }
    if (data.containsKey('source_reference')) {
      context.handle(
          _sourceReferenceMeta,
          sourceReference.isAcceptableOrUnknown(
              data['source_reference']!, _sourceReferenceMeta));
    } else if (isInserting) {
      context.missing(_sourceReferenceMeta);
    }
    if (data.containsKey('author_or_scholar')) {
      context.handle(
          _authorOrScholarMeta,
          authorOrScholar.isAcceptableOrUnknown(
              data['author_or_scholar']!, _authorOrScholarMeta));
    }
    if (data.containsKey('book_page_ref')) {
      context.handle(
          _bookPageRefMeta,
          bookPageRef.isAcceptableOrUnknown(
              data['book_page_ref']!, _bookPageRefMeta));
    }
    if (data.containsKey('reading_time_sec')) {
      context.handle(
          _readingTimeSecMeta,
          readingTimeSec.isAcceptableOrUnknown(
              data['reading_time_sec']!, _readingTimeSecMeta));
    }
    if (data.containsKey('is_liked')) {
      context.handle(_isLikedMeta,
          isLiked.isAcceptableOrUnknown(data['is_liked']!, _isLikedMeta));
    }
    if (data.containsKey('is_read')) {
      context.handle(_isReadMeta,
          isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta));
    }
    if (data.containsKey('published_at')) {
      context.handle(
          _publishedAtMeta,
          publishedAt.isAcceptableOrUnknown(
              data['published_at']!, _publishedAtMeta));
    } else if (isInserting) {
      context.missing(_publishedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IlmiFeedItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IlmiFeedItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      arabicText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}arabic_text']),
      summaryBody: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}summary_body'])!,
      detailedCommentary: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}detailed_commentary']),
      sourceReference: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}source_reference'])!,
      authorOrScholar: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}author_or_scholar']),
      bookPageRef: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}book_page_ref']),
      readingTimeSec: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reading_time_sec'])!,
      isLiked: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_liked'])!,
      isRead: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_read'])!,
      publishedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}published_at'])!,
    );
  }

  @override
  $IlmiFeedItemsTable createAlias(String alias) {
    return $IlmiFeedItemsTable(attachedDatabase, alias);
  }
}

class IlmiFeedItem extends DataClass implements Insertable<IlmiFeedItem> {
  final String id;
  final String category;
  final String? title;
  final String? arabicText;
  final String summaryBody;
  final String? detailedCommentary;
  final String sourceReference;
  final String? authorOrScholar;
  final String? bookPageRef;
  final int readingTimeSec;
  final int isLiked;
  final int isRead;
  final int publishedAt;
  const IlmiFeedItem(
      {required this.id,
      required this.category,
      this.title,
      this.arabicText,
      required this.summaryBody,
      this.detailedCommentary,
      required this.sourceReference,
      this.authorOrScholar,
      this.bookPageRef,
      required this.readingTimeSec,
      required this.isLiked,
      required this.isRead,
      required this.publishedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || arabicText != null) {
      map['arabic_text'] = Variable<String>(arabicText);
    }
    map['summary_body'] = Variable<String>(summaryBody);
    if (!nullToAbsent || detailedCommentary != null) {
      map['detailed_commentary'] = Variable<String>(detailedCommentary);
    }
    map['source_reference'] = Variable<String>(sourceReference);
    if (!nullToAbsent || authorOrScholar != null) {
      map['author_or_scholar'] = Variable<String>(authorOrScholar);
    }
    if (!nullToAbsent || bookPageRef != null) {
      map['book_page_ref'] = Variable<String>(bookPageRef);
    }
    map['reading_time_sec'] = Variable<int>(readingTimeSec);
    map['is_liked'] = Variable<int>(isLiked);
    map['is_read'] = Variable<int>(isRead);
    map['published_at'] = Variable<int>(publishedAt);
    return map;
  }

  IlmiFeedItemsCompanion toCompanion(bool nullToAbsent) {
    return IlmiFeedItemsCompanion(
      id: Value(id),
      category: Value(category),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      arabicText: arabicText == null && nullToAbsent
          ? const Value.absent()
          : Value(arabicText),
      summaryBody: Value(summaryBody),
      detailedCommentary: detailedCommentary == null && nullToAbsent
          ? const Value.absent()
          : Value(detailedCommentary),
      sourceReference: Value(sourceReference),
      authorOrScholar: authorOrScholar == null && nullToAbsent
          ? const Value.absent()
          : Value(authorOrScholar),
      bookPageRef: bookPageRef == null && nullToAbsent
          ? const Value.absent()
          : Value(bookPageRef),
      readingTimeSec: Value(readingTimeSec),
      isLiked: Value(isLiked),
      isRead: Value(isRead),
      publishedAt: Value(publishedAt),
    );
  }

  factory IlmiFeedItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IlmiFeedItem(
      id: serializer.fromJson<String>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      title: serializer.fromJson<String?>(json['title']),
      arabicText: serializer.fromJson<String?>(json['arabicText']),
      summaryBody: serializer.fromJson<String>(json['summaryBody']),
      detailedCommentary:
          serializer.fromJson<String?>(json['detailedCommentary']),
      sourceReference: serializer.fromJson<String>(json['sourceReference']),
      authorOrScholar: serializer.fromJson<String?>(json['authorOrScholar']),
      bookPageRef: serializer.fromJson<String?>(json['bookPageRef']),
      readingTimeSec: serializer.fromJson<int>(json['readingTimeSec']),
      isLiked: serializer.fromJson<int>(json['isLiked']),
      isRead: serializer.fromJson<int>(json['isRead']),
      publishedAt: serializer.fromJson<int>(json['publishedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'category': serializer.toJson<String>(category),
      'title': serializer.toJson<String?>(title),
      'arabicText': serializer.toJson<String?>(arabicText),
      'summaryBody': serializer.toJson<String>(summaryBody),
      'detailedCommentary': serializer.toJson<String?>(detailedCommentary),
      'sourceReference': serializer.toJson<String>(sourceReference),
      'authorOrScholar': serializer.toJson<String?>(authorOrScholar),
      'bookPageRef': serializer.toJson<String?>(bookPageRef),
      'readingTimeSec': serializer.toJson<int>(readingTimeSec),
      'isLiked': serializer.toJson<int>(isLiked),
      'isRead': serializer.toJson<int>(isRead),
      'publishedAt': serializer.toJson<int>(publishedAt),
    };
  }

  IlmiFeedItem copyWith(
          {String? id,
          String? category,
          Value<String?> title = const Value.absent(),
          Value<String?> arabicText = const Value.absent(),
          String? summaryBody,
          Value<String?> detailedCommentary = const Value.absent(),
          String? sourceReference,
          Value<String?> authorOrScholar = const Value.absent(),
          Value<String?> bookPageRef = const Value.absent(),
          int? readingTimeSec,
          int? isLiked,
          int? isRead,
          int? publishedAt}) =>
      IlmiFeedItem(
        id: id ?? this.id,
        category: category ?? this.category,
        title: title.present ? title.value : this.title,
        arabicText: arabicText.present ? arabicText.value : this.arabicText,
        summaryBody: summaryBody ?? this.summaryBody,
        detailedCommentary: detailedCommentary.present
            ? detailedCommentary.value
            : this.detailedCommentary,
        sourceReference: sourceReference ?? this.sourceReference,
        authorOrScholar: authorOrScholar.present
            ? authorOrScholar.value
            : this.authorOrScholar,
        bookPageRef: bookPageRef.present ? bookPageRef.value : this.bookPageRef,
        readingTimeSec: readingTimeSec ?? this.readingTimeSec,
        isLiked: isLiked ?? this.isLiked,
        isRead: isRead ?? this.isRead,
        publishedAt: publishedAt ?? this.publishedAt,
      );
  IlmiFeedItem copyWithCompanion(IlmiFeedItemsCompanion data) {
    return IlmiFeedItem(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      title: data.title.present ? data.title.value : this.title,
      arabicText:
          data.arabicText.present ? data.arabicText.value : this.arabicText,
      summaryBody:
          data.summaryBody.present ? data.summaryBody.value : this.summaryBody,
      detailedCommentary: data.detailedCommentary.present
          ? data.detailedCommentary.value
          : this.detailedCommentary,
      sourceReference: data.sourceReference.present
          ? data.sourceReference.value
          : this.sourceReference,
      authorOrScholar: data.authorOrScholar.present
          ? data.authorOrScholar.value
          : this.authorOrScholar,
      bookPageRef:
          data.bookPageRef.present ? data.bookPageRef.value : this.bookPageRef,
      readingTimeSec: data.readingTimeSec.present
          ? data.readingTimeSec.value
          : this.readingTimeSec,
      isLiked: data.isLiked.present ? data.isLiked.value : this.isLiked,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      publishedAt:
          data.publishedAt.present ? data.publishedAt.value : this.publishedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IlmiFeedItem(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('title: $title, ')
          ..write('arabicText: $arabicText, ')
          ..write('summaryBody: $summaryBody, ')
          ..write('detailedCommentary: $detailedCommentary, ')
          ..write('sourceReference: $sourceReference, ')
          ..write('authorOrScholar: $authorOrScholar, ')
          ..write('bookPageRef: $bookPageRef, ')
          ..write('readingTimeSec: $readingTimeSec, ')
          ..write('isLiked: $isLiked, ')
          ..write('isRead: $isRead, ')
          ..write('publishedAt: $publishedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      category,
      title,
      arabicText,
      summaryBody,
      detailedCommentary,
      sourceReference,
      authorOrScholar,
      bookPageRef,
      readingTimeSec,
      isLiked,
      isRead,
      publishedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IlmiFeedItem &&
          other.id == this.id &&
          other.category == this.category &&
          other.title == this.title &&
          other.arabicText == this.arabicText &&
          other.summaryBody == this.summaryBody &&
          other.detailedCommentary == this.detailedCommentary &&
          other.sourceReference == this.sourceReference &&
          other.authorOrScholar == this.authorOrScholar &&
          other.bookPageRef == this.bookPageRef &&
          other.readingTimeSec == this.readingTimeSec &&
          other.isLiked == this.isLiked &&
          other.isRead == this.isRead &&
          other.publishedAt == this.publishedAt);
}

class IlmiFeedItemsCompanion extends UpdateCompanion<IlmiFeedItem> {
  final Value<String> id;
  final Value<String> category;
  final Value<String?> title;
  final Value<String?> arabicText;
  final Value<String> summaryBody;
  final Value<String?> detailedCommentary;
  final Value<String> sourceReference;
  final Value<String?> authorOrScholar;
  final Value<String?> bookPageRef;
  final Value<int> readingTimeSec;
  final Value<int> isLiked;
  final Value<int> isRead;
  final Value<int> publishedAt;
  final Value<int> rowid;
  const IlmiFeedItemsCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.title = const Value.absent(),
    this.arabicText = const Value.absent(),
    this.summaryBody = const Value.absent(),
    this.detailedCommentary = const Value.absent(),
    this.sourceReference = const Value.absent(),
    this.authorOrScholar = const Value.absent(),
    this.bookPageRef = const Value.absent(),
    this.readingTimeSec = const Value.absent(),
    this.isLiked = const Value.absent(),
    this.isRead = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IlmiFeedItemsCompanion.insert({
    required String id,
    required String category,
    this.title = const Value.absent(),
    this.arabicText = const Value.absent(),
    required String summaryBody,
    this.detailedCommentary = const Value.absent(),
    required String sourceReference,
    this.authorOrScholar = const Value.absent(),
    this.bookPageRef = const Value.absent(),
    this.readingTimeSec = const Value.absent(),
    this.isLiked = const Value.absent(),
    this.isRead = const Value.absent(),
    required int publishedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        category = Value(category),
        summaryBody = Value(summaryBody),
        sourceReference = Value(sourceReference),
        publishedAt = Value(publishedAt);
  static Insertable<IlmiFeedItem> custom({
    Expression<String>? id,
    Expression<String>? category,
    Expression<String>? title,
    Expression<String>? arabicText,
    Expression<String>? summaryBody,
    Expression<String>? detailedCommentary,
    Expression<String>? sourceReference,
    Expression<String>? authorOrScholar,
    Expression<String>? bookPageRef,
    Expression<int>? readingTimeSec,
    Expression<int>? isLiked,
    Expression<int>? isRead,
    Expression<int>? publishedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (title != null) 'title': title,
      if (arabicText != null) 'arabic_text': arabicText,
      if (summaryBody != null) 'summary_body': summaryBody,
      if (detailedCommentary != null) 'detailed_commentary': detailedCommentary,
      if (sourceReference != null) 'source_reference': sourceReference,
      if (authorOrScholar != null) 'author_or_scholar': authorOrScholar,
      if (bookPageRef != null) 'book_page_ref': bookPageRef,
      if (readingTimeSec != null) 'reading_time_sec': readingTimeSec,
      if (isLiked != null) 'is_liked': isLiked,
      if (isRead != null) 'is_read': isRead,
      if (publishedAt != null) 'published_at': publishedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IlmiFeedItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? category,
      Value<String?>? title,
      Value<String?>? arabicText,
      Value<String>? summaryBody,
      Value<String?>? detailedCommentary,
      Value<String>? sourceReference,
      Value<String?>? authorOrScholar,
      Value<String?>? bookPageRef,
      Value<int>? readingTimeSec,
      Value<int>? isLiked,
      Value<int>? isRead,
      Value<int>? publishedAt,
      Value<int>? rowid}) {
    return IlmiFeedItemsCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      arabicText: arabicText ?? this.arabicText,
      summaryBody: summaryBody ?? this.summaryBody,
      detailedCommentary: detailedCommentary ?? this.detailedCommentary,
      sourceReference: sourceReference ?? this.sourceReference,
      authorOrScholar: authorOrScholar ?? this.authorOrScholar,
      bookPageRef: bookPageRef ?? this.bookPageRef,
      readingTimeSec: readingTimeSec ?? this.readingTimeSec,
      isLiked: isLiked ?? this.isLiked,
      isRead: isRead ?? this.isRead,
      publishedAt: publishedAt ?? this.publishedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (arabicText.present) {
      map['arabic_text'] = Variable<String>(arabicText.value);
    }
    if (summaryBody.present) {
      map['summary_body'] = Variable<String>(summaryBody.value);
    }
    if (detailedCommentary.present) {
      map['detailed_commentary'] = Variable<String>(detailedCommentary.value);
    }
    if (sourceReference.present) {
      map['source_reference'] = Variable<String>(sourceReference.value);
    }
    if (authorOrScholar.present) {
      map['author_or_scholar'] = Variable<String>(authorOrScholar.value);
    }
    if (bookPageRef.present) {
      map['book_page_ref'] = Variable<String>(bookPageRef.value);
    }
    if (readingTimeSec.present) {
      map['reading_time_sec'] = Variable<int>(readingTimeSec.value);
    }
    if (isLiked.present) {
      map['is_liked'] = Variable<int>(isLiked.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<int>(isRead.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<int>(publishedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IlmiFeedItemsCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('title: $title, ')
          ..write('arabicText: $arabicText, ')
          ..write('summaryBody: $summaryBody, ')
          ..write('detailedCommentary: $detailedCommentary, ')
          ..write('sourceReference: $sourceReference, ')
          ..write('authorOrScholar: $authorOrScholar, ')
          ..write('bookPageRef: $bookPageRef, ')
          ..write('readingTimeSec: $readingTimeSec, ')
          ..write('isLiked: $isLiked, ')
          ..write('isRead: $isRead, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CollectionsTable extends Collections
    with TableInfo<$CollectionsTable, Collection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
      'color_hex', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, colorHex, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collections';
  @override
  VerificationContext validateIntegrity(Insertable<Collection> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    } else if (isInserting) {
      context.missing(_colorHexMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Collection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Collection(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_hex'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CollectionsTable createAlias(String alias) {
    return $CollectionsTable(attachedDatabase, alias);
  }
}

class Collection extends DataClass implements Insertable<Collection> {
  final String id;
  final String name;
  final String colorHex;
  final int createdAt;
  const Collection(
      {required this.id,
      required this.name,
      required this.colorHex,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['color_hex'] = Variable<String>(colorHex);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  CollectionsCompanion toCompanion(bool nullToAbsent) {
    return CollectionsCompanion(
      id: Value(id),
      name: Value(name),
      colorHex: Value(colorHex),
      createdAt: Value(createdAt),
    );
  }

  factory Collection.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Collection(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'colorHex': serializer.toJson<String>(colorHex),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  Collection copyWith(
          {String? id, String? name, String? colorHex, int? createdAt}) =>
      Collection(
        id: id ?? this.id,
        name: name ?? this.name,
        colorHex: colorHex ?? this.colorHex,
        createdAt: createdAt ?? this.createdAt,
      );
  Collection copyWithCompanion(CollectionsCompanion data) {
    return Collection(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Collection(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorHex: $colorHex, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, colorHex, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Collection &&
          other.id == this.id &&
          other.name == this.name &&
          other.colorHex == this.colorHex &&
          other.createdAt == this.createdAt);
}

class CollectionsCompanion extends UpdateCompanion<Collection> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> colorHex;
  final Value<int> createdAt;
  final Value<int> rowid;
  const CollectionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CollectionsCompanion.insert({
    required String id,
    required String name,
    required String colorHex,
    required int createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        colorHex = Value(colorHex),
        createdAt = Value(createdAt);
  static Insertable<Collection> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? colorHex,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (colorHex != null) 'color_hex': colorHex,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CollectionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? colorHex,
      Value<int>? createdAt,
      Value<int>? rowid}) {
    return CollectionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      colorHex: colorHex ?? this.colorHex,
      createdAt: createdAt ?? this.createdAt,
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
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorHex: $colorHex, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavedItemsTable extends SavedItems
    with TableInfo<$SavedItemsTable, SavedItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _collectionIdMeta =
      const VerificationMeta('collectionId');
  @override
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
      'collection_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES collections (id) ON DELETE CASCADE'));
  static const VerificationMeta _targetTypeMeta =
      const VerificationMeta('targetType');
  @override
  late final GeneratedColumn<String> targetType = GeneratedColumn<String>(
      'target_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetIdMeta =
      const VerificationMeta('targetId');
  @override
  late final GeneratedColumn<String> targetId = GeneratedColumn<String>(
      'target_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _savedAtMeta =
      const VerificationMeta('savedAt');
  @override
  late final GeneratedColumn<int> savedAt = GeneratedColumn<int>(
      'saved_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, collectionId, targetType, targetId, savedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_items';
  @override
  VerificationContext validateIntegrity(Insertable<SavedItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collection_id')) {
      context.handle(
          _collectionIdMeta,
          collectionId.isAcceptableOrUnknown(
              data['collection_id']!, _collectionIdMeta));
    }
    if (data.containsKey('target_type')) {
      context.handle(
          _targetTypeMeta,
          targetType.isAcceptableOrUnknown(
              data['target_type']!, _targetTypeMeta));
    } else if (isInserting) {
      context.missing(_targetTypeMeta);
    }
    if (data.containsKey('target_id')) {
      context.handle(_targetIdMeta,
          targetId.isAcceptableOrUnknown(data['target_id']!, _targetIdMeta));
    } else if (isInserting) {
      context.missing(_targetIdMeta);
    }
    if (data.containsKey('saved_at')) {
      context.handle(_savedAtMeta,
          savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta));
    } else if (isInserting) {
      context.missing(_savedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {collectionId, targetType, targetId},
      ];
  @override
  SavedItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      collectionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}collection_id']),
      targetType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target_type'])!,
      targetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target_id'])!,
      savedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}saved_at'])!,
    );
  }

  @override
  $SavedItemsTable createAlias(String alias) {
    return $SavedItemsTable(attachedDatabase, alias);
  }
}

class SavedItem extends DataClass implements Insertable<SavedItem> {
  final int id;
  final String? collectionId;
  final String targetType;
  final String targetId;
  final int savedAt;
  const SavedItem(
      {required this.id,
      this.collectionId,
      required this.targetType,
      required this.targetId,
      required this.savedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || collectionId != null) {
      map['collection_id'] = Variable<String>(collectionId);
    }
    map['target_type'] = Variable<String>(targetType);
    map['target_id'] = Variable<String>(targetId);
    map['saved_at'] = Variable<int>(savedAt);
    return map;
  }

  SavedItemsCompanion toCompanion(bool nullToAbsent) {
    return SavedItemsCompanion(
      id: Value(id),
      collectionId: collectionId == null && nullToAbsent
          ? const Value.absent()
          : Value(collectionId),
      targetType: Value(targetType),
      targetId: Value(targetId),
      savedAt: Value(savedAt),
    );
  }

  factory SavedItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedItem(
      id: serializer.fromJson<int>(json['id']),
      collectionId: serializer.fromJson<String?>(json['collectionId']),
      targetType: serializer.fromJson<String>(json['targetType']),
      targetId: serializer.fromJson<String>(json['targetId']),
      savedAt: serializer.fromJson<int>(json['savedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'collectionId': serializer.toJson<String?>(collectionId),
      'targetType': serializer.toJson<String>(targetType),
      'targetId': serializer.toJson<String>(targetId),
      'savedAt': serializer.toJson<int>(savedAt),
    };
  }

  SavedItem copyWith(
          {int? id,
          Value<String?> collectionId = const Value.absent(),
          String? targetType,
          String? targetId,
          int? savedAt}) =>
      SavedItem(
        id: id ?? this.id,
        collectionId:
            collectionId.present ? collectionId.value : this.collectionId,
        targetType: targetType ?? this.targetType,
        targetId: targetId ?? this.targetId,
        savedAt: savedAt ?? this.savedAt,
      );
  SavedItem copyWithCompanion(SavedItemsCompanion data) {
    return SavedItem(
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      targetType:
          data.targetType.present ? data.targetType.value : this.targetType,
      targetId: data.targetId.present ? data.targetId.value : this.targetId,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedItem(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('targetType: $targetType, ')
          ..write('targetId: $targetId, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, collectionId, targetType, targetId, savedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedItem &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.targetType == this.targetType &&
          other.targetId == this.targetId &&
          other.savedAt == this.savedAt);
}

class SavedItemsCompanion extends UpdateCompanion<SavedItem> {
  final Value<int> id;
  final Value<String?> collectionId;
  final Value<String> targetType;
  final Value<String> targetId;
  final Value<int> savedAt;
  const SavedItemsCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.targetType = const Value.absent(),
    this.targetId = const Value.absent(),
    this.savedAt = const Value.absent(),
  });
  SavedItemsCompanion.insert({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    required String targetType,
    required String targetId,
    required int savedAt,
  })  : targetType = Value(targetType),
        targetId = Value(targetId),
        savedAt = Value(savedAt);
  static Insertable<SavedItem> custom({
    Expression<int>? id,
    Expression<String>? collectionId,
    Expression<String>? targetType,
    Expression<String>? targetId,
    Expression<int>? savedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (targetType != null) 'target_type': targetType,
      if (targetId != null) 'target_id': targetId,
      if (savedAt != null) 'saved_at': savedAt,
    });
  }

  SavedItemsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? collectionId,
      Value<String>? targetType,
      Value<String>? targetId,
      Value<int>? savedAt}) {
    return SavedItemsCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      savedAt: savedAt ?? this.savedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (targetType.present) {
      map['target_type'] = Variable<String>(targetType.value);
    }
    if (targetId.present) {
      map['target_id'] = Variable<String>(targetId.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<int>(savedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedItemsCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('targetType: $targetType, ')
          ..write('targetId: $targetId, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }
}

class $ErkamDuaPagesTable extends ErkamDuaPages
    with TableInfo<$ErkamDuaPagesTable, ErkamDuaPage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ErkamDuaPagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pageNumberMeta =
      const VerificationMeta('pageNumber');
  @override
  late final GeneratedColumn<int> pageNumber = GeneratedColumn<int>(
      'page_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _chapterTitleMeta =
      const VerificationMeta('chapterTitle');
  @override
  late final GeneratedColumn<String> chapterTitle = GeneratedColumn<String>(
      'chapter_title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subTitleMeta =
      const VerificationMeta('subTitle');
  @override
  late final GeneratedColumn<String> subTitle = GeneratedColumn<String>(
      'sub_title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _arabicContentMeta =
      const VerificationMeta('arabicContent');
  @override
  late final GeneratedColumn<String> arabicContent = GeneratedColumn<String>(
      'arabic_content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _transliterationTrMeta =
      const VerificationMeta('transliterationTr');
  @override
  late final GeneratedColumn<String> transliterationTr =
      GeneratedColumn<String>('transliteration_tr', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _meaningTrMeta =
      const VerificationMeta('meaningTr');
  @override
  late final GeneratedColumn<String> meaningTr = GeneratedColumn<String>(
      'meaning_tr', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _virtueAndSourceMeta =
      const VerificationMeta('virtueAndSource');
  @override
  late final GeneratedColumn<String> virtueAndSource = GeneratedColumn<String>(
      'virtue_and_source', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _recommendedCountMeta =
      const VerificationMeta('recommendedCount');
  @override
  late final GeneratedColumn<int> recommendedCount = GeneratedColumn<int>(
      'recommended_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _audioAssetUrlMeta =
      const VerificationMeta('audioAssetUrl');
  @override
  late final GeneratedColumn<String> audioAssetUrl = GeneratedColumn<String>(
      'audio_asset_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<int> isFavorite = GeneratedColumn<int>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastReadAtMeta =
      const VerificationMeta('lastReadAt');
  @override
  late final GeneratedColumn<int> lastReadAt = GeneratedColumn<int>(
      'last_read_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        pageNumber,
        chapterTitle,
        subTitle,
        arabicContent,
        transliterationTr,
        meaningTr,
        virtueAndSource,
        recommendedCount,
        audioAssetUrl,
        isFavorite,
        lastReadAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'erkam_dua_pages';
  @override
  VerificationContext validateIntegrity(Insertable<ErkamDuaPage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('page_number')) {
      context.handle(
          _pageNumberMeta,
          pageNumber.isAcceptableOrUnknown(
              data['page_number']!, _pageNumberMeta));
    }
    if (data.containsKey('chapter_title')) {
      context.handle(
          _chapterTitleMeta,
          chapterTitle.isAcceptableOrUnknown(
              data['chapter_title']!, _chapterTitleMeta));
    } else if (isInserting) {
      context.missing(_chapterTitleMeta);
    }
    if (data.containsKey('sub_title')) {
      context.handle(_subTitleMeta,
          subTitle.isAcceptableOrUnknown(data['sub_title']!, _subTitleMeta));
    }
    if (data.containsKey('arabic_content')) {
      context.handle(
          _arabicContentMeta,
          arabicContent.isAcceptableOrUnknown(
              data['arabic_content']!, _arabicContentMeta));
    }
    if (data.containsKey('transliteration_tr')) {
      context.handle(
          _transliterationTrMeta,
          transliterationTr.isAcceptableOrUnknown(
              data['transliteration_tr']!, _transliterationTrMeta));
    }
    if (data.containsKey('meaning_tr')) {
      context.handle(_meaningTrMeta,
          meaningTr.isAcceptableOrUnknown(data['meaning_tr']!, _meaningTrMeta));
    } else if (isInserting) {
      context.missing(_meaningTrMeta);
    }
    if (data.containsKey('virtue_and_source')) {
      context.handle(
          _virtueAndSourceMeta,
          virtueAndSource.isAcceptableOrUnknown(
              data['virtue_and_source']!, _virtueAndSourceMeta));
    }
    if (data.containsKey('recommended_count')) {
      context.handle(
          _recommendedCountMeta,
          recommendedCount.isAcceptableOrUnknown(
              data['recommended_count']!, _recommendedCountMeta));
    }
    if (data.containsKey('audio_asset_url')) {
      context.handle(
          _audioAssetUrlMeta,
          audioAssetUrl.isAcceptableOrUnknown(
              data['audio_asset_url']!, _audioAssetUrlMeta));
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    if (data.containsKey('last_read_at')) {
      context.handle(
          _lastReadAtMeta,
          lastReadAt.isAcceptableOrUnknown(
              data['last_read_at']!, _lastReadAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pageNumber};
  @override
  ErkamDuaPage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ErkamDuaPage(
      pageNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}page_number'])!,
      chapterTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}chapter_title'])!,
      subTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sub_title']),
      arabicContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}arabic_content']),
      transliterationTr: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}transliteration_tr']),
      meaningTr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meaning_tr'])!,
      virtueAndSource: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}virtue_and_source']),
      recommendedCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}recommended_count']),
      audioAssetUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}audio_asset_url']),
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_favorite'])!,
      lastReadAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_read_at']),
    );
  }

  @override
  $ErkamDuaPagesTable createAlias(String alias) {
    return $ErkamDuaPagesTable(attachedDatabase, alias);
  }
}

class ErkamDuaPage extends DataClass implements Insertable<ErkamDuaPage> {
  final int pageNumber;
  final String chapterTitle;
  final String? subTitle;
  final String? arabicContent;
  final String? transliterationTr;
  final String meaningTr;
  final String? virtueAndSource;
  final int? recommendedCount;
  final String? audioAssetUrl;
  final int isFavorite;
  final int? lastReadAt;
  const ErkamDuaPage(
      {required this.pageNumber,
      required this.chapterTitle,
      this.subTitle,
      this.arabicContent,
      this.transliterationTr,
      required this.meaningTr,
      this.virtueAndSource,
      this.recommendedCount,
      this.audioAssetUrl,
      required this.isFavorite,
      this.lastReadAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['page_number'] = Variable<int>(pageNumber);
    map['chapter_title'] = Variable<String>(chapterTitle);
    if (!nullToAbsent || subTitle != null) {
      map['sub_title'] = Variable<String>(subTitle);
    }
    if (!nullToAbsent || arabicContent != null) {
      map['arabic_content'] = Variable<String>(arabicContent);
    }
    if (!nullToAbsent || transliterationTr != null) {
      map['transliteration_tr'] = Variable<String>(transliterationTr);
    }
    map['meaning_tr'] = Variable<String>(meaningTr);
    if (!nullToAbsent || virtueAndSource != null) {
      map['virtue_and_source'] = Variable<String>(virtueAndSource);
    }
    if (!nullToAbsent || recommendedCount != null) {
      map['recommended_count'] = Variable<int>(recommendedCount);
    }
    if (!nullToAbsent || audioAssetUrl != null) {
      map['audio_asset_url'] = Variable<String>(audioAssetUrl);
    }
    map['is_favorite'] = Variable<int>(isFavorite);
    if (!nullToAbsent || lastReadAt != null) {
      map['last_read_at'] = Variable<int>(lastReadAt);
    }
    return map;
  }

  ErkamDuaPagesCompanion toCompanion(bool nullToAbsent) {
    return ErkamDuaPagesCompanion(
      pageNumber: Value(pageNumber),
      chapterTitle: Value(chapterTitle),
      subTitle: subTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(subTitle),
      arabicContent: arabicContent == null && nullToAbsent
          ? const Value.absent()
          : Value(arabicContent),
      transliterationTr: transliterationTr == null && nullToAbsent
          ? const Value.absent()
          : Value(transliterationTr),
      meaningTr: Value(meaningTr),
      virtueAndSource: virtueAndSource == null && nullToAbsent
          ? const Value.absent()
          : Value(virtueAndSource),
      recommendedCount: recommendedCount == null && nullToAbsent
          ? const Value.absent()
          : Value(recommendedCount),
      audioAssetUrl: audioAssetUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(audioAssetUrl),
      isFavorite: Value(isFavorite),
      lastReadAt: lastReadAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReadAt),
    );
  }

  factory ErkamDuaPage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ErkamDuaPage(
      pageNumber: serializer.fromJson<int>(json['pageNumber']),
      chapterTitle: serializer.fromJson<String>(json['chapterTitle']),
      subTitle: serializer.fromJson<String?>(json['subTitle']),
      arabicContent: serializer.fromJson<String?>(json['arabicContent']),
      transliterationTr:
          serializer.fromJson<String?>(json['transliterationTr']),
      meaningTr: serializer.fromJson<String>(json['meaningTr']),
      virtueAndSource: serializer.fromJson<String?>(json['virtueAndSource']),
      recommendedCount: serializer.fromJson<int?>(json['recommendedCount']),
      audioAssetUrl: serializer.fromJson<String?>(json['audioAssetUrl']),
      isFavorite: serializer.fromJson<int>(json['isFavorite']),
      lastReadAt: serializer.fromJson<int?>(json['lastReadAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pageNumber': serializer.toJson<int>(pageNumber),
      'chapterTitle': serializer.toJson<String>(chapterTitle),
      'subTitle': serializer.toJson<String?>(subTitle),
      'arabicContent': serializer.toJson<String?>(arabicContent),
      'transliterationTr': serializer.toJson<String?>(transliterationTr),
      'meaningTr': serializer.toJson<String>(meaningTr),
      'virtueAndSource': serializer.toJson<String?>(virtueAndSource),
      'recommendedCount': serializer.toJson<int?>(recommendedCount),
      'audioAssetUrl': serializer.toJson<String?>(audioAssetUrl),
      'isFavorite': serializer.toJson<int>(isFavorite),
      'lastReadAt': serializer.toJson<int?>(lastReadAt),
    };
  }

  ErkamDuaPage copyWith(
          {int? pageNumber,
          String? chapterTitle,
          Value<String?> subTitle = const Value.absent(),
          Value<String?> arabicContent = const Value.absent(),
          Value<String?> transliterationTr = const Value.absent(),
          String? meaningTr,
          Value<String?> virtueAndSource = const Value.absent(),
          Value<int?> recommendedCount = const Value.absent(),
          Value<String?> audioAssetUrl = const Value.absent(),
          int? isFavorite,
          Value<int?> lastReadAt = const Value.absent()}) =>
      ErkamDuaPage(
        pageNumber: pageNumber ?? this.pageNumber,
        chapterTitle: chapterTitle ?? this.chapterTitle,
        subTitle: subTitle.present ? subTitle.value : this.subTitle,
        arabicContent:
            arabicContent.present ? arabicContent.value : this.arabicContent,
        transliterationTr: transliterationTr.present
            ? transliterationTr.value
            : this.transliterationTr,
        meaningTr: meaningTr ?? this.meaningTr,
        virtueAndSource: virtueAndSource.present
            ? virtueAndSource.value
            : this.virtueAndSource,
        recommendedCount: recommendedCount.present
            ? recommendedCount.value
            : this.recommendedCount,
        audioAssetUrl:
            audioAssetUrl.present ? audioAssetUrl.value : this.audioAssetUrl,
        isFavorite: isFavorite ?? this.isFavorite,
        lastReadAt: lastReadAt.present ? lastReadAt.value : this.lastReadAt,
      );
  ErkamDuaPage copyWithCompanion(ErkamDuaPagesCompanion data) {
    return ErkamDuaPage(
      pageNumber:
          data.pageNumber.present ? data.pageNumber.value : this.pageNumber,
      chapterTitle: data.chapterTitle.present
          ? data.chapterTitle.value
          : this.chapterTitle,
      subTitle: data.subTitle.present ? data.subTitle.value : this.subTitle,
      arabicContent: data.arabicContent.present
          ? data.arabicContent.value
          : this.arabicContent,
      transliterationTr: data.transliterationTr.present
          ? data.transliterationTr.value
          : this.transliterationTr,
      meaningTr: data.meaningTr.present ? data.meaningTr.value : this.meaningTr,
      virtueAndSource: data.virtueAndSource.present
          ? data.virtueAndSource.value
          : this.virtueAndSource,
      recommendedCount: data.recommendedCount.present
          ? data.recommendedCount.value
          : this.recommendedCount,
      audioAssetUrl: data.audioAssetUrl.present
          ? data.audioAssetUrl.value
          : this.audioAssetUrl,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      lastReadAt:
          data.lastReadAt.present ? data.lastReadAt.value : this.lastReadAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ErkamDuaPage(')
          ..write('pageNumber: $pageNumber, ')
          ..write('chapterTitle: $chapterTitle, ')
          ..write('subTitle: $subTitle, ')
          ..write('arabicContent: $arabicContent, ')
          ..write('transliterationTr: $transliterationTr, ')
          ..write('meaningTr: $meaningTr, ')
          ..write('virtueAndSource: $virtueAndSource, ')
          ..write('recommendedCount: $recommendedCount, ')
          ..write('audioAssetUrl: $audioAssetUrl, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('lastReadAt: $lastReadAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      pageNumber,
      chapterTitle,
      subTitle,
      arabicContent,
      transliterationTr,
      meaningTr,
      virtueAndSource,
      recommendedCount,
      audioAssetUrl,
      isFavorite,
      lastReadAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ErkamDuaPage &&
          other.pageNumber == this.pageNumber &&
          other.chapterTitle == this.chapterTitle &&
          other.subTitle == this.subTitle &&
          other.arabicContent == this.arabicContent &&
          other.transliterationTr == this.transliterationTr &&
          other.meaningTr == this.meaningTr &&
          other.virtueAndSource == this.virtueAndSource &&
          other.recommendedCount == this.recommendedCount &&
          other.audioAssetUrl == this.audioAssetUrl &&
          other.isFavorite == this.isFavorite &&
          other.lastReadAt == this.lastReadAt);
}

class ErkamDuaPagesCompanion extends UpdateCompanion<ErkamDuaPage> {
  final Value<int> pageNumber;
  final Value<String> chapterTitle;
  final Value<String?> subTitle;
  final Value<String?> arabicContent;
  final Value<String?> transliterationTr;
  final Value<String> meaningTr;
  final Value<String?> virtueAndSource;
  final Value<int?> recommendedCount;
  final Value<String?> audioAssetUrl;
  final Value<int> isFavorite;
  final Value<int?> lastReadAt;
  const ErkamDuaPagesCompanion({
    this.pageNumber = const Value.absent(),
    this.chapterTitle = const Value.absent(),
    this.subTitle = const Value.absent(),
    this.arabicContent = const Value.absent(),
    this.transliterationTr = const Value.absent(),
    this.meaningTr = const Value.absent(),
    this.virtueAndSource = const Value.absent(),
    this.recommendedCount = const Value.absent(),
    this.audioAssetUrl = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.lastReadAt = const Value.absent(),
  });
  ErkamDuaPagesCompanion.insert({
    this.pageNumber = const Value.absent(),
    required String chapterTitle,
    this.subTitle = const Value.absent(),
    this.arabicContent = const Value.absent(),
    this.transliterationTr = const Value.absent(),
    required String meaningTr,
    this.virtueAndSource = const Value.absent(),
    this.recommendedCount = const Value.absent(),
    this.audioAssetUrl = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.lastReadAt = const Value.absent(),
  })  : chapterTitle = Value(chapterTitle),
        meaningTr = Value(meaningTr);
  static Insertable<ErkamDuaPage> custom({
    Expression<int>? pageNumber,
    Expression<String>? chapterTitle,
    Expression<String>? subTitle,
    Expression<String>? arabicContent,
    Expression<String>? transliterationTr,
    Expression<String>? meaningTr,
    Expression<String>? virtueAndSource,
    Expression<int>? recommendedCount,
    Expression<String>? audioAssetUrl,
    Expression<int>? isFavorite,
    Expression<int>? lastReadAt,
  }) {
    return RawValuesInsertable({
      if (pageNumber != null) 'page_number': pageNumber,
      if (chapterTitle != null) 'chapter_title': chapterTitle,
      if (subTitle != null) 'sub_title': subTitle,
      if (arabicContent != null) 'arabic_content': arabicContent,
      if (transliterationTr != null) 'transliteration_tr': transliterationTr,
      if (meaningTr != null) 'meaning_tr': meaningTr,
      if (virtueAndSource != null) 'virtue_and_source': virtueAndSource,
      if (recommendedCount != null) 'recommended_count': recommendedCount,
      if (audioAssetUrl != null) 'audio_asset_url': audioAssetUrl,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (lastReadAt != null) 'last_read_at': lastReadAt,
    });
  }

  ErkamDuaPagesCompanion copyWith(
      {Value<int>? pageNumber,
      Value<String>? chapterTitle,
      Value<String?>? subTitle,
      Value<String?>? arabicContent,
      Value<String?>? transliterationTr,
      Value<String>? meaningTr,
      Value<String?>? virtueAndSource,
      Value<int?>? recommendedCount,
      Value<String?>? audioAssetUrl,
      Value<int>? isFavorite,
      Value<int?>? lastReadAt}) {
    return ErkamDuaPagesCompanion(
      pageNumber: pageNumber ?? this.pageNumber,
      chapterTitle: chapterTitle ?? this.chapterTitle,
      subTitle: subTitle ?? this.subTitle,
      arabicContent: arabicContent ?? this.arabicContent,
      transliterationTr: transliterationTr ?? this.transliterationTr,
      meaningTr: meaningTr ?? this.meaningTr,
      virtueAndSource: virtueAndSource ?? this.virtueAndSource,
      recommendedCount: recommendedCount ?? this.recommendedCount,
      audioAssetUrl: audioAssetUrl ?? this.audioAssetUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      lastReadAt: lastReadAt ?? this.lastReadAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pageNumber.present) {
      map['page_number'] = Variable<int>(pageNumber.value);
    }
    if (chapterTitle.present) {
      map['chapter_title'] = Variable<String>(chapterTitle.value);
    }
    if (subTitle.present) {
      map['sub_title'] = Variable<String>(subTitle.value);
    }
    if (arabicContent.present) {
      map['arabic_content'] = Variable<String>(arabicContent.value);
    }
    if (transliterationTr.present) {
      map['transliteration_tr'] = Variable<String>(transliterationTr.value);
    }
    if (meaningTr.present) {
      map['meaning_tr'] = Variable<String>(meaningTr.value);
    }
    if (virtueAndSource.present) {
      map['virtue_and_source'] = Variable<String>(virtueAndSource.value);
    }
    if (recommendedCount.present) {
      map['recommended_count'] = Variable<int>(recommendedCount.value);
    }
    if (audioAssetUrl.present) {
      map['audio_asset_url'] = Variable<String>(audioAssetUrl.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<int>(isFavorite.value);
    }
    if (lastReadAt.present) {
      map['last_read_at'] = Variable<int>(lastReadAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ErkamDuaPagesCompanion(')
          ..write('pageNumber: $pageNumber, ')
          ..write('chapterTitle: $chapterTitle, ')
          ..write('subTitle: $subTitle, ')
          ..write('arabicContent: $arabicContent, ')
          ..write('transliterationTr: $transliterationTr, ')
          ..write('meaningTr: $meaningTr, ')
          ..write('virtueAndSource: $virtueAndSource, ')
          ..write('recommendedCount: $recommendedCount, ')
          ..write('audioAssetUrl: $audioAssetUrl, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('lastReadAt: $lastReadAt')
          ..write(')'))
        .toString();
  }
}

class $QuranSurahsTable extends QuranSurahs
    with TableInfo<$QuranSurahsTable, QuranSurah> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuranSurahsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _surahNumberMeta =
      const VerificationMeta('surahNumber');
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
      'surah_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameArabicMeta =
      const VerificationMeta('nameArabic');
  @override
  late final GeneratedColumn<String> nameArabic = GeneratedColumn<String>(
      'name_arabic', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameTrMeta = const VerificationMeta('nameTr');
  @override
  late final GeneratedColumn<String> nameTr = GeneratedColumn<String>(
      'name_tr', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _meaningTrMeta =
      const VerificationMeta('meaningTr');
  @override
  late final GeneratedColumn<String> meaningTr = GeneratedColumn<String>(
      'meaning_tr', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ayahCountMeta =
      const VerificationMeta('ayahCount');
  @override
  late final GeneratedColumn<int> ayahCount = GeneratedColumn<int>(
      'ayah_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _revelationPlaceMeta =
      const VerificationMeta('revelationPlace');
  @override
  late final GeneratedColumn<String> revelationPlace = GeneratedColumn<String>(
      'revelation_place', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startPageMeta =
      const VerificationMeta('startPage');
  @override
  late final GeneratedColumn<int> startPage = GeneratedColumn<int>(
      'start_page', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isDownloadedOfflineMeta =
      const VerificationMeta('isDownloadedOffline');
  @override
  late final GeneratedColumn<int> isDownloadedOffline = GeneratedColumn<int>(
      'is_downloaded_offline', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _downloadedReciterIdMeta =
      const VerificationMeta('downloadedReciterId');
  @override
  late final GeneratedColumn<String> downloadedReciterId =
      GeneratedColumn<String>('downloaded_reciter_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _localStorageBytesMeta =
      const VerificationMeta('localStorageBytes');
  @override
  late final GeneratedColumn<int> localStorageBytes = GeneratedColumn<int>(
      'local_storage_bytes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        surahNumber,
        nameArabic,
        nameTr,
        meaningTr,
        ayahCount,
        revelationPlace,
        startPage,
        isDownloadedOffline,
        downloadedReciterId,
        localStorageBytes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quran_surahs';
  @override
  VerificationContext validateIntegrity(Insertable<QuranSurah> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('surah_number')) {
      context.handle(
          _surahNumberMeta,
          surahNumber.isAcceptableOrUnknown(
              data['surah_number']!, _surahNumberMeta));
    }
    if (data.containsKey('name_arabic')) {
      context.handle(
          _nameArabicMeta,
          nameArabic.isAcceptableOrUnknown(
              data['name_arabic']!, _nameArabicMeta));
    } else if (isInserting) {
      context.missing(_nameArabicMeta);
    }
    if (data.containsKey('name_tr')) {
      context.handle(_nameTrMeta,
          nameTr.isAcceptableOrUnknown(data['name_tr']!, _nameTrMeta));
    } else if (isInserting) {
      context.missing(_nameTrMeta);
    }
    if (data.containsKey('meaning_tr')) {
      context.handle(_meaningTrMeta,
          meaningTr.isAcceptableOrUnknown(data['meaning_tr']!, _meaningTrMeta));
    } else if (isInserting) {
      context.missing(_meaningTrMeta);
    }
    if (data.containsKey('ayah_count')) {
      context.handle(_ayahCountMeta,
          ayahCount.isAcceptableOrUnknown(data['ayah_count']!, _ayahCountMeta));
    } else if (isInserting) {
      context.missing(_ayahCountMeta);
    }
    if (data.containsKey('revelation_place')) {
      context.handle(
          _revelationPlaceMeta,
          revelationPlace.isAcceptableOrUnknown(
              data['revelation_place']!, _revelationPlaceMeta));
    } else if (isInserting) {
      context.missing(_revelationPlaceMeta);
    }
    if (data.containsKey('start_page')) {
      context.handle(_startPageMeta,
          startPage.isAcceptableOrUnknown(data['start_page']!, _startPageMeta));
    } else if (isInserting) {
      context.missing(_startPageMeta);
    }
    if (data.containsKey('is_downloaded_offline')) {
      context.handle(
          _isDownloadedOfflineMeta,
          isDownloadedOffline.isAcceptableOrUnknown(
              data['is_downloaded_offline']!, _isDownloadedOfflineMeta));
    }
    if (data.containsKey('downloaded_reciter_id')) {
      context.handle(
          _downloadedReciterIdMeta,
          downloadedReciterId.isAcceptableOrUnknown(
              data['downloaded_reciter_id']!, _downloadedReciterIdMeta));
    }
    if (data.containsKey('local_storage_bytes')) {
      context.handle(
          _localStorageBytesMeta,
          localStorageBytes.isAcceptableOrUnknown(
              data['local_storage_bytes']!, _localStorageBytesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {surahNumber};
  @override
  QuranSurah map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuranSurah(
      surahNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}surah_number'])!,
      nameArabic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_arabic'])!,
      nameTr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_tr'])!,
      meaningTr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meaning_tr'])!,
      ayahCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ayah_count'])!,
      revelationPlace: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}revelation_place'])!,
      startPage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_page'])!,
      isDownloadedOffline: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}is_downloaded_offline'])!,
      downloadedReciterId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}downloaded_reciter_id']),
      localStorageBytes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}local_storage_bytes'])!,
    );
  }

  @override
  $QuranSurahsTable createAlias(String alias) {
    return $QuranSurahsTable(attachedDatabase, alias);
  }
}

class QuranSurah extends DataClass implements Insertable<QuranSurah> {
  final int surahNumber;
  final String nameArabic;
  final String nameTr;
  final String meaningTr;
  final int ayahCount;
  final String revelationPlace;
  final int startPage;
  final int isDownloadedOffline;
  final String? downloadedReciterId;
  final int localStorageBytes;
  const QuranSurah(
      {required this.surahNumber,
      required this.nameArabic,
      required this.nameTr,
      required this.meaningTr,
      required this.ayahCount,
      required this.revelationPlace,
      required this.startPage,
      required this.isDownloadedOffline,
      this.downloadedReciterId,
      required this.localStorageBytes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['surah_number'] = Variable<int>(surahNumber);
    map['name_arabic'] = Variable<String>(nameArabic);
    map['name_tr'] = Variable<String>(nameTr);
    map['meaning_tr'] = Variable<String>(meaningTr);
    map['ayah_count'] = Variable<int>(ayahCount);
    map['revelation_place'] = Variable<String>(revelationPlace);
    map['start_page'] = Variable<int>(startPage);
    map['is_downloaded_offline'] = Variable<int>(isDownloadedOffline);
    if (!nullToAbsent || downloadedReciterId != null) {
      map['downloaded_reciter_id'] = Variable<String>(downloadedReciterId);
    }
    map['local_storage_bytes'] = Variable<int>(localStorageBytes);
    return map;
  }

  QuranSurahsCompanion toCompanion(bool nullToAbsent) {
    return QuranSurahsCompanion(
      surahNumber: Value(surahNumber),
      nameArabic: Value(nameArabic),
      nameTr: Value(nameTr),
      meaningTr: Value(meaningTr),
      ayahCount: Value(ayahCount),
      revelationPlace: Value(revelationPlace),
      startPage: Value(startPage),
      isDownloadedOffline: Value(isDownloadedOffline),
      downloadedReciterId: downloadedReciterId == null && nullToAbsent
          ? const Value.absent()
          : Value(downloadedReciterId),
      localStorageBytes: Value(localStorageBytes),
    );
  }

  factory QuranSurah.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuranSurah(
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      nameArabic: serializer.fromJson<String>(json['nameArabic']),
      nameTr: serializer.fromJson<String>(json['nameTr']),
      meaningTr: serializer.fromJson<String>(json['meaningTr']),
      ayahCount: serializer.fromJson<int>(json['ayahCount']),
      revelationPlace: serializer.fromJson<String>(json['revelationPlace']),
      startPage: serializer.fromJson<int>(json['startPage']),
      isDownloadedOffline:
          serializer.fromJson<int>(json['isDownloadedOffline']),
      downloadedReciterId:
          serializer.fromJson<String?>(json['downloadedReciterId']),
      localStorageBytes: serializer.fromJson<int>(json['localStorageBytes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'surahNumber': serializer.toJson<int>(surahNumber),
      'nameArabic': serializer.toJson<String>(nameArabic),
      'nameTr': serializer.toJson<String>(nameTr),
      'meaningTr': serializer.toJson<String>(meaningTr),
      'ayahCount': serializer.toJson<int>(ayahCount),
      'revelationPlace': serializer.toJson<String>(revelationPlace),
      'startPage': serializer.toJson<int>(startPage),
      'isDownloadedOffline': serializer.toJson<int>(isDownloadedOffline),
      'downloadedReciterId': serializer.toJson<String?>(downloadedReciterId),
      'localStorageBytes': serializer.toJson<int>(localStorageBytes),
    };
  }

  QuranSurah copyWith(
          {int? surahNumber,
          String? nameArabic,
          String? nameTr,
          String? meaningTr,
          int? ayahCount,
          String? revelationPlace,
          int? startPage,
          int? isDownloadedOffline,
          Value<String?> downloadedReciterId = const Value.absent(),
          int? localStorageBytes}) =>
      QuranSurah(
        surahNumber: surahNumber ?? this.surahNumber,
        nameArabic: nameArabic ?? this.nameArabic,
        nameTr: nameTr ?? this.nameTr,
        meaningTr: meaningTr ?? this.meaningTr,
        ayahCount: ayahCount ?? this.ayahCount,
        revelationPlace: revelationPlace ?? this.revelationPlace,
        startPage: startPage ?? this.startPage,
        isDownloadedOffline: isDownloadedOffline ?? this.isDownloadedOffline,
        downloadedReciterId: downloadedReciterId.present
            ? downloadedReciterId.value
            : this.downloadedReciterId,
        localStorageBytes: localStorageBytes ?? this.localStorageBytes,
      );
  QuranSurah copyWithCompanion(QuranSurahsCompanion data) {
    return QuranSurah(
      surahNumber:
          data.surahNumber.present ? data.surahNumber.value : this.surahNumber,
      nameArabic:
          data.nameArabic.present ? data.nameArabic.value : this.nameArabic,
      nameTr: data.nameTr.present ? data.nameTr.value : this.nameTr,
      meaningTr: data.meaningTr.present ? data.meaningTr.value : this.meaningTr,
      ayahCount: data.ayahCount.present ? data.ayahCount.value : this.ayahCount,
      revelationPlace: data.revelationPlace.present
          ? data.revelationPlace.value
          : this.revelationPlace,
      startPage: data.startPage.present ? data.startPage.value : this.startPage,
      isDownloadedOffline: data.isDownloadedOffline.present
          ? data.isDownloadedOffline.value
          : this.isDownloadedOffline,
      downloadedReciterId: data.downloadedReciterId.present
          ? data.downloadedReciterId.value
          : this.downloadedReciterId,
      localStorageBytes: data.localStorageBytes.present
          ? data.localStorageBytes.value
          : this.localStorageBytes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuranSurah(')
          ..write('surahNumber: $surahNumber, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('nameTr: $nameTr, ')
          ..write('meaningTr: $meaningTr, ')
          ..write('ayahCount: $ayahCount, ')
          ..write('revelationPlace: $revelationPlace, ')
          ..write('startPage: $startPage, ')
          ..write('isDownloadedOffline: $isDownloadedOffline, ')
          ..write('downloadedReciterId: $downloadedReciterId, ')
          ..write('localStorageBytes: $localStorageBytes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      surahNumber,
      nameArabic,
      nameTr,
      meaningTr,
      ayahCount,
      revelationPlace,
      startPage,
      isDownloadedOffline,
      downloadedReciterId,
      localStorageBytes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuranSurah &&
          other.surahNumber == this.surahNumber &&
          other.nameArabic == this.nameArabic &&
          other.nameTr == this.nameTr &&
          other.meaningTr == this.meaningTr &&
          other.ayahCount == this.ayahCount &&
          other.revelationPlace == this.revelationPlace &&
          other.startPage == this.startPage &&
          other.isDownloadedOffline == this.isDownloadedOffline &&
          other.downloadedReciterId == this.downloadedReciterId &&
          other.localStorageBytes == this.localStorageBytes);
}

class QuranSurahsCompanion extends UpdateCompanion<QuranSurah> {
  final Value<int> surahNumber;
  final Value<String> nameArabic;
  final Value<String> nameTr;
  final Value<String> meaningTr;
  final Value<int> ayahCount;
  final Value<String> revelationPlace;
  final Value<int> startPage;
  final Value<int> isDownloadedOffline;
  final Value<String?> downloadedReciterId;
  final Value<int> localStorageBytes;
  const QuranSurahsCompanion({
    this.surahNumber = const Value.absent(),
    this.nameArabic = const Value.absent(),
    this.nameTr = const Value.absent(),
    this.meaningTr = const Value.absent(),
    this.ayahCount = const Value.absent(),
    this.revelationPlace = const Value.absent(),
    this.startPage = const Value.absent(),
    this.isDownloadedOffline = const Value.absent(),
    this.downloadedReciterId = const Value.absent(),
    this.localStorageBytes = const Value.absent(),
  });
  QuranSurahsCompanion.insert({
    this.surahNumber = const Value.absent(),
    required String nameArabic,
    required String nameTr,
    required String meaningTr,
    required int ayahCount,
    required String revelationPlace,
    required int startPage,
    this.isDownloadedOffline = const Value.absent(),
    this.downloadedReciterId = const Value.absent(),
    this.localStorageBytes = const Value.absent(),
  })  : nameArabic = Value(nameArabic),
        nameTr = Value(nameTr),
        meaningTr = Value(meaningTr),
        ayahCount = Value(ayahCount),
        revelationPlace = Value(revelationPlace),
        startPage = Value(startPage);
  static Insertable<QuranSurah> custom({
    Expression<int>? surahNumber,
    Expression<String>? nameArabic,
    Expression<String>? nameTr,
    Expression<String>? meaningTr,
    Expression<int>? ayahCount,
    Expression<String>? revelationPlace,
    Expression<int>? startPage,
    Expression<int>? isDownloadedOffline,
    Expression<String>? downloadedReciterId,
    Expression<int>? localStorageBytes,
  }) {
    return RawValuesInsertable({
      if (surahNumber != null) 'surah_number': surahNumber,
      if (nameArabic != null) 'name_arabic': nameArabic,
      if (nameTr != null) 'name_tr': nameTr,
      if (meaningTr != null) 'meaning_tr': meaningTr,
      if (ayahCount != null) 'ayah_count': ayahCount,
      if (revelationPlace != null) 'revelation_place': revelationPlace,
      if (startPage != null) 'start_page': startPage,
      if (isDownloadedOffline != null)
        'is_downloaded_offline': isDownloadedOffline,
      if (downloadedReciterId != null)
        'downloaded_reciter_id': downloadedReciterId,
      if (localStorageBytes != null) 'local_storage_bytes': localStorageBytes,
    });
  }

  QuranSurahsCompanion copyWith(
      {Value<int>? surahNumber,
      Value<String>? nameArabic,
      Value<String>? nameTr,
      Value<String>? meaningTr,
      Value<int>? ayahCount,
      Value<String>? revelationPlace,
      Value<int>? startPage,
      Value<int>? isDownloadedOffline,
      Value<String?>? downloadedReciterId,
      Value<int>? localStorageBytes}) {
    return QuranSurahsCompanion(
      surahNumber: surahNumber ?? this.surahNumber,
      nameArabic: nameArabic ?? this.nameArabic,
      nameTr: nameTr ?? this.nameTr,
      meaningTr: meaningTr ?? this.meaningTr,
      ayahCount: ayahCount ?? this.ayahCount,
      revelationPlace: revelationPlace ?? this.revelationPlace,
      startPage: startPage ?? this.startPage,
      isDownloadedOffline: isDownloadedOffline ?? this.isDownloadedOffline,
      downloadedReciterId: downloadedReciterId ?? this.downloadedReciterId,
      localStorageBytes: localStorageBytes ?? this.localStorageBytes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (nameArabic.present) {
      map['name_arabic'] = Variable<String>(nameArabic.value);
    }
    if (nameTr.present) {
      map['name_tr'] = Variable<String>(nameTr.value);
    }
    if (meaningTr.present) {
      map['meaning_tr'] = Variable<String>(meaningTr.value);
    }
    if (ayahCount.present) {
      map['ayah_count'] = Variable<int>(ayahCount.value);
    }
    if (revelationPlace.present) {
      map['revelation_place'] = Variable<String>(revelationPlace.value);
    }
    if (startPage.present) {
      map['start_page'] = Variable<int>(startPage.value);
    }
    if (isDownloadedOffline.present) {
      map['is_downloaded_offline'] = Variable<int>(isDownloadedOffline.value);
    }
    if (downloadedReciterId.present) {
      map['downloaded_reciter_id'] =
          Variable<String>(downloadedReciterId.value);
    }
    if (localStorageBytes.present) {
      map['local_storage_bytes'] = Variable<int>(localStorageBytes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuranSurahsCompanion(')
          ..write('surahNumber: $surahNumber, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('nameTr: $nameTr, ')
          ..write('meaningTr: $meaningTr, ')
          ..write('ayahCount: $ayahCount, ')
          ..write('revelationPlace: $revelationPlace, ')
          ..write('startPage: $startPage, ')
          ..write('isDownloadedOffline: $isDownloadedOffline, ')
          ..write('downloadedReciterId: $downloadedReciterId, ')
          ..write('localStorageBytes: $localStorageBytes')
          ..write(')'))
        .toString();
  }
}

class $QuranAyahsTable extends QuranAyahs
    with TableInfo<$QuranAyahsTable, QuranAyah> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuranAyahsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _surahNumberMeta =
      const VerificationMeta('surahNumber');
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
      'surah_number', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES quran_surahs (surah_number)'));
  static const VerificationMeta _ayahNumberMeta =
      const VerificationMeta('ayahNumber');
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
      'ayah_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _mushafPageMeta =
      const VerificationMeta('mushafPage');
  @override
  late final GeneratedColumn<int> mushafPage = GeneratedColumn<int>(
      'mushaf_page', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _juzNumberMeta =
      const VerificationMeta('juzNumber');
  @override
  late final GeneratedColumn<int> juzNumber = GeneratedColumn<int>(
      'juz_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _uthmaniTextMeta =
      const VerificationMeta('uthmaniText');
  @override
  late final GeneratedColumn<String> uthmaniText = GeneratedColumn<String>(
      'uthmani_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _translationTrMeta =
      const VerificationMeta('translationTr');
  @override
  late final GeneratedColumn<String> translationTr = GeneratedColumn<String>(
      'translation_tr', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shortTafsirTrMeta =
      const VerificationMeta('shortTafsirTr');
  @override
  late final GeneratedColumn<String> shortTafsirTr = GeneratedColumn<String>(
      'short_tafsir_tr', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isSajdahMeta =
      const VerificationMeta('isSajdah');
  @override
  late final GeneratedColumn<int> isSajdah = GeneratedColumn<int>(
      'is_sajdah', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        surahNumber,
        ayahNumber,
        mushafPage,
        juzNumber,
        uthmaniText,
        translationTr,
        shortTafsirTr,
        isSajdah
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quran_ayahs';
  @override
  VerificationContext validateIntegrity(Insertable<QuranAyah> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_number')) {
      context.handle(
          _surahNumberMeta,
          surahNumber.isAcceptableOrUnknown(
              data['surah_number']!, _surahNumberMeta));
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
          _ayahNumberMeta,
          ayahNumber.isAcceptableOrUnknown(
              data['ayah_number']!, _ayahNumberMeta));
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('mushaf_page')) {
      context.handle(
          _mushafPageMeta,
          mushafPage.isAcceptableOrUnknown(
              data['mushaf_page']!, _mushafPageMeta));
    } else if (isInserting) {
      context.missing(_mushafPageMeta);
    }
    if (data.containsKey('juz_number')) {
      context.handle(_juzNumberMeta,
          juzNumber.isAcceptableOrUnknown(data['juz_number']!, _juzNumberMeta));
    } else if (isInserting) {
      context.missing(_juzNumberMeta);
    }
    if (data.containsKey('uthmani_text')) {
      context.handle(
          _uthmaniTextMeta,
          uthmaniText.isAcceptableOrUnknown(
              data['uthmani_text']!, _uthmaniTextMeta));
    } else if (isInserting) {
      context.missing(_uthmaniTextMeta);
    }
    if (data.containsKey('translation_tr')) {
      context.handle(
          _translationTrMeta,
          translationTr.isAcceptableOrUnknown(
              data['translation_tr']!, _translationTrMeta));
    } else if (isInserting) {
      context.missing(_translationTrMeta);
    }
    if (data.containsKey('short_tafsir_tr')) {
      context.handle(
          _shortTafsirTrMeta,
          shortTafsirTr.isAcceptableOrUnknown(
              data['short_tafsir_tr']!, _shortTafsirTrMeta));
    }
    if (data.containsKey('is_sajdah')) {
      context.handle(_isSajdahMeta,
          isSajdah.isAcceptableOrUnknown(data['is_sajdah']!, _isSajdahMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuranAyah map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuranAyah(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surahNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}surah_number'])!,
      ayahNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ayah_number'])!,
      mushafPage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mushaf_page'])!,
      juzNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}juz_number'])!,
      uthmaniText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uthmani_text'])!,
      translationTr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}translation_tr'])!,
      shortTafsirTr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}short_tafsir_tr']),
      isSajdah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_sajdah'])!,
    );
  }

  @override
  $QuranAyahsTable createAlias(String alias) {
    return $QuranAyahsTable(attachedDatabase, alias);
  }
}

class QuranAyah extends DataClass implements Insertable<QuranAyah> {
  final int id;
  final int surahNumber;
  final int ayahNumber;
  final int mushafPage;
  final int juzNumber;
  final String uthmaniText;
  final String translationTr;
  final String? shortTafsirTr;
  final int isSajdah;
  const QuranAyah(
      {required this.id,
      required this.surahNumber,
      required this.ayahNumber,
      required this.mushafPage,
      required this.juzNumber,
      required this.uthmaniText,
      required this.translationTr,
      this.shortTafsirTr,
      required this.isSajdah});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['mushaf_page'] = Variable<int>(mushafPage);
    map['juz_number'] = Variable<int>(juzNumber);
    map['uthmani_text'] = Variable<String>(uthmaniText);
    map['translation_tr'] = Variable<String>(translationTr);
    if (!nullToAbsent || shortTafsirTr != null) {
      map['short_tafsir_tr'] = Variable<String>(shortTafsirTr);
    }
    map['is_sajdah'] = Variable<int>(isSajdah);
    return map;
  }

  QuranAyahsCompanion toCompanion(bool nullToAbsent) {
    return QuranAyahsCompanion(
      id: Value(id),
      surahNumber: Value(surahNumber),
      ayahNumber: Value(ayahNumber),
      mushafPage: Value(mushafPage),
      juzNumber: Value(juzNumber),
      uthmaniText: Value(uthmaniText),
      translationTr: Value(translationTr),
      shortTafsirTr: shortTafsirTr == null && nullToAbsent
          ? const Value.absent()
          : Value(shortTafsirTr),
      isSajdah: Value(isSajdah),
    );
  }

  factory QuranAyah.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuranAyah(
      id: serializer.fromJson<int>(json['id']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      mushafPage: serializer.fromJson<int>(json['mushafPage']),
      juzNumber: serializer.fromJson<int>(json['juzNumber']),
      uthmaniText: serializer.fromJson<String>(json['uthmaniText']),
      translationTr: serializer.fromJson<String>(json['translationTr']),
      shortTafsirTr: serializer.fromJson<String?>(json['shortTafsirTr']),
      isSajdah: serializer.fromJson<int>(json['isSajdah']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'mushafPage': serializer.toJson<int>(mushafPage),
      'juzNumber': serializer.toJson<int>(juzNumber),
      'uthmaniText': serializer.toJson<String>(uthmaniText),
      'translationTr': serializer.toJson<String>(translationTr),
      'shortTafsirTr': serializer.toJson<String?>(shortTafsirTr),
      'isSajdah': serializer.toJson<int>(isSajdah),
    };
  }

  QuranAyah copyWith(
          {int? id,
          int? surahNumber,
          int? ayahNumber,
          int? mushafPage,
          int? juzNumber,
          String? uthmaniText,
          String? translationTr,
          Value<String?> shortTafsirTr = const Value.absent(),
          int? isSajdah}) =>
      QuranAyah(
        id: id ?? this.id,
        surahNumber: surahNumber ?? this.surahNumber,
        ayahNumber: ayahNumber ?? this.ayahNumber,
        mushafPage: mushafPage ?? this.mushafPage,
        juzNumber: juzNumber ?? this.juzNumber,
        uthmaniText: uthmaniText ?? this.uthmaniText,
        translationTr: translationTr ?? this.translationTr,
        shortTafsirTr:
            shortTafsirTr.present ? shortTafsirTr.value : this.shortTafsirTr,
        isSajdah: isSajdah ?? this.isSajdah,
      );
  QuranAyah copyWithCompanion(QuranAyahsCompanion data) {
    return QuranAyah(
      id: data.id.present ? data.id.value : this.id,
      surahNumber:
          data.surahNumber.present ? data.surahNumber.value : this.surahNumber,
      ayahNumber:
          data.ayahNumber.present ? data.ayahNumber.value : this.ayahNumber,
      mushafPage:
          data.mushafPage.present ? data.mushafPage.value : this.mushafPage,
      juzNumber: data.juzNumber.present ? data.juzNumber.value : this.juzNumber,
      uthmaniText:
          data.uthmaniText.present ? data.uthmaniText.value : this.uthmaniText,
      translationTr: data.translationTr.present
          ? data.translationTr.value
          : this.translationTr,
      shortTafsirTr: data.shortTafsirTr.present
          ? data.shortTafsirTr.value
          : this.shortTafsirTr,
      isSajdah: data.isSajdah.present ? data.isSajdah.value : this.isSajdah,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuranAyah(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('mushafPage: $mushafPage, ')
          ..write('juzNumber: $juzNumber, ')
          ..write('uthmaniText: $uthmaniText, ')
          ..write('translationTr: $translationTr, ')
          ..write('shortTafsirTr: $shortTafsirTr, ')
          ..write('isSajdah: $isSajdah')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, surahNumber, ayahNumber, mushafPage,
      juzNumber, uthmaniText, translationTr, shortTafsirTr, isSajdah);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuranAyah &&
          other.id == this.id &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber &&
          other.mushafPage == this.mushafPage &&
          other.juzNumber == this.juzNumber &&
          other.uthmaniText == this.uthmaniText &&
          other.translationTr == this.translationTr &&
          other.shortTafsirTr == this.shortTafsirTr &&
          other.isSajdah == this.isSajdah);
}

class QuranAyahsCompanion extends UpdateCompanion<QuranAyah> {
  final Value<int> id;
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<int> mushafPage;
  final Value<int> juzNumber;
  final Value<String> uthmaniText;
  final Value<String> translationTr;
  final Value<String?> shortTafsirTr;
  final Value<int> isSajdah;
  const QuranAyahsCompanion({
    this.id = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.mushafPage = const Value.absent(),
    this.juzNumber = const Value.absent(),
    this.uthmaniText = const Value.absent(),
    this.translationTr = const Value.absent(),
    this.shortTafsirTr = const Value.absent(),
    this.isSajdah = const Value.absent(),
  });
  QuranAyahsCompanion.insert({
    this.id = const Value.absent(),
    required int surahNumber,
    required int ayahNumber,
    required int mushafPage,
    required int juzNumber,
    required String uthmaniText,
    required String translationTr,
    this.shortTafsirTr = const Value.absent(),
    this.isSajdah = const Value.absent(),
  })  : surahNumber = Value(surahNumber),
        ayahNumber = Value(ayahNumber),
        mushafPage = Value(mushafPage),
        juzNumber = Value(juzNumber),
        uthmaniText = Value(uthmaniText),
        translationTr = Value(translationTr);
  static Insertable<QuranAyah> custom({
    Expression<int>? id,
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<int>? mushafPage,
    Expression<int>? juzNumber,
    Expression<String>? uthmaniText,
    Expression<String>? translationTr,
    Expression<String>? shortTafsirTr,
    Expression<int>? isSajdah,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (mushafPage != null) 'mushaf_page': mushafPage,
      if (juzNumber != null) 'juz_number': juzNumber,
      if (uthmaniText != null) 'uthmani_text': uthmaniText,
      if (translationTr != null) 'translation_tr': translationTr,
      if (shortTafsirTr != null) 'short_tafsir_tr': shortTafsirTr,
      if (isSajdah != null) 'is_sajdah': isSajdah,
    });
  }

  QuranAyahsCompanion copyWith(
      {Value<int>? id,
      Value<int>? surahNumber,
      Value<int>? ayahNumber,
      Value<int>? mushafPage,
      Value<int>? juzNumber,
      Value<String>? uthmaniText,
      Value<String>? translationTr,
      Value<String?>? shortTafsirTr,
      Value<int>? isSajdah}) {
    return QuranAyahsCompanion(
      id: id ?? this.id,
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      mushafPage: mushafPage ?? this.mushafPage,
      juzNumber: juzNumber ?? this.juzNumber,
      uthmaniText: uthmaniText ?? this.uthmaniText,
      translationTr: translationTr ?? this.translationTr,
      shortTafsirTr: shortTafsirTr ?? this.shortTafsirTr,
      isSajdah: isSajdah ?? this.isSajdah,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (mushafPage.present) {
      map['mushaf_page'] = Variable<int>(mushafPage.value);
    }
    if (juzNumber.present) {
      map['juz_number'] = Variable<int>(juzNumber.value);
    }
    if (uthmaniText.present) {
      map['uthmani_text'] = Variable<String>(uthmaniText.value);
    }
    if (translationTr.present) {
      map['translation_tr'] = Variable<String>(translationTr.value);
    }
    if (shortTafsirTr.present) {
      map['short_tafsir_tr'] = Variable<String>(shortTafsirTr.value);
    }
    if (isSajdah.present) {
      map['is_sajdah'] = Variable<int>(isSajdah.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuranAyahsCompanion(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('mushafPage: $mushafPage, ')
          ..write('juzNumber: $juzNumber, ')
          ..write('uthmaniText: $uthmaniText, ')
          ..write('translationTr: $translationTr, ')
          ..write('shortTafsirTr: $shortTafsirTr, ')
          ..write('isSajdah: $isSajdah')
          ..write(')'))
        .toString();
  }
}

class $DhikrItemsTable extends DhikrItems
    with TableInfo<$DhikrItemsTable, DhikrItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DhikrItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _arabicTextMeta =
      const VerificationMeta('arabicText');
  @override
  late final GeneratedColumn<String> arabicText = GeneratedColumn<String>(
      'arabic_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _transliterationMeta =
      const VerificationMeta('transliteration');
  @override
  late final GeneratedColumn<String> transliteration = GeneratedColumn<String>(
      'transliteration', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _meaningTrMeta =
      const VerificationMeta('meaningTr');
  @override
  late final GeneratedColumn<String> meaningTr = GeneratedColumn<String>(
      'meaning_tr', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _targetCountMeta =
      const VerificationMeta('targetCount');
  @override
  late final GeneratedColumn<int> targetCount = GeneratedColumn<int>(
      'target_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(33));
  static const VerificationMeta _currentCountMeta =
      const VerificationMeta('currentCount');
  @override
  late final GeneratedColumn<int> currentCount = GeneratedColumn<int>(
      'current_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalLifetimeCountMeta =
      const VerificationMeta('totalLifetimeCount');
  @override
  late final GeneratedColumn<int> totalLifetimeCount = GeneratedColumn<int>(
      'total_lifetime_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _linkedErkamPageMeta =
      const VerificationMeta('linkedErkamPage');
  @override
  late final GeneratedColumn<int> linkedErkamPage = GeneratedColumn<int>(
      'linked_erkam_page', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES erkam_dua_pages (page_number)'));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        arabicText,
        transliteration,
        meaningTr,
        targetCount,
        currentCount,
        totalLifetimeCount,
        linkedErkamPage,
        sortOrder
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dhikr_items';
  @override
  VerificationContext validateIntegrity(Insertable<DhikrItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('arabic_text')) {
      context.handle(
          _arabicTextMeta,
          arabicText.isAcceptableOrUnknown(
              data['arabic_text']!, _arabicTextMeta));
    }
    if (data.containsKey('transliteration')) {
      context.handle(
          _transliterationMeta,
          transliteration.isAcceptableOrUnknown(
              data['transliteration']!, _transliterationMeta));
    }
    if (data.containsKey('meaning_tr')) {
      context.handle(_meaningTrMeta,
          meaningTr.isAcceptableOrUnknown(data['meaning_tr']!, _meaningTrMeta));
    }
    if (data.containsKey('target_count')) {
      context.handle(
          _targetCountMeta,
          targetCount.isAcceptableOrUnknown(
              data['target_count']!, _targetCountMeta));
    }
    if (data.containsKey('current_count')) {
      context.handle(
          _currentCountMeta,
          currentCount.isAcceptableOrUnknown(
              data['current_count']!, _currentCountMeta));
    }
    if (data.containsKey('total_lifetime_count')) {
      context.handle(
          _totalLifetimeCountMeta,
          totalLifetimeCount.isAcceptableOrUnknown(
              data['total_lifetime_count']!, _totalLifetimeCountMeta));
    }
    if (data.containsKey('linked_erkam_page')) {
      context.handle(
          _linkedErkamPageMeta,
          linkedErkamPage.isAcceptableOrUnknown(
              data['linked_erkam_page']!, _linkedErkamPageMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DhikrItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DhikrItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      arabicText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}arabic_text']),
      transliteration: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}transliteration']),
      meaningTr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meaning_tr']),
      targetCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_count'])!,
      currentCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_count'])!,
      totalLifetimeCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_lifetime_count'])!,
      linkedErkamPage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}linked_erkam_page']),
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $DhikrItemsTable createAlias(String alias) {
    return $DhikrItemsTable(attachedDatabase, alias);
  }
}

class DhikrItem extends DataClass implements Insertable<DhikrItem> {
  final String id;
  final String title;
  final String? arabicText;
  final String? transliteration;
  final String? meaningTr;
  final int targetCount;
  final int currentCount;
  final int totalLifetimeCount;
  final int? linkedErkamPage;
  final int sortOrder;
  const DhikrItem(
      {required this.id,
      required this.title,
      this.arabicText,
      this.transliteration,
      this.meaningTr,
      required this.targetCount,
      required this.currentCount,
      required this.totalLifetimeCount,
      this.linkedErkamPage,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || arabicText != null) {
      map['arabic_text'] = Variable<String>(arabicText);
    }
    if (!nullToAbsent || transliteration != null) {
      map['transliteration'] = Variable<String>(transliteration);
    }
    if (!nullToAbsent || meaningTr != null) {
      map['meaning_tr'] = Variable<String>(meaningTr);
    }
    map['target_count'] = Variable<int>(targetCount);
    map['current_count'] = Variable<int>(currentCount);
    map['total_lifetime_count'] = Variable<int>(totalLifetimeCount);
    if (!nullToAbsent || linkedErkamPage != null) {
      map['linked_erkam_page'] = Variable<int>(linkedErkamPage);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  DhikrItemsCompanion toCompanion(bool nullToAbsent) {
    return DhikrItemsCompanion(
      id: Value(id),
      title: Value(title),
      arabicText: arabicText == null && nullToAbsent
          ? const Value.absent()
          : Value(arabicText),
      transliteration: transliteration == null && nullToAbsent
          ? const Value.absent()
          : Value(transliteration),
      meaningTr: meaningTr == null && nullToAbsent
          ? const Value.absent()
          : Value(meaningTr),
      targetCount: Value(targetCount),
      currentCount: Value(currentCount),
      totalLifetimeCount: Value(totalLifetimeCount),
      linkedErkamPage: linkedErkamPage == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedErkamPage),
      sortOrder: Value(sortOrder),
    );
  }

  factory DhikrItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DhikrItem(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      arabicText: serializer.fromJson<String?>(json['arabicText']),
      transliteration: serializer.fromJson<String?>(json['transliteration']),
      meaningTr: serializer.fromJson<String?>(json['meaningTr']),
      targetCount: serializer.fromJson<int>(json['targetCount']),
      currentCount: serializer.fromJson<int>(json['currentCount']),
      totalLifetimeCount: serializer.fromJson<int>(json['totalLifetimeCount']),
      linkedErkamPage: serializer.fromJson<int?>(json['linkedErkamPage']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'arabicText': serializer.toJson<String?>(arabicText),
      'transliteration': serializer.toJson<String?>(transliteration),
      'meaningTr': serializer.toJson<String?>(meaningTr),
      'targetCount': serializer.toJson<int>(targetCount),
      'currentCount': serializer.toJson<int>(currentCount),
      'totalLifetimeCount': serializer.toJson<int>(totalLifetimeCount),
      'linkedErkamPage': serializer.toJson<int?>(linkedErkamPage),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  DhikrItem copyWith(
          {String? id,
          String? title,
          Value<String?> arabicText = const Value.absent(),
          Value<String?> transliteration = const Value.absent(),
          Value<String?> meaningTr = const Value.absent(),
          int? targetCount,
          int? currentCount,
          int? totalLifetimeCount,
          Value<int?> linkedErkamPage = const Value.absent(),
          int? sortOrder}) =>
      DhikrItem(
        id: id ?? this.id,
        title: title ?? this.title,
        arabicText: arabicText.present ? arabicText.value : this.arabicText,
        transliteration: transliteration.present
            ? transliteration.value
            : this.transliteration,
        meaningTr: meaningTr.present ? meaningTr.value : this.meaningTr,
        targetCount: targetCount ?? this.targetCount,
        currentCount: currentCount ?? this.currentCount,
        totalLifetimeCount: totalLifetimeCount ?? this.totalLifetimeCount,
        linkedErkamPage: linkedErkamPage.present
            ? linkedErkamPage.value
            : this.linkedErkamPage,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  DhikrItem copyWithCompanion(DhikrItemsCompanion data) {
    return DhikrItem(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      arabicText:
          data.arabicText.present ? data.arabicText.value : this.arabicText,
      transliteration: data.transliteration.present
          ? data.transliteration.value
          : this.transliteration,
      meaningTr: data.meaningTr.present ? data.meaningTr.value : this.meaningTr,
      targetCount:
          data.targetCount.present ? data.targetCount.value : this.targetCount,
      currentCount: data.currentCount.present
          ? data.currentCount.value
          : this.currentCount,
      totalLifetimeCount: data.totalLifetimeCount.present
          ? data.totalLifetimeCount.value
          : this.totalLifetimeCount,
      linkedErkamPage: data.linkedErkamPage.present
          ? data.linkedErkamPage.value
          : this.linkedErkamPage,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DhikrItem(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('arabicText: $arabicText, ')
          ..write('transliteration: $transliteration, ')
          ..write('meaningTr: $meaningTr, ')
          ..write('targetCount: $targetCount, ')
          ..write('currentCount: $currentCount, ')
          ..write('totalLifetimeCount: $totalLifetimeCount, ')
          ..write('linkedErkamPage: $linkedErkamPage, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      arabicText,
      transliteration,
      meaningTr,
      targetCount,
      currentCount,
      totalLifetimeCount,
      linkedErkamPage,
      sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DhikrItem &&
          other.id == this.id &&
          other.title == this.title &&
          other.arabicText == this.arabicText &&
          other.transliteration == this.transliteration &&
          other.meaningTr == this.meaningTr &&
          other.targetCount == this.targetCount &&
          other.currentCount == this.currentCount &&
          other.totalLifetimeCount == this.totalLifetimeCount &&
          other.linkedErkamPage == this.linkedErkamPage &&
          other.sortOrder == this.sortOrder);
}

class DhikrItemsCompanion extends UpdateCompanion<DhikrItem> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> arabicText;
  final Value<String?> transliteration;
  final Value<String?> meaningTr;
  final Value<int> targetCount;
  final Value<int> currentCount;
  final Value<int> totalLifetimeCount;
  final Value<int?> linkedErkamPage;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const DhikrItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.arabicText = const Value.absent(),
    this.transliteration = const Value.absent(),
    this.meaningTr = const Value.absent(),
    this.targetCount = const Value.absent(),
    this.currentCount = const Value.absent(),
    this.totalLifetimeCount = const Value.absent(),
    this.linkedErkamPage = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DhikrItemsCompanion.insert({
    required String id,
    required String title,
    this.arabicText = const Value.absent(),
    this.transliteration = const Value.absent(),
    this.meaningTr = const Value.absent(),
    this.targetCount = const Value.absent(),
    this.currentCount = const Value.absent(),
    this.totalLifetimeCount = const Value.absent(),
    this.linkedErkamPage = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title);
  static Insertable<DhikrItem> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? arabicText,
    Expression<String>? transliteration,
    Expression<String>? meaningTr,
    Expression<int>? targetCount,
    Expression<int>? currentCount,
    Expression<int>? totalLifetimeCount,
    Expression<int>? linkedErkamPage,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (arabicText != null) 'arabic_text': arabicText,
      if (transliteration != null) 'transliteration': transliteration,
      if (meaningTr != null) 'meaning_tr': meaningTr,
      if (targetCount != null) 'target_count': targetCount,
      if (currentCount != null) 'current_count': currentCount,
      if (totalLifetimeCount != null)
        'total_lifetime_count': totalLifetimeCount,
      if (linkedErkamPage != null) 'linked_erkam_page': linkedErkamPage,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DhikrItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? arabicText,
      Value<String?>? transliteration,
      Value<String?>? meaningTr,
      Value<int>? targetCount,
      Value<int>? currentCount,
      Value<int>? totalLifetimeCount,
      Value<int?>? linkedErkamPage,
      Value<int>? sortOrder,
      Value<int>? rowid}) {
    return DhikrItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      arabicText: arabicText ?? this.arabicText,
      transliteration: transliteration ?? this.transliteration,
      meaningTr: meaningTr ?? this.meaningTr,
      targetCount: targetCount ?? this.targetCount,
      currentCount: currentCount ?? this.currentCount,
      totalLifetimeCount: totalLifetimeCount ?? this.totalLifetimeCount,
      linkedErkamPage: linkedErkamPage ?? this.linkedErkamPage,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (arabicText.present) {
      map['arabic_text'] = Variable<String>(arabicText.value);
    }
    if (transliteration.present) {
      map['transliteration'] = Variable<String>(transliteration.value);
    }
    if (meaningTr.present) {
      map['meaning_tr'] = Variable<String>(meaningTr.value);
    }
    if (targetCount.present) {
      map['target_count'] = Variable<int>(targetCount.value);
    }
    if (currentCount.present) {
      map['current_count'] = Variable<int>(currentCount.value);
    }
    if (totalLifetimeCount.present) {
      map['total_lifetime_count'] = Variable<int>(totalLifetimeCount.value);
    }
    if (linkedErkamPage.present) {
      map['linked_erkam_page'] = Variable<int>(linkedErkamPage.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DhikrItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('arabicText: $arabicText, ')
          ..write('transliteration: $transliteration, ')
          ..write('meaningTr: $meaningTr, ')
          ..write('targetCount: $targetCount, ')
          ..write('currentCount: $currentCount, ')
          ..write('totalLifetimeCount: $totalLifetimeCount, ')
          ..write('linkedErkamPage: $linkedErkamPage, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SmartAlarmsTable extends SmartAlarms
    with TableInfo<$SmartAlarmsTable, SmartAlarm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmartAlarmsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _alarmTypeMeta =
      const VerificationMeta('alarmType');
  @override
  late final GeneratedColumn<String> alarmType = GeneratedColumn<String>(
      'alarm_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fixedTimestampMeta =
      const VerificationMeta('fixedTimestamp');
  @override
  late final GeneratedColumn<int> fixedTimestamp = GeneratedColumn<int>(
      'fixed_timestamp', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _anchorPrayerMeta =
      const VerificationMeta('anchorPrayer');
  @override
  late final GeneratedColumn<String> anchorPrayer = GeneratedColumn<String>(
      'anchor_prayer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _offsetMinutesMeta =
      const VerificationMeta('offsetMinutes');
  @override
  late final GeneratedColumn<int> offsetMinutes = GeneratedColumn<int>(
      'offset_minutes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _hijriDaysCsvMeta =
      const VerificationMeta('hijriDaysCsv');
  @override
  late final GeneratedColumn<String> hijriDaysCsv = GeneratedColumn<String>(
      'hijri_days_csv', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _weekdaysCsvMeta =
      const VerificationMeta('weekdaysCsv');
  @override
  late final GeneratedColumn<String> weekdaysCsv = GeneratedColumn<String>(
      'weekdays_csv', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _linkedRouteMeta =
      const VerificationMeta('linkedRoute');
  @override
  late final GeneratedColumn<String> linkedRoute = GeneratedColumn<String>(
      'linked_route', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _soundIdMeta =
      const VerificationMeta('soundId');
  @override
  late final GeneratedColumn<String> soundId = GeneratedColumn<String>(
      'sound_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isEnabledMeta =
      const VerificationMeta('isEnabled');
  @override
  late final GeneratedColumn<int> isEnabled = GeneratedColumn<int>(
      'is_enabled', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        alarmType,
        fixedTimestamp,
        anchorPrayer,
        offsetMinutes,
        hijriDaysCsv,
        weekdaysCsv,
        linkedRoute,
        soundId,
        isEnabled
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'smart_alarms';
  @override
  VerificationContext validateIntegrity(Insertable<SmartAlarm> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('alarm_type')) {
      context.handle(_alarmTypeMeta,
          alarmType.isAcceptableOrUnknown(data['alarm_type']!, _alarmTypeMeta));
    } else if (isInserting) {
      context.missing(_alarmTypeMeta);
    }
    if (data.containsKey('fixed_timestamp')) {
      context.handle(
          _fixedTimestampMeta,
          fixedTimestamp.isAcceptableOrUnknown(
              data['fixed_timestamp']!, _fixedTimestampMeta));
    }
    if (data.containsKey('anchor_prayer')) {
      context.handle(
          _anchorPrayerMeta,
          anchorPrayer.isAcceptableOrUnknown(
              data['anchor_prayer']!, _anchorPrayerMeta));
    }
    if (data.containsKey('offset_minutes')) {
      context.handle(
          _offsetMinutesMeta,
          offsetMinutes.isAcceptableOrUnknown(
              data['offset_minutes']!, _offsetMinutesMeta));
    }
    if (data.containsKey('hijri_days_csv')) {
      context.handle(
          _hijriDaysCsvMeta,
          hijriDaysCsv.isAcceptableOrUnknown(
              data['hijri_days_csv']!, _hijriDaysCsvMeta));
    }
    if (data.containsKey('weekdays_csv')) {
      context.handle(
          _weekdaysCsvMeta,
          weekdaysCsv.isAcceptableOrUnknown(
              data['weekdays_csv']!, _weekdaysCsvMeta));
    }
    if (data.containsKey('linked_route')) {
      context.handle(
          _linkedRouteMeta,
          linkedRoute.isAcceptableOrUnknown(
              data['linked_route']!, _linkedRouteMeta));
    }
    if (data.containsKey('sound_id')) {
      context.handle(_soundIdMeta,
          soundId.isAcceptableOrUnknown(data['sound_id']!, _soundIdMeta));
    } else if (isInserting) {
      context.missing(_soundIdMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(_isEnabledMeta,
          isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SmartAlarm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmartAlarm(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      alarmType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}alarm_type'])!,
      fixedTimestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fixed_timestamp']),
      anchorPrayer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}anchor_prayer']),
      offsetMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}offset_minutes']),
      hijriDaysCsv: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hijri_days_csv']),
      weekdaysCsv: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}weekdays_csv']),
      linkedRoute: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}linked_route']),
      soundId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sound_id'])!,
      isEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_enabled'])!,
    );
  }

  @override
  $SmartAlarmsTable createAlias(String alias) {
    return $SmartAlarmsTable(attachedDatabase, alias);
  }
}

class SmartAlarm extends DataClass implements Insertable<SmartAlarm> {
  final String id;
  final String title;
  final String alarmType;
  final int? fixedTimestamp;
  final String? anchorPrayer;
  final int? offsetMinutes;
  final String? hijriDaysCsv;
  final String? weekdaysCsv;
  final String? linkedRoute;
  final String soundId;
  final int isEnabled;
  const SmartAlarm(
      {required this.id,
      required this.title,
      required this.alarmType,
      this.fixedTimestamp,
      this.anchorPrayer,
      this.offsetMinutes,
      this.hijriDaysCsv,
      this.weekdaysCsv,
      this.linkedRoute,
      required this.soundId,
      required this.isEnabled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['alarm_type'] = Variable<String>(alarmType);
    if (!nullToAbsent || fixedTimestamp != null) {
      map['fixed_timestamp'] = Variable<int>(fixedTimestamp);
    }
    if (!nullToAbsent || anchorPrayer != null) {
      map['anchor_prayer'] = Variable<String>(anchorPrayer);
    }
    if (!nullToAbsent || offsetMinutes != null) {
      map['offset_minutes'] = Variable<int>(offsetMinutes);
    }
    if (!nullToAbsent || hijriDaysCsv != null) {
      map['hijri_days_csv'] = Variable<String>(hijriDaysCsv);
    }
    if (!nullToAbsent || weekdaysCsv != null) {
      map['weekdays_csv'] = Variable<String>(weekdaysCsv);
    }
    if (!nullToAbsent || linkedRoute != null) {
      map['linked_route'] = Variable<String>(linkedRoute);
    }
    map['sound_id'] = Variable<String>(soundId);
    map['is_enabled'] = Variable<int>(isEnabled);
    return map;
  }

  SmartAlarmsCompanion toCompanion(bool nullToAbsent) {
    return SmartAlarmsCompanion(
      id: Value(id),
      title: Value(title),
      alarmType: Value(alarmType),
      fixedTimestamp: fixedTimestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(fixedTimestamp),
      anchorPrayer: anchorPrayer == null && nullToAbsent
          ? const Value.absent()
          : Value(anchorPrayer),
      offsetMinutes: offsetMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(offsetMinutes),
      hijriDaysCsv: hijriDaysCsv == null && nullToAbsent
          ? const Value.absent()
          : Value(hijriDaysCsv),
      weekdaysCsv: weekdaysCsv == null && nullToAbsent
          ? const Value.absent()
          : Value(weekdaysCsv),
      linkedRoute: linkedRoute == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedRoute),
      soundId: Value(soundId),
      isEnabled: Value(isEnabled),
    );
  }

  factory SmartAlarm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SmartAlarm(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      alarmType: serializer.fromJson<String>(json['alarmType']),
      fixedTimestamp: serializer.fromJson<int?>(json['fixedTimestamp']),
      anchorPrayer: serializer.fromJson<String?>(json['anchorPrayer']),
      offsetMinutes: serializer.fromJson<int?>(json['offsetMinutes']),
      hijriDaysCsv: serializer.fromJson<String?>(json['hijriDaysCsv']),
      weekdaysCsv: serializer.fromJson<String?>(json['weekdaysCsv']),
      linkedRoute: serializer.fromJson<String?>(json['linkedRoute']),
      soundId: serializer.fromJson<String>(json['soundId']),
      isEnabled: serializer.fromJson<int>(json['isEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'alarmType': serializer.toJson<String>(alarmType),
      'fixedTimestamp': serializer.toJson<int?>(fixedTimestamp),
      'anchorPrayer': serializer.toJson<String?>(anchorPrayer),
      'offsetMinutes': serializer.toJson<int?>(offsetMinutes),
      'hijriDaysCsv': serializer.toJson<String?>(hijriDaysCsv),
      'weekdaysCsv': serializer.toJson<String?>(weekdaysCsv),
      'linkedRoute': serializer.toJson<String?>(linkedRoute),
      'soundId': serializer.toJson<String>(soundId),
      'isEnabled': serializer.toJson<int>(isEnabled),
    };
  }

  SmartAlarm copyWith(
          {String? id,
          String? title,
          String? alarmType,
          Value<int?> fixedTimestamp = const Value.absent(),
          Value<String?> anchorPrayer = const Value.absent(),
          Value<int?> offsetMinutes = const Value.absent(),
          Value<String?> hijriDaysCsv = const Value.absent(),
          Value<String?> weekdaysCsv = const Value.absent(),
          Value<String?> linkedRoute = const Value.absent(),
          String? soundId,
          int? isEnabled}) =>
      SmartAlarm(
        id: id ?? this.id,
        title: title ?? this.title,
        alarmType: alarmType ?? this.alarmType,
        fixedTimestamp:
            fixedTimestamp.present ? fixedTimestamp.value : this.fixedTimestamp,
        anchorPrayer:
            anchorPrayer.present ? anchorPrayer.value : this.anchorPrayer,
        offsetMinutes:
            offsetMinutes.present ? offsetMinutes.value : this.offsetMinutes,
        hijriDaysCsv:
            hijriDaysCsv.present ? hijriDaysCsv.value : this.hijriDaysCsv,
        weekdaysCsv: weekdaysCsv.present ? weekdaysCsv.value : this.weekdaysCsv,
        linkedRoute: linkedRoute.present ? linkedRoute.value : this.linkedRoute,
        soundId: soundId ?? this.soundId,
        isEnabled: isEnabled ?? this.isEnabled,
      );
  SmartAlarm copyWithCompanion(SmartAlarmsCompanion data) {
    return SmartAlarm(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      alarmType: data.alarmType.present ? data.alarmType.value : this.alarmType,
      fixedTimestamp: data.fixedTimestamp.present
          ? data.fixedTimestamp.value
          : this.fixedTimestamp,
      anchorPrayer: data.anchorPrayer.present
          ? data.anchorPrayer.value
          : this.anchorPrayer,
      offsetMinutes: data.offsetMinutes.present
          ? data.offsetMinutes.value
          : this.offsetMinutes,
      hijriDaysCsv: data.hijriDaysCsv.present
          ? data.hijriDaysCsv.value
          : this.hijriDaysCsv,
      weekdaysCsv:
          data.weekdaysCsv.present ? data.weekdaysCsv.value : this.weekdaysCsv,
      linkedRoute:
          data.linkedRoute.present ? data.linkedRoute.value : this.linkedRoute,
      soundId: data.soundId.present ? data.soundId.value : this.soundId,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SmartAlarm(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('alarmType: $alarmType, ')
          ..write('fixedTimestamp: $fixedTimestamp, ')
          ..write('anchorPrayer: $anchorPrayer, ')
          ..write('offsetMinutes: $offsetMinutes, ')
          ..write('hijriDaysCsv: $hijriDaysCsv, ')
          ..write('weekdaysCsv: $weekdaysCsv, ')
          ..write('linkedRoute: $linkedRoute, ')
          ..write('soundId: $soundId, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      alarmType,
      fixedTimestamp,
      anchorPrayer,
      offsetMinutes,
      hijriDaysCsv,
      weekdaysCsv,
      linkedRoute,
      soundId,
      isEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SmartAlarm &&
          other.id == this.id &&
          other.title == this.title &&
          other.alarmType == this.alarmType &&
          other.fixedTimestamp == this.fixedTimestamp &&
          other.anchorPrayer == this.anchorPrayer &&
          other.offsetMinutes == this.offsetMinutes &&
          other.hijriDaysCsv == this.hijriDaysCsv &&
          other.weekdaysCsv == this.weekdaysCsv &&
          other.linkedRoute == this.linkedRoute &&
          other.soundId == this.soundId &&
          other.isEnabled == this.isEnabled);
}

class SmartAlarmsCompanion extends UpdateCompanion<SmartAlarm> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> alarmType;
  final Value<int?> fixedTimestamp;
  final Value<String?> anchorPrayer;
  final Value<int?> offsetMinutes;
  final Value<String?> hijriDaysCsv;
  final Value<String?> weekdaysCsv;
  final Value<String?> linkedRoute;
  final Value<String> soundId;
  final Value<int> isEnabled;
  final Value<int> rowid;
  const SmartAlarmsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.alarmType = const Value.absent(),
    this.fixedTimestamp = const Value.absent(),
    this.anchorPrayer = const Value.absent(),
    this.offsetMinutes = const Value.absent(),
    this.hijriDaysCsv = const Value.absent(),
    this.weekdaysCsv = const Value.absent(),
    this.linkedRoute = const Value.absent(),
    this.soundId = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SmartAlarmsCompanion.insert({
    required String id,
    required String title,
    required String alarmType,
    this.fixedTimestamp = const Value.absent(),
    this.anchorPrayer = const Value.absent(),
    this.offsetMinutes = const Value.absent(),
    this.hijriDaysCsv = const Value.absent(),
    this.weekdaysCsv = const Value.absent(),
    this.linkedRoute = const Value.absent(),
    required String soundId,
    this.isEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        alarmType = Value(alarmType),
        soundId = Value(soundId);
  static Insertable<SmartAlarm> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? alarmType,
    Expression<int>? fixedTimestamp,
    Expression<String>? anchorPrayer,
    Expression<int>? offsetMinutes,
    Expression<String>? hijriDaysCsv,
    Expression<String>? weekdaysCsv,
    Expression<String>? linkedRoute,
    Expression<String>? soundId,
    Expression<int>? isEnabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (alarmType != null) 'alarm_type': alarmType,
      if (fixedTimestamp != null) 'fixed_timestamp': fixedTimestamp,
      if (anchorPrayer != null) 'anchor_prayer': anchorPrayer,
      if (offsetMinutes != null) 'offset_minutes': offsetMinutes,
      if (hijriDaysCsv != null) 'hijri_days_csv': hijriDaysCsv,
      if (weekdaysCsv != null) 'weekdays_csv': weekdaysCsv,
      if (linkedRoute != null) 'linked_route': linkedRoute,
      if (soundId != null) 'sound_id': soundId,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SmartAlarmsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? alarmType,
      Value<int?>? fixedTimestamp,
      Value<String?>? anchorPrayer,
      Value<int?>? offsetMinutes,
      Value<String?>? hijriDaysCsv,
      Value<String?>? weekdaysCsv,
      Value<String?>? linkedRoute,
      Value<String>? soundId,
      Value<int>? isEnabled,
      Value<int>? rowid}) {
    return SmartAlarmsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      alarmType: alarmType ?? this.alarmType,
      fixedTimestamp: fixedTimestamp ?? this.fixedTimestamp,
      anchorPrayer: anchorPrayer ?? this.anchorPrayer,
      offsetMinutes: offsetMinutes ?? this.offsetMinutes,
      hijriDaysCsv: hijriDaysCsv ?? this.hijriDaysCsv,
      weekdaysCsv: weekdaysCsv ?? this.weekdaysCsv,
      linkedRoute: linkedRoute ?? this.linkedRoute,
      soundId: soundId ?? this.soundId,
      isEnabled: isEnabled ?? this.isEnabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (alarmType.present) {
      map['alarm_type'] = Variable<String>(alarmType.value);
    }
    if (fixedTimestamp.present) {
      map['fixed_timestamp'] = Variable<int>(fixedTimestamp.value);
    }
    if (anchorPrayer.present) {
      map['anchor_prayer'] = Variable<String>(anchorPrayer.value);
    }
    if (offsetMinutes.present) {
      map['offset_minutes'] = Variable<int>(offsetMinutes.value);
    }
    if (hijriDaysCsv.present) {
      map['hijri_days_csv'] = Variable<String>(hijriDaysCsv.value);
    }
    if (weekdaysCsv.present) {
      map['weekdays_csv'] = Variable<String>(weekdaysCsv.value);
    }
    if (linkedRoute.present) {
      map['linked_route'] = Variable<String>(linkedRoute.value);
    }
    if (soundId.present) {
      map['sound_id'] = Variable<String>(soundId.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<int>(isEnabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SmartAlarmsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('alarmType: $alarmType, ')
          ..write('fixedTimestamp: $fixedTimestamp, ')
          ..write('anchorPrayer: $anchorPrayer, ')
          ..write('offsetMinutes: $offsetMinutes, ')
          ..write('hijriDaysCsv: $hijriDaysCsv, ')
          ..write('weekdaysCsv: $weekdaysCsv, ')
          ..write('linkedRoute: $linkedRoute, ')
          ..write('soundId: $soundId, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserNotesTable extends UserNotes
    with TableInfo<$UserNotesTable, UserNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _folderNameMeta =
      const VerificationMeta('folderName');
  @override
  late final GeneratedColumn<String> folderName = GeneratedColumn<String>(
      'folder_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Genel'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _markdownBodyMeta =
      const VerificationMeta('markdownBody');
  @override
  late final GeneratedColumn<String> markdownBody = GeneratedColumn<String>(
      'markdown_body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _linkedEntityTypeMeta =
      const VerificationMeta('linkedEntityType');
  @override
  late final GeneratedColumn<String> linkedEntityType = GeneratedColumn<String>(
      'linked_entity_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _linkedEntityIdMeta =
      const VerificationMeta('linkedEntityId');
  @override
  late final GeneratedColumn<String> linkedEntityId = GeneratedColumn<String>(
      'linked_entity_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isLockedBiometricMeta =
      const VerificationMeta('isLockedBiometric');
  @override
  late final GeneratedColumn<int> isLockedBiometric = GeneratedColumn<int>(
      'is_locked_biometric', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        folderName,
        title,
        markdownBody,
        linkedEntityType,
        linkedEntityId,
        isLockedBiometric,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_notes';
  @override
  VerificationContext validateIntegrity(Insertable<UserNote> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('folder_name')) {
      context.handle(
          _folderNameMeta,
          folderName.isAcceptableOrUnknown(
              data['folder_name']!, _folderNameMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('markdown_body')) {
      context.handle(
          _markdownBodyMeta,
          markdownBody.isAcceptableOrUnknown(
              data['markdown_body']!, _markdownBodyMeta));
    } else if (isInserting) {
      context.missing(_markdownBodyMeta);
    }
    if (data.containsKey('linked_entity_type')) {
      context.handle(
          _linkedEntityTypeMeta,
          linkedEntityType.isAcceptableOrUnknown(
              data['linked_entity_type']!, _linkedEntityTypeMeta));
    }
    if (data.containsKey('linked_entity_id')) {
      context.handle(
          _linkedEntityIdMeta,
          linkedEntityId.isAcceptableOrUnknown(
              data['linked_entity_id']!, _linkedEntityIdMeta));
    }
    if (data.containsKey('is_locked_biometric')) {
      context.handle(
          _isLockedBiometricMeta,
          isLockedBiometric.isAcceptableOrUnknown(
              data['is_locked_biometric']!, _isLockedBiometricMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserNote(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      folderName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}folder_name'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      markdownBody: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}markdown_body'])!,
      linkedEntityType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}linked_entity_type']),
      linkedEntityId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}linked_entity_id']),
      isLockedBiometric: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}is_locked_biometric'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UserNotesTable createAlias(String alias) {
    return $UserNotesTable(attachedDatabase, alias);
  }
}

class UserNote extends DataClass implements Insertable<UserNote> {
  final String id;
  final String folderName;
  final String title;
  final String markdownBody;
  final String? linkedEntityType;
  final String? linkedEntityId;
  final int isLockedBiometric;
  final int createdAt;
  final int updatedAt;
  const UserNote(
      {required this.id,
      required this.folderName,
      required this.title,
      required this.markdownBody,
      this.linkedEntityType,
      this.linkedEntityId,
      required this.isLockedBiometric,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['folder_name'] = Variable<String>(folderName);
    map['title'] = Variable<String>(title);
    map['markdown_body'] = Variable<String>(markdownBody);
    if (!nullToAbsent || linkedEntityType != null) {
      map['linked_entity_type'] = Variable<String>(linkedEntityType);
    }
    if (!nullToAbsent || linkedEntityId != null) {
      map['linked_entity_id'] = Variable<String>(linkedEntityId);
    }
    map['is_locked_biometric'] = Variable<int>(isLockedBiometric);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  UserNotesCompanion toCompanion(bool nullToAbsent) {
    return UserNotesCompanion(
      id: Value(id),
      folderName: Value(folderName),
      title: Value(title),
      markdownBody: Value(markdownBody),
      linkedEntityType: linkedEntityType == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedEntityType),
      linkedEntityId: linkedEntityId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedEntityId),
      isLockedBiometric: Value(isLockedBiometric),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserNote.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserNote(
      id: serializer.fromJson<String>(json['id']),
      folderName: serializer.fromJson<String>(json['folderName']),
      title: serializer.fromJson<String>(json['title']),
      markdownBody: serializer.fromJson<String>(json['markdownBody']),
      linkedEntityType: serializer.fromJson<String?>(json['linkedEntityType']),
      linkedEntityId: serializer.fromJson<String?>(json['linkedEntityId']),
      isLockedBiometric: serializer.fromJson<int>(json['isLockedBiometric']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'folderName': serializer.toJson<String>(folderName),
      'title': serializer.toJson<String>(title),
      'markdownBody': serializer.toJson<String>(markdownBody),
      'linkedEntityType': serializer.toJson<String?>(linkedEntityType),
      'linkedEntityId': serializer.toJson<String?>(linkedEntityId),
      'isLockedBiometric': serializer.toJson<int>(isLockedBiometric),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  UserNote copyWith(
          {String? id,
          String? folderName,
          String? title,
          String? markdownBody,
          Value<String?> linkedEntityType = const Value.absent(),
          Value<String?> linkedEntityId = const Value.absent(),
          int? isLockedBiometric,
          int? createdAt,
          int? updatedAt}) =>
      UserNote(
        id: id ?? this.id,
        folderName: folderName ?? this.folderName,
        title: title ?? this.title,
        markdownBody: markdownBody ?? this.markdownBody,
        linkedEntityType: linkedEntityType.present
            ? linkedEntityType.value
            : this.linkedEntityType,
        linkedEntityId:
            linkedEntityId.present ? linkedEntityId.value : this.linkedEntityId,
        isLockedBiometric: isLockedBiometric ?? this.isLockedBiometric,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  UserNote copyWithCompanion(UserNotesCompanion data) {
    return UserNote(
      id: data.id.present ? data.id.value : this.id,
      folderName:
          data.folderName.present ? data.folderName.value : this.folderName,
      title: data.title.present ? data.title.value : this.title,
      markdownBody: data.markdownBody.present
          ? data.markdownBody.value
          : this.markdownBody,
      linkedEntityType: data.linkedEntityType.present
          ? data.linkedEntityType.value
          : this.linkedEntityType,
      linkedEntityId: data.linkedEntityId.present
          ? data.linkedEntityId.value
          : this.linkedEntityId,
      isLockedBiometric: data.isLockedBiometric.present
          ? data.isLockedBiometric.value
          : this.isLockedBiometric,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserNote(')
          ..write('id: $id, ')
          ..write('folderName: $folderName, ')
          ..write('title: $title, ')
          ..write('markdownBody: $markdownBody, ')
          ..write('linkedEntityType: $linkedEntityType, ')
          ..write('linkedEntityId: $linkedEntityId, ')
          ..write('isLockedBiometric: $isLockedBiometric, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      folderName,
      title,
      markdownBody,
      linkedEntityType,
      linkedEntityId,
      isLockedBiometric,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserNote &&
          other.id == this.id &&
          other.folderName == this.folderName &&
          other.title == this.title &&
          other.markdownBody == this.markdownBody &&
          other.linkedEntityType == this.linkedEntityType &&
          other.linkedEntityId == this.linkedEntityId &&
          other.isLockedBiometric == this.isLockedBiometric &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserNotesCompanion extends UpdateCompanion<UserNote> {
  final Value<String> id;
  final Value<String> folderName;
  final Value<String> title;
  final Value<String> markdownBody;
  final Value<String?> linkedEntityType;
  final Value<String?> linkedEntityId;
  final Value<int> isLockedBiometric;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const UserNotesCompanion({
    this.id = const Value.absent(),
    this.folderName = const Value.absent(),
    this.title = const Value.absent(),
    this.markdownBody = const Value.absent(),
    this.linkedEntityType = const Value.absent(),
    this.linkedEntityId = const Value.absent(),
    this.isLockedBiometric = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserNotesCompanion.insert({
    required String id,
    this.folderName = const Value.absent(),
    required String title,
    required String markdownBody,
    this.linkedEntityType = const Value.absent(),
    this.linkedEntityId = const Value.absent(),
    this.isLockedBiometric = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        markdownBody = Value(markdownBody),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<UserNote> custom({
    Expression<String>? id,
    Expression<String>? folderName,
    Expression<String>? title,
    Expression<String>? markdownBody,
    Expression<String>? linkedEntityType,
    Expression<String>? linkedEntityId,
    Expression<int>? isLockedBiometric,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (folderName != null) 'folder_name': folderName,
      if (title != null) 'title': title,
      if (markdownBody != null) 'markdown_body': markdownBody,
      if (linkedEntityType != null) 'linked_entity_type': linkedEntityType,
      if (linkedEntityId != null) 'linked_entity_id': linkedEntityId,
      if (isLockedBiometric != null) 'is_locked_biometric': isLockedBiometric,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserNotesCompanion copyWith(
      {Value<String>? id,
      Value<String>? folderName,
      Value<String>? title,
      Value<String>? markdownBody,
      Value<String?>? linkedEntityType,
      Value<String?>? linkedEntityId,
      Value<int>? isLockedBiometric,
      Value<int>? createdAt,
      Value<int>? updatedAt,
      Value<int>? rowid}) {
    return UserNotesCompanion(
      id: id ?? this.id,
      folderName: folderName ?? this.folderName,
      title: title ?? this.title,
      markdownBody: markdownBody ?? this.markdownBody,
      linkedEntityType: linkedEntityType ?? this.linkedEntityType,
      linkedEntityId: linkedEntityId ?? this.linkedEntityId,
      isLockedBiometric: isLockedBiometric ?? this.isLockedBiometric,
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
    if (folderName.present) {
      map['folder_name'] = Variable<String>(folderName.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (markdownBody.present) {
      map['markdown_body'] = Variable<String>(markdownBody.value);
    }
    if (linkedEntityType.present) {
      map['linked_entity_type'] = Variable<String>(linkedEntityType.value);
    }
    if (linkedEntityId.present) {
      map['linked_entity_id'] = Variable<String>(linkedEntityId.value);
    }
    if (isLockedBiometric.present) {
      map['is_locked_biometric'] = Variable<int>(isLockedBiometric.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserNotesCompanion(')
          ..write('id: $id, ')
          ..write('folderName: $folderName, ')
          ..write('title: $title, ')
          ..write('markdownBody: $markdownBody, ')
          ..write('linkedEntityType: $linkedEntityType, ')
          ..write('linkedEntityId: $linkedEntityId, ')
          ..write('isLockedBiometric: $isLockedBiometric, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QadaTrackerTable extends QadaTracker
    with TableInfo<$QadaTrackerTable, QadaTrackerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QadaTrackerTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _prayerTypeMeta =
      const VerificationMeta('prayerType');
  @override
  late final GeneratedColumn<String> prayerType = GeneratedColumn<String>(
      'prayer_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _remainingCountMeta =
      const VerificationMeta('remainingCount');
  @override
  late final GeneratedColumn<int> remainingCount = GeneratedColumn<int>(
      'remaining_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _completedCountMeta =
      const VerificationMeta('completedCount');
  @override
  late final GeneratedColumn<int> completedCount = GeneratedColumn<int>(
      'completed_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _dailyTargetMeta =
      const VerificationMeta('dailyTarget');
  @override
  late final GeneratedColumn<int> dailyTarget = GeneratedColumn<int>(
      'daily_target', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [prayerType, remainingCount, completedCount, dailyTarget, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'qada_tracker';
  @override
  VerificationContext validateIntegrity(Insertable<QadaTrackerData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('prayer_type')) {
      context.handle(
          _prayerTypeMeta,
          prayerType.isAcceptableOrUnknown(
              data['prayer_type']!, _prayerTypeMeta));
    } else if (isInserting) {
      context.missing(_prayerTypeMeta);
    }
    if (data.containsKey('remaining_count')) {
      context.handle(
          _remainingCountMeta,
          remainingCount.isAcceptableOrUnknown(
              data['remaining_count']!, _remainingCountMeta));
    }
    if (data.containsKey('completed_count')) {
      context.handle(
          _completedCountMeta,
          completedCount.isAcceptableOrUnknown(
              data['completed_count']!, _completedCountMeta));
    }
    if (data.containsKey('daily_target')) {
      context.handle(
          _dailyTargetMeta,
          dailyTarget.isAcceptableOrUnknown(
              data['daily_target']!, _dailyTargetMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {prayerType};
  @override
  QadaTrackerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QadaTrackerData(
      prayerType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}prayer_type'])!,
      remainingCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}remaining_count'])!,
      completedCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}completed_count'])!,
      dailyTarget: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}daily_target'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $QadaTrackerTable createAlias(String alias) {
    return $QadaTrackerTable(attachedDatabase, alias);
  }
}

class QadaTrackerData extends DataClass implements Insertable<QadaTrackerData> {
  final String prayerType;
  final int remainingCount;
  final int completedCount;
  final int dailyTarget;
  final int updatedAt;
  const QadaTrackerData(
      {required this.prayerType,
      required this.remainingCount,
      required this.completedCount,
      required this.dailyTarget,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['prayer_type'] = Variable<String>(prayerType);
    map['remaining_count'] = Variable<int>(remainingCount);
    map['completed_count'] = Variable<int>(completedCount);
    map['daily_target'] = Variable<int>(dailyTarget);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  QadaTrackerCompanion toCompanion(bool nullToAbsent) {
    return QadaTrackerCompanion(
      prayerType: Value(prayerType),
      remainingCount: Value(remainingCount),
      completedCount: Value(completedCount),
      dailyTarget: Value(dailyTarget),
      updatedAt: Value(updatedAt),
    );
  }

  factory QadaTrackerData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QadaTrackerData(
      prayerType: serializer.fromJson<String>(json['prayerType']),
      remainingCount: serializer.fromJson<int>(json['remainingCount']),
      completedCount: serializer.fromJson<int>(json['completedCount']),
      dailyTarget: serializer.fromJson<int>(json['dailyTarget']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'prayerType': serializer.toJson<String>(prayerType),
      'remainingCount': serializer.toJson<int>(remainingCount),
      'completedCount': serializer.toJson<int>(completedCount),
      'dailyTarget': serializer.toJson<int>(dailyTarget),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  QadaTrackerData copyWith(
          {String? prayerType,
          int? remainingCount,
          int? completedCount,
          int? dailyTarget,
          int? updatedAt}) =>
      QadaTrackerData(
        prayerType: prayerType ?? this.prayerType,
        remainingCount: remainingCount ?? this.remainingCount,
        completedCount: completedCount ?? this.completedCount,
        dailyTarget: dailyTarget ?? this.dailyTarget,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  QadaTrackerData copyWithCompanion(QadaTrackerCompanion data) {
    return QadaTrackerData(
      prayerType:
          data.prayerType.present ? data.prayerType.value : this.prayerType,
      remainingCount: data.remainingCount.present
          ? data.remainingCount.value
          : this.remainingCount,
      completedCount: data.completedCount.present
          ? data.completedCount.value
          : this.completedCount,
      dailyTarget:
          data.dailyTarget.present ? data.dailyTarget.value : this.dailyTarget,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QadaTrackerData(')
          ..write('prayerType: $prayerType, ')
          ..write('remainingCount: $remainingCount, ')
          ..write('completedCount: $completedCount, ')
          ..write('dailyTarget: $dailyTarget, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      prayerType, remainingCount, completedCount, dailyTarget, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QadaTrackerData &&
          other.prayerType == this.prayerType &&
          other.remainingCount == this.remainingCount &&
          other.completedCount == this.completedCount &&
          other.dailyTarget == this.dailyTarget &&
          other.updatedAt == this.updatedAt);
}

class QadaTrackerCompanion extends UpdateCompanion<QadaTrackerData> {
  final Value<String> prayerType;
  final Value<int> remainingCount;
  final Value<int> completedCount;
  final Value<int> dailyTarget;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const QadaTrackerCompanion({
    this.prayerType = const Value.absent(),
    this.remainingCount = const Value.absent(),
    this.completedCount = const Value.absent(),
    this.dailyTarget = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QadaTrackerCompanion.insert({
    required String prayerType,
    this.remainingCount = const Value.absent(),
    this.completedCount = const Value.absent(),
    this.dailyTarget = const Value.absent(),
    required int updatedAt,
    this.rowid = const Value.absent(),
  })  : prayerType = Value(prayerType),
        updatedAt = Value(updatedAt);
  static Insertable<QadaTrackerData> custom({
    Expression<String>? prayerType,
    Expression<int>? remainingCount,
    Expression<int>? completedCount,
    Expression<int>? dailyTarget,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (prayerType != null) 'prayer_type': prayerType,
      if (remainingCount != null) 'remaining_count': remainingCount,
      if (completedCount != null) 'completed_count': completedCount,
      if (dailyTarget != null) 'daily_target': dailyTarget,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QadaTrackerCompanion copyWith(
      {Value<String>? prayerType,
      Value<int>? remainingCount,
      Value<int>? completedCount,
      Value<int>? dailyTarget,
      Value<int>? updatedAt,
      Value<int>? rowid}) {
    return QadaTrackerCompanion(
      prayerType: prayerType ?? this.prayerType,
      remainingCount: remainingCount ?? this.remainingCount,
      completedCount: completedCount ?? this.completedCount,
      dailyTarget: dailyTarget ?? this.dailyTarget,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (prayerType.present) {
      map['prayer_type'] = Variable<String>(prayerType.value);
    }
    if (remainingCount.present) {
      map['remaining_count'] = Variable<int>(remainingCount.value);
    }
    if (completedCount.present) {
      map['completed_count'] = Variable<int>(completedCount.value);
    }
    if (dailyTarget.present) {
      map['daily_target'] = Variable<int>(dailyTarget.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QadaTrackerCompanion(')
          ..write('prayerType: $prayerType, ')
          ..write('remainingCount: $remainingCount, ')
          ..write('completedCount: $completedCount, ')
          ..write('dailyTarget: $dailyTarget, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PrayerTimesCacheTable prayerTimesCache =
      $PrayerTimesCacheTable(this);
  late final $IlmiFeedItemsTable ilmiFeedItems = $IlmiFeedItemsTable(this);
  late final $CollectionsTable collections = $CollectionsTable(this);
  late final $SavedItemsTable savedItems = $SavedItemsTable(this);
  late final $ErkamDuaPagesTable erkamDuaPages = $ErkamDuaPagesTable(this);
  late final $QuranSurahsTable quranSurahs = $QuranSurahsTable(this);
  late final $QuranAyahsTable quranAyahs = $QuranAyahsTable(this);
  late final $DhikrItemsTable dhikrItems = $DhikrItemsTable(this);
  late final $SmartAlarmsTable smartAlarms = $SmartAlarmsTable(this);
  late final $UserNotesTable userNotes = $UserNotesTable(this);
  late final $QadaTrackerTable qadaTracker = $QadaTrackerTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        prayerTimesCache,
        ilmiFeedItems,
        collections,
        savedItems,
        erkamDuaPages,
        quranSurahs,
        quranAyahs,
        dhikrItems,
        smartAlarms,
        userNotes,
        qadaTracker
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('collections',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('saved_items', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$PrayerTimesCacheTableCreateCompanionBuilder
    = PrayerTimesCacheCompanion Function({
  Value<int> id,
  required String locationId,
  required String gregorianDate,
  required String hijriDate,
  required String fajr,
  required String sunrise,
  required String dhuhr,
  required String asr,
  required String maghrib,
  required String isha,
  required String calculationSource,
});
typedef $$PrayerTimesCacheTableUpdateCompanionBuilder
    = PrayerTimesCacheCompanion Function({
  Value<int> id,
  Value<String> locationId,
  Value<String> gregorianDate,
  Value<String> hijriDate,
  Value<String> fajr,
  Value<String> sunrise,
  Value<String> dhuhr,
  Value<String> asr,
  Value<String> maghrib,
  Value<String> isha,
  Value<String> calculationSource,
});

class $$PrayerTimesCacheTableFilterComposer
    extends Composer<_$AppDatabase, $PrayerTimesCacheTable> {
  $$PrayerTimesCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gregorianDate => $composableBuilder(
      column: $table.gregorianDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get hijriDate => $composableBuilder(
      column: $table.hijriDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fajr => $composableBuilder(
      column: $table.fajr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sunrise => $composableBuilder(
      column: $table.sunrise, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dhuhr => $composableBuilder(
      column: $table.dhuhr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get asr => $composableBuilder(
      column: $table.asr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get maghrib => $composableBuilder(
      column: $table.maghrib, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get isha => $composableBuilder(
      column: $table.isha, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get calculationSource => $composableBuilder(
      column: $table.calculationSource,
      builder: (column) => ColumnFilters(column));
}

class $$PrayerTimesCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $PrayerTimesCacheTable> {
  $$PrayerTimesCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gregorianDate => $composableBuilder(
      column: $table.gregorianDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get hijriDate => $composableBuilder(
      column: $table.hijriDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fajr => $composableBuilder(
      column: $table.fajr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sunrise => $composableBuilder(
      column: $table.sunrise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dhuhr => $composableBuilder(
      column: $table.dhuhr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get asr => $composableBuilder(
      column: $table.asr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get maghrib => $composableBuilder(
      column: $table.maghrib, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get isha => $composableBuilder(
      column: $table.isha, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get calculationSource => $composableBuilder(
      column: $table.calculationSource,
      builder: (column) => ColumnOrderings(column));
}

class $$PrayerTimesCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrayerTimesCacheTable> {
  $$PrayerTimesCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => column);

  GeneratedColumn<String> get gregorianDate => $composableBuilder(
      column: $table.gregorianDate, builder: (column) => column);

  GeneratedColumn<String> get hijriDate =>
      $composableBuilder(column: $table.hijriDate, builder: (column) => column);

  GeneratedColumn<String> get fajr =>
      $composableBuilder(column: $table.fajr, builder: (column) => column);

  GeneratedColumn<String> get sunrise =>
      $composableBuilder(column: $table.sunrise, builder: (column) => column);

  GeneratedColumn<String> get dhuhr =>
      $composableBuilder(column: $table.dhuhr, builder: (column) => column);

  GeneratedColumn<String> get asr =>
      $composableBuilder(column: $table.asr, builder: (column) => column);

  GeneratedColumn<String> get maghrib =>
      $composableBuilder(column: $table.maghrib, builder: (column) => column);

  GeneratedColumn<String> get isha =>
      $composableBuilder(column: $table.isha, builder: (column) => column);

  GeneratedColumn<String> get calculationSource => $composableBuilder(
      column: $table.calculationSource, builder: (column) => column);
}

class $$PrayerTimesCacheTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PrayerTimesCacheTable,
    PrayerTimesCacheData,
    $$PrayerTimesCacheTableFilterComposer,
    $$PrayerTimesCacheTableOrderingComposer,
    $$PrayerTimesCacheTableAnnotationComposer,
    $$PrayerTimesCacheTableCreateCompanionBuilder,
    $$PrayerTimesCacheTableUpdateCompanionBuilder,
    (
      PrayerTimesCacheData,
      BaseReferences<_$AppDatabase, $PrayerTimesCacheTable,
          PrayerTimesCacheData>
    ),
    PrayerTimesCacheData,
    PrefetchHooks Function()> {
  $$PrayerTimesCacheTableTableManager(
      _$AppDatabase db, $PrayerTimesCacheTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrayerTimesCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrayerTimesCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrayerTimesCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> locationId = const Value.absent(),
            Value<String> gregorianDate = const Value.absent(),
            Value<String> hijriDate = const Value.absent(),
            Value<String> fajr = const Value.absent(),
            Value<String> sunrise = const Value.absent(),
            Value<String> dhuhr = const Value.absent(),
            Value<String> asr = const Value.absent(),
            Value<String> maghrib = const Value.absent(),
            Value<String> isha = const Value.absent(),
            Value<String> calculationSource = const Value.absent(),
          }) =>
              PrayerTimesCacheCompanion(
            id: id,
            locationId: locationId,
            gregorianDate: gregorianDate,
            hijriDate: hijriDate,
            fajr: fajr,
            sunrise: sunrise,
            dhuhr: dhuhr,
            asr: asr,
            maghrib: maghrib,
            isha: isha,
            calculationSource: calculationSource,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String locationId,
            required String gregorianDate,
            required String hijriDate,
            required String fajr,
            required String sunrise,
            required String dhuhr,
            required String asr,
            required String maghrib,
            required String isha,
            required String calculationSource,
          }) =>
              PrayerTimesCacheCompanion.insert(
            id: id,
            locationId: locationId,
            gregorianDate: gregorianDate,
            hijriDate: hijriDate,
            fajr: fajr,
            sunrise: sunrise,
            dhuhr: dhuhr,
            asr: asr,
            maghrib: maghrib,
            isha: isha,
            calculationSource: calculationSource,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$PrayerTimesCacheTable, PrayerTimesCacheData>(
                        table),
                    BaseReferences<_$AppDatabase, $PrayerTimesCacheTable,
                        PrayerTimesCacheData>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PrayerTimesCacheTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PrayerTimesCacheTable,
    PrayerTimesCacheData,
    $$PrayerTimesCacheTableFilterComposer,
    $$PrayerTimesCacheTableOrderingComposer,
    $$PrayerTimesCacheTableAnnotationComposer,
    $$PrayerTimesCacheTableCreateCompanionBuilder,
    $$PrayerTimesCacheTableUpdateCompanionBuilder,
    (
      PrayerTimesCacheData,
      BaseReferences<_$AppDatabase, $PrayerTimesCacheTable,
          PrayerTimesCacheData>
    ),
    PrayerTimesCacheData,
    PrefetchHooks Function()>;
typedef $$IlmiFeedItemsTableCreateCompanionBuilder = IlmiFeedItemsCompanion
    Function({
  required String id,
  required String category,
  Value<String?> title,
  Value<String?> arabicText,
  required String summaryBody,
  Value<String?> detailedCommentary,
  required String sourceReference,
  Value<String?> authorOrScholar,
  Value<String?> bookPageRef,
  Value<int> readingTimeSec,
  Value<int> isLiked,
  Value<int> isRead,
  required int publishedAt,
  Value<int> rowid,
});
typedef $$IlmiFeedItemsTableUpdateCompanionBuilder = IlmiFeedItemsCompanion
    Function({
  Value<String> id,
  Value<String> category,
  Value<String?> title,
  Value<String?> arabicText,
  Value<String> summaryBody,
  Value<String?> detailedCommentary,
  Value<String> sourceReference,
  Value<String?> authorOrScholar,
  Value<String?> bookPageRef,
  Value<int> readingTimeSec,
  Value<int> isLiked,
  Value<int> isRead,
  Value<int> publishedAt,
  Value<int> rowid,
});

class $$IlmiFeedItemsTableFilterComposer
    extends Composer<_$AppDatabase, $IlmiFeedItemsTable> {
  $$IlmiFeedItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get arabicText => $composableBuilder(
      column: $table.arabicText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get summaryBody => $composableBuilder(
      column: $table.summaryBody, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get detailedCommentary => $composableBuilder(
      column: $table.detailedCommentary,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceReference => $composableBuilder(
      column: $table.sourceReference,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get authorOrScholar => $composableBuilder(
      column: $table.authorOrScholar,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bookPageRef => $composableBuilder(
      column: $table.bookPageRef, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get readingTimeSec => $composableBuilder(
      column: $table.readingTimeSec,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isLiked => $composableBuilder(
      column: $table.isLiked, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isRead => $composableBuilder(
      column: $table.isRead, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnFilters(column));
}

class $$IlmiFeedItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $IlmiFeedItemsTable> {
  $$IlmiFeedItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get arabicText => $composableBuilder(
      column: $table.arabicText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get summaryBody => $composableBuilder(
      column: $table.summaryBody, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get detailedCommentary => $composableBuilder(
      column: $table.detailedCommentary,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceReference => $composableBuilder(
      column: $table.sourceReference,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get authorOrScholar => $composableBuilder(
      column: $table.authorOrScholar,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bookPageRef => $composableBuilder(
      column: $table.bookPageRef, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get readingTimeSec => $composableBuilder(
      column: $table.readingTimeSec,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isLiked => $composableBuilder(
      column: $table.isLiked, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isRead => $composableBuilder(
      column: $table.isRead, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnOrderings(column));
}

class $$IlmiFeedItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IlmiFeedItemsTable> {
  $$IlmiFeedItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get arabicText => $composableBuilder(
      column: $table.arabicText, builder: (column) => column);

  GeneratedColumn<String> get summaryBody => $composableBuilder(
      column: $table.summaryBody, builder: (column) => column);

  GeneratedColumn<String> get detailedCommentary => $composableBuilder(
      column: $table.detailedCommentary, builder: (column) => column);

  GeneratedColumn<String> get sourceReference => $composableBuilder(
      column: $table.sourceReference, builder: (column) => column);

  GeneratedColumn<String> get authorOrScholar => $composableBuilder(
      column: $table.authorOrScholar, builder: (column) => column);

  GeneratedColumn<String> get bookPageRef => $composableBuilder(
      column: $table.bookPageRef, builder: (column) => column);

  GeneratedColumn<int> get readingTimeSec => $composableBuilder(
      column: $table.readingTimeSec, builder: (column) => column);

  GeneratedColumn<int> get isLiked =>
      $composableBuilder(column: $table.isLiked, builder: (column) => column);

  GeneratedColumn<int> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<int> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => column);
}

class $$IlmiFeedItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IlmiFeedItemsTable,
    IlmiFeedItem,
    $$IlmiFeedItemsTableFilterComposer,
    $$IlmiFeedItemsTableOrderingComposer,
    $$IlmiFeedItemsTableAnnotationComposer,
    $$IlmiFeedItemsTableCreateCompanionBuilder,
    $$IlmiFeedItemsTableUpdateCompanionBuilder,
    (
      IlmiFeedItem,
      BaseReferences<_$AppDatabase, $IlmiFeedItemsTable, IlmiFeedItem>
    ),
    IlmiFeedItem,
    PrefetchHooks Function()> {
  $$IlmiFeedItemsTableTableManager(_$AppDatabase db, $IlmiFeedItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IlmiFeedItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IlmiFeedItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IlmiFeedItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> arabicText = const Value.absent(),
            Value<String> summaryBody = const Value.absent(),
            Value<String?> detailedCommentary = const Value.absent(),
            Value<String> sourceReference = const Value.absent(),
            Value<String?> authorOrScholar = const Value.absent(),
            Value<String?> bookPageRef = const Value.absent(),
            Value<int> readingTimeSec = const Value.absent(),
            Value<int> isLiked = const Value.absent(),
            Value<int> isRead = const Value.absent(),
            Value<int> publishedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              IlmiFeedItemsCompanion(
            id: id,
            category: category,
            title: title,
            arabicText: arabicText,
            summaryBody: summaryBody,
            detailedCommentary: detailedCommentary,
            sourceReference: sourceReference,
            authorOrScholar: authorOrScholar,
            bookPageRef: bookPageRef,
            readingTimeSec: readingTimeSec,
            isLiked: isLiked,
            isRead: isRead,
            publishedAt: publishedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String category,
            Value<String?> title = const Value.absent(),
            Value<String?> arabicText = const Value.absent(),
            required String summaryBody,
            Value<String?> detailedCommentary = const Value.absent(),
            required String sourceReference,
            Value<String?> authorOrScholar = const Value.absent(),
            Value<String?> bookPageRef = const Value.absent(),
            Value<int> readingTimeSec = const Value.absent(),
            Value<int> isLiked = const Value.absent(),
            Value<int> isRead = const Value.absent(),
            required int publishedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              IlmiFeedItemsCompanion.insert(
            id: id,
            category: category,
            title: title,
            arabicText: arabicText,
            summaryBody: summaryBody,
            detailedCommentary: detailedCommentary,
            sourceReference: sourceReference,
            authorOrScholar: authorOrScholar,
            bookPageRef: bookPageRef,
            readingTimeSec: readingTimeSec,
            isLiked: isLiked,
            isRead: isRead,
            publishedAt: publishedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$IlmiFeedItemsTable, IlmiFeedItem>(table),
                    BaseReferences<_$AppDatabase, $IlmiFeedItemsTable,
                        IlmiFeedItem>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$IlmiFeedItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $IlmiFeedItemsTable,
    IlmiFeedItem,
    $$IlmiFeedItemsTableFilterComposer,
    $$IlmiFeedItemsTableOrderingComposer,
    $$IlmiFeedItemsTableAnnotationComposer,
    $$IlmiFeedItemsTableCreateCompanionBuilder,
    $$IlmiFeedItemsTableUpdateCompanionBuilder,
    (
      IlmiFeedItem,
      BaseReferences<_$AppDatabase, $IlmiFeedItemsTable, IlmiFeedItem>
    ),
    IlmiFeedItem,
    PrefetchHooks Function()>;
typedef $$CollectionsTableCreateCompanionBuilder = CollectionsCompanion
    Function({
  required String id,
  required String name,
  required String colorHex,
  required int createdAt,
  Value<int> rowid,
});
typedef $$CollectionsTableUpdateCompanionBuilder = CollectionsCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String> colorHex,
  Value<int> createdAt,
  Value<int> rowid,
});

final class $$CollectionsTableReferences
    extends BaseReferences<_$AppDatabase, $CollectionsTable, Collection> {
  $$CollectionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SavedItemsTable, List<SavedItem>>
      _savedItemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.savedItems,
              aliasName: 'collections__id__saved_items__collection_id');

  $$SavedItemsTableProcessedTableManager get savedItemsRefs {
    final manager = $$SavedItemsTableTableManager($_db, $_db.savedItems).filter(
        (f) => f.collectionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_savedItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CollectionsTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionsTable> {
  $$CollectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> savedItemsRefs(
      Expression<bool> Function($$SavedItemsTableFilterComposer f) f) {
    final $$SavedItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.savedItems,
        getReferencedColumn: (t) => t.collectionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedItemsTableFilterComposer(
              $db: $db,
              $table: $db.savedItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CollectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectionsTable> {
  $$CollectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$CollectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectionsTable> {
  $$CollectionsTableAnnotationComposer({
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

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> savedItemsRefs<T extends Object>(
      Expression<T> Function($$SavedItemsTableAnnotationComposer a) f) {
    final $$SavedItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.savedItems,
        getReferencedColumn: (t) => t.collectionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.savedItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CollectionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CollectionsTable,
    Collection,
    $$CollectionsTableFilterComposer,
    $$CollectionsTableOrderingComposer,
    $$CollectionsTableAnnotationComposer,
    $$CollectionsTableCreateCompanionBuilder,
    $$CollectionsTableUpdateCompanionBuilder,
    (Collection, $$CollectionsTableReferences),
    Collection,
    PrefetchHooks Function({bool savedItemsRefs})> {
  $$CollectionsTableTableManager(_$AppDatabase db, $CollectionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CollectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CollectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CollectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> colorHex = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CollectionsCompanion(
            id: id,
            name: name,
            colorHex: colorHex,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String colorHex,
            required int createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CollectionsCompanion.insert(
            id: id,
            name: name,
            colorHex: colorHex,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$CollectionsTable, Collection>(table),
                    $$CollectionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({savedItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (savedItemsRefs) db.savedItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (savedItemsRefs)
                    await $_getPrefetchedDataByColumns<Collection,
                            $CollectionsTable, SavedItem, $SavedItemsTable>(
                        currentTable: table,
                        referencedTable: $$CollectionsTableReferences
                            ._savedItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CollectionsTableReferences(db, table, p0)
                                .savedItemsRefs,
                        currentColumn: 'id',
                        referencedColumn: 'collection_id',
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CollectionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CollectionsTable,
    Collection,
    $$CollectionsTableFilterComposer,
    $$CollectionsTableOrderingComposer,
    $$CollectionsTableAnnotationComposer,
    $$CollectionsTableCreateCompanionBuilder,
    $$CollectionsTableUpdateCompanionBuilder,
    (Collection, $$CollectionsTableReferences),
    Collection,
    PrefetchHooks Function({bool savedItemsRefs})>;
typedef $$SavedItemsTableCreateCompanionBuilder = SavedItemsCompanion Function({
  Value<int> id,
  Value<String?> collectionId,
  required String targetType,
  required String targetId,
  required int savedAt,
});
typedef $$SavedItemsTableUpdateCompanionBuilder = SavedItemsCompanion Function({
  Value<int> id,
  Value<String?> collectionId,
  Value<String> targetType,
  Value<String> targetId,
  Value<int> savedAt,
});

final class $$SavedItemsTableReferences
    extends BaseReferences<_$AppDatabase, $SavedItemsTable, SavedItem> {
  $$SavedItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CollectionsTable _collectionIdTable(_$AppDatabase db) =>
      db.collections.createAlias('saved_items__collection_id__collections__id');

  $$CollectionsTableProcessedTableManager? get collectionId {
    final $_column = $_itemColumn<String>('collection_id');
    if ($_column == null) return null;
    final manager = $$CollectionsTableTableManager($_db, $_db.collections)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SavedItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SavedItemsTable> {
  $$SavedItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get targetType => $composableBuilder(
      column: $table.targetType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get targetId => $composableBuilder(
      column: $table.targetId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get savedAt => $composableBuilder(
      column: $table.savedAt, builder: (column) => ColumnFilters(column));

  $$CollectionsTableFilterComposer get collectionId {
    final $$CollectionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectionId,
        referencedTable: $db.collections,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectionsTableFilterComposer(
              $db: $db,
              $table: $db.collections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SavedItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedItemsTable> {
  $$SavedItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get targetType => $composableBuilder(
      column: $table.targetType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get targetId => $composableBuilder(
      column: $table.targetId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get savedAt => $composableBuilder(
      column: $table.savedAt, builder: (column) => ColumnOrderings(column));

  $$CollectionsTableOrderingComposer get collectionId {
    final $$CollectionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectionId,
        referencedTable: $db.collections,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectionsTableOrderingComposer(
              $db: $db,
              $table: $db.collections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SavedItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedItemsTable> {
  $$SavedItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get targetType => $composableBuilder(
      column: $table.targetType, builder: (column) => column);

  GeneratedColumn<String> get targetId =>
      $composableBuilder(column: $table.targetId, builder: (column) => column);

  GeneratedColumn<int> get savedAt =>
      $composableBuilder(column: $table.savedAt, builder: (column) => column);

  $$CollectionsTableAnnotationComposer get collectionId {
    final $$CollectionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.collectionId,
        referencedTable: $db.collections,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CollectionsTableAnnotationComposer(
              $db: $db,
              $table: $db.collections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SavedItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SavedItemsTable,
    SavedItem,
    $$SavedItemsTableFilterComposer,
    $$SavedItemsTableOrderingComposer,
    $$SavedItemsTableAnnotationComposer,
    $$SavedItemsTableCreateCompanionBuilder,
    $$SavedItemsTableUpdateCompanionBuilder,
    (SavedItem, $$SavedItemsTableReferences),
    SavedItem,
    PrefetchHooks Function({bool collectionId})> {
  $$SavedItemsTableTableManager(_$AppDatabase db, $SavedItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> collectionId = const Value.absent(),
            Value<String> targetType = const Value.absent(),
            Value<String> targetId = const Value.absent(),
            Value<int> savedAt = const Value.absent(),
          }) =>
              SavedItemsCompanion(
            id: id,
            collectionId: collectionId,
            targetType: targetType,
            targetId: targetId,
            savedAt: savedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> collectionId = const Value.absent(),
            required String targetType,
            required String targetId,
            required int savedAt,
          }) =>
              SavedItemsCompanion.insert(
            id: id,
            collectionId: collectionId,
            targetType: targetType,
            targetId: targetId,
            savedAt: savedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$SavedItemsTable, SavedItem>(table),
                    $$SavedItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({collectionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (collectionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.collectionId,
                    referencedTable:
                        $$SavedItemsTableReferences._collectionIdTable(db),
                    referencedColumn:
                        $$SavedItemsTableReferences._collectionIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SavedItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SavedItemsTable,
    SavedItem,
    $$SavedItemsTableFilterComposer,
    $$SavedItemsTableOrderingComposer,
    $$SavedItemsTableAnnotationComposer,
    $$SavedItemsTableCreateCompanionBuilder,
    $$SavedItemsTableUpdateCompanionBuilder,
    (SavedItem, $$SavedItemsTableReferences),
    SavedItem,
    PrefetchHooks Function({bool collectionId})>;
typedef $$ErkamDuaPagesTableCreateCompanionBuilder = ErkamDuaPagesCompanion
    Function({
  Value<int> pageNumber,
  required String chapterTitle,
  Value<String?> subTitle,
  Value<String?> arabicContent,
  Value<String?> transliterationTr,
  required String meaningTr,
  Value<String?> virtueAndSource,
  Value<int?> recommendedCount,
  Value<String?> audioAssetUrl,
  Value<int> isFavorite,
  Value<int?> lastReadAt,
});
typedef $$ErkamDuaPagesTableUpdateCompanionBuilder = ErkamDuaPagesCompanion
    Function({
  Value<int> pageNumber,
  Value<String> chapterTitle,
  Value<String?> subTitle,
  Value<String?> arabicContent,
  Value<String?> transliterationTr,
  Value<String> meaningTr,
  Value<String?> virtueAndSource,
  Value<int?> recommendedCount,
  Value<String?> audioAssetUrl,
  Value<int> isFavorite,
  Value<int?> lastReadAt,
});

final class $$ErkamDuaPagesTableReferences
    extends BaseReferences<_$AppDatabase, $ErkamDuaPagesTable, ErkamDuaPage> {
  $$ErkamDuaPagesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DhikrItemsTable, List<DhikrItem>>
      _dhikrItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.dhikrItems,
          aliasName:
              'erkam_dua_pages__page_number__dhikr_items__linked_erkam_page');

  $$DhikrItemsTableProcessedTableManager get dhikrItemsRefs {
    final manager = $$DhikrItemsTableTableManager($_db, $_db.dhikrItems).filter(
        (f) => f.linkedErkamPage.pageNumber
            .sqlEquals($_itemColumn<int>('page_number')!));

    final cache = $_typedResult.readTableOrNull(_dhikrItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ErkamDuaPagesTableFilterComposer
    extends Composer<_$AppDatabase, $ErkamDuaPagesTable> {
  $$ErkamDuaPagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get pageNumber => $composableBuilder(
      column: $table.pageNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get chapterTitle => $composableBuilder(
      column: $table.chapterTitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subTitle => $composableBuilder(
      column: $table.subTitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get arabicContent => $composableBuilder(
      column: $table.arabicContent, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transliterationTr => $composableBuilder(
      column: $table.transliterationTr,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get meaningTr => $composableBuilder(
      column: $table.meaningTr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get virtueAndSource => $composableBuilder(
      column: $table.virtueAndSource,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get recommendedCount => $composableBuilder(
      column: $table.recommendedCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get audioAssetUrl => $composableBuilder(
      column: $table.audioAssetUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastReadAt => $composableBuilder(
      column: $table.lastReadAt, builder: (column) => ColumnFilters(column));

  Expression<bool> dhikrItemsRefs(
      Expression<bool> Function($$DhikrItemsTableFilterComposer f) f) {
    final $$DhikrItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pageNumber,
        referencedTable: $db.dhikrItems,
        getReferencedColumn: (t) => t.linkedErkamPage,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DhikrItemsTableFilterComposer(
              $db: $db,
              $table: $db.dhikrItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ErkamDuaPagesTableOrderingComposer
    extends Composer<_$AppDatabase, $ErkamDuaPagesTable> {
  $$ErkamDuaPagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get pageNumber => $composableBuilder(
      column: $table.pageNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get chapterTitle => $composableBuilder(
      column: $table.chapterTitle,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subTitle => $composableBuilder(
      column: $table.subTitle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get arabicContent => $composableBuilder(
      column: $table.arabicContent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transliterationTr => $composableBuilder(
      column: $table.transliterationTr,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get meaningTr => $composableBuilder(
      column: $table.meaningTr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get virtueAndSource => $composableBuilder(
      column: $table.virtueAndSource,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get recommendedCount => $composableBuilder(
      column: $table.recommendedCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get audioAssetUrl => $composableBuilder(
      column: $table.audioAssetUrl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastReadAt => $composableBuilder(
      column: $table.lastReadAt, builder: (column) => ColumnOrderings(column));
}

class $$ErkamDuaPagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ErkamDuaPagesTable> {
  $$ErkamDuaPagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get pageNumber => $composableBuilder(
      column: $table.pageNumber, builder: (column) => column);

  GeneratedColumn<String> get chapterTitle => $composableBuilder(
      column: $table.chapterTitle, builder: (column) => column);

  GeneratedColumn<String> get subTitle =>
      $composableBuilder(column: $table.subTitle, builder: (column) => column);

  GeneratedColumn<String> get arabicContent => $composableBuilder(
      column: $table.arabicContent, builder: (column) => column);

  GeneratedColumn<String> get transliterationTr => $composableBuilder(
      column: $table.transliterationTr, builder: (column) => column);

  GeneratedColumn<String> get meaningTr =>
      $composableBuilder(column: $table.meaningTr, builder: (column) => column);

  GeneratedColumn<String> get virtueAndSource => $composableBuilder(
      column: $table.virtueAndSource, builder: (column) => column);

  GeneratedColumn<int> get recommendedCount => $composableBuilder(
      column: $table.recommendedCount, builder: (column) => column);

  GeneratedColumn<String> get audioAssetUrl => $composableBuilder(
      column: $table.audioAssetUrl, builder: (column) => column);

  GeneratedColumn<int> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);

  GeneratedColumn<int> get lastReadAt => $composableBuilder(
      column: $table.lastReadAt, builder: (column) => column);

  Expression<T> dhikrItemsRefs<T extends Object>(
      Expression<T> Function($$DhikrItemsTableAnnotationComposer a) f) {
    final $$DhikrItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pageNumber,
        referencedTable: $db.dhikrItems,
        getReferencedColumn: (t) => t.linkedErkamPage,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DhikrItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.dhikrItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ErkamDuaPagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ErkamDuaPagesTable,
    ErkamDuaPage,
    $$ErkamDuaPagesTableFilterComposer,
    $$ErkamDuaPagesTableOrderingComposer,
    $$ErkamDuaPagesTableAnnotationComposer,
    $$ErkamDuaPagesTableCreateCompanionBuilder,
    $$ErkamDuaPagesTableUpdateCompanionBuilder,
    (ErkamDuaPage, $$ErkamDuaPagesTableReferences),
    ErkamDuaPage,
    PrefetchHooks Function({bool dhikrItemsRefs})> {
  $$ErkamDuaPagesTableTableManager(_$AppDatabase db, $ErkamDuaPagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ErkamDuaPagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ErkamDuaPagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ErkamDuaPagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> pageNumber = const Value.absent(),
            Value<String> chapterTitle = const Value.absent(),
            Value<String?> subTitle = const Value.absent(),
            Value<String?> arabicContent = const Value.absent(),
            Value<String?> transliterationTr = const Value.absent(),
            Value<String> meaningTr = const Value.absent(),
            Value<String?> virtueAndSource = const Value.absent(),
            Value<int?> recommendedCount = const Value.absent(),
            Value<String?> audioAssetUrl = const Value.absent(),
            Value<int> isFavorite = const Value.absent(),
            Value<int?> lastReadAt = const Value.absent(),
          }) =>
              ErkamDuaPagesCompanion(
            pageNumber: pageNumber,
            chapterTitle: chapterTitle,
            subTitle: subTitle,
            arabicContent: arabicContent,
            transliterationTr: transliterationTr,
            meaningTr: meaningTr,
            virtueAndSource: virtueAndSource,
            recommendedCount: recommendedCount,
            audioAssetUrl: audioAssetUrl,
            isFavorite: isFavorite,
            lastReadAt: lastReadAt,
          ),
          createCompanionCallback: ({
            Value<int> pageNumber = const Value.absent(),
            required String chapterTitle,
            Value<String?> subTitle = const Value.absent(),
            Value<String?> arabicContent = const Value.absent(),
            Value<String?> transliterationTr = const Value.absent(),
            required String meaningTr,
            Value<String?> virtueAndSource = const Value.absent(),
            Value<int?> recommendedCount = const Value.absent(),
            Value<String?> audioAssetUrl = const Value.absent(),
            Value<int> isFavorite = const Value.absent(),
            Value<int?> lastReadAt = const Value.absent(),
          }) =>
              ErkamDuaPagesCompanion.insert(
            pageNumber: pageNumber,
            chapterTitle: chapterTitle,
            subTitle: subTitle,
            arabicContent: arabicContent,
            transliterationTr: transliterationTr,
            meaningTr: meaningTr,
            virtueAndSource: virtueAndSource,
            recommendedCount: recommendedCount,
            audioAssetUrl: audioAssetUrl,
            isFavorite: isFavorite,
            lastReadAt: lastReadAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$ErkamDuaPagesTable, ErkamDuaPage>(table),
                    $$ErkamDuaPagesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({dhikrItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (dhikrItemsRefs) db.dhikrItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (dhikrItemsRefs)
                    await $_getPrefetchedDataByColumns<ErkamDuaPage,
                            $ErkamDuaPagesTable, DhikrItem, $DhikrItemsTable>(
                        currentTable: table,
                        referencedTable: $$ErkamDuaPagesTableReferences
                            ._dhikrItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ErkamDuaPagesTableReferences(db, table, p0)
                                .dhikrItemsRefs,
                        currentColumn: 'page_number',
                        referencedColumn: 'linked_erkam_page',
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ErkamDuaPagesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ErkamDuaPagesTable,
    ErkamDuaPage,
    $$ErkamDuaPagesTableFilterComposer,
    $$ErkamDuaPagesTableOrderingComposer,
    $$ErkamDuaPagesTableAnnotationComposer,
    $$ErkamDuaPagesTableCreateCompanionBuilder,
    $$ErkamDuaPagesTableUpdateCompanionBuilder,
    (ErkamDuaPage, $$ErkamDuaPagesTableReferences),
    ErkamDuaPage,
    PrefetchHooks Function({bool dhikrItemsRefs})>;
typedef $$QuranSurahsTableCreateCompanionBuilder = QuranSurahsCompanion
    Function({
  Value<int> surahNumber,
  required String nameArabic,
  required String nameTr,
  required String meaningTr,
  required int ayahCount,
  required String revelationPlace,
  required int startPage,
  Value<int> isDownloadedOffline,
  Value<String?> downloadedReciterId,
  Value<int> localStorageBytes,
});
typedef $$QuranSurahsTableUpdateCompanionBuilder = QuranSurahsCompanion
    Function({
  Value<int> surahNumber,
  Value<String> nameArabic,
  Value<String> nameTr,
  Value<String> meaningTr,
  Value<int> ayahCount,
  Value<String> revelationPlace,
  Value<int> startPage,
  Value<int> isDownloadedOffline,
  Value<String?> downloadedReciterId,
  Value<int> localStorageBytes,
});

final class $$QuranSurahsTableReferences
    extends BaseReferences<_$AppDatabase, $QuranSurahsTable, QuranSurah> {
  $$QuranSurahsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$QuranAyahsTable, List<QuranAyah>>
      _quranAyahsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.quranAyahs,
          aliasName: 'quran_surahs__surah_number__quran_ayahs__surah_number');

  $$QuranAyahsTableProcessedTableManager get quranAyahsRefs {
    final manager = $$QuranAyahsTableTableManager($_db, $_db.quranAyahs).filter(
        (f) => f.surahNumber.surahNumber
            .sqlEquals($_itemColumn<int>('surah_number')!));

    final cache = $_typedResult.readTableOrNull(_quranAyahsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$QuranSurahsTableFilterComposer
    extends Composer<_$AppDatabase, $QuranSurahsTable> {
  $$QuranSurahsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameArabic => $composableBuilder(
      column: $table.nameArabic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameTr => $composableBuilder(
      column: $table.nameTr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get meaningTr => $composableBuilder(
      column: $table.meaningTr, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ayahCount => $composableBuilder(
      column: $table.ayahCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get revelationPlace => $composableBuilder(
      column: $table.revelationPlace,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startPage => $composableBuilder(
      column: $table.startPage, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isDownloadedOffline => $composableBuilder(
      column: $table.isDownloadedOffline,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get downloadedReciterId => $composableBuilder(
      column: $table.downloadedReciterId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get localStorageBytes => $composableBuilder(
      column: $table.localStorageBytes,
      builder: (column) => ColumnFilters(column));

  Expression<bool> quranAyahsRefs(
      Expression<bool> Function($$QuranAyahsTableFilterComposer f) f) {
    final $$QuranAyahsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.surahNumber,
        referencedTable: $db.quranAyahs,
        getReferencedColumn: (t) => t.surahNumber,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuranAyahsTableFilterComposer(
              $db: $db,
              $table: $db.quranAyahs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$QuranSurahsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuranSurahsTable> {
  $$QuranSurahsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameArabic => $composableBuilder(
      column: $table.nameArabic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameTr => $composableBuilder(
      column: $table.nameTr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get meaningTr => $composableBuilder(
      column: $table.meaningTr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ayahCount => $composableBuilder(
      column: $table.ayahCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get revelationPlace => $composableBuilder(
      column: $table.revelationPlace,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startPage => $composableBuilder(
      column: $table.startPage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isDownloadedOffline => $composableBuilder(
      column: $table.isDownloadedOffline,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get downloadedReciterId => $composableBuilder(
      column: $table.downloadedReciterId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get localStorageBytes => $composableBuilder(
      column: $table.localStorageBytes,
      builder: (column) => ColumnOrderings(column));
}

class $$QuranSurahsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuranSurahsTable> {
  $$QuranSurahsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get surahNumber => $composableBuilder(
      column: $table.surahNumber, builder: (column) => column);

  GeneratedColumn<String> get nameArabic => $composableBuilder(
      column: $table.nameArabic, builder: (column) => column);

  GeneratedColumn<String> get nameTr =>
      $composableBuilder(column: $table.nameTr, builder: (column) => column);

  GeneratedColumn<String> get meaningTr =>
      $composableBuilder(column: $table.meaningTr, builder: (column) => column);

  GeneratedColumn<int> get ayahCount =>
      $composableBuilder(column: $table.ayahCount, builder: (column) => column);

  GeneratedColumn<String> get revelationPlace => $composableBuilder(
      column: $table.revelationPlace, builder: (column) => column);

  GeneratedColumn<int> get startPage =>
      $composableBuilder(column: $table.startPage, builder: (column) => column);

  GeneratedColumn<int> get isDownloadedOffline => $composableBuilder(
      column: $table.isDownloadedOffline, builder: (column) => column);

  GeneratedColumn<String> get downloadedReciterId => $composableBuilder(
      column: $table.downloadedReciterId, builder: (column) => column);

  GeneratedColumn<int> get localStorageBytes => $composableBuilder(
      column: $table.localStorageBytes, builder: (column) => column);

  Expression<T> quranAyahsRefs<T extends Object>(
      Expression<T> Function($$QuranAyahsTableAnnotationComposer a) f) {
    final $$QuranAyahsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.surahNumber,
        referencedTable: $db.quranAyahs,
        getReferencedColumn: (t) => t.surahNumber,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuranAyahsTableAnnotationComposer(
              $db: $db,
              $table: $db.quranAyahs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$QuranSurahsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuranSurahsTable,
    QuranSurah,
    $$QuranSurahsTableFilterComposer,
    $$QuranSurahsTableOrderingComposer,
    $$QuranSurahsTableAnnotationComposer,
    $$QuranSurahsTableCreateCompanionBuilder,
    $$QuranSurahsTableUpdateCompanionBuilder,
    (QuranSurah, $$QuranSurahsTableReferences),
    QuranSurah,
    PrefetchHooks Function({bool quranAyahsRefs})> {
  $$QuranSurahsTableTableManager(_$AppDatabase db, $QuranSurahsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuranSurahsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuranSurahsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuranSurahsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> surahNumber = const Value.absent(),
            Value<String> nameArabic = const Value.absent(),
            Value<String> nameTr = const Value.absent(),
            Value<String> meaningTr = const Value.absent(),
            Value<int> ayahCount = const Value.absent(),
            Value<String> revelationPlace = const Value.absent(),
            Value<int> startPage = const Value.absent(),
            Value<int> isDownloadedOffline = const Value.absent(),
            Value<String?> downloadedReciterId = const Value.absent(),
            Value<int> localStorageBytes = const Value.absent(),
          }) =>
              QuranSurahsCompanion(
            surahNumber: surahNumber,
            nameArabic: nameArabic,
            nameTr: nameTr,
            meaningTr: meaningTr,
            ayahCount: ayahCount,
            revelationPlace: revelationPlace,
            startPage: startPage,
            isDownloadedOffline: isDownloadedOffline,
            downloadedReciterId: downloadedReciterId,
            localStorageBytes: localStorageBytes,
          ),
          createCompanionCallback: ({
            Value<int> surahNumber = const Value.absent(),
            required String nameArabic,
            required String nameTr,
            required String meaningTr,
            required int ayahCount,
            required String revelationPlace,
            required int startPage,
            Value<int> isDownloadedOffline = const Value.absent(),
            Value<String?> downloadedReciterId = const Value.absent(),
            Value<int> localStorageBytes = const Value.absent(),
          }) =>
              QuranSurahsCompanion.insert(
            surahNumber: surahNumber,
            nameArabic: nameArabic,
            nameTr: nameTr,
            meaningTr: meaningTr,
            ayahCount: ayahCount,
            revelationPlace: revelationPlace,
            startPage: startPage,
            isDownloadedOffline: isDownloadedOffline,
            downloadedReciterId: downloadedReciterId,
            localStorageBytes: localStorageBytes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$QuranSurahsTable, QuranSurah>(table),
                    $$QuranSurahsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({quranAyahsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (quranAyahsRefs) db.quranAyahs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (quranAyahsRefs)
                    await $_getPrefetchedDataByColumns<QuranSurah,
                            $QuranSurahsTable, QuranAyah, $QuranAyahsTable>(
                        currentTable: table,
                        referencedTable: $$QuranSurahsTableReferences
                            ._quranAyahsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$QuranSurahsTableReferences(db, table, p0)
                                .quranAyahsRefs,
                        currentColumn: 'surah_number',
                        referencedColumn: 'surah_number',
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$QuranSurahsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuranSurahsTable,
    QuranSurah,
    $$QuranSurahsTableFilterComposer,
    $$QuranSurahsTableOrderingComposer,
    $$QuranSurahsTableAnnotationComposer,
    $$QuranSurahsTableCreateCompanionBuilder,
    $$QuranSurahsTableUpdateCompanionBuilder,
    (QuranSurah, $$QuranSurahsTableReferences),
    QuranSurah,
    PrefetchHooks Function({bool quranAyahsRefs})>;
typedef $$QuranAyahsTableCreateCompanionBuilder = QuranAyahsCompanion Function({
  Value<int> id,
  required int surahNumber,
  required int ayahNumber,
  required int mushafPage,
  required int juzNumber,
  required String uthmaniText,
  required String translationTr,
  Value<String?> shortTafsirTr,
  Value<int> isSajdah,
});
typedef $$QuranAyahsTableUpdateCompanionBuilder = QuranAyahsCompanion Function({
  Value<int> id,
  Value<int> surahNumber,
  Value<int> ayahNumber,
  Value<int> mushafPage,
  Value<int> juzNumber,
  Value<String> uthmaniText,
  Value<String> translationTr,
  Value<String?> shortTafsirTr,
  Value<int> isSajdah,
});

final class $$QuranAyahsTableReferences
    extends BaseReferences<_$AppDatabase, $QuranAyahsTable, QuranAyah> {
  $$QuranAyahsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $QuranSurahsTable _surahNumberTable(_$AppDatabase db) => db.quranSurahs
      .createAlias('quran_ayahs__surah_number__quran_surahs__surah_number');

  $$QuranSurahsTableProcessedTableManager get surahNumber {
    final $_column = $_itemColumn<int>('surah_number')!;

    final manager = $$QuranSurahsTableTableManager($_db, $_db.quranSurahs)
        .filter((f) => f.surahNumber.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_surahNumberTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$QuranAyahsTableFilterComposer
    extends Composer<_$AppDatabase, $QuranAyahsTable> {
  $$QuranAyahsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ayahNumber => $composableBuilder(
      column: $table.ayahNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mushafPage => $composableBuilder(
      column: $table.mushafPage, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get juzNumber => $composableBuilder(
      column: $table.juzNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uthmaniText => $composableBuilder(
      column: $table.uthmaniText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get translationTr => $composableBuilder(
      column: $table.translationTr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shortTafsirTr => $composableBuilder(
      column: $table.shortTafsirTr, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isSajdah => $composableBuilder(
      column: $table.isSajdah, builder: (column) => ColumnFilters(column));

  $$QuranSurahsTableFilterComposer get surahNumber {
    final $$QuranSurahsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.surahNumber,
        referencedTable: $db.quranSurahs,
        getReferencedColumn: (t) => t.surahNumber,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuranSurahsTableFilterComposer(
              $db: $db,
              $table: $db.quranSurahs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuranAyahsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuranAyahsTable> {
  $$QuranAyahsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
      column: $table.ayahNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mushafPage => $composableBuilder(
      column: $table.mushafPage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get juzNumber => $composableBuilder(
      column: $table.juzNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uthmaniText => $composableBuilder(
      column: $table.uthmaniText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get translationTr => $composableBuilder(
      column: $table.translationTr,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shortTafsirTr => $composableBuilder(
      column: $table.shortTafsirTr,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isSajdah => $composableBuilder(
      column: $table.isSajdah, builder: (column) => ColumnOrderings(column));

  $$QuranSurahsTableOrderingComposer get surahNumber {
    final $$QuranSurahsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.surahNumber,
        referencedTable: $db.quranSurahs,
        getReferencedColumn: (t) => t.surahNumber,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuranSurahsTableOrderingComposer(
              $db: $db,
              $table: $db.quranSurahs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuranAyahsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuranAyahsTable> {
  $$QuranAyahsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
      column: $table.ayahNumber, builder: (column) => column);

  GeneratedColumn<int> get mushafPage => $composableBuilder(
      column: $table.mushafPage, builder: (column) => column);

  GeneratedColumn<int> get juzNumber =>
      $composableBuilder(column: $table.juzNumber, builder: (column) => column);

  GeneratedColumn<String> get uthmaniText => $composableBuilder(
      column: $table.uthmaniText, builder: (column) => column);

  GeneratedColumn<String> get translationTr => $composableBuilder(
      column: $table.translationTr, builder: (column) => column);

  GeneratedColumn<String> get shortTafsirTr => $composableBuilder(
      column: $table.shortTafsirTr, builder: (column) => column);

  GeneratedColumn<int> get isSajdah =>
      $composableBuilder(column: $table.isSajdah, builder: (column) => column);

  $$QuranSurahsTableAnnotationComposer get surahNumber {
    final $$QuranSurahsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.surahNumber,
        referencedTable: $db.quranSurahs,
        getReferencedColumn: (t) => t.surahNumber,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuranSurahsTableAnnotationComposer(
              $db: $db,
              $table: $db.quranSurahs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuranAyahsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuranAyahsTable,
    QuranAyah,
    $$QuranAyahsTableFilterComposer,
    $$QuranAyahsTableOrderingComposer,
    $$QuranAyahsTableAnnotationComposer,
    $$QuranAyahsTableCreateCompanionBuilder,
    $$QuranAyahsTableUpdateCompanionBuilder,
    (QuranAyah, $$QuranAyahsTableReferences),
    QuranAyah,
    PrefetchHooks Function({bool surahNumber})> {
  $$QuranAyahsTableTableManager(_$AppDatabase db, $QuranAyahsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuranAyahsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuranAyahsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuranAyahsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> surahNumber = const Value.absent(),
            Value<int> ayahNumber = const Value.absent(),
            Value<int> mushafPage = const Value.absent(),
            Value<int> juzNumber = const Value.absent(),
            Value<String> uthmaniText = const Value.absent(),
            Value<String> translationTr = const Value.absent(),
            Value<String?> shortTafsirTr = const Value.absent(),
            Value<int> isSajdah = const Value.absent(),
          }) =>
              QuranAyahsCompanion(
            id: id,
            surahNumber: surahNumber,
            ayahNumber: ayahNumber,
            mushafPage: mushafPage,
            juzNumber: juzNumber,
            uthmaniText: uthmaniText,
            translationTr: translationTr,
            shortTafsirTr: shortTafsirTr,
            isSajdah: isSajdah,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int surahNumber,
            required int ayahNumber,
            required int mushafPage,
            required int juzNumber,
            required String uthmaniText,
            required String translationTr,
            Value<String?> shortTafsirTr = const Value.absent(),
            Value<int> isSajdah = const Value.absent(),
          }) =>
              QuranAyahsCompanion.insert(
            id: id,
            surahNumber: surahNumber,
            ayahNumber: ayahNumber,
            mushafPage: mushafPage,
            juzNumber: juzNumber,
            uthmaniText: uthmaniText,
            translationTr: translationTr,
            shortTafsirTr: shortTafsirTr,
            isSajdah: isSajdah,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$QuranAyahsTable, QuranAyah>(table),
                    $$QuranAyahsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({surahNumber = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (surahNumber) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.surahNumber,
                    referencedTable:
                        $$QuranAyahsTableReferences._surahNumberTable(db),
                    referencedColumn: $$QuranAyahsTableReferences
                        ._surahNumberTable(db)
                        .surahNumber,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$QuranAyahsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuranAyahsTable,
    QuranAyah,
    $$QuranAyahsTableFilterComposer,
    $$QuranAyahsTableOrderingComposer,
    $$QuranAyahsTableAnnotationComposer,
    $$QuranAyahsTableCreateCompanionBuilder,
    $$QuranAyahsTableUpdateCompanionBuilder,
    (QuranAyah, $$QuranAyahsTableReferences),
    QuranAyah,
    PrefetchHooks Function({bool surahNumber})>;
typedef $$DhikrItemsTableCreateCompanionBuilder = DhikrItemsCompanion Function({
  required String id,
  required String title,
  Value<String?> arabicText,
  Value<String?> transliteration,
  Value<String?> meaningTr,
  Value<int> targetCount,
  Value<int> currentCount,
  Value<int> totalLifetimeCount,
  Value<int?> linkedErkamPage,
  Value<int> sortOrder,
  Value<int> rowid,
});
typedef $$DhikrItemsTableUpdateCompanionBuilder = DhikrItemsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String?> arabicText,
  Value<String?> transliteration,
  Value<String?> meaningTr,
  Value<int> targetCount,
  Value<int> currentCount,
  Value<int> totalLifetimeCount,
  Value<int?> linkedErkamPage,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$DhikrItemsTableReferences
    extends BaseReferences<_$AppDatabase, $DhikrItemsTable, DhikrItem> {
  $$DhikrItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ErkamDuaPagesTable _linkedErkamPageTable(_$AppDatabase db) =>
      db.erkamDuaPages.createAlias(
          'dhikr_items__linked_erkam_page__erkam_dua_pages__page_number');

  $$ErkamDuaPagesTableProcessedTableManager? get linkedErkamPage {
    final $_column = $_itemColumn<int>('linked_erkam_page');
    if ($_column == null) return null;
    final manager = $$ErkamDuaPagesTableTableManager($_db, $_db.erkamDuaPages)
        .filter((f) => f.pageNumber.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_linkedErkamPageTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DhikrItemsTableFilterComposer
    extends Composer<_$AppDatabase, $DhikrItemsTable> {
  $$DhikrItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get arabicText => $composableBuilder(
      column: $table.arabicText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transliteration => $composableBuilder(
      column: $table.transliteration,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get meaningTr => $composableBuilder(
      column: $table.meaningTr, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetCount => $composableBuilder(
      column: $table.targetCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentCount => $composableBuilder(
      column: $table.currentCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalLifetimeCount => $composableBuilder(
      column: $table.totalLifetimeCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  $$ErkamDuaPagesTableFilterComposer get linkedErkamPage {
    final $$ErkamDuaPagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.linkedErkamPage,
        referencedTable: $db.erkamDuaPages,
        getReferencedColumn: (t) => t.pageNumber,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ErkamDuaPagesTableFilterComposer(
              $db: $db,
              $table: $db.erkamDuaPages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DhikrItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $DhikrItemsTable> {
  $$DhikrItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get arabicText => $composableBuilder(
      column: $table.arabicText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transliteration => $composableBuilder(
      column: $table.transliteration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get meaningTr => $composableBuilder(
      column: $table.meaningTr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetCount => $composableBuilder(
      column: $table.targetCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentCount => $composableBuilder(
      column: $table.currentCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalLifetimeCount => $composableBuilder(
      column: $table.totalLifetimeCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  $$ErkamDuaPagesTableOrderingComposer get linkedErkamPage {
    final $$ErkamDuaPagesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.linkedErkamPage,
        referencedTable: $db.erkamDuaPages,
        getReferencedColumn: (t) => t.pageNumber,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ErkamDuaPagesTableOrderingComposer(
              $db: $db,
              $table: $db.erkamDuaPages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DhikrItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DhikrItemsTable> {
  $$DhikrItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get arabicText => $composableBuilder(
      column: $table.arabicText, builder: (column) => column);

  GeneratedColumn<String> get transliteration => $composableBuilder(
      column: $table.transliteration, builder: (column) => column);

  GeneratedColumn<String> get meaningTr =>
      $composableBuilder(column: $table.meaningTr, builder: (column) => column);

  GeneratedColumn<int> get targetCount => $composableBuilder(
      column: $table.targetCount, builder: (column) => column);

  GeneratedColumn<int> get currentCount => $composableBuilder(
      column: $table.currentCount, builder: (column) => column);

  GeneratedColumn<int> get totalLifetimeCount => $composableBuilder(
      column: $table.totalLifetimeCount, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$ErkamDuaPagesTableAnnotationComposer get linkedErkamPage {
    final $$ErkamDuaPagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.linkedErkamPage,
        referencedTable: $db.erkamDuaPages,
        getReferencedColumn: (t) => t.pageNumber,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ErkamDuaPagesTableAnnotationComposer(
              $db: $db,
              $table: $db.erkamDuaPages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DhikrItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DhikrItemsTable,
    DhikrItem,
    $$DhikrItemsTableFilterComposer,
    $$DhikrItemsTableOrderingComposer,
    $$DhikrItemsTableAnnotationComposer,
    $$DhikrItemsTableCreateCompanionBuilder,
    $$DhikrItemsTableUpdateCompanionBuilder,
    (DhikrItem, $$DhikrItemsTableReferences),
    DhikrItem,
    PrefetchHooks Function({bool linkedErkamPage})> {
  $$DhikrItemsTableTableManager(_$AppDatabase db, $DhikrItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DhikrItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DhikrItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DhikrItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> arabicText = const Value.absent(),
            Value<String?> transliteration = const Value.absent(),
            Value<String?> meaningTr = const Value.absent(),
            Value<int> targetCount = const Value.absent(),
            Value<int> currentCount = const Value.absent(),
            Value<int> totalLifetimeCount = const Value.absent(),
            Value<int?> linkedErkamPage = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DhikrItemsCompanion(
            id: id,
            title: title,
            arabicText: arabicText,
            transliteration: transliteration,
            meaningTr: meaningTr,
            targetCount: targetCount,
            currentCount: currentCount,
            totalLifetimeCount: totalLifetimeCount,
            linkedErkamPage: linkedErkamPage,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> arabicText = const Value.absent(),
            Value<String?> transliteration = const Value.absent(),
            Value<String?> meaningTr = const Value.absent(),
            Value<int> targetCount = const Value.absent(),
            Value<int> currentCount = const Value.absent(),
            Value<int> totalLifetimeCount = const Value.absent(),
            Value<int?> linkedErkamPage = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DhikrItemsCompanion.insert(
            id: id,
            title: title,
            arabicText: arabicText,
            transliteration: transliteration,
            meaningTr: meaningTr,
            targetCount: targetCount,
            currentCount: currentCount,
            totalLifetimeCount: totalLifetimeCount,
            linkedErkamPage: linkedErkamPage,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$DhikrItemsTable, DhikrItem>(table),
                    $$DhikrItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({linkedErkamPage = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (linkedErkamPage) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.linkedErkamPage,
                    referencedTable:
                        $$DhikrItemsTableReferences._linkedErkamPageTable(db),
                    referencedColumn: $$DhikrItemsTableReferences
                        ._linkedErkamPageTable(db)
                        .pageNumber,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DhikrItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DhikrItemsTable,
    DhikrItem,
    $$DhikrItemsTableFilterComposer,
    $$DhikrItemsTableOrderingComposer,
    $$DhikrItemsTableAnnotationComposer,
    $$DhikrItemsTableCreateCompanionBuilder,
    $$DhikrItemsTableUpdateCompanionBuilder,
    (DhikrItem, $$DhikrItemsTableReferences),
    DhikrItem,
    PrefetchHooks Function({bool linkedErkamPage})>;
typedef $$SmartAlarmsTableCreateCompanionBuilder = SmartAlarmsCompanion
    Function({
  required String id,
  required String title,
  required String alarmType,
  Value<int?> fixedTimestamp,
  Value<String?> anchorPrayer,
  Value<int?> offsetMinutes,
  Value<String?> hijriDaysCsv,
  Value<String?> weekdaysCsv,
  Value<String?> linkedRoute,
  required String soundId,
  Value<int> isEnabled,
  Value<int> rowid,
});
typedef $$SmartAlarmsTableUpdateCompanionBuilder = SmartAlarmsCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<String> alarmType,
  Value<int?> fixedTimestamp,
  Value<String?> anchorPrayer,
  Value<int?> offsetMinutes,
  Value<String?> hijriDaysCsv,
  Value<String?> weekdaysCsv,
  Value<String?> linkedRoute,
  Value<String> soundId,
  Value<int> isEnabled,
  Value<int> rowid,
});

class $$SmartAlarmsTableFilterComposer
    extends Composer<_$AppDatabase, $SmartAlarmsTable> {
  $$SmartAlarmsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get alarmType => $composableBuilder(
      column: $table.alarmType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fixedTimestamp => $composableBuilder(
      column: $table.fixedTimestamp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get anchorPrayer => $composableBuilder(
      column: $table.anchorPrayer, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get offsetMinutes => $composableBuilder(
      column: $table.offsetMinutes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get hijriDaysCsv => $composableBuilder(
      column: $table.hijriDaysCsv, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get weekdaysCsv => $composableBuilder(
      column: $table.weekdaysCsv, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get linkedRoute => $composableBuilder(
      column: $table.linkedRoute, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get soundId => $composableBuilder(
      column: $table.soundId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnFilters(column));
}

class $$SmartAlarmsTableOrderingComposer
    extends Composer<_$AppDatabase, $SmartAlarmsTable> {
  $$SmartAlarmsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get alarmType => $composableBuilder(
      column: $table.alarmType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fixedTimestamp => $composableBuilder(
      column: $table.fixedTimestamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get anchorPrayer => $composableBuilder(
      column: $table.anchorPrayer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get offsetMinutes => $composableBuilder(
      column: $table.offsetMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get hijriDaysCsv => $composableBuilder(
      column: $table.hijriDaysCsv,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get weekdaysCsv => $composableBuilder(
      column: $table.weekdaysCsv, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get linkedRoute => $composableBuilder(
      column: $table.linkedRoute, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get soundId => $composableBuilder(
      column: $table.soundId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnOrderings(column));
}

class $$SmartAlarmsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SmartAlarmsTable> {
  $$SmartAlarmsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get alarmType =>
      $composableBuilder(column: $table.alarmType, builder: (column) => column);

  GeneratedColumn<int> get fixedTimestamp => $composableBuilder(
      column: $table.fixedTimestamp, builder: (column) => column);

  GeneratedColumn<String> get anchorPrayer => $composableBuilder(
      column: $table.anchorPrayer, builder: (column) => column);

  GeneratedColumn<int> get offsetMinutes => $composableBuilder(
      column: $table.offsetMinutes, builder: (column) => column);

  GeneratedColumn<String> get hijriDaysCsv => $composableBuilder(
      column: $table.hijriDaysCsv, builder: (column) => column);

  GeneratedColumn<String> get weekdaysCsv => $composableBuilder(
      column: $table.weekdaysCsv, builder: (column) => column);

  GeneratedColumn<String> get linkedRoute => $composableBuilder(
      column: $table.linkedRoute, builder: (column) => column);

  GeneratedColumn<String> get soundId =>
      $composableBuilder(column: $table.soundId, builder: (column) => column);

  GeneratedColumn<int> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);
}

class $$SmartAlarmsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SmartAlarmsTable,
    SmartAlarm,
    $$SmartAlarmsTableFilterComposer,
    $$SmartAlarmsTableOrderingComposer,
    $$SmartAlarmsTableAnnotationComposer,
    $$SmartAlarmsTableCreateCompanionBuilder,
    $$SmartAlarmsTableUpdateCompanionBuilder,
    (SmartAlarm, BaseReferences<_$AppDatabase, $SmartAlarmsTable, SmartAlarm>),
    SmartAlarm,
    PrefetchHooks Function()> {
  $$SmartAlarmsTableTableManager(_$AppDatabase db, $SmartAlarmsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SmartAlarmsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SmartAlarmsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SmartAlarmsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> alarmType = const Value.absent(),
            Value<int?> fixedTimestamp = const Value.absent(),
            Value<String?> anchorPrayer = const Value.absent(),
            Value<int?> offsetMinutes = const Value.absent(),
            Value<String?> hijriDaysCsv = const Value.absent(),
            Value<String?> weekdaysCsv = const Value.absent(),
            Value<String?> linkedRoute = const Value.absent(),
            Value<String> soundId = const Value.absent(),
            Value<int> isEnabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SmartAlarmsCompanion(
            id: id,
            title: title,
            alarmType: alarmType,
            fixedTimestamp: fixedTimestamp,
            anchorPrayer: anchorPrayer,
            offsetMinutes: offsetMinutes,
            hijriDaysCsv: hijriDaysCsv,
            weekdaysCsv: weekdaysCsv,
            linkedRoute: linkedRoute,
            soundId: soundId,
            isEnabled: isEnabled,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String alarmType,
            Value<int?> fixedTimestamp = const Value.absent(),
            Value<String?> anchorPrayer = const Value.absent(),
            Value<int?> offsetMinutes = const Value.absent(),
            Value<String?> hijriDaysCsv = const Value.absent(),
            Value<String?> weekdaysCsv = const Value.absent(),
            Value<String?> linkedRoute = const Value.absent(),
            required String soundId,
            Value<int> isEnabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SmartAlarmsCompanion.insert(
            id: id,
            title: title,
            alarmType: alarmType,
            fixedTimestamp: fixedTimestamp,
            anchorPrayer: anchorPrayer,
            offsetMinutes: offsetMinutes,
            hijriDaysCsv: hijriDaysCsv,
            weekdaysCsv: weekdaysCsv,
            linkedRoute: linkedRoute,
            soundId: soundId,
            isEnabled: isEnabled,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$SmartAlarmsTable, SmartAlarm>(table),
                    BaseReferences<_$AppDatabase, $SmartAlarmsTable,
                        SmartAlarm>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SmartAlarmsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SmartAlarmsTable,
    SmartAlarm,
    $$SmartAlarmsTableFilterComposer,
    $$SmartAlarmsTableOrderingComposer,
    $$SmartAlarmsTableAnnotationComposer,
    $$SmartAlarmsTableCreateCompanionBuilder,
    $$SmartAlarmsTableUpdateCompanionBuilder,
    (SmartAlarm, BaseReferences<_$AppDatabase, $SmartAlarmsTable, SmartAlarm>),
    SmartAlarm,
    PrefetchHooks Function()>;
typedef $$UserNotesTableCreateCompanionBuilder = UserNotesCompanion Function({
  required String id,
  Value<String> folderName,
  required String title,
  required String markdownBody,
  Value<String?> linkedEntityType,
  Value<String?> linkedEntityId,
  Value<int> isLockedBiometric,
  required int createdAt,
  required int updatedAt,
  Value<int> rowid,
});
typedef $$UserNotesTableUpdateCompanionBuilder = UserNotesCompanion Function({
  Value<String> id,
  Value<String> folderName,
  Value<String> title,
  Value<String> markdownBody,
  Value<String?> linkedEntityType,
  Value<String?> linkedEntityId,
  Value<int> isLockedBiometric,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<int> rowid,
});

class $$UserNotesTableFilterComposer
    extends Composer<_$AppDatabase, $UserNotesTable> {
  $$UserNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get folderName => $composableBuilder(
      column: $table.folderName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get markdownBody => $composableBuilder(
      column: $table.markdownBody, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get linkedEntityType => $composableBuilder(
      column: $table.linkedEntityType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get linkedEntityId => $composableBuilder(
      column: $table.linkedEntityId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isLockedBiometric => $composableBuilder(
      column: $table.isLockedBiometric,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$UserNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserNotesTable> {
  $$UserNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get folderName => $composableBuilder(
      column: $table.folderName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get markdownBody => $composableBuilder(
      column: $table.markdownBody,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get linkedEntityType => $composableBuilder(
      column: $table.linkedEntityType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get linkedEntityId => $composableBuilder(
      column: $table.linkedEntityId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isLockedBiometric => $composableBuilder(
      column: $table.isLockedBiometric,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$UserNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserNotesTable> {
  $$UserNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get folderName => $composableBuilder(
      column: $table.folderName, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get markdownBody => $composableBuilder(
      column: $table.markdownBody, builder: (column) => column);

  GeneratedColumn<String> get linkedEntityType => $composableBuilder(
      column: $table.linkedEntityType, builder: (column) => column);

  GeneratedColumn<String> get linkedEntityId => $composableBuilder(
      column: $table.linkedEntityId, builder: (column) => column);

  GeneratedColumn<int> get isLockedBiometric => $composableBuilder(
      column: $table.isLockedBiometric, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserNotesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserNotesTable,
    UserNote,
    $$UserNotesTableFilterComposer,
    $$UserNotesTableOrderingComposer,
    $$UserNotesTableAnnotationComposer,
    $$UserNotesTableCreateCompanionBuilder,
    $$UserNotesTableUpdateCompanionBuilder,
    (UserNote, BaseReferences<_$AppDatabase, $UserNotesTable, UserNote>),
    UserNote,
    PrefetchHooks Function()> {
  $$UserNotesTableTableManager(_$AppDatabase db, $UserNotesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> folderName = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> markdownBody = const Value.absent(),
            Value<String?> linkedEntityType = const Value.absent(),
            Value<String?> linkedEntityId = const Value.absent(),
            Value<int> isLockedBiometric = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserNotesCompanion(
            id: id,
            folderName: folderName,
            title: title,
            markdownBody: markdownBody,
            linkedEntityType: linkedEntityType,
            linkedEntityId: linkedEntityId,
            isLockedBiometric: isLockedBiometric,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String> folderName = const Value.absent(),
            required String title,
            required String markdownBody,
            Value<String?> linkedEntityType = const Value.absent(),
            Value<String?> linkedEntityId = const Value.absent(),
            Value<int> isLockedBiometric = const Value.absent(),
            required int createdAt,
            required int updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              UserNotesCompanion.insert(
            id: id,
            folderName: folderName,
            title: title,
            markdownBody: markdownBody,
            linkedEntityType: linkedEntityType,
            linkedEntityId: linkedEntityId,
            isLockedBiometric: isLockedBiometric,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$UserNotesTable, UserNote>(table),
                    BaseReferences<_$AppDatabase, $UserNotesTable, UserNote>(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserNotesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserNotesTable,
    UserNote,
    $$UserNotesTableFilterComposer,
    $$UserNotesTableOrderingComposer,
    $$UserNotesTableAnnotationComposer,
    $$UserNotesTableCreateCompanionBuilder,
    $$UserNotesTableUpdateCompanionBuilder,
    (UserNote, BaseReferences<_$AppDatabase, $UserNotesTable, UserNote>),
    UserNote,
    PrefetchHooks Function()>;
typedef $$QadaTrackerTableCreateCompanionBuilder = QadaTrackerCompanion
    Function({
  required String prayerType,
  Value<int> remainingCount,
  Value<int> completedCount,
  Value<int> dailyTarget,
  required int updatedAt,
  Value<int> rowid,
});
typedef $$QadaTrackerTableUpdateCompanionBuilder = QadaTrackerCompanion
    Function({
  Value<String> prayerType,
  Value<int> remainingCount,
  Value<int> completedCount,
  Value<int> dailyTarget,
  Value<int> updatedAt,
  Value<int> rowid,
});

class $$QadaTrackerTableFilterComposer
    extends Composer<_$AppDatabase, $QadaTrackerTable> {
  $$QadaTrackerTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get prayerType => $composableBuilder(
      column: $table.prayerType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get remainingCount => $composableBuilder(
      column: $table.remainingCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get completedCount => $composableBuilder(
      column: $table.completedCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dailyTarget => $composableBuilder(
      column: $table.dailyTarget, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$QadaTrackerTableOrderingComposer
    extends Composer<_$AppDatabase, $QadaTrackerTable> {
  $$QadaTrackerTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get prayerType => $composableBuilder(
      column: $table.prayerType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get remainingCount => $composableBuilder(
      column: $table.remainingCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get completedCount => $composableBuilder(
      column: $table.completedCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dailyTarget => $composableBuilder(
      column: $table.dailyTarget, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$QadaTrackerTableAnnotationComposer
    extends Composer<_$AppDatabase, $QadaTrackerTable> {
  $$QadaTrackerTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get prayerType => $composableBuilder(
      column: $table.prayerType, builder: (column) => column);

  GeneratedColumn<int> get remainingCount => $composableBuilder(
      column: $table.remainingCount, builder: (column) => column);

  GeneratedColumn<int> get completedCount => $composableBuilder(
      column: $table.completedCount, builder: (column) => column);

  GeneratedColumn<int> get dailyTarget => $composableBuilder(
      column: $table.dailyTarget, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$QadaTrackerTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QadaTrackerTable,
    QadaTrackerData,
    $$QadaTrackerTableFilterComposer,
    $$QadaTrackerTableOrderingComposer,
    $$QadaTrackerTableAnnotationComposer,
    $$QadaTrackerTableCreateCompanionBuilder,
    $$QadaTrackerTableUpdateCompanionBuilder,
    (
      QadaTrackerData,
      BaseReferences<_$AppDatabase, $QadaTrackerTable, QadaTrackerData>
    ),
    QadaTrackerData,
    PrefetchHooks Function()> {
  $$QadaTrackerTableTableManager(_$AppDatabase db, $QadaTrackerTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QadaTrackerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QadaTrackerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QadaTrackerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> prayerType = const Value.absent(),
            Value<int> remainingCount = const Value.absent(),
            Value<int> completedCount = const Value.absent(),
            Value<int> dailyTarget = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QadaTrackerCompanion(
            prayerType: prayerType,
            remainingCount: remainingCount,
            completedCount: completedCount,
            dailyTarget: dailyTarget,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String prayerType,
            Value<int> remainingCount = const Value.absent(),
            Value<int> completedCount = const Value.absent(),
            Value<int> dailyTarget = const Value.absent(),
            required int updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              QadaTrackerCompanion.insert(
            prayerType: prayerType,
            remainingCount: remainingCount,
            completedCount: completedCount,
            dailyTarget: dailyTarget,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$QadaTrackerTable, QadaTrackerData>(table),
                    BaseReferences<_$AppDatabase, $QadaTrackerTable,
                        QadaTrackerData>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$QadaTrackerTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QadaTrackerTable,
    QadaTrackerData,
    $$QadaTrackerTableFilterComposer,
    $$QadaTrackerTableOrderingComposer,
    $$QadaTrackerTableAnnotationComposer,
    $$QadaTrackerTableCreateCompanionBuilder,
    $$QadaTrackerTableUpdateCompanionBuilder,
    (
      QadaTrackerData,
      BaseReferences<_$AppDatabase, $QadaTrackerTable, QadaTrackerData>
    ),
    QadaTrackerData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PrayerTimesCacheTableTableManager get prayerTimesCache =>
      $$PrayerTimesCacheTableTableManager(_db, _db.prayerTimesCache);
  $$IlmiFeedItemsTableTableManager get ilmiFeedItems =>
      $$IlmiFeedItemsTableTableManager(_db, _db.ilmiFeedItems);
  $$CollectionsTableTableManager get collections =>
      $$CollectionsTableTableManager(_db, _db.collections);
  $$SavedItemsTableTableManager get savedItems =>
      $$SavedItemsTableTableManager(_db, _db.savedItems);
  $$ErkamDuaPagesTableTableManager get erkamDuaPages =>
      $$ErkamDuaPagesTableTableManager(_db, _db.erkamDuaPages);
  $$QuranSurahsTableTableManager get quranSurahs =>
      $$QuranSurahsTableTableManager(_db, _db.quranSurahs);
  $$QuranAyahsTableTableManager get quranAyahs =>
      $$QuranAyahsTableTableManager(_db, _db.quranAyahs);
  $$DhikrItemsTableTableManager get dhikrItems =>
      $$DhikrItemsTableTableManager(_db, _db.dhikrItems);
  $$SmartAlarmsTableTableManager get smartAlarms =>
      $$SmartAlarmsTableTableManager(_db, _db.smartAlarms);
  $$UserNotesTableTableManager get userNotes =>
      $$UserNotesTableTableManager(_db, _db.userNotes);
  $$QadaTrackerTableTableManager get qadaTracker =>
      $$QadaTrackerTableTableManager(_db, _db.qadaTracker);
}
