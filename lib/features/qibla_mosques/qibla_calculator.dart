import 'dart:math';

class QiblaCalculator {
  // Kaaba Coordinates (Makkah)
  static const double kaabaLatitude = 21.422487;
  static const double kaabaLongitude = 39.826206;

  /// Büyük Daire Azimut Açısı Formülü:
  /// Q = atan2(sin(Δλ), cos(φ_U) * tan(φ_K) - sin(φ_U) * cos(Δλ))
  static double calculateQiblaAngle({
    required double userLat,
    required double userLon,
  }) {
    final phiU = _degToRad(userLat);
    final phiK = _degToRad(kaabaLatitude);
    final deltaLambda = _degToRad(kaabaLongitude - userLon);

    final y = sin(deltaLambda);
    final x = cos(phiU) * tan(phiK) - sin(phiU) * cos(deltaLambda);

    final qRad = atan2(y, x);
    final qDeg = _radToDeg(qRad);

    // Normalize to 0° - 360°
    return (qDeg + 360.0) % 360.0;
  }

  /// Kabe'ye olan kuş uçuşu mesafe (km - Haversine)
  static double distanceToKaabaKm({
    required double userLat,
    required double userLon,
  }) {
    const double earthRadiusKm = 6371.0;
    final dLat = _degToRad(kaabaLatitude - userLat);
    final dLon = _degToRad(kaabaLongitude - userLon);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(userLat)) *
            cos(_degToRad(kaabaLatitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusKm * c;
  }

  static double _degToRad(double deg) => deg * pi / 180.0;
  static double _radToDeg(double rad) => rad * 180.0 / pi;
}
