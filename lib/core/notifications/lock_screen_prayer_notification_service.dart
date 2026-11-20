import 'dart:async';
import 'package:flutter/services.dart';
import '../../features/prayer_times/prayer_times_model.dart';
import '../widgets_bridge/widget_sync_bridge.dart';

/// Kilit Ekranı ve Bildirim Çubuğu Canlı Namaz Vakti Senkronizasyon Servisi
/// Android Persistent Media/Status Notification (VISIBILITY_PUBLIC) ve
/// iOS Live Activities / Glance köprüsü üzerinden kilit ekranında gösterim sağlar.
class LockScreenPrayerNotificationService {
  static const MethodChannel _channel = MethodChannel('com.sukun.app/lockscreen_notification');

  static bool _isLockScreenEnabled = true;
  static bool get isLockScreenEnabled => _isLockScreenEnabled;

  /// Kilit ekranı namaz vakti görünümünü açıp kapatır
  static void setLockScreenEnabled(bool enabled) {
    _isLockScreenEnabled = enabled;
    if (!enabled) {
      clearLockScreenNotification();
    }
  }

  /// Bildirim izni ister (Android 13+ POST_NOTIFICATIONS)
  static Future<void> requestPermission() async {
    try {
      await _channel.invokeMethod('requestNotificationPermission');
    } catch (_) {}
  }

  /// Aktif vakit verilerini hem Widget köprüsüne hem de Kilit Ekranı servisine gönderir
  static Future<void> updateLockScreen(PrayerDayTimes times) async {
    // 1. SharedPreferences & Native Widget timelines güncelle
    await WidgetSyncBridge.syncPrayerData(times);

    if (!_isLockScreenEnabled) return;

    try {
      final next = times.nextPrayer;
      final remaining = times.timeRemainingToNext;
      final remainingStr = _formatDuration(remaining);

      final title = '${next.label} Vaktine: $remainingStr';
      final subtitle = '${times.locationName} • ${times.hijriDate}';
      final details = 'İmsak: ${_formatTime(times.fajr)} | Güneş: ${_formatTime(times.sunrise)} | Öğle: ${_formatTime(times.dhuhr)} | İkindi: ${_formatTime(times.asr)} | Akşam: ${_formatTime(times.maghrib)} | Yatsı: ${_formatTime(times.isha)}';

      await _channel.invokeMethod('showLockScreenNotification', {
        'title': title,
        'subtitle': subtitle,
        'details': details,
        'nextPrayerName': next.label,
        'countdown': remainingStr,
        'remainingSeconds': remaining.inSeconds,
        'fajr': _formatTime(times.fajr),
        'sunrise': _formatTime(times.sunrise),
        'dhuhr': _formatTime(times.dhuhr),
        'asr': _formatTime(times.asr),
        'maghrib': _formatTime(times.maghrib),
        'isha': _formatTime(times.isha),
        'location': times.locationName,
        'hijriDate': times.hijriDate,
        'quote': "Kalpler ancak Allah'ı anmakla sükûnet bulur. (Ra'd, 28)",
        'visibility': 'public', // Kilit ekranında açık gösterim (VISIBILITY_PUBLIC)
        'ongoing': true,        // Kaza ile silinmeyen sabit servis bildirimi
      });
    } catch (_) {
      // Native taraf bağlı değilken (ör. Linux masaüstü ortamında) sessizce düşer
    }
  }

  /// Kilit ekranı bildirimini kaldırır
  static Future<void> clearLockScreenNotification() async {
    try {
      await _channel.invokeMethod('clearLockScreenNotification');
    } catch (_) {}
  }

  static String _formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  static String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
