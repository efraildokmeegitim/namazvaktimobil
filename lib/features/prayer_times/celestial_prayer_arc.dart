import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/theme/sukun_theme.dart';
import 'prayer_times_model.dart';

class CelestialPrayerArc extends StatelessWidget {
  final PrayerDayTimes prayerTimes;

  const CelestialPrayerArc({
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
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const RadialGradient(
          center: Alignment(0, -0.4),
          radius: 1.2,
          colors: [
            Color(0xFF1B3830), // Deep emerald glow
            Color(0xFF0C1715),
            Color(0xFF060B0A),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: SukunColors.goldAccent.withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: SukunColors.emeraldPrimary.withValues(alpha: 0.15),
            blurRadius: 32,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Location & Hijri Date with subtle pill
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: SukunColors.emeraldPrimary.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.location_on_rounded, size: 14, color: SukunColors.emeraldPrimary),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    prayerTimes.locationName,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.white),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: SukunColors.goldAccent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: SukunColors.goldAccent.withValues(alpha: 0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.nightlight_round, size: 12, color: SukunColors.goldAccent),
                    const SizedBox(width: 6),
                    Text(
                      prayerTimes.hijriDate,
                      style: const TextStyle(color: SukunColors.goldAccent, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Arc Visualization & Center Time
          SizedBox(
            height: 160,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(260, 150),
                  painter: _SunArcPainter(progress: prayerTimes.sunProgress),
                ),
                Positioned(
                  bottom: 12,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: SukunColors.goldAccent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${next.label.toUpperCase()} VAKTİNE',
                          style: const TextStyle(
                            color: SukunColors.goldAccent,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _formatDuration(remaining),
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -1.5,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                      Text(
                        'Saat: ${_formatTime(prayerTimes.getTime(next))}',
                        style: const TextStyle(color: Colors.white60, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 6 Prayer Times Horizontal Strip with Glassmorphism
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: PrayerType.values.map((type) {
                final isCurrent = type == current;
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    decoration: BoxDecoration(
                      color: isCurrent ? SukunColors.emeraldPrimary.withValues(alpha: 0.25) : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: isCurrent ? Border.all(color: SukunColors.emeraldPrimary, width: 1.2) : null,
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
                          fontWeight: FontWeight.w800,
                          fontFeatures: const [FontFeature.tabularFigures()],
                          color: isCurrent ? SukunColors.goldAccent : Colors.white,
                        ),
                      ),
                    ],
                  ),
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

class _SunArcPainter extends CustomPainter {
  final double progress; // 0.0 to 1.0

  const _SunArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width * 0.44;

    // Background track arc
    final bgPaint = Paint()
      ..color = Colors.white12
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      pi,
      false,
      bgPaint,
    );

    // Active illuminated sun arc
    final activePaint = Paint()
      ..shader = const LinearGradient(
        colors: [SukunColors.emeraldPrimary, SukunColors.goldAccent],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;

    final sweepAngle = pi * progress.clamp(0.0, 1.0);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      sweepAngle,
      false,
      activePaint,
    );

    // Sun knob position on the arc
    final angle = pi + sweepAngle;
    final sunX = center.dx + radius * cos(angle);
    final sunY = center.dy + radius * sin(angle);

    final sunGlow = Paint()
      ..color = SukunColors.goldAccent.withValues(alpha: 0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(Offset(sunX, sunY), 10, sunGlow);

    final sunKnob = Paint()..color = SukunColors.goldAccent;
    canvas.drawCircle(Offset(sunX, sunY), 6, sunKnob);

    final sunInner = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(sunX, sunY), 2.5, sunInner);
  }

  @override
  bool shouldRepaint(covariant _SunArcPainter oldDelegate) => oldDelegate.progress != progress;
}
