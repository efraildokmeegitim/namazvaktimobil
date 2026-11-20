import 'package:flutter/material.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';

class DailyWisdomWidgetCard extends StatelessWidget {
  final VoidCallback onExploreFeed;
  final VoidCallback onShare;

  const DailyWisdomWidgetCard({
    super.key,
    required this.onExploreFeed,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return SukunSurfaceCard(
      enableGlass: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        color: SukunColors.goldAccent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.lightbulb_rounded, size: 14, color: SukunColors.goldAccent),
                    ),
                    const SizedBox(width: 8),
                    const Flexible(
                      child: Text(
                        'GÜNÜN HİKMETLİ SÖZÜ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: SukunColors.goldAccent,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              InkWell(
                onTap: onExploreFeed,
                borderRadius: BorderRadius.circular(12),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Tümünü Gör',
                        style: TextStyle(color: SukunColors.emeraldPrimary, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded, size: 10, color: SukunColors.emeraldPrimary),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '"Vakit bir kılıç gibidir; eğer sen onu hayırla kesmezsen, o seni kesip tüketir. Nefsini hakla meşgul etmezsen batıl seni işgal eder."',
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              height: 1.5,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '— İmam Şâfiî (r.a.) • Medâricü\'s-Sâlikîn',
                style: TextStyle(color: Colors.white54, fontSize: 11),
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined, size: 16, color: Colors.white60),
                onPressed: onShare,
                tooltip: 'Hikmet Kartını Paylaş',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
