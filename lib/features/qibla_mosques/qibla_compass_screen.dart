import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';
import '../prayer_times/prayer_times_provider.dart';
import 'qibla_calculator.dart';

class QiblaCompassScreen extends ConsumerStatefulWidget {
  const QiblaCompassScreen({super.key});

  @override
  ConsumerState<QiblaCompassScreen> createState() => _QiblaCompassScreenState();
}

class _QiblaCompassScreenState extends ConsumerState<QiblaCompassScreen> {
  static const EventChannel _compassChannel = EventChannel('com.sukun.app/compass_sensor');
  StreamSubscription? _compassSubscription;
  double _deviceHeading = 0.0;
  bool _wasAligned = false;

  @override
  void initState() {
    super.initState();
    _startListeningCompass();
  }

  void _startListeningCompass() {
    try {
      _compassSubscription = _compassChannel.receiveBroadcastStream().listen(
        (event) {
          if (event is double && mounted) {
            final location = ref.read(userLocationProvider);
            final qiblaAngle = QiblaCalculator.calculateQiblaAngle(
              userLat: location.latitude,
              userLon: location.longitude,
            );
            final diff = ((qiblaAngle - event) % 360).abs();
            final isAligned = diff <= 2.5 || (360 - diff) <= 2.5;

            if (isAligned && !_wasAligned) {
              HapticFeedback.mediumImpact();
            }
            _wasAligned = isAligned;

            setState(() {
              _deviceHeading = event;
            });
          }
        },
        onError: (err) {
          // Cihazda manyetometre yoksa veya masaüstü emülatörde sessizce düşer
        },
      );
    } catch (_) {}
  }

  @override
  void dispose() {
    _compassSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final location = ref.watch(userLocationProvider);
    final qiblaAngle = QiblaCalculator.calculateQiblaAngle(
      userLat: location.latitude,
      userLon: location.longitude,
    );
    final distanceKm = QiblaCalculator.distanceToKaabaKm(
      userLat: location.latitude,
      userLon: location.longitude,
    );

    // Difference between device heading and Qibla
    final diff = ((qiblaAngle - _deviceHeading) % 360).abs();
    final isAligned = diff <= 2.5 || (360 - diff) <= 2.5;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hassas Kıble Pusulası', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Info Card
          SukunSurfaceCard(
            enableGlass: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text('Kıble Açısı', style: TextStyle(color: Colors.white54, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(
                      '${qiblaAngle.toStringAsFixed(1)}°',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: SukunColors.goldAccent,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ),
                Container(height: 36, width: 1, color: Colors.white12),
                Column(
                  children: [
                    const Text('Kâbe Mesafesi', style: TextStyle(color: Colors.white54, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(
                      '${distanceKm.toStringAsFixed(0)} km',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: SukunColors.emeraldPrimary,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          // Compass Dial
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer ring
                Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isAligned ? SukunColors.emeraldPrimary : Colors.white12,
                      width: isAligned ? 3 : 1.5,
                    ),
                    boxShadow: isAligned
                        ? [
                            BoxShadow(
                              color: SukunColors.emeraldPrimary.withValues(alpha: 0.3),
                              blurRadius: 30,
                              spreadRadius: 4,
                            )
                          ]
                        : null,
                  ),
                ),
                // Compass Needle / Kaaba indicator
                Transform.rotate(
                  angle: (qiblaAngle - _deviceHeading) * (3.1415926535 / 180.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isAligned ? SukunColors.emeraldPrimary : SukunColors.goldAccent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.mosque_rounded, color: Colors.black, size: 24),
                      ),
                      Container(
                        width: 4,
                        height: 90,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              isAligned ? SukunColors.emeraldPrimary : SukunColors.goldAccent,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 90),
                    ],
                  ),
                ),
                // Center hub
                Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Alignment status
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color: isAligned
                  ? SukunColors.emeraldPrimary.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isAligned ? SukunColors.emeraldPrimary : Colors.white12,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isAligned ? Icons.check_circle_rounded : Icons.explore_rounded,
                  color: isAligned ? SukunColors.emeraldPrimary : Colors.white70,
                ),
                const SizedBox(width: 8),
                Text(
                  isAligned ? 'Kıbleye Tam Hizalandınız (Kâbe Yönü)' : 'Pusulayı Kâbe ikonuna doğru çevirin',
                  style: TextStyle(
                    color: isAligned ? SukunColors.emeraldPrimary : Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
