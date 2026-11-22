import 'dart:math';

class CityCoordinate {
  final String name;
  final double latitude;
  final double longitude;

  const CityCoordinate({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

class OfflineGeoLookupService {
  /// Türkiye 81 İl Merkezi Çevrimdışı Koordinat Kütüphanesi
  static const List<CityCoordinate> cities = [
    CityCoordinate(name: 'Adana', latitude: 37.0000, longitude: 35.3213),
    CityCoordinate(name: 'Adıyaman', latitude: 37.7648, longitude: 38.2786),
    CityCoordinate(name: 'Afyonkarahisar', latitude: 38.7507, longitude: 30.5567),
    CityCoordinate(name: 'Ağrı', latitude: 39.7191, longitude: 43.0503),
    CityCoordinate(name: 'Amasya', latitude: 40.6533, longitude: 35.8331),
    CityCoordinate(name: 'Ankara', latitude: 39.9334, longitude: 32.8597),
    CityCoordinate(name: 'Antalya', latitude: 36.8969, longitude: 30.7133),
    CityCoordinate(name: 'Artvin', latitude: 41.1828, longitude: 41.8183),
    CityCoordinate(name: 'Aydın', latitude: 37.8560, longitude: 27.8416),
    CityCoordinate(name: 'Balıkesir', latitude: 39.6484, longitude: 27.8826),
    CityCoordinate(name: 'Bilecik', latitude: 40.1451, longitude: 29.9799),
    CityCoordinate(name: 'Bingöl', latitude: 38.8854, longitude: 40.4983),
    CityCoordinate(name: 'Bitlis', latitude: 38.4006, longitude: 42.1095),
    CityCoordinate(name: 'Bolu', latitude: 40.7350, longitude: 31.6061),
    CityCoordinate(name: 'Burdur', latitude: 37.7203, longitude: 30.2908),
    CityCoordinate(name: 'Bursa', latitude: 40.1885, longitude: 29.0610),
    CityCoordinate(name: 'Çanakkale', latitude: 40.1553, longitude: 26.4142),
    CityCoordinate(name: 'Çankırı', latitude: 40.6013, longitude: 33.6134),
    CityCoordinate(name: 'Çorum', latitude: 40.5506, longitude: 34.9556),
    CityCoordinate(name: 'Denizli', latitude: 37.7765, longitude: 29.0864),
    CityCoordinate(name: 'Diyarbakır', latitude: 37.9144, longitude: 40.2306),
    CityCoordinate(name: 'Edirne', latitude: 41.6818, longitude: 26.5623),
    CityCoordinate(name: 'Elazığ', latitude: 38.6810, longitude: 39.2264),
    CityCoordinate(name: 'Erzincan', latitude: 39.7500, longitude: 39.5000),
    CityCoordinate(name: 'Erzurum', latitude: 39.9043, longitude: 41.2679),
    CityCoordinate(name: 'Eskişehir', latitude: 39.7767, longitude: 30.5206),
    CityCoordinate(name: 'Gaziantep', latitude: 37.0662, longitude: 37.3833),
    CityCoordinate(name: 'Giresun', latitude: 40.9128, longitude: 38.3895),
    CityCoordinate(name: 'Gümüşhane', latitude: 40.4600, longitude: 39.4717),
    CityCoordinate(name: 'Hakkari', latitude: 37.5833, longitude: 43.7333),
    CityCoordinate(name: 'Hatay', latitude: 36.4018, longitude: 36.3498),
    CityCoordinate(name: 'Isparta', latitude: 37.7648, longitude: 30.5566),
    CityCoordinate(name: 'Mersin', latitude: 36.8121, longitude: 34.6415),
    CityCoordinate(name: 'İstanbul', latitude: 41.0082, longitude: 28.9784),
    CityCoordinate(name: 'İzmir', latitude: 38.4237, longitude: 27.1428),
    CityCoordinate(name: 'Kars', latitude: 40.6167, longitude: 43.1000),
    CityCoordinate(name: 'Kastamonu', latitude: 41.3887, longitude: 33.7827),
    CityCoordinate(name: 'Kayseri', latitude: 38.7312, longitude: 35.4787),
    CityCoordinate(name: 'Kırklareli', latitude: 41.7333, longitude: 27.2167),
    CityCoordinate(name: 'Kırşehir', latitude: 39.1425, longitude: 34.1709),
    CityCoordinate(name: 'Kocaeli', latitude: 40.8533, longitude: 29.8815),
    CityCoordinate(name: 'Konya', latitude: 37.8667, longitude: 32.4833),
    CityCoordinate(name: 'Kütahya', latitude: 39.4167, longitude: 29.9833),
    CityCoordinate(name: 'Malatya', latitude: 38.3552, longitude: 38.3095),
    CityCoordinate(name: 'Manisa', latitude: 38.6191, longitude: 27.4289),
    CityCoordinate(name: 'Kahramanmaraş', latitude: 37.5858, longitude: 36.9371),
    CityCoordinate(name: 'Mardin', latitude: 37.3212, longitude: 40.7245),
    CityCoordinate(name: 'Muğla', latitude: 37.2153, longitude: 28.3636),
    CityCoordinate(name: 'Muş', latitude: 38.7432, longitude: 41.5064),
    CityCoordinate(name: 'Nevşehir', latitude: 38.6244, longitude: 34.7144),
    CityCoordinate(name: 'Niğde', latitude: 37.9667, longitude: 34.6833),
    CityCoordinate(name: 'Ordu', latitude: 40.9839, longitude: 37.8764),
    CityCoordinate(name: 'Rize', latitude: 41.0201, longitude: 40.5234),
    CityCoordinate(name: 'Sakarya', latitude: 40.7569, longitude: 30.3783),
    CityCoordinate(name: 'Samsun', latitude: 41.2928, longitude: 36.3313),
    CityCoordinate(name: 'Siirt', latitude: 37.9333, longitude: 41.9500),
    CityCoordinate(name: 'Sinop', latitude: 42.0231, longitude: 35.1531),
    CityCoordinate(name: 'Sivas', latitude: 39.7477, longitude: 37.0179),
    CityCoordinate(name: 'Tekirdağ', latitude: 40.9833, longitude: 27.5167),
    CityCoordinate(name: 'Tokat', latitude: 40.3167, longitude: 36.5500),
    CityCoordinate(name: 'Trabzon', latitude: 41.0015, longitude: 39.7178),
    CityCoordinate(name: 'Tunceli', latitude: 39.1079, longitude: 39.5401),
    CityCoordinate(name: 'Şanlıurfa', latitude: 37.1591, longitude: 38.7969),
    CityCoordinate(name: 'Uşak', latitude: 38.6823, longitude: 29.4082),
    CityCoordinate(name: 'Van', latitude: 38.4891, longitude: 43.4089),
    CityCoordinate(name: 'Yozgat', latitude: 39.8181, longitude: 34.8147),
    CityCoordinate(name: 'Zonguldak', latitude: 41.4564, longitude: 31.7987),
    CityCoordinate(name: 'Aksaray', latitude: 38.3687, longitude: 34.0370),
    CityCoordinate(name: 'Bayburt', latitude: 40.2552, longitude: 40.2249),
    CityCoordinate(name: 'Karaman', latitude: 37.1759, longitude: 33.2287),
    CityCoordinate(name: 'Kırıkkale', latitude: 39.8468, longitude: 33.5153),
    CityCoordinate(name: 'Batman', latitude: 37.8812, longitude: 41.1293),
    CityCoordinate(name: 'Şırnak', latitude: 37.5164, longitude: 42.4611),
    CityCoordinate(name: 'Bartın', latitude: 41.6344, longitude: 32.3375),
    CityCoordinate(name: 'Ardahan', latitude: 41.1105, longitude: 42.7022),
    CityCoordinate(name: 'Iğdır', latitude: 39.9167, longitude: 44.0333),
    CityCoordinate(name: 'Yalova', latitude: 40.6500, longitude: 29.2667),
    CityCoordinate(name: 'Karabük', latitude: 41.2061, longitude: 32.6204),
    CityCoordinate(name: 'Kilis', latitude: 36.7184, longitude: 37.1212),
    CityCoordinate(name: 'Osmaniye', latitude: 37.0742, longitude: 36.2467),
    CityCoordinate(name: 'Düzce', latitude: 40.8438, longitude: 31.1565),
  ];

  /// Sıfır veri/internet kullanımı ile GPS koordinatına en yakın şehri anında tespit eder
  static String findNearestCity(double lat, double lon) {
    CityCoordinate? nearest;
    double minDistance = double.infinity;

    for (final city in cities) {
      final dLat = (city.latitude - lat) * (pi / 180.0);
      final dLon = (city.longitude - lon) * (pi / 180.0);
      final a = sin(dLat / 2) * sin(dLat / 2) +
          cos(lat * (pi / 180.0)) * cos(city.latitude * (pi / 180.0)) * sin(dLon / 2) * sin(dLon / 2);
      final c = 2 * atan2(sqrt(a), sqrt(1 - a));
      final distance = 6371.0 * c;

      if (distance < minDistance) {
        minDistance = distance;
        nearest = city;
      }
    }

    if (nearest != null) {
      // Eğer il merkezine 60 km'den yakınsa doğrudan şehir adını ver
      if (minDistance <= 60) {
        return nearest.name;
      } else {
        return '${nearest.name} (${minDistance.round()} km)';
      }
    }

    return 'Konum (${lat.toStringAsFixed(2)}, ${lon.toStringAsFixed(2)})';
  }
}
