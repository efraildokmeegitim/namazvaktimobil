import 'package:flutter/material.dart';
import '../../core/theme/sukun_theme.dart';
import 'prayer_times_model.dart';

class ModernDashboardHero extends StatelessWidget {
  final PrayerDayTimes prayerTimes;

  const ModernDashboardHero({
    super.key,
    required this.prayerTimes,
  });

  String _formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    final next = prayerTimes.nextPrayer;
    final current = prayerTimes.currentPrayer;
    final remaining = prayerTimes.timeRemainingToNext;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF142421),
            Color(0xFF0A1311),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: SukunColors.emeraldPrimary.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: SukunColors.emeraldPrimary.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top bar: Location & Hijri date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: SukunColors.emeraldPrimary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.near_me_rounded, size: 14, color: SukunColors.emeraldPrimary),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    prayerTimes.locationName,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.white),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white12),
                ),
                child: Text(
                  prayerTimes.hijriDate,
                  style: const TextStyle(color: SukunColors.goldAccent, fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          // Central countdown section
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: SukunColors.goldAccent,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${next.label.toUpperCase()} VAKTİNE KALAN',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDuration(remaining),
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -1.0,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: SukunColors.emeraldPrimary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: SukunColors.emeraldPrimary.withValues(alpha: 0.4)),
                ),
                child: Column(
                  children: [
                    const Text('Vakit Saati', style: TextStyle(fontSize: 10, color: Colors.white60)),
                    const SizedBox(height: 2),
                    Text(
                      _formatTime(prayerTimes.getTime(next)),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: SukunColors.goldAccent,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Sun progress arc bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Günlük İlerleme (Güneş Yayı)', style: TextStyle(fontSize: 10, color: Colors.white38)),
                  Text('${(prayerTimes.sunProgress * 100).toInt()}%',
                      style: const TextStyle(fontSize: 10, color: SukunColors.goldAccent, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: prayerTimes.sunProgress,
                  minHeight: 5,
                  backgroundColor: Colors.white10,
                  valueColor: const AlwaysStoppedAnimation<Color>(SukunColors.goldAccent),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 6 Prayer Times Horizontal Strip
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: PrayerType.values.map((type) {
                final isCurrent = type == current;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: isCurrent ? SukunColors.emeraldPrimary.withValues(alpha: 0.25) : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: isCurrent ? Border.all(color: SukunColors.emeraldPrimary, width: 1) : null,
                  ),
                  child: Column(
                    children: [
                      Text(
                        type.label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                          color: isCurrent ? SukunColors.emeraldPrimary : Colors.white60,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatTime(prayerTimes.getTime(type)),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          fontFeatures: const [FontFeature.tabularFigures()],
                          color: isCurrent ? SukunColors.goldAccent : Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
