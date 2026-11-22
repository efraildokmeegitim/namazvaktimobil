import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/database/app_database.dart';
import '../../core/widgets_bridge/widget_sync_bridge.dart';
import '../../main.dart';


class TasbihState {
  final String title;
  final String? arabicText;
  final int count;
  final int targetCount;
  final int round;
  final bool isVibrationEnabled;
  final bool isSoundEnabled;
  final bool isOledMode;

  const TasbihState({
    this.title = 'Sübhânallâh',
    this.arabicText = 'سُبْحَانَ اللَّهِ',
    this.count = 0,
    this.targetCount = 33,
    this.round = 1,
    this.isVibrationEnabled = true,
    this.isSoundEnabled = true,
    this.isOledMode = false,
  });

  TasbihState copyWith({
    String? title,
    String? arabicText,
    int? count,
    int? targetCount,
    int? round,
    bool? isVibrationEnabled,
    bool? isSoundEnabled,
    bool? isOledMode,
  }) {
    return TasbihState(
      title: title ?? this.title,
      arabicText: arabicText ?? this.arabicText,
      count: count ?? this.count,
      targetCount: targetCount ?? this.targetCount,
      round: round ?? this.round,
      isVibrationEnabled: isVibrationEnabled ?? this.isVibrationEnabled,
      isSoundEnabled: isSoundEnabled ?? this.isSoundEnabled,
      isOledMode: isOledMode ?? this.isOledMode,
    );
  }
}

class TasbihNotifier extends StateNotifier<TasbihState> {
  final AppDatabase db;

  TasbihNotifier(this.db) : super(const TasbihState());

  /// Namaz Tesbihatı Zincirleme Modu (33'lük) veya 99 / 111 / Serbest zikir modu:
  void increment() {
    final nextCount = state.count + 1;

    if (state.targetCount > 0 && nextCount >= state.targetCount) {
      if (state.targetCount == 33) {
        // 33'lük Zincirleme Namaz Tesbihatı
        if (state.title == 'Sübhânallâh') {
          state = state.copyWith(
            title: 'Elhamdülillâh',
            arabicText: 'الْحَمْدُ لِلَّهِ',
            count: 0,
            round: 2,
          );
        } else if (state.title == 'Elhamdülillâh') {
          state = state.copyWith(
            title: 'Allâhuekber',
            arabicText: 'اللَّهُ أَكْبَرُ',
            count: 0,
            round: 3,
          );
        } else {
          // Devir tamamlandı
          state = state.copyWith(
            title: 'Sübhânallâh',
            arabicText: 'سُبْحَانَ اللَّهِ',
            count: 0,
            round: state.round + 1,
          );
        }
      } else {
        // 99'luk, 111'lik veya Özel Hedefli Tesbih Tamamlandı
        state = state.copyWith(
          count: 0,
          round: state.round + 1,
        );
      }
    } else {
      state = state.copyWith(count: nextCount);
    }
    _syncWidgetTasbih();
  }

  void setTargetCount(int target) {
    state = state.copyWith(targetCount: target, count: 0, round: 1);
    _syncWidgetTasbih();
  }

  void setZikr({required String title, String? arabicText, int targetCount = 33}) {
    state = state.copyWith(
      title: title,
      arabicText: arabicText,
      targetCount: targetCount,
      count: 0,
      round: 1,
    );
    _syncWidgetTasbih();
  }

  void reset() {
    state = state.copyWith(count: 0, round: 1);
    _syncWidgetTasbih();
  }

  void toggleOledMode() {
    state = state.copyWith(isOledMode: !state.isOledMode);
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
