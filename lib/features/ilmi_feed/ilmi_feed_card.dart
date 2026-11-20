import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/app_database.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';
import 'ilmi_feed_provider.dart';

class IlmiFeedCard extends ConsumerWidget {
  final IlmiFeedItem item;
  final bool isFullScreen;

  const IlmiFeedCard({
    super.key,
    required this.item,
    this.isFullScreen = false,
  });

  String _getCategoryTitle(String cat) {
    switch (cat) {
      case 'fikih':
        return 'FIKIH & İLMİHÂL';
      case 'hadis':
        return 'HADİS-İ ŞERİF';
      case 'ayet':
        return 'ÂYET-İ KERÎME';
      case 'siyer':
        return 'SİYER-İ NEBÎ';
      case 'kelam':
        return 'KELÂM & AKAİD';
      case 'ozlu_soz':
        return 'HİKMETLİ SÖZ';
      case 'kitap_alintisi':
        return 'KİTAP PASAJI';
      case 'tasavvuf':
        return 'TASAVVUF & KALBÎ HAYAT';
      case 'nefs_terbiyesi':
        return 'NEFS TERBİYESİ & TEZKİYE';
      case 'ahlak_adab':
        return 'İSLÂM AHLÂKI & ADÂB';
      default:
        return cat.toUpperCase();
    }
  }

  IconData _getCategoryIcon(String cat) {
    switch (cat) {
      case 'fikih':
        return Icons.balance_rounded;
      case 'hadis':
        return Icons.format_quote_rounded;
      case 'ayet':
        return Icons.menu_book_rounded;
      case 'siyer':
        return Icons.history_edu_rounded;
      case 'kelam':
        return Icons.psychology_alt_rounded;
      case 'ozlu_soz':
        return Icons.lightbulb_outline_rounded;
      case 'kitap_alintisi':
        return Icons.bookmark_outline_rounded;
      case 'tasavvuf':
        return Icons.favorite_border_rounded;
      case 'nefs_terbiyesi':
        return Icons.self_improvement_rounded;
      case 'ahlak_adab':
        return Icons.verified_user_outlined;
      default:
        return Icons.auto_stories_rounded;
    }
  }

  void _showCommentarySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          decoration: const BoxDecoration(
            color: SukunColors.carbonCardSurface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).padding.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(_getCategoryIcon(item.category), color: SukunColors.goldAccent, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      _getCategoryTitle(item.category),
                      style: const TextStyle(
                        color: SukunColors.goldAccent,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (item.title != null)
                  Text(
                    item.title!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(height: 14),
                if (item.arabicText != null) ...[
                  ArabicScriptBlock(
                    arabicText: item.arabicText!,
                    showTransliteration: false,
                    showTranslation: false,
                  ),
                  const SizedBox(height: 14),
                ],
                const Text(
                  'Özet & Temel Mesaj',
                  style: TextStyle(
                    color: SukunColors.emeraldPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.summaryBody,
                  style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
                ),
                const Divider(height: 28, color: Colors.white12),
                const Text(
                  'Kapsamlı Şerh ve İzah',
                  style: TextStyle(
                    color: SukunColors.emeraldPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.detailedCommentary ?? item.summaryBody,
                  style: const TextStyle(
                    color: SukunColors.carbonTextPrimary,
                    fontSize: 15,
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.authorOrScholar != null) ...[
                        Text(
                          'Müellif / Râvi / Âlim: ${item.authorOrScholar!}',
                          style: const TextStyle(color: SukunColors.goldAccent, fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                      ],
                      Text(
                        'Kaynak: ${item.sourceReference}',
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      if (item.bookPageRef != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Referans Sayfa: ${item.bookPageRef!}',
                          style: const TextStyle(color: Colors.white54, fontSize: 11),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = ref.read(ilmiFeedActionsProvider);

    final cardContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isFullScreen ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(_getCategoryIcon(item.category), color: SukunColors.goldAccent, size: 16),
                const SizedBox(width: 6),
                Text(
                  _getCategoryTitle(item.category),
                  style: const TextStyle(
                    color: SukunColors.goldAccent,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
            if (item.readingTimeSec > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${item.readingTimeSec} sn',
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ),
          ],
        ),
        if (item.title != null) ...[
          const SizedBox(height: 10),
          Text(
            item.title!,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.2,
            ),
          ),
        ],
        if (item.arabicText != null) ...[
          const SizedBox(height: 12),
          ArabicScriptBlock(
            arabicText: item.arabicText!,
            showTransliteration: false,
            showTranslation: false,
            arabicFontSize: isFullScreen ? 22 : 18,
          ),
        ],
        const SizedBox(height: 12),
        Text(
          item.summaryBody,
          style: const TextStyle(
            fontSize: 14,
            height: 1.5,
            color: SukunColors.carbonTextPrimary,
          ),
        ),
        const SizedBox(height: 12),
        // Action row: Şerhi Oku + Kaynak Badge
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => _showCommentarySheet(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: SukunColors.emeraldPrimary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: SukunColors.emeraldPrimary.withValues(alpha: 0.4)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.menu_book_rounded, color: SukunColors.emeraldPrimary, size: 14),
                    SizedBox(width: 6),
                    Text(
                      'Şerhi Oku / Derinleş',
                      style: TextStyle(
                        color: SukunColors.emeraldPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward_rounded, color: SukunColors.emeraldPrimary, size: 12),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Text(
                item.sourceReference,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: SukunColors.carbonTextSecondary, fontSize: 11),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(height: 1, color: Colors.white12),
        ContextualActionRow(
          isLiked: item.isLiked == 1,
          isSaved: item.isLiked == 1,
          onLike: () => actions.toggleLike(item.id, item.isLiked == 1),
          onSave: () {
            actions.toggleLike(item.id, item.isLiked == 1);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(item.isLiked == 1 ? 'Kart favorilerden çıkarıldı.' : 'Kart ilmi koleksiyonunuza kaydedildi.'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          onAddNote: () {},
          onShare: () {
            ShareStudioSheet.show(
              context,
              title: item.title ?? _getCategoryTitle(item.category),
              arabicText: item.arabicText,
              bodyText: item.summaryBody,
              sourceReference: item.sourceReference,
            );
          },
        ),
      ],
    );

    if (isFullScreen) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SukunSurfaceCard(
            enableGlass: true,
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.all(22),
            child: cardContent,
          ),
        ),
      );
    }

    return SukunSurfaceCard(
      enableGlass: true,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      child: cardContent,
    );
  }
}
