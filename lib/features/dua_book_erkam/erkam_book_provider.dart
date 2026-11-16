import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../core/database/app_database.dart';
import '../../main.dart';

enum ErkamViewStyle {
  continuous,
  page,
  block;
}

final erkamViewStyleProvider = StateProvider<ErkamViewStyle>((ref) => ErkamViewStyle.continuous);
final showTransliterationProvider = StateProvider<bool>((ref) => true);
final erkamFontSizeProvider = StateProvider<double>((ref) => 18.0);
final erkamSepiaModeProvider = StateProvider<bool>((ref) => true);

enum ErkamCategoryFilter {
  all('Tümü'),
  favorites('Favorilerim'),
  selamAyetleri('Selâm Âyetleri (160-163)'),
  hifzAyetleri('Hıfz Âyetleri (164-174)'),
  kuranHadisDua('Kur\'ân ve Hadislerde Duâ'),
  duaAdabi('Duâ Âdâbı'),
  besmeleHamdele('Besmele - Hamdele - Salvele'),
  gununBelliZamanlari('Günün Belli Zamanları'),
  abdestCami('Abdest ve Cami Duâları'),
  seneninZamanlari('Senenin Muayyen Zamanları'),
  muhtelifVesileler('Muhtelif Vesilelerle Duâlar'),
  zikrullah('Zikrullah ve Meclisleri'),
  kuranFazileti('Kur\'ân Okumanın Faziletleri'),
  ediyeEzkar('Ed\'iye ve Ezkâr');

  final String label;
  const ErkamCategoryFilter(this.label);
}

final erkamActiveCategoryProvider = StateProvider<ErkamCategoryFilter>((ref) => ErkamCategoryFilter.all);
final erkamSearchQueryProvider = StateProvider<String>((ref) => '');

final erkamDuaPagesStreamProvider = StreamProvider<List<ErkamDuaPage>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final cat = ref.watch(erkamActiveCategoryProvider);
  final search = ref.watch(erkamSearchQueryProvider).trim().toLowerCase();

  SimpleSelectStatement<$ErkamDuaPagesTable, ErkamDuaPage> query;
  if (cat == ErkamCategoryFilter.favorites) {
    query = (db.select(db.erkamDuaPages)
      ..where((t) => t.isFavorite.equals(1))
      ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]));
  } else if (cat == ErkamCategoryFilter.selamAyetleri) {
    query = (db.select(db.erkamDuaPages)
      ..where((t) => t.pageNumber.isBetweenValues(160, 163))
      ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]));
  } else if (cat == ErkamCategoryFilter.hifzAyetleri) {
    query = (db.select(db.erkamDuaPages)
      ..where((t) => t.pageNumber.isBetweenValues(164, 174))
      ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]));
  } else if (cat == ErkamCategoryFilter.gununBelliZamanlari) {
    query = (db.select(db.erkamDuaPages)
      ..where((t) => (t.chapterTitle.contains('Günün Belli') | t.chapterTitle.contains('Uyanınca')) & t.pageNumber.isNotIn(const [160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174]))
      ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]));
  } else if (cat == ErkamCategoryFilter.muhtelifVesileler) {
    query = (db.select(db.erkamDuaPages)
      ..where((t) => t.chapterTitle.contains('Muhtelif') & t.pageNumber.isNotIn(const [160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174]))
      ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]));
  } else if (cat == ErkamCategoryFilter.abdestCami) {
    query = (db.select(db.erkamDuaPages)
      ..where((t) => t.chapterTitle.contains('Abdest') | t.chapterTitle.contains('Cami'))
      ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]));
  } else if (cat == ErkamCategoryFilter.besmeleHamdele) {
    query = (db.select(db.erkamDuaPages)
      ..where((t) => t.chapterTitle.contains('Besmele') | t.chapterTitle.contains('Hamdele') | t.chapterTitle.contains('Salvele'))
      ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]));
  } else if (cat == ErkamCategoryFilter.duaAdabi) {
    query = (db.select(db.erkamDuaPages)
      ..where((t) => t.chapterTitle.contains('Âdâbı') | t.chapterTitle.contains('Adabı'))
      ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]));
  } else if (cat == ErkamCategoryFilter.seneninZamanlari) {
    query = (db.select(db.erkamDuaPages)
      ..where((t) => t.chapterTitle.contains('Senenin') | t.chapterTitle.contains('Aylar') | t.chapterTitle.contains('Zamanları'))
      ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]));
  } else if (cat == ErkamCategoryFilter.zikrullah) {
    query = (db.select(db.erkamDuaPages)
      ..where((t) => t.chapterTitle.contains('Zikrullah') | t.chapterTitle.contains('Zikir Meclisleri'))
      ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]));
  } else if (cat == ErkamCategoryFilter.kuranFazileti) {
    query = (db.select(db.erkamDuaPages)
      ..where((t) => t.chapterTitle.contains('Fazilet'))
      ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]));
  } else if (cat == ErkamCategoryFilter.kuranHadisDua) {
    query = (db.select(db.erkamDuaPages)
      ..where((t) => t.chapterTitle.contains('Kur\'ân ve Hadis') | t.chapterTitle.contains('Hadislerde Duâ'))
      ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]));
  } else if (cat == ErkamCategoryFilter.ediyeEzkar) {
    query = (db.select(db.erkamDuaPages)
      ..where((t) => t.chapterTitle.contains('Ed\'iye') | t.chapterTitle.contains('Ezkâr'))
      ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]));
  } else {
    query = (db.select(db.erkamDuaPages)..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]));
  }

  return query.watch().map((pages) {
    if (search.isEmpty) return pages;
    return pages.where((p) =>
      p.chapterTitle.toLowerCase().contains(search) ||
      (p.subTitle?.toLowerCase().contains(search) ?? false) ||
      p.meaningTr.toLowerCase().contains(search) ||
      (p.transliterationTr?.toLowerCase().contains(search) ?? false) ||
      p.pageNumber.toString() == search
    ).toList();
  });
});

final erkamFavoritePagesStreamProvider = StreamProvider<List<ErkamDuaPage>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.erkamDuaPages)
        ..where((t) => t.isFavorite.equals(1))
        ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]))
      .watch();
});

final erkamAllPagesStreamProvider = StreamProvider<List<ErkamDuaPage>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.erkamDuaPages)
        ..orderBy([(t) => OrderingTerm.asc(t.pageNumber)]))
      .watch();
});

final erkamDrawerSearchQueryProvider = StateProvider<String>((ref) => '');
final erkamTargetPageProvider = StateProvider<int?>((ref) => null);

class ErkamBookActions {
  final AppDatabase db;
  ErkamBookActions(this.db);

  Future<void> toggleFavorite(int pageNumber, bool currentStatus) async {
    await (db.update(db.erkamDuaPages)..where((t) => t.pageNumber.equals(pageNumber))).write(
      ErkamDuaPagesCompanion(
        isFavorite: Value(currentStatus ? 0 : 1),
      ),
    );
  }

  Future<void> updateLastRead(int pageNumber) async {
    await (db.update(db.erkamDuaPages)..where((t) => t.pageNumber.equals(pageNumber))).write(
      ErkamDuaPagesCompanion(
        lastReadAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }
}

final erkamBookActionsProvider = Provider<ErkamBookActions>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ErkamBookActions(db);
});
