import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';
import 'quran_provider.dart';
import 'quran_audio_service.dart';
import 'mushaf_page_reader_screen.dart';

class QuranScreen extends ConsumerStatefulWidget {
  const QuranScreen({super.key});

  @override
  ConsumerState<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends ConsumerState<QuranScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isPlayingAudio = false;
  int? _activePlayingSurah;
  String _selectedReciterId = 'ismail_bicer';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openMushafPage(BuildContext context, int pageNumber) {
    ref.read(quranMushafPageNumberProvider.notifier).state = pageNumber;
    ref.read(quranLastReadPageProvider.notifier).state = pageNumber;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MushafPageReaderScreen(initialPage: pageNumber),
      ),
    );
  }

  void _togglePlayAudio(int surahNumber) async {
    if (_isPlayingAudio && _activePlayingSurah == surahNumber) {
      await QuranAudioService.stop();
      if (mounted) {
        setState(() {
          _isPlayingAudio = false;
          _activePlayingSurah = null;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _isPlayingAudio = true;
          _activePlayingSurah = surahNumber;
        });
      }
      final success = await QuranAudioService.playSurah(
        surahNumber: surahNumber,
        reciterId: _selectedReciterId,
      );
      if (!success && mounted) {
        setState(() {
          _isPlayingAudio = false;
          _activePlayingSurah = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ses akışı başlatılamadı, internet bağlantınızı kontrol edin.')),
        );
      }
    }
  }

  void _showReciterSelectionSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: SukunColors.carbonCardSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    'Kâri / Tilavet Edeni Seçin (Türk Usulü & Klasik)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                  ),
                ),
                const Divider(color: Colors.white12),
                ...QuranAudioService.reciters.map((r) {
                  final isSelected = _selectedReciterId == r['id'];
                  return ListTile(
                    leading: Icon(
                      isSelected ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                      color: isSelected ? SukunColors.emeraldPrimary : Colors.white38,
                    ),
                    title: Text(
                      r['name'] ?? '',
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? SukunColors.goldAccent : Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      r['title'] ?? '',
                      style: const TextStyle(fontSize: 12, color: Colors.white54),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedReciterId = r['id']!;
                      });
                      Navigator.pop(ctx);
                      if (_isPlayingAudio && _activePlayingSurah != null) {
                        _togglePlayAudio(_activePlayingSurah!);
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openSurahReader(BuildContext context, int surahNumber, {int? targetAyahNumber, int? startPage}) {
    ref.read(selectedSurahNumberProvider.notifier).state = surahNumber;
    ref.read(quranLastReadSurahProvider.notifier).state = surahNumber;
    if (targetAyahNumber != null) {
      ref.read(quranLastReadAyahProvider.notifier).state = targetAyahNumber;
    }
    final viewMode = ref.read(quranViewModeProvider);
    if (viewMode == QuranViewMode.mushaf && startPage != null) {
      _openMushafPage(context, startPage);
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _QuranSurahReaderScreen(initialAyahNumber: targetAyahNumber),
      ),
    );
  }

  void _showDisplaySettingsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Consumer(
          builder: (context, ref, _) {
            final arabicSize = ref.watch(quranArabicFontSizeProvider);
            final mealSize = ref.watch(quranTranslationFontSizeProvider);
            final activeFont = ref.watch(quranActiveFontFamilyProvider);

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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Icon(Icons.palette_outlined, color: SukunColors.goldAccent, size: 20),
                      SizedBox(width: 8),
                      Text('Mushaf & Metin Tercihleri', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Text('Hatt-ı Şerif (Arapça Yazı Tipi)', style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: QuranFontFamily.values.map((f) {
                      final isSel = activeFont == f;
                      return ChoiceChip(
                        label: Text(f.label, style: const TextStyle(fontSize: 12)),
                        selected: isSel,
                        selectedColor: SukunColors.emeraldPrimary.withValues(alpha: 0.3),
                        onSelected: (_) => ref.read(quranActiveFontFamilyProvider.notifier).state = f,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  Text('Arapça Hat Boyutu (${arabicSize.toInt()} pt)', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  Slider(
                    value: arabicSize,
                    min: 18,
                    max: 38,
                    divisions: 10,
                    activeColor: SukunColors.emeraldPrimary,
                    onChanged: (val) => ref.read(quranArabicFontSizeProvider.notifier).state = val,
                  ),
                  const SizedBox(height: 8),
                  Text('Türkçe Meal Boyutu (${mealSize.toInt()} pt)', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  Slider(
                    value: mealSize,
                    min: 12,
                    max: 22,
                    divisions: 10,
                    activeColor: SukunColors.goldAccent,
                    onChanged: (val) => ref.read(quranTranslationFontSizeProvider.notifier).state = val,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showOfflineDownloadSheet(BuildContext context) {
    final manager = ref.read(quranDownloadManagerProvider);
    final surahs = ref.read(quranSurahsStreamProvider).asData?.value ?? [];
    final downloadedCount = surahs.where((s) => s.isDownloadedOffline == 1).length;
    final totalDownloadedBytes = surahs.fold<int>(0, (sum, s) => sum + (s.isDownloadedOffline == 1 ? s.localStorageBytes : 0));
    final totalDownloadedMb = (totalDownloadedBytes / (1024 * 1024)).toStringAsFixed(1);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
              decoration: const BoxDecoration(
                color: SukunColors.carbonCardSurface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: EdgeInsets.only(
                top: 16,
                left: 18,
                right: 18,
                bottom: MediaQuery.of(context).padding.bottom + 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.offline_pin_rounded, color: SukunColors.emeraldPrimary, size: 22),
                          SizedBox(width: 8),
                          Text(
                            'Çevrimdışı İndirme Yöneticisi',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.close_rounded, color: Colors.white54, size: 20),
                        onPressed: () => Navigator.pop(bottomSheetContext),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Storage Info Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF141A17),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: SukunColors.emeraldPrimary.withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: SukunColors.emeraldPrimary.withAlpha(30),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.sd_storage_rounded, color: SukunColors.emeraldPrimary, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Çevrimdışı Depolama: $downloadedCount / 114 Sure',
                                style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Toplam Kullanılan Alan: $totalDownloadedMb MB (İnternetsiz Dinleme)',
                                style: const TextStyle(color: Colors.white60, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'İndirme Paketleri',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: SukunColors.emeraldPrimary),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        _buildDownloadPackageCard(
                          context: context,
                          title: '⚡ Namaz & Kısa Sureler Paketi',
                          subtitle: 'Fîl Suresi ile Nâs Suresi arası (10 Sure)',
                          sizeLabel: '~20 MB',
                          icon: Icons.flash_on_rounded,
                          accentColor: const Color(0xFFE5A93C),
                          onDownload: () async {
                            await manager.downloadNamazSurahsPackage();
                            if (bottomSheetContext.mounted) {
                              Navigator.pop(bottomSheetContext);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Namaz Sureleri (Fil - Nâs) çevrimdışı indirildi.')),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 8),
                        _buildDownloadPackageCard(
                          context: context,
                          title: '📖 30. Cüz Ezber Paketi',
                          subtitle: 'Nebe Suresi ile Nâs Suresi arası (37 Sure)',
                          sizeLabel: '~110 MB',
                          icon: Icons.menu_book_rounded,
                          accentColor: SukunColors.emeraldPrimary,
                          onDownload: () async {
                            await manager.downloadJuz30Package();
                            if (bottomSheetContext.mounted) {
                              Navigator.pop(bottomSheetContext);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('30. Cüz Ezber Paketi (78 - 114) indirildi.')),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 8),
                        _buildDownloadPackageCard(
                          context: context,
                          title: '⭐ Faziletli 10 Sure Paketi',
                          subtitle: 'Yâsîn, Mülk, Nebe, Fetih, Kehf, Vâkıa, Rahmân, Cuma...',
                          sizeLabel: '~120 MB',
                          icon: Icons.star_rounded,
                          accentColor: const Color(0xFF38BDF8),
                          onDownload: () async {
                            await manager.downloadFrequentSurahsPackage();
                            if (bottomSheetContext.mounted) {
                              Navigator.pop(bottomSheetContext);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Faziletli 10 Sure paketi çevrimdışı indirildi.')),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 8),
                        _buildDownloadPackageCard(
                          context: context,
                          title: '🕌 Tam Mushaf Hatim Paketi',
                          subtitle: '114 Surenin tamamı yüksek kaliteli kıraat',
                          sizeLabel: '~900 MB',
                          icon: Icons.library_books_rounded,
                          accentColor: const Color(0xFFA855F7),
                          onDownload: () async {
                            await manager.downloadFullQuranPackage();
                            if (bottomSheetContext.mounted) {
                              Navigator.pop(bottomSheetContext);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Tam Mushaf (114 Sure) çevrimdışı indirildi.')),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.redAccent,
                      side: const BorderSide(color: Colors.redAccent),
                      minimumSize: const Size.fromHeight(42),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.delete_sweep_rounded, size: 18),
                    label: const Text('İndirilenleri Temizle (Hafızayı Boşalt)', style: TextStyle(fontSize: 13)),
                    onPressed: () async {
                      await manager.clearOfflineStorage();
                      if (bottomSheetContext.mounted) {
                        Navigator.pop(bottomSheetContext);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tüm çevrimdışı ses dosyaları temizlendi.')),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDownloadPackageCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String sizeLabel,
    required IconData icon,
    required Color accentColor,
    required Future<void> Function() onDownload,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF19211D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withAlpha(12)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accentColor.withAlpha(30),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accentColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white60, fontSize: 11),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                sizeLabel,
                style: TextStyle(color: accentColor, fontSize: 11, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              InkWell(
                onTap: onDownload,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: accentColor.withAlpha(40),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentColor.withAlpha(80)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.download_rounded, color: accentColor, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        'İndir',
                        style: TextStyle(color: accentColor, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
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


  @override
  Widget build(BuildContext context) {
    final surahsAsync = ref.watch(quranSurahsStreamProvider);
    final lastReadSurahNum = ref.watch(quranLastReadSurahProvider);
    final lastReadAyahNum = ref.watch(quranLastReadAyahProvider);
    final searchQuery = ref.watch(quranSearchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kur\'ân-ı Kerîm', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_stories_rounded, color: SukunColors.goldAccent),
            tooltip: '604 Sayfa Mushaf-ı Şerif',
            onPressed: () {
              final lastPage = ref.read(quranLastReadPageProvider);
              _openMushafPage(context, lastPage);
            },
          ),
          IconButton(
            icon: const Icon(Icons.format_size_rounded, color: Colors.white70),
            tooltip: 'Metin & Hat Tercihleri',
            onPressed: () => _showDisplaySettingsSheet(context),
          ),
          IconButton(
            icon: const Icon(Icons.cloud_download_outlined, color: SukunColors.emeraldPrimary),
            tooltip: 'Çevrimdışı İndirici',
            onPressed: () => _showOfflineDownloadSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Son Kaldığım Yer Kahraman Kartı (Quick Continue Banner)
          surahsAsync.when(
            data: (surahs) {
              final lastSurah = surahs.firstWhere(
                (s) => s.surahNumber == lastReadSurahNum,
                orElse: () => surahs.first,
              );

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: SukunSurfaceCard(
                  enableGlass: true,
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: InkWell(
                    onTap: () {
                      final viewMode = ref.read(quranViewModeProvider);
                      if (viewMode == QuranViewMode.mushaf) {
                        final lastPage = ref.read(quranLastReadPageProvider);
                        _openMushafPage(context, lastPage > 0 ? lastPage : lastSurah.startPage);
                      } else {
                        _openSurahReader(context, lastSurah.surahNumber, targetAyahNumber: lastReadAyahNum);
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: SukunColors.emeraldPrimary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: SukunColors.emeraldPrimary.withValues(alpha: 0.3)),
                          ),
                          child: const Icon(Icons.menu_book_rounded, color: SukunColors.emeraldPrimary, size: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.bookmark_added_rounded, size: 14, color: SukunColors.goldAccent),
                                  SizedBox(width: 4),
                                  Text(
                                    'Kaldığım Yerden Devam Et',
                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: SukunColors.goldAccent),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${lastSurah.nameTr} Suresi • $lastReadAyahNum. Âyet',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              Text(
                                '${lastSurah.startPage}. Sayfa • ${lastSurah.revelationPlace}',
                                style: const TextStyle(fontSize: 11, color: Colors.white54),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: SukunColors.emeraldPrimary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Oku', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                              SizedBox(width: 2),
                              Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // 1.5. Hızlı Erişim Paneli & Sesli Tilavet Çubuğu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ActionChip(
                    avatar: const Icon(Icons.auto_stories_rounded, size: 16, color: SukunColors.goldAccent),
                    label: const Text('604 Sayfa Mushaf', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                    backgroundColor: SukunColors.carbonCardSurface,
                    side: const BorderSide(color: SukunColors.goldAccent, width: 0.8),
                    onPressed: () {
                      final lastPage = ref.read(quranLastReadPageProvider);
                      _openMushafPage(context, lastPage);
                    },
                  ),
                  const SizedBox(width: 8),
                  ActionChip(
                    avatar: Icon(
                      _isPlayingAudio ? Icons.pause_rounded : Icons.headphones_rounded,
                      size: 16,
                      color: SukunColors.emeraldPrimary,
                    ),
                    label: Text(
                      _isPlayingAudio ? 'Tilaveti Durdur' : 'Sesli Dinle (Hafız)',
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: _isPlayingAudio
                        ? SukunColors.emeraldPrimary.withValues(alpha: 0.2)
                        : SukunColors.carbonCardSurface,
                    side: const BorderSide(color: SukunColors.emeraldPrimary, width: 0.8),
                    onPressed: () {
                      final lastSurah = ref.read(quranLastReadSurahProvider);
                      _togglePlayAudio(lastSurah);
                    },
                  ),
                  const SizedBox(width: 8),
                  ActionChip(
                    avatar: const Icon(Icons.person_pin_circle_outlined, size: 16, color: Colors.white70),
                    label: Text(
                      'Kâri: ${_selectedReciterId == 'ismail_bicer' ? 'İsmail Biçer' : (_selectedReciterId == 'fatih_colak' ? 'Fatih Çollak' : (_selectedReciterId == 'ilhan_tok' ? 'İlhan Tok' : 'Mişari'))}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    backgroundColor: SukunColors.carbonCardSurface,
                    side: const BorderSide(color: Colors.white12),
                    onPressed: _showReciterSelectionSheet,
                  ),
                  const SizedBox(width: 8),
                  ActionChip(
                    avatar: const Icon(Icons.format_size_rounded, size: 16, color: Colors.white70),
                    label: const Text('Hat & Ayarlar', style: TextStyle(color: Colors.white, fontSize: 12)),
                    backgroundColor: SukunColors.carbonCardSurface,
                    side: const BorderSide(color: Colors.white12),
                    onPressed: () => _showDisplaySettingsSheet(context),
                  ),
                  const SizedBox(width: 8),
                  ActionChip(
                    avatar: const Icon(Icons.cloud_download_outlined, size: 16, color: SukunColors.emeraldPrimary),
                    label: const Text('Çevrimdışı İndir', style: TextStyle(color: Colors.white, fontSize: 12)),
                    backgroundColor: SukunColors.carbonCardSurface,
                    side: const BorderSide(color: Colors.white12),
                    onPressed: () => _showOfflineDownloadSheet(context),
                  ),
                ],
              ),
            ),
          ),

          // Canlı Oynatılan Ses Çubuğu (Mini Player)
          if (_isPlayingAudio && _activePlayingSurah != null)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: SukunColors.emeraldPrimary.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: SukunColors.emeraldPrimary.withValues(alpha: 0.4)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.volume_up_rounded, color: SukunColors.goldAccent, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$_activePlayingSurah. Sure Çalınıyor',
                          style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Kâri: ${_selectedReciterId == 'ismail_bicer' ? 'Hafız İsmail Biçer' : (_selectedReciterId == 'fatih_colak' ? 'Dr. Fatih Çollak' : (_selectedReciterId == 'ilhan_tok' ? 'Hafız İlhan Tok' : 'Mişari Râşid'))}',
                          style: const TextStyle(color: Colors.white60, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.stop_circle_rounded, color: SukunColors.goldAccent, size: 26),
                    tooltip: 'Durdur',
                    onPressed: () => _togglePlayAudio(_activePlayingSurah!),
                  ),
                ],
              ),
            ),

          // 2. Canlı Arama Kutusu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: TextField(
              onChanged: (val) => ref.read(quranSearchQueryProvider.notifier).state = val,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Sure adı, âyet meali veya numarası ara...',
                hintStyle: const TextStyle(fontSize: 13, color: Colors.white38),
                prefixIcon: const Icon(Icons.search, size: 20, color: SukunColors.emeraldPrimary),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18, color: Colors.white70),
                        onPressed: () => ref.read(quranSearchQueryProvider.notifier).state = '',
                      )
                    : null,
                filled: true,
                fillColor: SukunColors.carbonCardSurface,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white12, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white12, width: 1),
                ),
              ),
            ),
          ),

          // 3. Tab Bar (Sureler, Cüzler, Yer İmleri, Ezber Havuzu)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: SukunColors.carbonCardSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white10),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: SukunColors.emeraldPrimary.withValues(alpha: 0.25),
                border: Border.all(color: SukunColors.emeraldPrimary.withValues(alpha: 0.6)),
              ),
              labelColor: SukunColors.emeraldPrimary,
              unselectedLabelColor: Colors.white60,
              labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: 'Sureler'),
                Tab(text: 'Cüzler'),
                Tab(text: 'Yer İmleri'),
                Tab(text: 'Ezber'),
              ],
            ),
          ),

          // 4. Tab Görünümleri
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSurahListView(context),
                _buildJuzListView(context),
                _buildBookmarksView(context),
                _buildMemorizationView(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- SURE LİSTESİ ---
  Widget _buildSurahListView(BuildContext context) {
    final surahsAsync = ref.watch(quranSurahsStreamProvider);
    final searchQuery = ref.watch(quranSearchQueryProvider).trim().toLowerCase();

    return surahsAsync.when(
      data: (surahs) {
        final filtered = surahs.where((s) {
          if (searchQuery.isEmpty) return true;
          return s.nameTr.toLowerCase().contains(searchQuery) ||
              s.nameArabic.contains(searchQuery) ||
              s.meaningTr.toLowerCase().contains(searchQuery) ||
              s.surahNumber.toString() == searchQuery;
        }).toList();

        if (filtered.isEmpty) {
          return const Center(child: Text('Aradığınız kriterde sure bulunamadı.', style: TextStyle(color: Colors.white54)));
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: filtered.length,
          separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.white10),
          itemBuilder: (context, index) {
            final surah = filtered[index];

            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              onTap: () => _openSurahReader(context, surah.surahNumber, startPage: surah.startPage),
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: SukunColors.emeraldPrimary.withValues(alpha: 0.12),
                  border: Border.all(color: SukunColors.emeraldPrimary.withValues(alpha: 0.3)),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${surah.surahNumber}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: SukunColors.emeraldPrimary),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      surah.nameTr,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                    ),
                  ),
                  Text(
                    surah.nameArabic,
                    style: SukunTheme.arabicQuranStyle(fontSize: 18, color: SukunColors.goldAccent),
                  ),
                ],
              ),
              subtitle: Text(
                '${surah.revelationPlace} • ${surah.ayahCount} Âyet • ${surah.startPage}. Sayfa (${surah.meaningTr})',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11, color: Colors.white54),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      (_isPlayingAudio && _activePlayingSurah == surah.surahNumber)
                          ? Icons.pause_circle_filled_rounded
                          : Icons.play_circle_outline_rounded,
                      color: (_isPlayingAudio && _activePlayingSurah == surah.surahNumber)
                          ? SukunColors.goldAccent
                          : SukunColors.emeraldPrimary,
                      size: 26,
                    ),
                    tooltip: (_isPlayingAudio && _activePlayingSurah == surah.surahNumber)
                        ? 'Tilaveti Durdur'
                        : 'Sesli Dinle (Hafız)',
                    onPressed: () => _togglePlayAudio(surah.surahNumber),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 12),
                ],
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Hata: $e')),
    );
  }

  // --- CÜZ LİSTESİ ---
  Widget _buildJuzListView(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: 30,
      itemBuilder: (context, index) {
        final juzNum = index + 1;
        final startPage = (juzNum - 1) * 20 + 2;

        return SukunSurfaceCard(
          enableGlass: true,
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: InkWell(
            onTap: () {
              ref.read(selectedJuzNumberProvider.notifier).state = juzNum;
              ref.read(quranActiveMainTabProvider.notifier).state = QuranMainTab.juzList;
              final effectiveStartPage = juzNum == 1 ? 1 : startPage;
              final viewMode = ref.read(quranViewModeProvider);
              if (viewMode == QuranViewMode.mushaf) {
                _openMushafPage(context, effectiveStartPage);
              } else {
                _openSurahReader(context, 1);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: SukunColors.goldAccent.withValues(alpha: 0.15),
                        border: Border.all(color: SukunColors.goldAccent.withValues(alpha: 0.3)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$juzNum',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: SukunColors.goldAccent, fontSize: 13),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$juzNum. Cüz-i Şerif', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                        Text('Başlangıç Sayfası: $startPage • 20 Sayfa', style: const TextStyle(fontSize: 11, color: Colors.white54)),
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.chevron_right_rounded, color: Colors.white38),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- YER İMLERİ ---
  Widget _buildBookmarksView(BuildContext context) {
    final bookmarkedIds = ref.watch(quranBookmarkedAyahIdsProvider);
    final ayahsAsync = ref.watch(currentSurahAyahsStreamProvider);

    if (bookmarkedIds.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bookmark_border_rounded, size: 48, color: Colors.white30),
              SizedBox(height: 12),
              Text('Henüz kaydedilmiş bir âyet bulunmuyor.', style: TextStyle(color: Colors.white60)),
              SizedBox(height: 4),
              Text('Okurken âyetlerin sağındaki yer imi simgesine dokunarak buraya ekleyebilirsiniz.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white38, fontSize: 12)),
            ],
          ),
        ),
      );
    }

    return ayahsAsync.when(
      data: (ayahs) {
        final bookmarks = ayahs.where((a) => bookmarkedIds.contains(a.id)).toList();
        if (bookmarks.isEmpty) {
          return const Center(child: Text('Kayıtlı âyetler yükleniyor...', style: TextStyle(color: Colors.white54)));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: bookmarks.length,
          itemBuilder: (context, index) {
            final a = bookmarks[index];
            return SukunSurfaceCard(
              enableGlass: true,
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${a.surahNumber}. Sure • ${a.ayahNumber}. Âyet', style: const TextStyle(fontWeight: FontWeight.bold, color: SukunColors.goldAccent, fontSize: 13)),
                      IconButton(
                        icon: const Icon(Icons.bookmark_remove_rounded, color: Colors.redAccent, size: 20),
                        onPressed: () {
                          final current = Set<int>.from(ref.read(quranBookmarkedAyahIdsProvider));
                          current.remove(a.id);
                          ref.read(quranBookmarkedAyahIdsProvider.notifier).state = current;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ArabicScriptBlock(
                    arabicText: a.uthmaniText,
                    translation: a.translationTr,
                    arabicFontSize: 20,
                  ),
                ],
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Hata: $e')),
    );
  }

  // --- EZBER MODU VE HAVUZU ---
  Widget _buildMemorizationView(BuildContext context) {
    final memorizingIds = ref.watch(quranMemorizingAyahIdsProvider);
    final ayahsAsync = ref.watch(currentSurahAyahsStreamProvider);

    return ayahsAsync.when(
      data: (ayahs) {
        final memAyahs = ayahs.where((a) => memorizingIds.contains(a.id)).toList();

        if (memAyahs.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.psychology_outlined, size: 48, color: Colors.purpleAccent),
                  SizedBox(height: 12),
                  Text('Ezber havuzunuz henüz boş.', style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 4),
                  Text('Sure okuma ekranında dilediğiniz âyetleri "Ezbere Ekle" ile buraya taşıyabilir, hafıza gizleme testleri yapabilirsiniz.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white38, fontSize: 12)),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: memAyahs.length,
          itemBuilder: (context, index) {
            final a = memAyahs[index];
            final isHidden = ref.watch(quranHiddenArabicAyahIdsProvider).contains(a.id);
            final reps = ref.watch(quranAyahRepetitionCountsProvider)[a.id] ?? 0;

            return SukunSurfaceCard(
              enableGlass: true,
              margin: const EdgeInsets.symmetric(vertical: 6),
              borderColor: Colors.purpleAccent.withValues(alpha: 0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${a.surahNumber}. Sure • ${a.ayahNumber}. Âyet', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.purpleAccent, fontSize: 13)),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(isHidden ? Icons.visibility_off_rounded : Icons.visibility_rounded, color: SukunColors.goldAccent, size: 20),
                            tooltip: isHidden ? 'Arapça Metni Göster' : 'Hafızadan Oku (Metni Gizle)',
                            onPressed: () {
                              final hidden = Set<int>.from(ref.read(quranHiddenArabicAyahIdsProvider));
                              if (hidden.contains(a.id)) {
                                hidden.remove(a.id);
                              } else {
                                hidden.add(a.id);
                              }
                              ref.read(quranHiddenArabicAyahIdsProvider.notifier).state = hidden;
                            },
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.purpleAccent.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: InkWell(
                              onTap: () {
                                final map = Map<int, int>.from(ref.read(quranAyahRepetitionCountsProvider));
                                map[a.id] = (map[a.id] ?? 0) + 1;
                                ref.read(quranAyahRepetitionCountsProvider.notifier).state = map;
                              },
                              child: Text(
                                'Tekrar: $reps/10 +',
                                style: const TextStyle(color: Colors.purpleAccent, fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  if (isHidden)
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('✦ Âyeti zihninden oku, kontrol etmek için göze dokun ✦', style: TextStyle(color: Colors.purpleAccent, fontSize: 11, fontStyle: FontStyle.italic)),
                    )
                  else
                    ArabicScriptBlock(
                      arabicText: a.uthmaniText,
                      translation: a.translationTr,
                      arabicFontSize: 22,
                    ),
                ],
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Hata: $e')),
    );
  }
}

// ==========================================
// YENİ PROFESYONEL SURE OKUMA VE HATİM EKRANI
// ==========================================
class _QuranSurahReaderScreen extends ConsumerWidget {
  final int? initialAyahNumber;

  const _QuranSurahReaderScreen({this.initialAyahNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surahsAsync = ref.watch(quranSurahsStreamProvider);
    final ayahsAsync = ref.watch(currentSurahAyahsStreamProvider);
    final selectedSurah = ref.watch(selectedSurahNumberProvider);
    final viewMode = ref.watch(quranViewModeProvider);
    final arabicSize = ref.watch(quranArabicFontSizeProvider);
    final mealSize = ref.watch(quranTranslationFontSizeProvider);
    final playingAyahId = ref.watch(quranPlayingAyahIdProvider);
    final isAudioPlaying = ref.watch(quranAudioIsPlayingProvider);
    final bookmarkedIds = ref.watch(quranBookmarkedAyahIdsProvider);
    final memorizingIds = ref.watch(quranMemorizingAyahIdsProvider);

    return surahsAsync.when(
      data: (surahs) {
        final surah = surahs.firstWhere(
          (s) => s.surahNumber == selectedSurah,
          orElse: () => surahs.first,
        );

        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${surah.surahNumber}. ${surah.nameTr} Suresi', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('${surah.nameArabic} • ${surah.ayahCount} Âyet • ${surah.startPage}. Sayfa', style: const TextStyle(fontSize: 11, color: Colors.white54)),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(
                  viewMode == QuranViewMode.mushaf ? Icons.view_headline_rounded : Icons.auto_stories_rounded,
                  color: SukunColors.goldAccent,
                ),
                tooltip: viewMode == QuranViewMode.mushaf ? 'Âyet & Meal Görünümü' : 'Tam Mushaf Görünümü',
                onPressed: () {
                  ref.read(quranViewModeProvider.notifier).state =
                      viewMode == QuranViewMode.mushaf ? QuranViewMode.mealWithShortTafsir : QuranViewMode.mushaf;
                },
              ),
            ],
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 8,
              bottom: MediaQuery.of(context).padding.bottom + 8,
            ),
            decoration: const BoxDecoration(
              color: SukunColors.carbonCardSurface,
              border: Border(top: BorderSide(color: Colors.white12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isAudioPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_filled_rounded,
                        color: SukunColors.goldAccent,
                        size: 34,
                      ),
                      onPressed: () async {
                        final next = !isAudioPlaying;
                        ref.read(quranAudioIsPlayingProvider.notifier).state = next;
                        if (next) {
                          ref.read(quranPlayingAyahIdProvider.notifier).state = selectedSurah * 1000 + 1;
                          await QuranAudioService.playSurah(
                            surahNumber: selectedSurah,
                            reciterId: 'ismail_bicer',
                          );
                        } else {
                          ref.read(quranPlayingAyahIdProvider.notifier).state = null;
                          await QuranAudioService.stop();
                        }
                      },
                    ),
                    const SizedBox(width: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isAudioPlaying ? 'Tilavet Dinleniyor' : 'Sesli Dinle (Hafız)',
                          style: TextStyle(
                            color: isAudioPlaying ? SukunColors.goldAccent : Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('Hafız İsmail Biçer (Türk Usulü)', style: TextStyle(color: Colors.white38, fontSize: 10)),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (selectedSurah > 1)
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_rounded, size: 16, color: SukunColors.goldAccent),
                        tooltip: 'Önceki Sure',
                        onPressed: () {
                          ref.read(selectedSurahNumberProvider.notifier).state = selectedSurah - 1;
                        },
                      ),
                    Text('${surah.surahNumber}/114', style: const TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold)),
                    if (selectedSurah < 114)
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: SukunColors.goldAccent),
                        tooltip: 'Sonraki Sure',
                        onPressed: () {
                          ref.read(selectedSurahNumberProvider.notifier).state = selectedSurah + 1;
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
          body: ayahsAsync.when(
            data: (ayahs) {
              if (ayahs.isEmpty) {
                return const Center(child: Text('Bu sureye ait âyetler yükleniyor...', style: TextStyle(color: Colors.white54)));
              }

              // 1. TAM MUSHAF GÖRÜNÜMÜ
              if (viewMode == QuranViewMode.mushaf) {
                final joinedArabic = ayahs.map((a) => '${a.uthmaniText} ﴿${a.ayahNumber}﴾').join(' ');
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: SukunSurfaceCard(
                    enableGlass: true,
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Sure Başı Besmele-i Şerif
                        if (surah.surahNumber != 9) ...[
                          Center(
                            child: Text(
                              'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                              style: SukunTheme.arabicQuranStyle(fontSize: arabicSize + 4, color: SukunColors.goldAccent),
                            ),
                          ),
                          const Divider(height: 24, color: Colors.white12),
                        ],
                        ArabicScriptBlock(
                          arabicText: joinedArabic,
                          arabicFontSize: arabicSize + 4,
                          showTransliteration: false,
                          showTranslation: false,
                        ),
                      ],
                    ),
                  ),
                );
              }

              // 2. ÂYET BE ÂYET MEAL & TEFSİR GÖRÜNÜMÜ
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                itemCount: ayahs.length,
                itemBuilder: (context, index) {
                  final ayah = ayahs[index];
                  final isPlaying = playingAyahId == ayah.id;
                  final isSaved = bookmarkedIds.contains(ayah.id);
                  final isMem = memorizingIds.contains(ayah.id);

                  return SukunSurfaceCard(
                    enableGlass: true,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    borderColor: isPlaying ? SukunColors.emeraldPrimary : (isMem ? Colors.purpleAccent.withValues(alpha: 0.4) : null),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Üst Bilgi Satırı
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: isPlaying
                                    ? SukunColors.emeraldPrimary.withValues(alpha: 0.25)
                                    : SukunColors.goldAccent.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Âyet ${ayah.ayahNumber}',
                                style: TextStyle(
                                  color: isPlaying ? SukunColors.emeraldPrimary : SukunColors.goldAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                if (ayah.isSajdah == 1)
                                  Container(
                                    margin: const EdgeInsets.only(right: 6),
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(color: Colors.redAccent.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4)),
                                    child: const Text('Secde Âyeti', style: TextStyle(fontSize: 10, color: Colors.redAccent, fontWeight: FontWeight.bold)),
                                  ),
                                IconButton(
                                  icon: Icon(
                                    isMem ? Icons.psychology_rounded : Icons.psychology_outlined,
                                    color: isMem ? Colors.purpleAccent : Colors.white38,
                                    size: 20,
                                  ),
                                  tooltip: isMem ? 'Ezber Havuzundan Çıkar' : 'Ezber Havuzuna Ekle',
                                  onPressed: () {
                                    final current = Set<int>.from(ref.read(quranMemorizingAyahIdsProvider));
                                    if (current.contains(ayah.id)) {
                                      current.remove(ayah.id);
                                    } else {
                                      current.add(ayah.id);
                                    }
                                    ref.read(quranMemorizingAyahIdsProvider.notifier).state = current;
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                                    color: isSaved ? SukunColors.goldAccent : Colors.white38,
                                    size: 20,
                                  ),
                                  tooltip: isSaved ? 'Yer İmini Kaldır' : 'Yer İmlerine Ekle',
                                  onPressed: () {
                                    final current = Set<int>.from(ref.read(quranBookmarkedAyahIdsProvider));
                                    if (current.contains(ayah.id)) {
                                      current.remove(ayah.id);
                                    } else {
                                      current.add(ayah.id);
                                    }
                                    ref.read(quranBookmarkedAyahIdsProvider.notifier).state = current;
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Arapça Metin ve Meal
                        ArabicScriptBlock(
                          arabicText: ayah.uthmaniText,
                          translation: ayah.translationTr,
                          arabicFontSize: arabicSize,
                          showTransliteration: false,
                        ),
                        if (ayah.shortTafsirTr != null) ...[
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.04),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Muhtasar Tefsir: ${ayah.shortTafsirTr!}',
                              style: TextStyle(fontSize: mealSize - 2, fontStyle: FontStyle.italic, color: SukunColors.carbonTextSecondary),
                            ),
                          ),
                        ],
                        const SizedBox(height: 8),
                        ContextualActionRow(
                          isSaved: isSaved,
                          onLike: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${surah.nameTr} ${ayah.ayahNumber}. Âyet beğenildi.')),
                            );
                          },
                          onSave: () {
                            final current = Set<int>.from(ref.read(quranBookmarkedAyahIdsProvider));
                            if (current.contains(ayah.id)) {
                              current.remove(ayah.id);
                            } else {
                              current.add(ayah.id);
                            }
                            ref.read(quranBookmarkedAyahIdsProvider.notifier).state = current;
                          },
                          onAddNote: () {},
                          onShare: () {
                            ShareStudioSheet.show(
                              context,
                              title: '${surah.nameTr} Suresi • ${ayah.ayahNumber}. Âyet',
                              arabicText: ayah.uthmaniText,
                              bodyText: ayah.translationTr,
                              sourceReference: 'Kur\'ân-ı Kerîm, ${ayah.mushafPage}. Sayfa',
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Hata: $e')),
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Hata: $e'))),
    );
  }
}
