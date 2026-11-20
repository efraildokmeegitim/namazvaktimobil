import 'package:flutter/services.dart';

class QuranAudioService {
  static const MethodChannel _channel = MethodChannel('com.sukun.app/quran_audio');

  // Türk ve dünya meşhur karileri listesi
  static const List<Map<String, String>> reciters = [
    {
      'id': 'ismail_bicer',
      'name': 'Hafız İsmail Biçer',
      'title': 'Reisülkurra (Türk Usulü Tavır)',
      'baseUrl': 'https://server8.mp3quran.net/bicer/',
    },
    {
      'id': 'fatih_colak',
      'name': 'Dr. Fatih Çollak',
      'title': 'Haseki Kıraat Hocası (Türkçe Tecvidli)',
      'baseUrl': 'https://server11.mp3quran.net/fatih/',
    },
    {
      'id': 'ilhan_tok',
      'name': 'Hafız İlhan Tok',
      'title': 'Diyanet Mushaf Hatmi (Ağır & Tane Tane)',
      'baseUrl': 'https://server10.mp3quran.net/tok/',
    },
    {
      'id': 'alafasy',
      'name': 'Mishary Rashid Alafasy',
      'title': 'Hafs Tilaveti',
      'baseUrl': 'https://server8.mp3quran.net/afs/',
    },
    {
      'id': 'abdulbasit',
      'name': 'Abdülbasit Abdüssamed',
      'title': 'Mücevved / Murattal Klasik',
      'baseUrl': 'https://server7.mp3quran.net/basit/',
    },
  ];

  static Future<bool> playSurah({
    required int surahNumber,
    required String reciterId,
  }) async {
    final reciter = reciters.firstWhere((r) => r['id'] == reciterId, orElse: () => reciters.first);
    final formattedNumber = surahNumber.toString().padLeft(3, '0');
    final audioUrl = '${reciter['baseUrl']}$formattedNumber.mp3';

    try {
      final res = await _channel.invokeMethod<bool>('playAudioUrl', {'url': audioUrl});
      return res ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> pause() async {
    try {
      final res = await _channel.invokeMethod<bool>('pauseAudio');
      return res ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> stop() async {
    try {
      final res = await _channel.invokeMethod<bool>('stopAudio');
      return res ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> isPlaying() async {
    try {
      final res = await _channel.invokeMethod<bool>('isPlaying');
      return res ?? false;
    } catch (_) {
      return false;
    }
  }
}
