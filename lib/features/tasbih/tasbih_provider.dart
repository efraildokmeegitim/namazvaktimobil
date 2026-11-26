import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/database/app_database.dart';
import '../../core/widgets_bridge/widget_sync_bridge.dart';
import '../../main.dart';

class CustomDhikrModel {
  final String id;
  final String title;
  final String? arabicText;
  final String? meaningTr;
  final int targetCount;
  final int currentCount;
  final int totalLifetimeCount;

  const CustomDhikrModel({
    required this.id,
    required this.title,
    this.arabicText,
    this.meaningTr,
    this.targetCount = 33,
    this.currentCount = 0,
    this.totalLifetimeCount = 0,
  });

  CustomDhikrModel copyWith({
    String? id,
    String? title,
    String? arabicText,
    String? meaningTr,
    int? targetCount,
    int? currentCount,
    int? totalLifetimeCount,
  }) {
    return CustomDhikrModel(
      id: id ?? this.id,
      title: title ?? this.title,
      arabicText: arabicText ?? this.arabicText,
      meaningTr: meaningTr ?? this.meaningTr,
      targetCount: targetCount ?? this.targetCount,
      currentCount: currentCount ?? this.currentCount,
      totalLifetimeCount: totalLifetimeCount ?? this.totalLifetimeCount,
    );
  }
}

class TasbihState {
  final String activeDhikrId;
  final String title;
  final String? arabicText;
  final String? meaningTr;
  final int count;
  final int targetCount;
  final int round;
  final int totalCount;
  final bool isVibrationEnabled;
  final bool isSoundEnabled;
  final bool isOledMode;
  final List<CustomDhikrModel> savedDhikrs;

  const TasbihState({
    this.activeDhikrId = 'subhanallah',
    this.title = 'Sübhânallâh',
    this.arabicText = 'سُبْحَانَ اللَّهِ',
    this.meaningTr = 'Allah her türlü noksan ve kusurdan münezzehtir.',
    this.count = 0,
    this.targetCount = 33,
    this.round = 1,
    this.totalCount = 0,
    this.isVibrationEnabled = true,
    this.isSoundEnabled = true,
    this.isOledMode = false,
    this.savedDhikrs = const [],
  });

  TasbihState copyWith({
    String? activeDhikrId,
    String? title,
    String? arabicText,
    String? meaningTr,
    int? count,
    int? targetCount,
    int? round,
    int? totalCount,
    bool? isVibrationEnabled,
    bool? isSoundEnabled,
    bool? isOledMode,
    List<CustomDhikrModel>? savedDhikrs,
  }) {
    return TasbihState(
      activeDhikrId: activeDhikrId ?? this.activeDhikrId,
      title: title ?? this.title,
      arabicText: arabicText ?? this.arabicText,
      meaningTr: meaningTr ?? this.meaningTr,
      count: count ?? this.count,
      targetCount: targetCount ?? this.targetCount,
      round: round ?? this.round,
      totalCount: totalCount ?? this.totalCount,
      isVibrationEnabled: isVibrationEnabled ?? this.isVibrationEnabled,
      isSoundEnabled: isSoundEnabled ?? this.isSoundEnabled,
      isOledMode: isOledMode ?? this.isOledMode,
      savedDhikrs: savedDhikrs ?? this.savedDhikrs,
    );
  }
}

class TasbihNotifier extends StateNotifier<TasbihState> {
  final AppDatabase db;
  static const MethodChannel _vibeChannel = MethodChannel('com.sukun.app/vibration');

  TasbihNotifier(this.db) : super(const TasbihState()) {
    _initDhikrs();
  }

