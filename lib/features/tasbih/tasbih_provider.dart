import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/app_database.dart';
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

  /// Namaz Tesbihatı Zincirleme Modu:
  /// 33 Sübhanallah -> 33 Elhamdülillah -> 33 Allahu Ekber
  void increment() {
    final nextCount = state.count + 1;

    if (nextCount >= state.targetCount) {
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
      state = state.copyWith(count: nextCount);
    }
  }

  void reset() {
    state = state.copyWith(count: 0, round: 1);
  }

  void toggleOledMode() {
    state = state.copyWith(isOledMode: !state.isOledMode);
  }
}

final tasbihProvider = StateNotifierProvider<TasbihNotifier, TasbihState>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return TasbihNotifier(db);
});
