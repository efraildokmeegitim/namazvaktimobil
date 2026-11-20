import 'package:flutter/material.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';

class RamadanImsakiyeWidgetCard extends StatelessWidget {
  final VoidCallback onOpenCalendar;

  const RamadanImsakiyeWidgetCard({
    super.key,
    required this.onOpenCalendar,
  });

  @override
  Widget build(BuildContext context) {
    return SukunSurfaceCard(
      enableGlass: true,
      customBackground: const Color(0xFF131D1A),
      borderColor: SukunColors.emeraldPrimary.withValues(alpha: 0.35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: SukunColors.emeraldPrimary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.star_rounded, size: 14, color: SukunColors.goldAccent),
                    ),
                    const SizedBox(width: 8),
                    const Flexible(
                      child: Text(
                        'İFTAR & SAHUR GERİ SAYIMI',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: SukunColors.emeraldPrimary,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: onOpenCalendar,
                child: const Text(
                  'İmsakiye',
                  style: TextStyle(color: SukunColors.goldAccent, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sahur (İmsak)', style: TextStyle(color: Colors.white54, fontSize: 11)),
                      SizedBox(height: 4),
                      Text(
                        '06:05',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                      Text('03 saat 21 dk kaldı', style: TextStyle(color: SukunColors.emeraldPrimary, fontSize: 10)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('İftar (Akşam)', style: TextStyle(color: Colors.white54, fontSize: 11)),
                      SizedBox(height: 4),
                      Text(
                        '18:04',
                        style: TextStyle(
                          color: SukunColors.goldAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                      Text('15 saat 20 dk kaldı', style: TextStyle(color: SukunColors.goldAccent, fontSize: 10)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
