import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:drift/drift.dart';
import 'app_database.dart';

class SeedLoaderService {
  final AppDatabase db;

  SeedLoaderService(this.db);

  Future<void> seedInitialDataIfEmpty() async {
    final duaCount = await db.select(db.erkamDuaPages).get();
    if (duaCount.length < 100) {
      await _seedErkamDualar();
    }

    final ilmiCount = await db.select(db.ilmiFeedItems).get();
    if (ilmiCount.isEmpty) {
      await _seedIlmiFeed();
    }

    final surahCount = await db.select(db.quranSurahs).get();
    if (surahCount.length < 6) {
      await _seedQuran();
    }
  }

  Future<void> reloadErkamDualar() async {
    await _seedErkamDualar();
  }

  Future<void> reloadQuran() async {
    await _seedQuran();
  }

  Future<void> _seedErkamDualar() async {
    try {
      final jsonString = await rootBundle.loadString('assets/seed_data/erkam_dualar_sample.json');
      final List<dynamic> list = jsonDecode(jsonString);

      await db.batch((batch) {
        batch.insertAll(
          db.erkamDuaPages,
          list.map((item) => ErkamDuaPagesCompanion.insert(
                pageNumber: Value(item['page_number'] as int),
                chapterTitle: item['chapter_title'] as String,
                subTitle: Value(item['sub_title'] as String?),
                arabicContent: Value(item['arabic_content'] as String?),
                transliterationTr: Value(item['transliteration_tr'] as String?),
                meaningTr: item['meaning_tr'] as String,
                virtueAndSource: Value(item['virtue_and_source'] as String?),
                recommendedCount: Value(item['recommended_count'] as int?),
                audioAssetUrl: Value(item['audio_asset_url'] as String?),
                isFavorite: Value(item['is_favorite'] as int? ?? 0),
              )),
          mode: InsertMode.insertOrReplace,
        );
      });
    } catch (_) {}
  }

  Future<void> reloadIlmiFeed() async {
    await _seedIlmiFeed();
  }

  Future<void> _seedIlmiFeed() async {
    try {
      final jsonString = await rootBundle.loadString('assets/seed_data/ilmi_feed_sample.json');
      final List<dynamic> list = jsonDecode(jsonString);

      await db.batch((batch) {
        batch.insertAll(
          db.ilmiFeedItems,
          list.map((item) => IlmiFeedItemsCompanion.insert(
                id: item['id'] as String,
                category: item['category'] as String,
                title: Value(item['title'] as String?),
                arabicText: Value(item['arabic_text'] as String?),
                summaryBody: item['summary_body'] as String,
                detailedCommentary: Value(item['detailed_commentary'] as String?),
                sourceReference: item['source_reference'] as String,
                authorOrScholar: Value(item['author_or_scholar'] as String?),
                bookPageRef: Value(item['book_page_ref'] as String?),
                readingTimeSec: Value(item['reading_time_sec'] as int? ?? 30),
                publishedAt: item['published_at'] as int,
              )),
          mode: InsertMode.insertOrReplace,
        );
      });
    } catch (_) {}
  }

  Future<void> _seedQuran() async {
    try {
      final jsonString = await rootBundle.loadString('assets/seed_data/quran_sample.json');
      final Map<String, dynamic> data = jsonDecode(jsonString);

      final surahs = data['surahs'] as List<dynamic>;
      final ayahs = data['ayahs'] as List<dynamic>;

      await db.batch((batch) {
        batch.insertAll(
          db.quranSurahs,
          surahs.map((s) => QuranSurahsCompanion.insert(
                surahNumber: Value(s['surah_number'] as int),
                nameArabic: s['name_arabic'] as String,
                nameTr: s['name_tr'] as String,
                meaningTr: s['meaning_tr'] as String,
                ayahCount: s['ayah_count'] as int,
                revelationPlace: s['revelation_place'] as String,
                startPage: s['start_page'] as int,
              )),
          mode: InsertMode.insertOrReplace,
        );

        batch.insertAll(
          db.quranAyahs,
          ayahs.map((a) => QuranAyahsCompanion.insert(
                id: Value(a['id'] as int),
                surahNumber: a['surah_number'] as int,
                ayahNumber: a['ayah_number'] as int,
                mushafPage: a['mushaf_page'] as int,
                juzNumber: a['juz_number'] as int,
                uthmaniText: a['uthmani_text'] as String,
                translationTr: a['translation_tr'] as String,
                shortTafsirTr: Value(a['short_tafsir_tr'] as String?),
                isSajdah: Value(a['is_sajdah'] as int? ?? 0),
              )),
          mode: InsertMode.insertOrReplace,
        );
      });
    } catch (_) {}
  }
}
