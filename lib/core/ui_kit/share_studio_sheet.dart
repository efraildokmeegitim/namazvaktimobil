import 'package:flutter/material.dart';
import '../theme/sukun_theme.dart';
import 'sukun_surface_card.dart';

enum ShareAspectRatio {
  story(9 / 16, '9:16 Hikaye'),
  square(1 / 1, '1:1 Kare'),
  portrait(4 / 5, '4:5 Portre');

  final double ratio;
  final String label;
  const ShareAspectRatio(this.ratio, this.label);
}

class ShareStudioSheet extends StatefulWidget {
  final String title;
  final String? arabicText;
  final String bodyText;
  final String sourceReference;

  const ShareStudioSheet({
    super.key,
    required this.title,
    this.arabicText,
    required this.bodyText,
    required this.sourceReference,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    String? arabicText,
    required String bodyText,
    required String sourceReference,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ShareStudioSheet(
        title: title,
        arabicText: arabicText,
        bodyText: bodyText,
        sourceReference: sourceReference,
      ),
    );
  }

  @override
  State<ShareStudioSheet> createState() => _ShareStudioSheetState();
}

class _ShareStudioSheetState extends State<ShareStudioSheet> {
  ShareAspectRatio _selectedRatio = ShareAspectRatio.story;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? SukunColors.carbonCardSurface : SukunColors.nurCardSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Paylaşım Stüdyosu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Aspect Ratio Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ShareAspectRatio.values.map((r) {
              final isSel = r == _selectedRatio;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(r.label),
                  selected: isSel,
                  onSelected: (_) => setState(() => _selectedRatio = r),
                  selectedColor: SukunColors.emeraldPrimary.withOpacity(0.2),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          // Preview Card
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 280),
            child: AspectRatio(
              aspectRatio: _selectedRatio.ratio,
              child: SukunSurfaceCard(
                margin: EdgeInsets.zero,
                enableGlass: true,
                customBackground: SukunColors.carbonBackground,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: SukunColors.goldAccent,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (widget.arabicText != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        widget.arabicText!,
                        textAlign: TextAlign.center,
                        style: SukunTheme.arabicQuranStyle(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.8,
                        ),
                      ),
                    ],
                    const SizedBox(height: 12),
                    Text(
                      widget.bodyText,
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.4),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.sourceReference,
                      style: const TextStyle(color: Colors.white54, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: SukunColors.emeraldPrimary,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.share_rounded),
            label: const Text('Görsel Olarak Paylaş', style: TextStyle(fontWeight: FontWeight.w700)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
