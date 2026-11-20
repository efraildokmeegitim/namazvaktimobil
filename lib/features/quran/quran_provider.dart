import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../core/database/app_database.dart';
import '../../main.dart';

enum QuranViewMode {
  mushaf,
  mealWithShortTafsir;
}

enum QuranMainTab {
  surahList,
  juzList,
  bookmarks,
  memorization,
}

enum QuranFontFamily {
  hafizOsman('Diyanet Hafız Osman', 'HafizOsman'),
  hayrat('Hayrat Nesih', 'HayratNesih'),
  scheherazade('Scheherazade', 'ScheherazadeNew'),
  uthmani('KFGQPC Hafs', 'KFGQPC Uthmanic Script HAFS'),
  amiri('Amiri', 'Amiri');

  final String label;
  final String fontFamily;
  const QuranFontFamily(this.label, this.fontFamily);
}

final quranActiveFontFamilyProvider = StateProvider<QuranFontFamily>((ref) => QuranFontFamily.hafizOsman);
final quranLastReadSurahProvider = StateProvider<int>((ref) => 1);
final quranLastReadAyahProvider = StateProvider<int>((ref) => 1);
final quranLastReadPageProvider = StateProvider<int>((ref) => 1);
final quranAudioIsPlayingProvider = StateProvider<bool>((ref) => false);
final quranAudioPlaybackSpeedProvider = StateProvider<double>((ref) => 1.0);
final quranSelectedReciterProvider = StateProvider<String>((ref) => 'Mishary Rashid Alafasy');

final quranActiveMainTabProvider = StateProvider<QuranMainTab>((ref) => QuranMainTab.surahList);
final quranBookmarkedAyahIdsProvider = StateProvider<Set<int>>((ref) => {1, 3601}); // Varsayılan örnek yer imleri
final quranMemorizingAyahIdsProvider = StateProvider<Set<int>>((ref) => {1, 2, 3, 4, 5, 6, 7, 11201}); // Ezber listesindeki âyetler
final quranHiddenArabicAyahIdsProvider = StateProvider<Set<int>>((ref) => {}); // Ezber modunda gizlenmiş âyetler
final quranAyahRepetitionCountsProvider = StateProvider<Map<int, int>>((ref) => {}); // Âyet bazlı tekrar sayacı
final selectedJuzNumberProvider = StateProvider<int>((ref) => 1);
final quranMushafPageNumberProvider = StateProvider<int>((ref) => 1);
final quranMushafSepiaModeProvider = StateProvider<bool>((ref) => true);
final quranMushafFontSizeMultiplierProvider = StateProvider<double>((ref) => 1.0);
final quranViewModeProvider = StateProvider<QuranViewMode>((ref) => QuranViewMode.mushaf);

class MushafVerse {
  final int surahNumber;
  final int ayahNumber;
  final String verseKey;
  final int juzNumber;
  final String text;

  const MushafVerse({
    required this.surahNumber,
    required this.ayahNumber,
    required this.verseKey,
    required this.juzNumber,
    required this.text,
  });

  factory MushafVerse.fromJson(Map<String, dynamic> json) {
    return MushafVerse(
      surahNumber: json['surah_number'] as int,
      ayahNumber: json['ayah_number'] as int,
      verseKey: json['verse_key'] as String,
      juzNumber: json['juz_number'] as int,
      text: json['text'] as String,
    );
  }
}

class MushafSurahMeta {
  final int surahNumber;
  final String nameTr;
  final String nameArabic;
  final String meaningTr;
  final int ayahCount;
  final String revelationPlace;
  final int startPage;

  const MushafSurahMeta({
    required this.surahNumber,
    required this.nameTr,
    required this.nameArabic,
    required this.meaningTr,
    required this.ayahCount,
    required this.revelationPlace,
    required this.startPage,
  });

  factory MushafSurahMeta.fromJson(Map<String, dynamic> json) {
    return MushafSurahMeta(
      surahNumber: json['surah_number'] as int,
      nameTr: json['name_tr'] as String,
      nameArabic: json['name_arabic'] as String,
      meaningTr: json['meaning_tr'] as String,
      ayahCount: json['ayah_count'] as int,
      revelationPlace: json['revelation_place'] as String,
      startPage: json['start_page'] as int,
    );
  }
}

class Mushaf604Data {
  final List<MushafSurahMeta> surahs;
  final Map<int, List<MushafVerse>> pages;

  const Mushaf604Data({required this.surahs, required this.pages});

  int getPageForSurah(int surahNumber) {
    final s = surahs.firstWhere(
      (item) => item.surahNumber == surahNumber,
      orElse: () => surahs.first,
    );
    return s.startPage;
  }

  int getPageForJuz(int juzNumber) {
    if (juzNumber <= 1) return 1;
    // Standart 20 sayfalık Diyanet / Hayrat tertibi
    final calculated = (juzNumber - 1) * 20 + 2;
    return calculated > 604 ? 604 : calculated;
  }
}

