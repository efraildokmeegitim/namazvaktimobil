import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
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
  final bool isGpsDetected;

  const CurrentLocationCoordinates({
    this.latitude = 41.0082, // İstanbul Fatih varsayılan
    this.longitude = 28.9784,
    this.locationName = 'İstanbul, Fatih',
    this.homeLatitude = 41.0082,
    this.homeLongitude = 28.9784,
    this.isGpsDetected = false,
  });

  CurrentLocationCoordinates copyWith({
    double? latitude,
    double? longitude,
    String? locationName,
    double? homeLatitude,
    double? homeLongitude,
    bool? isGpsDetected,
  }) {
    return CurrentLocationCoordinates(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationName: locationName ?? this.locationName,
      homeLatitude: homeLatitude ?? this.homeLatitude,
      homeLongitude: homeLongitude ?? this.homeLongitude,
      isGpsDetected: isGpsDetected ?? this.isGpsDetected,
    );
  }
}

class UserLocationNotifier extends StateNotifier<CurrentLocationCoordinates> {
  UserLocationNotifier() : super(const CurrentLocationCoordinates()) {
    detectCurrentGpsLocation();
  }

  Future<void> detectCurrentGpsLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }
      if (permission == LocationPermission.deniedForever) return;

      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: 10),
      );

      // Konum adını enleme/boylama göre biçimlendir
      final locName = 'GPS Konumu (${pos.latitude.toStringAsFixed(2)}, ${pos.longitude.toStringAsFixed(2)})';
      state = state.copyWith(
        latitude: pos.latitude,
        longitude: pos.longitude,
        locationName: locName,
        isGpsDetected: true,
      );
    } catch (_) {}
  }

  void setCustomLocation(double lat, double lon, String name) {
    state = state.copyWith(
      latitude: lat,
      longitude: lon,
      locationName: name,
      isGpsDetected: false,
    );
  }
}

final userLocationProvider = StateNotifierProvider<UserLocationNotifier, CurrentLocationCoordinates>((ref) {
  return UserLocationNotifier();
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
