import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// 1. Prayer Times Cache
class PrayerTimesCache extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get locationId => text()();
  TextColumn get gregorianDate => text()();
  TextColumn get hijriDate => text()();
  TextColumn get fajr => text()();
  TextColumn get sunrise => text()();
  TextColumn get dhuhr => text()();
  TextColumn get asr => text()();
  TextColumn get maghrib => text()();
  TextColumn get isha => text()();
  TextColumn get calculationSource => text()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {locationId, gregorianDate}
      ];
}

// 2. İlmi Feed Items
class IlmiFeedItems extends Table {
  TextColumn get id => text()();
  TextColumn get category => text()(); // fikih, siyer, kelam, hadis, ayet, ozlu_soz, kitap_alintisi, tasavvuf
  TextColumn get title => text().nullable()();
  TextColumn get arabicText => text().nullable()();
  TextColumn get summaryBody => text()();
  TextColumn get detailedCommentary => text().nullable()();
  TextColumn get sourceReference => text()();
  TextColumn get authorOrScholar => text().nullable()();
  TextColumn get bookPageRef => text().nullable()();
  IntColumn get readingTimeSec => integer().withDefault(const Constant(30))();
  IntColumn get isLiked => integer().withDefault(const Constant(0))();
  IntColumn get isRead => integer().withDefault(const Constant(0))();
  IntColumn get publishedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// 3. Collections
class Collections extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get colorHex => text()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// 4. Saved Items
class SavedItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get collectionId => text().nullable().references(Collections, #id, onDelete: KeyAction.cascade)();
  TextColumn get targetType => text()(); // ilmi_card, erkam_dua_page, quran_ayah
  TextColumn get targetId => text()();
  IntColumn get savedAt => integer()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {collectionId, targetType, targetId}
      ];
}

// 5. Erkam Dua Pages (Mahmud Sami Ramazanoğlu)
class ErkamDuaPages extends Table {
  IntColumn get pageNumber => integer()();
  TextColumn get chapterTitle => text()();
  TextColumn get subTitle => text().nullable()();
  TextColumn get arabicContent => text().nullable()();
  TextColumn get transliterationTr => text().nullable()();
  TextColumn get meaningTr => text()();
  TextColumn get virtueAndSource => text().nullable()();
  IntColumn get recommendedCount => integer().nullable()();
  TextColumn get audioAssetUrl => text().nullable()();
  IntColumn get isFavorite => integer().withDefault(const Constant(0))();
  IntColumn get lastReadAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {pageNumber};
}

// 6. Quran Surahs
class QuranSurahs extends Table {
  IntColumn get surahNumber => integer()();
  TextColumn get nameArabic => text()();
  TextColumn get nameTr => text()();
  TextColumn get meaningTr => text()();
  IntColumn get ayahCount => integer()();
  TextColumn get revelationPlace => text()();
  IntColumn get startPage => integer()();
  IntColumn get isDownloadedOffline => integer().withDefault(const Constant(0))();
  TextColumn get downloadedReciterId => text().nullable()();
  IntColumn get localStorageBytes => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {surahNumber};
}

// 7. Quran Ayahs
class QuranAyahs extends Table {
  IntColumn get id => integer()();
  IntColumn get surahNumber => integer().references(QuranSurahs, #surahNumber)();
  IntColumn get ayahNumber => integer()();
  IntColumn get mushafPage => integer()();
  IntColumn get juzNumber => integer()();
  TextColumn get uthmaniText => text()();
  TextColumn get translationTr => text()();
  TextColumn get shortTafsirTr => text().nullable()();
  IntColumn get isSajdah => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

// 8. Dhikr Items
class DhikrItems extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get arabicText => text().nullable()();
  TextColumn get transliteration => text().nullable()();
  TextColumn get meaningTr => text().nullable()();
  IntColumn get targetCount => integer().withDefault(const Constant(33))();
  IntColumn get currentCount => integer().withDefault(const Constant(0))();
  IntColumn get totalLifetimeCount => integer().withDefault(const Constant(0))();
  IntColumn get linkedErkamPage => integer().nullable().references(ErkamDuaPages, #pageNumber)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

// 9. Smart Alarms
class SmartAlarms extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get alarmType => text()(); // fixed_datetime, prayer_relative, hijri_recurring
  IntColumn get fixedTimestamp => integer().nullable()();
  TextColumn get anchorPrayer => text().nullable()();
  IntColumn get offsetMinutes => integer().nullable()();
  TextColumn get hijriDaysCsv => text().nullable()();
  TextColumn get weekdaysCsv => text().nullable()();
  TextColumn get linkedRoute => text().nullable()();
  TextColumn get soundId => text()();
  IntColumn get isEnabled => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}

// 10. User Notes
class UserNotes extends Table {
  TextColumn get id => text()();
  TextColumn get folderName => text().withDefault(const Constant('Genel'))();
  TextColumn get title => text()();
  TextColumn get markdownBody => text()();
  TextColumn get linkedEntityType => text().nullable()();
  TextColumn get linkedEntityId => text().nullable()();
  IntColumn get isLockedBiometric => integer().withDefault(const Constant(0))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// 11. Qada Tracker
class QadaTracker extends Table {
  TextColumn get prayerType => text()(); // fajr, dhuhr, asr, maghrib, isha, witr, fast
  IntColumn get remainingCount => integer().withDefault(const Constant(0))();
  IntColumn get completedCount => integer().withDefault(const Constant(0))();
  IntColumn get dailyTarget => integer().withDefault(const Constant(1))();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {prayerType};
}

@DriftDatabase(tables: [
  PrayerTimesCache,
  IlmiFeedItems,
  Collections,
  SavedItems,
  ErkamDuaPages,
  QuranSurahs,
  QuranAyahs,
  DhikrItems,
  SmartAlarms,
  UserNotes,
  QadaTracker,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          // Create FTS5 virtual table for full-text search across Quran, Duas, and Ilmi cards
          await customStatement('''
            CREATE VIRTUAL TABLE IF NOT EXISTS global_search_fts USING fts5(
              entity_type,
              entity_id,
              title,
              searchable_text
            );
          ''');
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sukun_app.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
