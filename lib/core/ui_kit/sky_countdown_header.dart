import 'package:flutter/material.dart';
import '../theme/sukun_theme.dart';

class SkyCountdownHeader extends StatelessWidget {
  final String nextPrayerName;
  final String remainingTimeFormatted;
  final String locationText;
  final String hijriDateText;
  final double sunProgress; // 0.0 to 1.0
  final List<Color>? gradientColors;

  const SkyCountdownHeader({
    super.key,
    required this.nextPrayerName,
    required this.remainingTimeFormatted,
    required this.locationText,
    required this.hijriDateText,
    this.sunProgress = 0.5,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final colors = gradientColors ?? SukunColors.gradientDhuhr;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 20,
        right: 20,
        bottom: 24,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 16, color: Colors.white70),
                  const SizedBox(width: 4),
                  Text(
                    locationText,
                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Text(
                hijriDateText,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            '$nextPrayerName Vaktine Kalan',
            style: const TextStyle(color: Colors.white70, fontSize: 14, letterSpacing: 0.5),
          ),
          const SizedBox(height: 4),
          Text(
            remainingTimeFormatted,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.w800,
              fontFeatures: [FontFeature.tabularFigures()],
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: sunProgress.clamp(0.0, 1.0),
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation<Color>(SukunColors.goldAccent),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
