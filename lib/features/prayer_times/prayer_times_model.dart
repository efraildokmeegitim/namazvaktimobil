enum PrayerType {
  fajr('İmsak'),
  sunrise('Güneş'),
  dhuhr('Öğle'),
  asr('İkindi'),
  maghrib('Akşam'),
  isha('Yatsı');

  final String label;
  const PrayerType(this.label);
}

class PrayerDayTimes {
  final DateTime date;
  final DateTime fajr;
  final DateTime sunrise;
  final DateTime dhuhr;
  final DateTime asr;
  final DateTime maghrib;
  final DateTime isha;
  final String hijriDate;
  final String locationName;

  const PrayerDayTimes({
    required this.date,
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.hijriDate,
    required this.locationName,
  });

  DateTime getTime(PrayerType type) {
    switch (type) {
      case PrayerType.fajr:
        return fajr;
      case PrayerType.sunrise:
        return sunrise;
      case PrayerType.dhuhr:
        return dhuhr;
      case PrayerType.asr:
        return asr;
      case PrayerType.maghrib:
        return maghrib;
      case PrayerType.isha:
        return isha;
    }
  }

  PrayerType get nextPrayer {
    final now = DateTime.now();
    if (now.isBefore(fajr)) return PrayerType.fajr;
    if (now.isBefore(sunrise)) return PrayerType.sunrise;
    if (now.isBefore(dhuhr)) return PrayerType.dhuhr;
    if (now.isBefore(asr)) return PrayerType.asr;
    if (now.isBefore(maghrib)) return PrayerType.maghrib;
    if (now.isBefore(isha)) return PrayerType.isha;
    return PrayerType.fajr; // ertesi gün imsak
  }

  PrayerType get currentPrayer {
    final now = DateTime.now();
    if (now.isBefore(fajr)) return PrayerType.isha;
    if (now.isBefore(sunrise)) return PrayerType.fajr;
    if (now.isBefore(dhuhr)) return PrayerType.sunrise;
    if (now.isBefore(asr)) return PrayerType.dhuhr;
    if (now.isBefore(maghrib)) return PrayerType.asr;
    if (now.isBefore(isha)) return PrayerType.maghrib;
    return PrayerType.isha;
  }

  Duration get timeRemainingToNext {
    final now = DateTime.now();
    final nextTime = getTime(nextPrayer);
    if (nextPrayer == PrayerType.fajr && now.isAfter(isha)) {
      final tomorrowFajr = fajr.add(const Duration(days: 1));
      return tomorrowFajr.difference(now);
    }
    return nextTime.difference(now);
  }

  /// Kerahat Vakti Kontrolü:
  /// 1. Güneş doğduktan sonraki ilk 45 dakika
  /// 2. Öğle namazından önceki 45 dakika (İstiva vakti)
  /// 3. Akşam namazından önceki 45 dakika
  bool get isKerahatTime {
    final now = DateTime.now();
    // 1. Güneş doğuşu sonrası ilk 45 dk
    if (now.isAfter(sunrise) && now.isBefore(sunrise.add(const Duration(minutes: 45)))) {
      return true;
    }
    // 2. Öğle öncesi 45 dk (İstiva)
    if (now.isAfter(dhuhr.subtract(const Duration(minutes: 45))) && now.isBefore(dhuhr)) {
      return true;
    }
    // 3. Akşam öncesi 45 dk
    if (now.isAfter(maghrib.subtract(const Duration(minutes: 45))) && now.isBefore(maghrib)) {
      return true;
    }
    return false;
  }

  String? get kerahatMessage {
    final now = DateTime.now();
    if (now.isAfter(sunrise) && now.isBefore(sunrise.add(const Duration(minutes: 45)))) {
      return 'Güneş Doğuşu Kerahati (Karahat-i Tulu\')';
    }
    if (now.isAfter(dhuhr.subtract(const Duration(minutes: 45))) && now.isBefore(dhuhr)) {
      return 'Öğle Öncesi İstivâ Kerahati';
    }
    if (now.isAfter(maghrib.subtract(const Duration(minutes: 45))) && now.isBefore(maghrib)) {
      return 'Akşam Öncesi Kerahati (Karahat-i Gurub)';
    }
    return null;
  }

  double get sunProgress {
    final now = DateTime.now();
    if (now.isBefore(sunrise)) return 0.0;
    if (now.isAfter(maghrib)) return 1.0;
    final totalDayDuration = maghrib.difference(sunrise).inSeconds;
    final currentDayElapsed = now.difference(sunrise).inSeconds;
    if (totalDayDuration <= 0) return 0.5;
    return (currentDayElapsed / totalDayDuration).clamp(0.0, 1.0);
  }
}
