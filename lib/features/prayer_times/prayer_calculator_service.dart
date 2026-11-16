import 'dart:math';
import 'package:adhan/adhan.dart';
import 'prayer_times_model.dart';

class PrayerCalculatorService {
  PrayerDayTimes calculateTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
    String locationName = 'İstanbul, Fatih',
  }) {
    final coordinates = Coordinates(latitude, longitude);
    final params = CalculationMethod.turkey.getParameters();
    params.madhab = Madhab.shafi; // standart ikindi veya hanefi seçilebilir

    final dateComponents = DateComponents.from(date);
    final prayerTimes = PrayerTimes(coordinates, dateComponents, params);

    return PrayerDayTimes(
      date: date,
      fajr: prayerTimes.fajr,
      sunrise: prayerTimes.sunrise,
      dhuhr: prayerTimes.dhuhr,
      asr: prayerTimes.asr,
      maghrib: prayerTimes.maghrib,
      isha: prayerTimes.isha,
      hijriDate: _getMockHijriDate(date),
      locationName: locationName,
    );
  }

  /// 90 km Seferilik Kontrolü:
  /// Haversine formülü ile kullanıcı koordinatı ve ev koordinatı arasındaki mesafeyi (km) hesaplar.
  double calculateDistanceKm({
    required double lat1,
    required double lon1,
    required double lat2,
    required double lon2,
  }) {
    const double earthRadiusKm = 6371.0;
    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusKm * c;
  }

  bool isSafir({
    required double currentLat,
    required double currentLon,
    required double homeLat,
    required double homeLon,
  }) {
    final distance = calculateDistanceKm(
      lat1: currentLat,
      lon1: currentLon,
      lat2: homeLat,
      lon2: homeLon,
    );
    return distance >= 90.0;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  String _getMockHijriDate(DateTime date) {
    return '24 Cemâziyelevvel 1448';
  }
}
