import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../prayer_times/prayer_times_model.dart';

class SmartCamiiSilentService {
  static const MethodChannel _channel = MethodChannel('com.sukun.app/ringer_mode');
  static const String _prefAutoSilentEnabled = 'sukun_auto_camii_silent_enabled';
  static const String _prefAutoSilentMinutes = 'sukun_auto_camii_silent_duration';
  static const String _prefLastSilentTime = 'sukun_last_auto_silent_time';

  static Future<bool> isAutoSilentEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prefAutoSilentEnabled) ?? false;
  }

  static Future<void> setAutoSilentEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefAutoSilentEnabled, enabled);
  }

  static Future<int> getAutoSilentDurationMinutes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_prefAutoSilentMinutes) ?? 30; // varsayılan 30 dk namaz süresi
  }

  static Future<void> setAutoSilentDurationMinutes(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefAutoSilentMinutes, minutes);
  }

  static Future<bool> setSilentMode() async {
    try {
      final res = await _channel.invokeMethod<bool>('setSilentMode');
      return res ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> setNormalMode() async {
    try {
      final res = await _channel.invokeMethod<bool>('setNormalMode');
      return res ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<String> getRingerMode() async {
    try {
      final res = await _channel.invokeMethod<String>('getRingerMode');
      return res ?? 'normal';
    } catch (_) {
      return 'normal';
    }
  }

  /// Ezan vakitlerinde akıllı otomatik sessize alma / normal moda döndürme kontrolü
  static Future<void> checkAndApplyAutoSilent(PrayerDayTimes times) async {
    try {
      final isEnabled = await isAutoSilentEnabled();
      if (!isEnabled) return;

      final now = DateTime.now();
      final durationMinutes = await getAutoSilentDurationMinutes();
      final prefs = await SharedPreferences.getInstance();

      final prayerTimesList = [
        times.fajr,
        times.dhuhr,
        times.asr,
        times.maghrib,
        times.isha,
      ];

      bool shouldBeSilent = false;
      for (final pTime in prayerTimesList) {
        final diff = now.difference(pTime);
        // Ezan vaktinden itibaren belirlenen dakika (ör. 30 dk) boyunca
        if (diff.inSeconds >= 0 && diff.inMinutes < durationMinutes) {
          shouldBeSilent = true;
          break;
        }
      }

      final currentMode = await getRingerMode();
      final lastSilentTime = prefs.getInt(_prefLastSilentTime) ?? 0;

      if (shouldBeSilent) {
        if (currentMode != 'vibrate' && currentMode != 'silent') {
          await setSilentMode();
          await prefs.setInt(_prefLastSilentTime, now.millisecondsSinceEpoch);
        }
      } else {
        // Namaz vakti bitti ve daha önce otomatik sessize alınmışsa normale döndür
        if (lastSilentTime > 0) {
          final elapsed = now.difference(DateTime.fromMillisecondsSinceEpoch(lastSilentTime));
          if (elapsed.inMinutes >= durationMinutes && elapsed.inMinutes < durationMinutes + 60) {
            await setNormalMode();
            await prefs.remove(_prefLastSilentTime);
          }
        }
      }
    } catch (_) {}
  }
}