final mushaf604DataProvider = FutureProvider<Mushaf604Data>((ref) async {
  final jsonStr = await rootBundle.loadString('assets/seed_data/mushaf_604_pages.json');
  final map = jsonDecode(jsonStr) as Map<String, dynamic>;
  final rawSurahs = map['surahs'] as List<dynamic>;
  final surahs = rawSurahs.map((s) => MushafSurahMeta.fromJson(s as Map<String, dynamic>)).toList();
  final rawPages = map['pages'] as Map<String, dynamic>;
  final pages = <int, List<MushafVerse>>{};
  rawPages.forEach((key, val) {
    final pageNum = int.tryParse(key) ?? 1;
    final list = (val as List<dynamic>).map((v) => MushafVerse.fromJson(v as Map<String, dynamic>)).toList();
    pages[pageNum] = list;
  });
  return Mushaf604Data(surahs: surahs, pages: pages);
});
final selectedSurahNumberProvider = StateProvider<int>((ref) => 1);
final quranSearchQueryProvider = StateProvider<String>((ref) => '');
final quranArabicFontSizeProvider = StateProvider<double>((ref) => 24.0);
final quranTranslationFontSizeProvider = StateProvider<double>((ref) => 15.0);
final quranPlayingAyahIdProvider = StateProvider<int?>((ref) => null);

final quranSurahsStreamProvider = StreamProvider<List<QuranSurah>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.quranSurahs)..orderBy([(t) => OrderingTerm.asc(t.surahNumber)])).watch();
});

final currentSurahAyahsStreamProvider = StreamProvider<List<QuranAyah>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final activeTab = ref.watch(quranActiveMainTabProvider);
  final surahNum = ref.watch(selectedSurahNumberProvider);
  final juzNum = ref.watch(selectedJuzNumberProvider);
  final bookmarkedIds = ref.watch(quranBookmarkedAyahIdsProvider);
  final memorizingIds = ref.watch(quranMemorizingAyahIdsProvider);
  final search = ref.watch(quranSearchQueryProvider).trim().toLowerCase();

  SimpleSelectStatement<$QuranAyahsTable, QuranAyah> query;
  if (activeTab == QuranMainTab.surahList) {
    query = (db.select(db.quranAyahs)
      ..where((t) => t.surahNumber.equals(surahNum))
      ..orderBy([(t) => OrderingTerm.asc(t.ayahNumber)]));
  } else if (activeTab == QuranMainTab.juzList) {
    query = (db.select(db.quranAyahs)
      ..where((t) => t.juzNumber.equals(juzNum))
      ..orderBy([(t) => OrderingTerm.asc(t.id)]));
  } else if (activeTab == QuranMainTab.memorization) {
    query = (db.select(db.quranAyahs)
      ..where((t) => t.id.isIn(memorizingIds))
      ..orderBy([(t) => OrderingTerm.asc(t.id)]));
  } else {
    query = (db.select(db.quranAyahs)
      ..where((t) => t.id.isIn(bookmarkedIds))
      ..orderBy([(t) => OrderingTerm.asc(t.id)]));
  }

  return query.watch().map((ayahs) {
    if (search.isEmpty) return ayahs;
    return ayahs.where((a) =>
      a.translationTr.toLowerCase().contains(search) ||
      (a.shortTafsirTr?.toLowerCase().contains(search) ?? false) ||
      a.uthmaniText.contains(search) ||
      a.ayahNumber.toString() == search
    ).toList();
  });
});

class QuranDownloadManager {
  final AppDatabase db;
  QuranDownloadManager(this.db);

  /// Sık Okunan Sureler Paketi (Yâsîn, Mülk, Nebe, Fetih, Kehf, Vâkıa, Rahmân, Cuma, Secde, Duhân)
  static const List<int> frequentSurahs = [36, 67, 78, 48, 18, 56, 55, 62, 32, 44];

  /// Namaz & Kısa Sureler (Fil -> Nâs: 105 - 114)
  static const List<int> namazSurahs = [105, 106, 107, 108, 109, 110, 111, 112, 113, 114];

  /// 30. Cüz Ezber Paketi (Nebe -> Nâs: 78 - 114)
  static final List<int> juz30Surahs = List.generate(37, (i) => 78 + i);

  Future<void> toggleDownloadSurah(int surahNumber, bool isDownloaded) async {
    await (db.update(db.quranSurahs)..where((t) => t.surahNumber.equals(surahNumber))).write(
      QuranSurahsCompanion(
        isDownloadedOffline: Value(isDownloaded ? 0 : 1),
        localStorageBytes: Value(isDownloaded ? 0 : 12 * 1024 * 1024),
      ),
    );
  }

  Future<void> downloadSurahList(List<int> numbers, int perSurahMb) async {
    for (final num in numbers) {
      await (db.update(db.quranSurahs)..where((t) => t.surahNumber.equals(num))).write(
        QuranSurahsCompanion(
          isDownloadedOffline: const Value(1),
          localStorageBytes: Value(perSurahMb * 1024 * 1024),
        ),
      );
    }
  }

  Future<void> downloadFrequentSurahsPackage() => downloadSurahList(frequentSurahs, 12);
  Future<void> downloadNamazSurahsPackage() => downloadSurahList(namazSurahs, 2);
  Future<void> downloadJuz30Package() => downloadSurahList(juz30Surahs, 3);
  Future<void> downloadFullQuranPackage() => downloadSurahList(List.generate(114, (i) => i + 1), 8);

  Future<void> clearOfflineStorage() async {
    await db.update(db.quranSurahs).write(
      const QuranSurahsCompanion(
        isDownloadedOffline: Value(0),
        localStorageBytes: Value(0),
      ),
    );
  }
}

final quranDownloadManagerProvider = Provider<QuranDownloadManager>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return QuranDownloadManager(db);
});

