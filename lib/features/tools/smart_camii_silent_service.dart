import 'package:flutter/services.dart';

class SmartCamiiSilentService {
  static const MethodChannel _channel = MethodChannel('com.sukun.app/ringer_mode');

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
}
