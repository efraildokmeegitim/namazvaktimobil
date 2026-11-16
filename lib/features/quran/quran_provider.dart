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

final quranActiveMainTabProvider = StateProvider<QuranMainTab>((ref) => QuranMainTab.surahList);
final quranBookmarkedAyahIdsProvider = StateProvider<Set<int>>((ref) => {1, 3601}); // Varsayılan örnek yer imleri
final quranMemorizingAyahIdsProvider = StateProvider<Set<int>>((ref) => {1, 2, 3, 4, 5, 6, 7, 11201}); // Ezber listesindeki âyetler
final quranHiddenArabicAyahIdsProvider = StateProvider<Set<int>>((ref) => {}); // Ezber modunda gizlenmiş âyetler
final quranAyahRepetitionCountsProvider = StateProvider<Map<int, int>>((ref) => {}); // Âyet bazlı tekrar sayacı
final selectedJuzNumberProvider = StateProvider<int>((ref) => 1);
final quranMushafPageNumberProvider = StateProvider<int>((ref) => 1);
final quranViewModeProvider = StateProvider<QuranViewMode>((ref) => QuranViewMode.mealWithShortTafsir);
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

  /// Sık Okunan Sureler Paketi (Yâsîn, Mülk, Nebe, Fetih, Kehf, Vâkıa, Rahmân, Cuma vb.)
  static const List<int> frequentSurahs = [36, 67, 78, 48, 18, 56, 55, 62];

  Future<void> toggleDownloadSurah(int surahNumber, bool isDownloaded) async {
    await (db.update(db.quranSurahs)..where((t) => t.surahNumber.equals(surahNumber))).write(
      QuranSurahsCompanion(
        isDownloadedOffline: Value(isDownloaded ? 0 : 1),
        localStorageBytes: Value(isDownloaded ? 0 : 15 * 1024 * 1024), // ~15 MB mock audio
      ),
    );
  }

  Future<void> downloadFrequentSurahsPackage() async {
    for (final num in frequentSurahs) {
      await (db.update(db.quranSurahs)..where((t) => t.surahNumber.equals(num))).write(
        const QuranSurahsCompanion(
          isDownloadedOffline: Value(1),
          localStorageBytes: Value(12 * 1024 * 1024),
        ),
      );
    }
  }

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