  Future<void> _initDhikrs() async {
    try {
      final rows = await (db.select(db.dhikrItems)..orderBy([(t) => drift.OrderingTerm(expression: t.sortOrder)])).get();

      if (rows.isEmpty) {
        // İlk kurulumda temel zikirleri tohumla
        final defaultDhikrs = [
          DhikrItemsCompanion.insert(
            id: 'namaz_tesbihati',
            title: 'Namaz Tesbihatı (33x3)',
            arabicText: const drift.Value('سُبْحَانَ اللَّهِ • الْحَمْدُ لِلَّهِ • اللَّهُ أَكْبَرُ'),
            meaningTr: const drift.Value('33 Sübhanallah, 33 Elhamdülillah, 33 Allahuekber zinciri'),
            targetCount: const drift.Value(33),
            sortOrder: const drift.Value(1),
          ),
          DhikrItemsCompanion.insert(
            id: 'kelime_i_tevhid',
            title: 'Kelime-i Tevhîd',
            arabicText: const drift.Value('لَا إِلٰهَ إِلَّا اللّٰهُ'),
            meaningTr: const drift.Value('Allah\'tan başka ilah yoktur.'),
            targetCount: const drift.Value(100),
            sortOrder: const drift.Value(2),
          ),
          DhikrItemsCompanion.insert(
            id: 'salavat_i_serif',
            title: 'Salavât-ı Şerîfe',
            arabicText: const drift.Value('اللَّهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ'),
            meaningTr: const drift.Value('Allah\'ım! Efendimiz Muhammed\'e salat ve selam eyle.'),
            targetCount: const drift.Value(100),
            sortOrder: const drift.Value(3),
          ),
          DhikrItemsCompanion.insert(
            id: 'istigfar',
            title: 'Estağfirullâhe\'l-Azîm',
            arabicText: const drift.Value('أَسْتَغْفِرُ اللَّهَ الْعَظِيمَ وَأَتُوبُ إِلَيْهِ'),
            meaningTr: const drift.Value('Yüce Allah\'tan bağışlanma diler ve O\'na tövbe ederim.'),
            targetCount: const drift.Value(100),
            sortOrder: const drift.Value(4),
          ),
          DhikrItemsCompanion.insert(
            id: 'havkale',
            title: 'Lâ Havle Velâ Kuvvete İllâ Billâh',
            arabicText: const drift.Value('لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ الْعَلِيِّ الْعَظِيمِ'),
            meaningTr: const drift.Value('Güç ve kuvvet ancak pek yüce ve ulu olan Allah\'ındır.'),
            targetCount: const drift.Value(33),
            sortOrder: const drift.Value(5),
          ),
          DhikrItemsCompanion.insert(
            id: 'subhanallahi_ve_bihamdihi',
            title: 'Sübhânallâhi ve bi-hamdihî',
            arabicText: const drift.Value('سُبْحَانَ اللَّهِ وَبِحَمْدِهِ سُبْحَانَ اللَّهِ الْعَظِيمِ'),
            meaningTr: const drift.Value('Allah\'ı hamdiyle tesbih ederim, Yüce Allah noksan sıfatlardan münezzehtir.'),
            targetCount: const drift.Value(100),
            sortOrder: const drift.Value(6),
          ),
        ];

        for (final item in defaultDhikrs) {
          await db.into(db.dhikrItems).insertOnConflictUpdate(item);
        }
      }

      await loadSavedDhikrs();
    } catch (_) {}
  }

  Future<void> loadSavedDhikrs() async {
    try {
      final rows = await (db.select(db.dhikrItems)..orderBy([(t) => drift.OrderingTerm(expression: t.sortOrder)])).get();
      final list = rows.map((r) => CustomDhikrModel(
        id: r.id,
        title: r.title,
        arabicText: r.arabicText,
        meaningTr: r.meaningTr,
        targetCount: r.targetCount,
        currentCount: r.currentCount,
        totalLifetimeCount: r.totalLifetimeCount,
      )).toList();

      state = state.copyWith(savedDhikrs: list);
    } catch (_) {}
  }

  /// Yeni Özel Zikir Ekle ve Veritabanına Kalıcı Kaydet
  Future<void> addCustomDhikr({
    required String title,
    String? arabicText,
    String? meaningTr,
    required int targetCount,
  }) async {
    final id = 'custom_${DateTime.now().millisecondsSinceEpoch}';
    final companion = DhikrItemsCompanion.insert(
      id: id,
      title: title,
      arabicText: drift.Value(arabicText?.trim().isEmpty == true ? null : arabicText),
      meaningTr: drift.Value(meaningTr?.trim().isEmpty == true ? null : meaningTr),
      targetCount: drift.Value(targetCount),
      currentCount: const drift.Value(0),
      totalLifetimeCount: const drift.Value(0),
      sortOrder: drift.Value(DateTime.now().millisecondsSinceEpoch ~/ 1000),
    );

    await db.into(db.dhikrItems).insert(companion);
    await loadSavedDhikrs();
    selectDhikr(id);
  }

  /// Kayıtlı Zikri Sil
  Future<void> deleteDhikr(String id) async {
    await (db.delete(db.dhikrItems)..where((t) => t.id.equals(id))).go();
    await loadSavedDhikrs();
    if (state.activeDhikrId == id) {
      if (state.savedDhikrs.isNotEmpty) {
        selectDhikr(state.savedDhikrs.first.id);
      } else {
        setZikr(title: 'Sübhânallâh', arabicText: 'سُبْحَانَ اللَّهِ', targetCount: 33);
      }
    }
  }

  /// Kayıtlı Listeden Zikir Seç
  void selectDhikr(String id) {
    final found = state.savedDhikrs.firstWhere(
      (d) => d.id == id,
      orElse: () => const CustomDhikrModel(id: 'namaz', title: 'Sübhânallâh', targetCount: 33),
    );

    state = state.copyWith(
      activeDhikrId: found.id,
      title: found.title,
      arabicText: found.arabicText,
      meaningTr: found.meaningTr,
      targetCount: found.targetCount,
      count: found.currentCount,
      totalCount: found.totalLifetimeCount,
      round: 1,
    );
    _syncWidgetTasbih();
  }

