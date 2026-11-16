import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/notifications/lock_screen_prayer_notification_service.dart';
import 'prayer_calculator_service.dart';
import 'prayer_times_model.dart';

final prayerCalculatorServiceProvider = Provider<PrayerCalculatorService>((ref) {
  return PrayerCalculatorService();
});

class CurrentLocationCoordinates {
  final double latitude;
  final double longitude;
  final String locationName;
  final double homeLatitude;
  final double homeLongitude;

  const CurrentLocationCoordinates({
    this.latitude = 41.0082, // İstanbul Fatih
    this.longitude = 28.9784,
    this.locationName = 'İstanbul, Fatih',
    this.homeLatitude = 41.0082,
    this.homeLongitude = 28.9784,
  });

  CurrentLocationCoordinates copyWith({
    double? latitude,
    double? longitude,
    String? locationName,
    double? homeLatitude,
    double? homeLongitude,
  }) {
    return CurrentLocationCoordinates(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationName: locationName ?? this.locationName,
      homeLatitude: homeLatitude ?? this.homeLatitude,
      homeLongitude: homeLongitude ?? this.homeLongitude,
    );
  }
}

final userLocationProvider = StateProvider<CurrentLocationCoordinates>((ref) {
  return const CurrentLocationCoordinates();
});

// Otomatik saniyelik güncellenen anlık namaz vakti durumu
final activePrayerTimesProvider = StreamProvider<PrayerDayTimes>((ref) {
  final service = ref.watch(prayerCalculatorServiceProvider);
  final location = ref.watch(userLocationProvider);

  return Stream.periodic(const Duration(seconds: 1), (_) {
    final times = service.calculateTimes(
      latitude: location.latitude,
      longitude: location.longitude,
      date: DateTime.now(),
      locationName: location.locationName,
    );
    // Kilit ekranı bildirimini ve native widget'ları anlık besle
    LockScreenPrayerNotificationService.updateLockScreen(times);
    return times;
  });
});

final isUserSafirProvider = Provider<bool>((ref) {
  final service = ref.watch(prayerCalculatorServiceProvider);
  final loc = ref.watch(userLocationProvider);

  return service.isSafir(
    currentLat: loc.latitude,
    currentLon: loc.longitude,
    homeLat: loc.homeLatitude,
    homeLon: loc.homeLongitude,
  );
});
