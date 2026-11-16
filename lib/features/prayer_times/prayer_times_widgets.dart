import 'package:flutter/material.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';
import 'prayer_times_model.dart';

class KerahatBadge extends StatelessWidget {
  final String message;

  const KerahatBadge({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: SukunColors.leafAmberAccent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: SukunColors.leafAmberAccent, width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: SukunColors.leafAmberAccent, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Kerahat Vakti: $message (Namaz kılınması mekruhtur)',
              style: const TextStyle(
                color: SukunColors.leafAmberAccent,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SeferiBadge extends StatelessWidget {
  final VoidCallback onTap;

  const SeferiBadge({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: SukunColors.emeraldPrimary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: SukunColors.emeraldPrimary, width: 1),
        ),
        child: const Row(
          children: [
            Icon(Icons.directions_walk_rounded, color: SukunColors.emeraldPrimary, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Seferi Modu Aktif (Evden 90+ km uzaklaştınız)',
                style: TextStyle(
                  color: SukunColors.emeraldPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: SukunColors.emeraldPrimary, size: 18),
          ],
        ),
      ),
    );
  }
}

class PrayerTimesHorizontalGrid extends StatelessWidget {
  final PrayerDayTimes prayerTimes;

  const PrayerTimesHorizontalGrid({
    super.key,
    required this.prayerTimes,
  });

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    final current = prayerTimes.currentPrayer;

    return SukunSurfaceCard(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: PrayerType.values.map((type) {
          final isCurrent = type == current;
          final timeStr = _formatTime(prayerTimes.getTime(type));

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: isCurrent ? SukunColors.emeraldPrimary.withValues(alpha: 0.2) : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: isCurrent ? Border.all(color: SukunColors.emeraldPrimary, width: 1) : null,
            ),
            child: Column(
              children: [
                Text(
                  type.label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                    color: isCurrent ? SukunColors.emeraldPrimary : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  timeStr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFeatures: const [FontFeature.tabularFigures()],
                    color: isCurrent ? SukunColors.goldAccent : null,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