  /// Zikir Artırma (Sayma) ve Hedefe Ulaşınca Titreşim
  void increment() {
    final nextCount = state.count + 1;
    final nextTotal = state.totalCount + 1;

    // Normal dokunuş hafif haptic feedback
    if (state.isVibrationEnabled) {
      _vibrateTick();
    }

    if (state.targetCount > 0 && nextCount >= state.targetCount) {
      // HEDEFE ULAŞILDI: Güçlü titreşim darbesi
      if (state.isVibrationEnabled) {
        _vibrateTargetReached();
      }

      if (state.activeDhikrId == 'namaz_tesbihati' && state.targetCount == 33) {
        // Namaz Tesbihatı Zincirleme Modu (33 Sübhanallah -> 33 Elhamdülillah -> 33 Allahuekber)
        if (state.title.contains('Sübhânallâh')) {
          state = state.copyWith(
            title: 'Elhamdülillâh',
            arabicText: 'الْحَمْدُ لِلَّهِ',
            meaningTr: 'Bütün hamd ve şükürler Allah\'a aittir.',
            count: 0,
            totalCount: nextTotal,
            round: 2,
          );
        } else if (state.title.contains('Elhamdülillâh')) {
          state = state.copyWith(
            title: 'Allâhuekber',
            arabicText: 'اللَّهُ أَكْبَرُ',
            meaningTr: 'Allah her şeyden yücedir ve en büyüktür.',
            count: 0,
            totalCount: nextTotal,
            round: 3,
          );
        } else {
          // Namaz tesbihatı devri tamamlandı
          state = state.copyWith(
            title: 'Sübhânallâh',
            arabicText: 'سُبْحَانَ اللَّهِ',
            meaningTr: 'Allah her türlü noksan ve kusurdan münezzehtir.',
            count: 0,
            totalCount: nextTotal,
            round: state.round + 1,
          );
        }
      } else {
        // Hedefe ulaşıldı, devir arttır
        state = state.copyWith(
          count: 0,
          totalCount: nextTotal,
          round: state.round + 1,
        );
      }
    } else {
      state = state.copyWith(count: nextCount, totalCount: nextTotal);
    }

    _persistCurrentCount();
    _syncWidgetTasbih();
  }

  void _persistCurrentCount() {
    if (state.activeDhikrId.isNotEmpty) {
      (db.update(db.dhikrItems)..where((t) => t.id.equals(state.activeDhikrId))).write(
        DhikrItemsCompanion(
          currentCount: drift.Value(state.count),
          totalLifetimeCount: drift.Value(state.totalCount),
        ),
      );
    }
  }

  void setTargetCount(int target) {
    state = state.copyWith(targetCount: target, count: 0, round: 1);
    if (state.activeDhikrId.isNotEmpty) {
      (db.update(db.dhikrItems)..where((t) => t.id.equals(state.activeDhikrId))).write(
        DhikrItemsCompanion(
          targetCount: drift.Value(target),
          currentCount: const drift.Value(0),
        ),
      );
    }
    _syncWidgetTasbih();
  }

  void setZikr({
    required String title,
    String? arabicText,
    String? meaningTr,
    int targetCount = 33,
  }) {
    state = state.copyWith(
      title: title,
      arabicText: arabicText,
      meaningTr: meaningTr,
      targetCount: targetCount,
      count: 0,
      round: 1,
    );
    _syncWidgetTasbih();
  }

  void reset() {
    state = state.copyWith(count: 0, round: 1);
    _persistCurrentCount();
    _syncWidgetTasbih();
  }

  void resetTotalLifetime() {
    state = state.copyWith(count: 0, round: 1, totalCount: 0);
    _persistCurrentCount();
    _syncWidgetTasbih();
  }

  void toggleOledMode() {
    state = state.copyWith(isOledMode: !state.isOledMode);
  }

  void toggleVibration() {
    state = state.copyWith(isVibrationEnabled: !state.isVibrationEnabled);
  }

  void _vibrateTick() {
    try {
      _vibeChannel.invokeMethod('vibrateTick');
    } catch (_) {
      HapticFeedback.lightImpact();
    }
  }

  void _vibrateTargetReached() {
    try {
      _vibeChannel.invokeMethod('vibrateTargetReached');
    } catch (_) {
      HapticFeedback.heavyImpact();
    }
  }

  Future<void> _syncWidgetTasbih() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('tasbih_widget_count', state.count);
      await prefs.setString('tasbih_widget_dhikr_name', state.title);
      await WidgetSyncBridge.channel.invokeMethod('reloadAllTimelines');
    } catch (_) {}
  }
}

final tasbihProvider = StateNotifierProvider<TasbihNotifier, TasbihState>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return TasbihNotifier(db);
});
