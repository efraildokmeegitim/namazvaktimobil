import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';
import '../prayer_times/prayer_times_model.dart';
import 'sukun_smart_engine.dart';

class SmartDailyAssistantCard extends StatelessWidget {
  final PrayerDayTimes prayerTimes;
  final bool isSafir;

  const SmartDailyAssistantCard({
    super.key,
    required this.prayerTimes,
    required this.isSafir,
  });

  @override
  Widget build(BuildContext context) {
    final recommendation = SukunSmartEngine.getRecommendation(
      times: prayerTimes,
      isSafir: isSafir,
    );

    return SukunSurfaceCard(
      enableGlass: true,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar: Icon, Tag & Badge
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: recommendation.accentColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: recommendation.accentColor.withValues(alpha: 0.4)),
                ),
                child: Icon(
                  recommendation.icon,
                  color: recommendation.accentColor,
                  size: 16,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Row(
                  children: [
                    Text(
                      'SÜKÛN AKILLI REHBER',
                      style: TextStyle(
                        color: SukunColors.goldAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      '✦ Çevrimdışı Asistan',
                      style: TextStyle(color: Colors.white38, fontSize: 10),
                    ),
                  ],
                ),
              ),
              if (recommendation.badgeText != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: recommendation.accentColor.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: recommendation.accentColor.withValues(alpha: 0.4)),
                  ),
                  child: Text(
                    recommendation.badgeText!,
                    style: TextStyle(
                      color: recommendation.accentColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Title
          Text(
            recommendation.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),

          // Subtitle / Commentary
          Text(
            recommendation.subtitle,
            style: const TextStyle(
              fontSize: 12,
              height: 1.45,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 12),

          // Action Button
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                context.push(recommendation.route);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      recommendation.accentColor.withValues(alpha: 0.25),
                      recommendation.accentColor.withValues(alpha: 0.12),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: recommendation.accentColor.withValues(alpha: 0.5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      recommendation.actionLabel,
                      style: TextStyle(
                        color: recommendation.accentColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: recommendation.accentColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
