import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/sukun_theme.dart';
import 'quran_provider.dart';
import 'quran_audio_service.dart';

/// 604 Sayfalık Orijinal Diyanet / Hayrat Tertibi Mushaf Sayfa Okuyucusu
class MushafPageReaderScreen extends ConsumerStatefulWidget {
  final int initialPage;

  const MushafPageReaderScreen({super.key, this.initialPage = 1});

  @override
  ConsumerState<MushafPageReaderScreen> createState() => _MushafPageReaderScreenState();
}

class _MushafPageReaderScreenState extends ConsumerState<MushafPageReaderScreen> {
  late PageController _pageController;
  late int _currentPage;
  bool _showControls = true;
  bool _isPlayingAudio = false;
  String _selectedReciterId = 'ismail_bicer';

  // Ezber Tekrar Sayacı (Sure & Sayfa bazlı ezber modu)
  bool _showEzberCounter = false;
  final Map<int, int> _pageRepeatCounts = {}; // sayfa -> tekrar sayısı

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage.clamp(1, 604);
    // 0-indexed PageController: page 1 -> index 0
    _pageController = PageController(initialPage: _currentPage - 1);
    _loadRepeatCounts();
  }

  Future<void> _loadRepeatCounts() async {
    final prefs = await SharedPreferences.getInstance();
    final count = prefs.getInt('mushaf_repeat_page_$_currentPage') ?? 0;
    if (mounted) {
      setState(() {
        _pageRepeatCounts[_currentPage] = count;
      });
    }
  }

  Future<void> _incrementRepeat() async {
    HapticFeedback.mediumImpact();
    final newCount = (_pageRepeatCounts[_currentPage] ?? 0) + 1;
    setState(() {
      _pageRepeatCounts[_currentPage] = newCount;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('mushaf_repeat_page_$_currentPage', newCount);
  }

  Future<void> _resetRepeat() async {
    setState(() {
      _pageRepeatCounts[_currentPage] = 0;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('mushaf_repeat_page_$_currentPage', 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    final pageNum = index + 1;
    setState(() {
      _currentPage = pageNum;
    });
    ref.read(quranMushafPageNumberProvider.notifier).state = pageNum;
    ref.read(quranLastReadPageProvider.notifier).state = pageNum;
    _loadRepeatCounts();
  }

  void _jumpToPage(int pageNum) {
    final clamped = pageNum.clamp(1, 604);
    _pageController.jumpToPage(clamped - 1);
  }

  void _showNavigationDrawer(Mushaf604Data mushafData) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return DefaultTabController(
          length: 2,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: const BoxDecoration(
              color: SukunColors.carbonCardSurface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
                  ),
                ),
                const SizedBox(height: 12),
                const TabBar(
                  indicatorColor: SukunColors.goldAccent,
                  labelColor: SukunColors.goldAccent,
                  unselectedLabelColor: Colors.white60,
                  tabs: [
                    Tab(icon: Icon(Icons.list_alt_rounded, size: 20), text: 'Sureler (1-114)'),
                    Tab(icon: Icon(Icons.menu_book_rounded, size: 20), text: 'Cüzler (1-30)'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // Sureler Listesi
                      ListView.separated(
                        itemCount: mushafData.surahs.length,
                        separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.white10),
                        itemBuilder: (c, idx) {
                          final s = mushafData.surahs[idx];
                          final isCurrent = s.startPage <= _currentPage &&
                              (idx == mushafData.surahs.length - 1 || mushafData.surahs[idx + 1].startPage > _currentPage);

                          return ListTile(
                            dense: true,
                            leading: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isCurrent ? SukunColors.goldAccent.withValues(alpha: 0.2) : Colors.white10,
                                border: Border.all(color: isCurrent ? SukunColors.goldAccent : Colors.transparent),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${s.surahNumber}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isCurrent ? SukunColors.goldAccent : Colors.white70,
                                ),
                              ),
                            ),
                            title: Row(
                              children: [
                                Text(s.nameTr, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)),
                                const Spacer(),
                                Text(s.nameArabic, style: SukunTheme.arabicQuranStyle(fontSize: 18, color: SukunColors.goldAccent)),
                              ],
                            ),
                            subtitle: Text('${s.ayahCount} Âyet • ${s.revelationPlace} • Sayfa ${s.startPage}', style: const TextStyle(fontSize: 11, color: Colors.white54)),
                            onTap: () {
                              Navigator.pop(ctx);
                              _jumpToPage(s.startPage);
                            },
                          );
                        },
                      ),
                      // Cüzler Listesi
                      ListView.builder(
                        itemCount: 30,
                        itemBuilder: (c, idx) {
                          final juzNum = idx + 1;
                          final startP = mushafData.getPageForJuz(juzNum);
                          final isCurrent = (_currentPage >= startP && _currentPage < startP + 20) || (juzNum == 30 && _currentPage >= startP);

                          return ListTile(
                            dense: true,
                            leading: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: isCurrent ? SukunColors.emeraldPrimary.withValues(alpha: 0.2) : Colors.white10,
                                border: Border.all(color: isCurrent ? SukunColors.emeraldPrimary : Colors.transparent),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '$juzNum',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isCurrent ? SukunColors.emeraldPrimary : Colors.white70,
                                ),
                              ),
                            ),
                            title: Text('$juzNum. Cüz-i Şerif', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                            subtitle: Text('Başlangıç Sayfası: $startP • 20 Sayfa', style: const TextStyle(fontSize: 11, color: Colors.white54)),
                            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.white38),
                            onTap: () {
                              Navigator.pop(ctx);
                              _jumpToPage(startP);
                            },
                          );
                        },
                      ),
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

  void _showPageJumpDialog() {
    final controller = TextEditingController(text: '$_currentPage');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: SukunColors.carbonCardSurface,
        title: const Text('Sayfaya Git', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          style: const TextStyle(color: Colors.white, fontSize: 18),
          decoration: InputDecoration(
            hintText: '1 - 604 arası sayfa girin',
            hintStyle: const TextStyle(color: Colors.white38),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: SukunColors.goldAccent)),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('İptal', style: TextStyle(color: Colors.white54))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: SukunColors.goldAccent, foregroundColor: Colors.black),
            onPressed: () {
              final target = int.tryParse(controller.text.trim());
              if (target != null && target >= 1 && target <= 604) {
                Navigator.pop(ctx);
                _jumpToPage(target);
              }
            },
            child: const Text('Git'),
          ),
        ],
      ),
    );
  }

  void _togglePlayAudio(int surahNumber) async {
    if (_isPlayingAudio) {
      await QuranAudioService.stop();
      if (mounted) setState(() => _isPlayingAudio = false);
    } else {
      if (mounted) setState(() => _isPlayingAudio = true);
      final success = await QuranAudioService.playSurah(
        surahNumber: surahNumber,
        reciterId: _selectedReciterId,
      );
      if (!success && mounted) {
        setState(() => _isPlayingAudio = false);
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
                      if (_isPlayingAudio) {
                        QuranAudioService.stop();
                        setState(() => _isPlayingAudio = false);
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

  @override
  Widget build(BuildContext context) {
    final mushafDataAsync = ref.watch(mushaf604DataProvider);
    final isSepia = ref.watch(quranMushafSepiaModeProvider);
    final fontScale = ref.watch(quranMushafFontSizeMultiplierProvider);

    return Scaffold(
      backgroundColor: isSepia ? const Color(0xFFF4ECD8) : SukunColors.carbonBackground,
      body: mushafDataAsync.when(
        data: (mushafData) {
          // Bulunulan sayfanın âyetleri ve sure bilgisi
          final pageVerses = mushafData.pages[_currentPage] ?? [];
          final firstVerse = pageVerses.isNotEmpty ? pageVerses.first : null;
          final currentJuz = firstVerse?.juzNumber ?? 1;
          final currentSurahNum = firstVerse?.surahNumber ?? 1;
          final currentSurahMeta = mushafData.surahs.firstWhere(
            (s) => s.surahNumber == currentSurahNum,
            orElse: () => mushafData.surahs.first,
          );

          return SafeArea(
            child: Stack(
              children: [
                // 1. ANA MUSHAF SAYFALARI (Horizontal PageView - RTL Mushaf Yönü)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showControls = !_showControls;
                    });
                  },
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 604,
                    reverse: true, // Saftan sola Mushaf tarzı çevirme
                    onPageChanged: _onPageChanged,
                    itemBuilder: (context, index) {
                      final pageNum = index + 1;
                      final verses = mushafData.pages[pageNum] ?? [];
                      return _MushafPageItem(
                        pageNumber: pageNum,
                        verses: verses,
                        surahs: mushafData.surahs,
                        isSepia: isSepia,
                        fontScale: fontScale,
                      );
                    },
                  ),
                ),

                // 2. ÜST SERLEVHA BAR (Animasyonlu Gizle/Göster)
                if (_showControls)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: (isSepia ? const Color(0xFFE8DFC8) : SukunColors.carbonCardSurface).withValues(alpha: 0.94),
                        border: Border(
                          bottom: BorderSide(
                            color: isSepia ? const Color(0xFFD4C8A8) : Colors.white12,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_rounded, color: isSepia ? Colors.black87 : Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () => _showNavigationDrawer(mushafData),
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${currentSurahMeta.surahNumber}. ${currentSurahMeta.nameTr} Suresi',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: isSepia ? const Color(0xFF2C2416) : Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: SukunColors.goldAccent),
                                      ],
                                    ),
                                    Text(
                                      '$currentJuz. Cüz • Sayfa $_currentPage / 604',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: isSepia ? const Color(0xFF7A6A50) : Colors.white54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Sesli Tilavet Oynat / Durdur (Türk Kariler & Klasik)
                          IconButton(
                            icon: Icon(
                              _isPlayingAudio ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                              color: SukunColors.goldAccent,
                              size: 26,
                            ),
                            tooltip: _isPlayingAudio ? 'Tilaveti Durdur' : 'Sesli Dinle (Hafız)',
                            onPressed: () => _togglePlayAudio(currentSurahNum),
                          ),
                          // Kâri Seçimi
                          IconButton(
                            icon: Icon(Icons.person_pin_circle_outlined, color: isSepia ? Colors.black87 : Colors.white),
                            tooltip: 'Kâri Seç (İsmail Biçer, Fatih Çollak...)',
                            onPressed: _showReciterSelectionSheet,
                          ),
                          // Sepya Kağıt Modu / Koyu OLED Modu
                          IconButton(
                            icon: Icon(
                              isSepia ? Icons.dark_mode_rounded : Icons.menu_book_rounded,
                              color: SukunColors.goldAccent,
                            ),
                            tooltip: isSepia ? 'Gece Modu' : 'Sepya Mushaf Kağıdı',
                            onPressed: () {
                              ref.read(quranMushafSepiaModeProvider.notifier).state = !isSepia;
                            },
                          ),
                          // Fihrist / Sayfaya Atla
                          IconButton(
                            icon: Icon(Icons.pin_outlined, color: isSepia ? Colors.black87 : Colors.white),
                            tooltip: 'Sayfaya Atla',
                            onPressed: _showPageJumpDialog,
                          ),
                          // Ezber & Tekrar Sayacı Aç/Kapa
                          IconButton(
                            icon: Icon(
                              _showEzberCounter ? Icons.replay_circle_filled_rounded : Icons.repeat_rounded,
                              color: _showEzberCounter ? SukunColors.emeraldPrimary : (isSepia ? Colors.black87 : Colors.white),
                            ),
                            tooltip: _showEzberCounter ? 'Ezber Sayacını Gizle' : 'Ezber & Tekrar Sayacını Aç',
                            onPressed: () {
                              setState(() {
                                _showEzberCounter = !_showEzberCounter;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.format_list_bulleted_rounded, color: isSepia ? Colors.black87 : Colors.white),
                            tooltip: 'Sure & Cüz Fihristi',
                            onPressed: () => _showNavigationDrawer(mushafData),
                          ),
                        ],
                      ),
                    ),
                  ),

                // 3. ALT HIZLI SAYFA KAYDIRICI & GEZİNME (Animasyonlu Gizle/Göster)
                if (_showControls)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: (isSepia ? const Color(0xFFE8DFC8) : SukunColors.carbonCardSurface).withValues(alpha: 0.94),
                        border: Border(
                          top: BorderSide(
                            color: isSepia ? const Color(0xFFD4C8A8) : Colors.white12,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Sayfa $_currentPage',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: isSepia ? const Color(0xFF2C2416) : SukunColors.goldAccent,
                                ),
                              ),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 3,
                                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                                  ),
                                  child: Slider(
                                    value: _currentPage.toDouble(),
                                    min: 1,
                                    max: 604,
                                    divisions: 603,
                                    activeColor: SukunColors.goldAccent,
                                    inactiveColor: isSepia ? const Color(0xFFD4C8A8) : Colors.white24,
                                    onChanged: (val) {
                                      _jumpToPage(val.toInt());
                                    },
                                  ),
                                ),
                              ),
                              Text(
                                '604',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSepia ? const Color(0xFF7A6A50) : Colors.white54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                // 4. EZBER & TEKRAR SAYACI (Kullanıcının her okuduğunda 1 artırdığı yüzen sayaç rozeti)
                if (_showEzberCounter)
                  Positioned(
                    right: 16,
                    bottom: _showControls ? 90 : 28,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: SukunColors.carbonCardSurface.withValues(alpha: 0.96),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: SukunColors.emeraldPrimary, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: SukunColors.emeraldPrimary.withValues(alpha: 0.3),
                            blurRadius: 16,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.repeat_rounded, color: SukunColors.goldAccent, size: 16),
                              const SizedBox(width: 6),
                              Text(
                                '${currentSurahMeta.nameTr} / S.$_currentPage',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: _resetRepeat,
                                child: const Icon(Icons.refresh_rounded, color: Colors.white38, size: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Tekrar Artırma Butonu
                          InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: _incrementRepeat,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                              decoration: BoxDecoration(
                                color: SukunColors.emeraldPrimary.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: SukunColors.emeraldPrimary.withValues(alpha: 0.5)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${_pageRepeatCounts[_currentPage] ?? 0}',
                                    style: const TextStyle(
                                      color: SukunColors.goldAccent,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w900,
                                      fontFeatures: [FontFeature.tabularFigures()],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'TEKRAR',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                      Text(
                                        '+1 Say (Tıkla)',
                                        style: TextStyle(color: SukunColors.emeraldPrimary, fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: SukunColors.goldAccent),
              SizedBox(height: 16),
              Text(
                '604 Sayfa Mushaf-ı Şerif Yükleniyor...',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ),
        error: (err, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Mushaf verisi yüklenemedi: $err', style: const TextStyle(color: Colors.redAccent)),
          ),
        ),
      ),
    );
  }
}

/// Tek Bir Fiziksel Mushaf Sayfası Bileşeni (Geleneksel Diyanet / Hayrat Çerçeve & Hat Düzeni)
class _MushafPageItem extends StatelessWidget {
  final int pageNumber;
  final List<MushafVerse> verses;
  final List<MushafSurahMeta> surahs;
  final bool isSepia;
  final double fontScale;

  const _MushafPageItem({
    required this.pageNumber,
    required this.verses,
    required this.surahs,
    required this.isSepia,
    required this.fontScale,
  });

  @override
  Widget build(BuildContext context) {
    if (verses.isEmpty) {
      return const Center(child: Text('Sayfa boş', style: TextStyle(color: Colors.white38)));
    }

    final firstVerse = verses.first;
    final juzNum = firstVerse.juzNumber;
    final surahNum = firstVerse.surahNumber;
    final surahMeta = surahs.firstWhere(
      (s) => s.surahNumber == surahNum,
      orElse: () => surahs.first,
    );

    final bgColor = isSepia ? const Color(0xFFFFFDF9) : const Color(0xFF0F1513);
    final borderColor = isSepia ? const Color(0xFF8B0000) : SukunColors.goldAccent.withValues(alpha: 0.65); // Bordo Diyanet Çerçevesi
    final outerBorderColor = isSepia ? const Color(0xFFC59B4B) : Colors.white12; // Altın Dış Çerçeve
    final textColor = isSepia ? const Color(0xFF141414) : SukunColors.carbonTextPrimary;
    final headerTextColor = isSepia ? const Color(0xFF7A1C1C) : SukunColors.goldAccent;

    return InteractiveViewer(
      minScale: 1.0,
      maxScale: 2.8,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: outerBorderColor, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isSepia ? 0.08 : 0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: borderColor, width: 1.8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ÜST SERLEVHA (Cüz No - Sure Adı)
                Container(
                  padding: const EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: borderColor.withValues(alpha: 0.4))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'الجزء $juzNum  •  $juzNum. Cüz',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: headerTextColor,
                          fontFamily: 'ScheherazadeNew',
                        ),
                      ),
                      Text(
                        'سورة ${surahMeta.nameArabic}  (${surahMeta.nameTr})',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: headerTextColor,
                          fontFamily: 'ScheherazadeNew',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),

                // METİN GÖVDESİ (15 Satır Klasik Tertip veya Sayfa Akışı)
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _buildPageBody(context, verses, surahs, textColor, headerTextColor),
                      ),
                    ),
                  ),
                ),

                // ALT BİLGİ & SAYFA NUMARASI
                Container(
                  padding: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: borderColor.withValues(alpha: 0.4))),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '— $pageNumber —',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: headerTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageBody(
    BuildContext context,
    List<MushafVerse> verses,
    List<MushafSurahMeta> allSurahs,
    Color textColor,
    Color accentColor,
  ) {
    final widgets = <Widget>[];

    int currentSurah = -1;
    final currentAyahSpans = <InlineSpan>[];

    void flushSpans() {
      if (currentAyahSpans.isNotEmpty) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text.rich(
              TextSpan(
                style: SukunTheme.arabicQuranStyle(
                  fontSize: 22 * fontScale,
                  height: 2.3,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ).copyWith(color: textColor),
                children: List.from(currentAyahSpans),
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        );
        currentAyahSpans.clear();
      }
    }

    for (final v in verses) {
      if (v.surahNumber != currentSurah) {
        flushSpans();
        currentSurah = v.surahNumber;

        final surahInfo = allSurahs.firstWhere(
          (s) => s.surahNumber == currentSurah,
          orElse: () => allSurahs.first,
        );

        if (v.ayahNumber == 1) {
          widgets.add(_buildDiyanetSurahHeader(surahInfo));
          if (currentSurah != 9 && currentSurah != 1) {
            widgets.add(_buildDiyanetBasmalah(fontScale));
          }
        }
      }

      // Âyet metni ve sonundaki altın renkli Diyanet dairesel durağı
      final spans = _buildDiyanetVerseSpans(v.text, v.ayahNumber, textColor, fontScale);
      currentAyahSpans.addAll(spans);
    }

    flushSpans();
    return widgets;
  }

  /// Diyanet Mushafı Orijinal Süslü Sure Başlığı Levhası
  Widget _buildDiyanetSurahHeader(MushafSurahMeta meta) {
    final mekkeliMedineli = meta.revelationPlace.contains('Mek') ? 'مَكِّيَّةٌ' : 'مَدَنِيَّةٌ';
    final ayetCountStr = _toArabicAyahWord(meta.ayahCount);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFC59B4B), // Altın Yaldız Fon
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFF8B0000), width: 3.5), // Bordo Dış Çerçeve
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFC59B4B), width: 2), // Altın Ara Çerçeve
          gradient: const LinearGradient(
            colors: [Color(0xFF28559A), Color(0xFFC0392B), Color(0xFF28559A)], // Lacivert & Kırmızı Rumi Tezhip Efekti
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFC9A250), // İç Altın Yazı Alanı
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFF8B0000), width: 1.5),
          ),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'سُورَةُ ${meta.nameArabic}  $mekkeliMedineli',
                style: SukunTheme.arabicQuranStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textDirection: TextDirection.rtl,
              ),
              Text(
                'وَهِيَ $ayetCountStr',
                style: SukunTheme.arabicQuranStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Diyanet Mushafı Orijinal Besmele-i Şerif (Uzatılmış Keşideli Hat ve Pembe/Kırmızı Lafzatullah)
  Widget _buildDiyanetBasmalah(double fontScale) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Text.rich(
            TextSpan(
              style: SukunTheme.arabicQuranStyle(
                fontSize: 22 * fontScale,
                height: 1.8,
                color: const Color(0xFF1B1B1B),
              ),
              children: const [
                TextSpan(text: 'بِسْمِ '),
                TextSpan(
                  text: 'اللّٰهِ ',
                  style: TextStyle(
                    color: Color(0xFFE91E63), // Pembe/Kırmızı Diyanet Lafzatullah Rengi
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: 'الرَّحْمٰنِ الرَّح۪يمِ'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Diyanet Mushafı Âyet Metni ve Altın Dairesel Durak Rozeti
  List<InlineSpan> _buildDiyanetVerseSpans(
    String rawText,
    int ayahNumber,
    Color defaultTextColor,
    double fontScale,
  ) {
    final spans = <InlineSpan>[];

    // Âyet sonundaki mevcut rakamları ayıkla
    final trimmed = rawText.trim();
    final digitsMatch = RegExp(r'[\u0660-\u0669\d]+$').firstMatch(trimmed);
    final verseBody = (digitsMatch != null
            ? trimmed.substring(0, digitsMatch.start).trim()
            : trimmed)
        .replaceAll(RegExp(r'[﴿﴾]'), '')
        .trim();

    final words = verseBody.split(' ');
    for (int i = 0; i < words.length; i++) {
      final w = words[i];
      final isLastWord = i == words.length - 1;
      final space = isLastWord ? '' : ' ';

      // Lafzatullah kontrolü (Diyanet baskısında pembe/kırmızı harf)
      final isLafzatullah = w.contains('اللّٰ') || w.contains('للّٰ') || w.contains('للَّ') || w.contains('لله') || w.contains('ٱللَّ');

      // Üst vakıf işaretleri kontrolü (Secavendler: ط, ج, ز, ص, لا, م, قلى, صلى)
      // Bu işaretler Diyanet Mushafında küçük kırmızı veya pembe harflerle kelimenin üzerine konulur
      if (isLafzatullah) {
        spans.add(
          TextSpan(
            text: '$w$space',
            style: const TextStyle(
              color: Color(0xFFE91E63), // Diyanet Pembe/Kırmızı Lafzatullah
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: '$w$space',
            style: TextStyle(color: defaultTextColor),
          ),
        );
      }
    }

    // Diyanet Altın Dairesel Âyet Sonu Rozeti (Ornate Golden Roundel)
    final arabicIndicNumber = _toArabicIndic(ayahNumber);
    spans.add(
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 22 * fontScale,
          height: 22 * fontScale,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFB58D3D), // Diyanet Mat Altın Yaldız Rengi
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 1, offset: Offset(0, 1)),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            arabicIndicNumber,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11 * fontScale,
              fontWeight: FontWeight.bold,
              fontFamily: 'ScheherazadeNew',
              height: 1.0,
            ),
          ),
        ),
      ),
    );

    spans.add(const TextSpan(text: ' '));
    return spans;
  }

  static String _toArabicIndic(int number) {
    const digits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    final s = number.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final code = s.codeUnitAt(i) - 48;
      if (code >= 0 && code <= 9) {
        buffer.write(digits[code]);
      } else {
        buffer.write(s[i]);
      }
    }
    return buffer.toString();
  }

  static String _toArabicAyahWord(int count) {
    switch (count) {
      case 3:
        return 'ثَلَاثُ آيَاتٍ';
      case 4:
        return 'أَرْبَعُ آيَاتٍ';
      case 5:
        return 'خَمْسُ آيَاتٍ';
      case 6:
        return 'سِتُّ آيَاتٍ';
      case 7:
        return 'سَبْعُ آيَاتٍ';
      case 8:
        return 'ثَمَانِي آيَاتٍ';
      case 9:
        return 'تِسْعُ آيَاتٍ';
      case 10:
        return 'عَشْرُ آيَاتٍ';
      case 11:
        return 'إِحْدَى عَشْرَةَ آيَةً';
      default:
        return '$count آيَةً';
    }
  }
}
