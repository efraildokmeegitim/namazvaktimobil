import 'package:flutter/material.dart';
import '../theme/sukun_theme.dart';

class ContextualActionRow extends StatelessWidget {
  final bool isLiked;
  final bool isSaved;
  final VoidCallback onLike;
  final VoidCallback onSave;
  final VoidCallback onAddNote;
  final VoidCallback? onSendToTasbih;
  final VoidCallback? onSetAlarm;
  final VoidCallback onShare;

  const ContextualActionRow({
    super.key,
    this.isLiked = false,
    this.isSaved = false,
    required this.onLike,
    required this.onSave,
    required this.onAddNote,
    this.onSendToTasbih,
    this.onSetAlarm,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultIconColor = isDark ? SukunColors.carbonTextSecondary : SukunColors.nurTextSecondary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.redAccent : defaultIconColor,
                size: 20,
              ),
              onPressed: onLike,
              tooltip: 'Beğen',
            ),
            IconButton(
              icon: Icon(
                isSaved ? Icons.bookmark : Icons.bookmark_border,
                color: isSaved ? SukunColors.goldAccent : defaultIconColor,
                size: 20,
              ),
              onPressed: onSave,
              tooltip: 'Koleksiyona Kaydet',
            ),
            IconButton(
              icon: Icon(Icons.edit_note_rounded, color: defaultIconColor, size: 22),
              onPressed: onAddNote,
              tooltip: 'Bağlamsal Not Ekle',
            ),
            if (onSendToTasbih != null)
              IconButton(
                icon: Icon(Icons.fingerprint_rounded, color: defaultIconColor, size: 20),
                onPressed: onSendToTasbih,
                tooltip: 'Tesbihmatik ile Çek',
              ),
            if (onSetAlarm != null)
              IconButton(
                icon: Icon(Icons.alarm_add_rounded, color: defaultIconColor, size: 20),
                onPressed: onSetAlarm,
                tooltip: 'Alarm Kur',
              ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.share_outlined, color: defaultIconColor, size: 20),
          onPressed: onShare,
          tooltip: 'Paylaş',
        ),
      ],
    );
  }
}
