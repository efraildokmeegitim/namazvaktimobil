import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/prayer_times/prayer_times_model.dart';

class WidgetSyncBridge {
  static const MethodChannel channel = MethodChannel('com.sukun.app/widget_bridge');

  /// Native iOS WidgetKit ve Android Glance için verileri SharedPreferences / AppGroup ile senkronize eder
  static Future<void> syncPrayerData(PrayerDayTimes times) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final widgetData = {
        'locationName': times.locationName,
        'hijriDate': times.hijriDate,
        'nextPrayerName': times.nextPrayer.label,
        'remainingSeconds': times.timeRemainingToNext.inSeconds,
        'fajr': _formatTime(times.fajr),
        'sunrise': _formatTime(times.sunrise),
        'dhuhr': _formatTime(times.dhuhr),
        'asr': _formatTime(times.asr),
        'maghrib': _formatTime(times.maghrib),
        'isha': _formatTime(times.isha),
        'sunProgress': times.sunProgress,
        'lastUpdated': DateTime.now().millisecondsSinceEpoch,
      };

      await prefs.setString('sukun_widget_data', jsonEncode(widgetData));

      // Native platformu tetikle (iOS WidgetCenter / Android AppWidgetManager)
      await channel.invokeMethod('reloadAllTimelines');
    } catch (_) {
      // Native taraf hazır olmadığında sessizce devam eder
    }
  }

  static String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
