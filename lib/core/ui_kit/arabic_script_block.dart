import 'package:flutter/material.dart';
import '../theme/sukun_theme.dart';

class ArabicScriptBlock extends StatelessWidget {
  final String arabicText;
  final String? transliteration;
  final String? translation;
  final double arabicFontSize;
  final bool showTransliteration;
  final bool showTranslation;
  final Color? textColor;

  const ArabicScriptBlock({
    super.key,
    required this.arabicText,
    this.transliteration,
    this.translation,
    this.arabicFontSize = 24.0,
    this.showTransliteration = true,
    this.showTranslation = true,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor = textColor ?? (isDark ? SukunColors.carbonTextPrimary : SukunColors.nurTextPrimary);
    final secondaryTextColor = isDark ? SukunColors.carbonTextSecondary : SukunColors.nurTextSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Arabic Calligraphy / Hayrat Tevâfuk & Nesih Style Colored Script
        Directionality(
          textDirection: TextDirection.rtl,
          child: RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
              style: SukunTheme.arabicQuranStyle(
                fontSize: arabicFontSize,
                height: 2.1,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
              children: _buildHayratStyleColoredSpans(arabicText, primaryTextColor),
            ),
          ),
        ),
        if (showTransliteration && transliteration != null && transliteration!.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            transliteration!,
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: secondaryTextColor,
              height: 1.4,
            ),
          ),
        ],
        if (showTranslation && translation != null && translation!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            translation!,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: primaryTextColor,
              height: 1.5,
            ),
          ),
        ],
      ],
    );
  }

  /// Hayrat Neşriyat Tevâfuklu Kur'ân-ı Kerîm tarzı renklendirme:
  /// - 'Allah', 'Lillâh', 'Rab' lafızları: Hayrat Kırmızı (Crimson Red: #D32F2F)
  /// - Âyet sonu durak ve süs parantezleri ﴿...﴾: Altın Sarısı (Gold: #D4AF37)
  /// - Ana metin: Canlı Nur/Karbon kontrast siyahı
  static List<TextSpan> _buildHayratStyleColoredSpans(String text, Color baseColor) {
    final spans = <TextSpan>[];
    final words = text.split(' ');

    for (int i = 0; i < words.length; i++) {
      final word = words[i];
      final isLast = i == words.length - 1;
      final suffix = isLast ? '' : ' ';

      // Lafzatullah / Tevâfuk kontrolü (الله, لِلَّهِ, بِاللَّهِ, رَبِّ vb.)
      final isLafzatullah = word.contains('اللَّ') ||
          word.contains('الله') ||
          word.contains('لِلَّهِ') ||
          word.contains('بِاللَّهِ') ||
          word.contains('وَاللَّهُ') ||
          word.contains('فَاللَّهُ');

      final isAyetBracket = word.contains('﴿') || word.contains('﴾');

      if (isLafzatullah) {
        spans.add(
          TextSpan(
            text: '$word$suffix',
            style: const TextStyle(
              color: Color(0xFFE53935), // Hayrat Tevâfuk Canlı Kırmızı
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else if (isAyetBracket) {
        spans.add(
          TextSpan(
            text: '$word$suffix',
            style: const TextStyle(
              color: Color(0xFFD4AF37), // Hayrat Altın Yaldız Durak
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: '$word$suffix',
            style: TextStyle(color: baseColor),
          ),
        );
      }
    }

    return spans;
  }
}
