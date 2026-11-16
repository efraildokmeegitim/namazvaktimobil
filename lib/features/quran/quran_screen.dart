import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';
import 'quran_provider.dart';

class QuranScreen extends ConsumerWidget {
  const QuranScreen({super.key});

  void _showDisplaySettingsSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Consumer(
          builder: (context, ref, _) {
            final arabicSize = ref.watch(quranArabicFontSizeProvider);
            final mealSize = ref.watch(quranTranslationFontSizeProvider);

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
                  const Text('Metin & Okuma Tercihleri', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
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

  void _showOfflineDownloadSheet(BuildContext context, WidgetRef ref) {
    final manager = ref.read(quranDownloadManagerProvider);

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
              const Text(
                'Çevrimdışı Sure & Ses İndirme Yöneticisi',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: SukunColors.emeraldPrimary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(44),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.download_rounded),
                label: const Text('Sık Okunan Sureler Paketini İndir (~96 MB)'),
                onPressed: () async {
                  await manager.downloadFrequentSurahsPackage();
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sık okunan sureler çevrimdışı kullanım için hazırlandı.')),
                    );
                  }
                },
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                  side: const BorderSide(color: Colors.redAccent),
                  minimumSize: const Size.fromHeight(44),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.delete_outline_rounded),
                label: const Text('İndirilen Ses Verilerini Temizle'),
                onPressed: () async {
                  await manager.clearOfflineStorage();
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Çevrimdışı hafıza temizlendi.')),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surahsAsync = ref.watch(quranSurahsStreamProvider);
    final ayahsAsync = ref.watch(currentSurahAyahsStreamProvider);
    final selectedSurah = ref.watch(selectedSurahNumberProvider);
    final viewMode = ref.watch(quranViewModeProvider);
    final arabicSize = ref.watch(quranArabicFontSizeProvider);
    final mealSize = ref.watch(quranTranslationFontSizeProvider);
    final playingAyahId = ref.watch(quranPlayingAyahIdProvider);
    final searchQuery = ref.watch(quranSearchQueryProvider);

    final activeTab = ref.watch(quranActiveMainTabProvider);
    final bookmarkedIds = ref.watch(quranBookmarkedAyahIdsProvider);
    final selectedJuz = ref.watch(selectedJuzNumberProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kur\'ân-ı Kerîm', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.format_size_rounded, color: SukunColors.goldAccent),
            tooltip: 'Yazı Boyutları',
            onPressed: () => _showDisplaySettingsSheet(context, ref),
          ),
          IconButton(
            icon: const Icon(Icons.cloud_download_outlined, color: SukunColors.emeraldPrimary),
            tooltip: 'Çevrimdışı İndirme Yöneticisi',
            onPressed: () => _showOfflineDownloadSheet(context, ref),
          ),
          IconButton(
            icon: Icon(
              viewMode == QuranViewMode.mealWithShortTafsir ? Icons.auto_stories : Icons.menu_book,
              color: SukunColors.goldAccent,
            ),
            tooltip: viewMode == QuranViewMode.mealWithShortTafsir ? 'Mushaf Görünümü' : 'Meal & Tefsir Görünümü',
            onPressed: () {
              ref.read(quranViewModeProvider.notifier).state =
                  viewMode == QuranViewMode.mealWithShortTafsir
                      ? QuranViewMode.mushaf
                      : QuranViewMode.mealWithShortTafsir;
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Segmented Navigation: Sureler, Cüzler, Yer İmleri, Ezber
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    label: const Text('Sureler', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    selected: activeTab == QuranMainTab.surahList,
                    onSelected: (_) => ref.read(quranActiveMainTabProvider.notifier).state = QuranMainTab.surahList,
                    selectedColor: SukunColors.emeraldPrimary.withValues(alpha: 0.25),
                  ),
                  const SizedBox(width: 6),
                  ChoiceChip(
                    label: const Text('Cüzler', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    selected: activeTab == QuranMainTab.juzList,
                    onSelected: (_) => ref.read(quranActiveMainTabProvider.notifier).state = QuranMainTab.juzList,
                    selectedColor: SukunColors.emeraldPrimary.withValues(alpha: 0.25),
                  ),
                  const SizedBox(width: 6),
                  ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.bookmark_rounded, size: 14, color: SukunColors.goldAccent),
                        const SizedBox(width: 4),
                        Text('Yer İmleri (${bookmarkedIds.length})', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    selected: activeTab == QuranMainTab.bookmarks,
                    onSelected: (_) => ref.read(quranActiveMainTabProvider.notifier).state = QuranMainTab.bookmarks,
                    selectedColor: SukunColors.goldAccent.withValues(alpha: 0.25),
                  ),
                  const SizedBox(width: 6),
                  Consumer(
                    builder: (context, ref, _) {
                      final memCount = ref.watch(quranMemorizingAyahIdsProvider).length;
                      return ChoiceChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.psychology_rounded, size: 14, color: Colors.purpleAccent),
                            const SizedBox(width: 4),
                            Text('Ezber Havuzu ($memCount)', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        selected: activeTab == QuranMainTab.memorization,
                        onSelected: (_) => ref.read(quranActiveMainTabProvider.notifier).state = QuranMainTab.memorization,
                        selectedColor: Colors.purpleAccent.withValues(alpha: 0.25),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Arama Çubuğu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: TextField(
              onChanged: (val) => ref.read(quranSearchQueryProvider.notifier).state = val,
              decoration: InputDecoration(
                hintText: activeTab == QuranMainTab.bookmarks
                    ? 'Kaydedilen âyetlerde ara...'
                    : (activeTab == QuranMainTab.memorization
                        ? 'Ezberlenen âyetlerde ara...'
                        : 'Âyet meali, tefsir veya numara ara...'),
                hintStyle: const TextStyle(fontSize: 13, color: Colors.white38),
                prefixIcon: const Icon(Icons.search, size: 20, color: SukunColors.emeraldPrimary),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () => ref.read(quranSearchQueryProvider.notifier).state = '',
                      )
                    : null,
                filled: true,
                fillColor: SukunColors.carbonCardSurface,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Sure veya Cüz Seçici
          if (activeTab == QuranMainTab.surahList)
            surahsAsync.when(
              data: (surahs) {
                return SizedBox(
                  height: 48,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    itemCount: surahs.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final s = surahs[index];
                      final isSel = s.surahNumber == selectedSurah;

                      return ChoiceChip(
                        label: Text('${s.surahNumber}. ${s.nameTr} (${s.nameArabic})'),
                        selected: isSel,
                        onSelected: (_) {
                          ref.read(selectedSurahNumberProvider.notifier).state = s.surahNumber;
                        },
                        selectedColor: SukunColors.emeraldPrimary.withValues(alpha: 0.2),
                      );
                    },
                  ),
                );
              },
              loading: () => const SizedBox(height: 48),
              error: (_, __) => const SizedBox(height: 48),
            )
          else if (activeTab == QuranMainTab.juzList)
            SizedBox(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                itemCount: 30,
                itemBuilder: (context, idx) {
                  final juzNum = idx + 1;
                  final isSel = juzNum == selectedJuz;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text('$juzNum. Cüz'),
                      selected: isSel,
                      onSelected: (_) {
                        ref.read(selectedJuzNumberProvider.notifier).state = juzNum;
                      },
                      selectedColor: SukunColors.emeraldPrimary.withValues(alpha: 0.25),
                    ),
                  );
                },
              ),
            ),
          // Aktif Sure Bilgi Bandı
          surahsAsync.when(
            data: (surahs) {
              final active = surahs.firstWhere(
                (s) => s.surahNumber == selectedSurah,
                orElse: () => surahs.first,
              );
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: SukunColors.carbonCardSurface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.menu_book_rounded, size: 16, color: SukunColors.goldAccent),
                        const SizedBox(width: 8),
                        Text(
                          '${active.nameTr} Suresi • ${active.ayahCount} Âyet',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                    Text(
                      '${active.revelationPlace} • ${active.startPage}. Sayfa',
                      style: const TextStyle(fontSize: 11, color: Colors.white54),
                    ),
                  ],
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: ayahsAsync.when(
              data: (ayahs) {
                if (ayahs.isEmpty) {
                  return const Center(child: Text('Âyet bulunamadı.'));
                }

                if (viewMode == QuranViewMode.mushaf) {
                  // Continuous Mushaf text view with Hayrat Tevâfuk Renklendirmesi
                  final joinedArabic = ayahs.map((a) => '${a.uthmaniText} ﴿${a.ayahNumber}﴾').join(' ');
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: SukunSurfaceCard(
                      enableGlass: true,
                      margin: EdgeInsets.zero,
                      padding: const EdgeInsets.all(24),
                      child: ArabicScriptBlock(
                        arabicText: joinedArabic,
                        arabicFontSize: arabicSize + 4,
                        showTransliteration: false,
                        showTranslation: false,
                      ),
                    ),
                  );
                }

                // Ayah-by-ayah Meal & Short Tafsir view
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 24),
                  itemCount: ayahs.length,
                  itemBuilder: (context, index) {
                    final ayah = ayahs[index];
                    final isPlaying = playingAyahId == ayah.id;

                    return SukunSurfaceCard(
                      enableGlass: true,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: isPlaying
                                          ? SukunColors.emeraldPrimary.withValues(alpha: 0.2)
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
                                  if (ayah.isSajdah == 1) ...[
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text(
                                        'Secde Âyeti',
                                        style: TextStyle(color: Colors.redAccent, fontSize: 10, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_outline_rounded,
                                      color: isPlaying ? SukunColors.emeraldPrimary : Colors.white60,
                                      size: 24,
                                    ),
                                    tooltip: isPlaying ? 'Durdur' : 'Tilâveti Dinle',
                                    onPressed: () {
                                      ref.read(quranPlayingAyahIdProvider.notifier).state =
                                          isPlaying ? null : ayah.id;
                                    },
                                  ),
                                  Text(
                                    '${ayah.juzNumber}. Cüz • ${ayah.mushafPage}. Sayfa',
                                    style: const TextStyle(color: Colors.white38, fontSize: 11),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Ezber Modu Özel Kontrolü (Gizle/Göster & Tekrar Sayacı)
                          Consumer(
                            builder: (context, ref, _) {
                              final memorizingSet = ref.watch(quranMemorizingAyahIdsProvider);
                              final hiddenSet = ref.watch(quranHiddenArabicAyahIdsProvider);
                              final repMap = ref.watch(quranAyahRepetitionCountsProvider);
                              final isMemorizing = memorizingSet.contains(ayah.id);
                              final isHidden = hiddenSet.contains(ayah.id);
                              final repCount = repMap[ayah.id] ?? 0;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isMemorizing
                                      ? Colors.purpleAccent.withValues(alpha: 0.12)
                                      : Colors.white.withValues(alpha: 0.03),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isMemorizing
                                        ? Colors.purpleAccent.withValues(alpha: 0.3)
                                        : Colors.white10,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        final current = Set<int>.from(ref.read(quranMemorizingAyahIdsProvider));
                                        if (current.contains(ayah.id)) {
                                          current.remove(ayah.id);
                                        } else {
                                          current.add(ayah.id);
                                        }
                                        ref.read(quranMemorizingAyahIdsProvider.notifier).state = current;
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            isMemorizing ? Icons.check_circle_rounded : Icons.add_circle_outline_rounded,
                                            size: 16,
                                            color: isMemorizing ? Colors.purpleAccent : Colors.white60,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            isMemorizing ? 'Ezber Havuzunda' : 'Ezbere Ekle',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: isMemorizing ? Colors.purpleAccent : Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isMemorizing)
                                      Row(
                                        children: [
                                          // Metni Gizle/Aç (Hafıza Testi)
                                          InkWell(
                                            onTap: () {
                                              final hidden = Set<int>.from(ref.read(quranHiddenArabicAyahIdsProvider));
                                              if (hidden.contains(ayah.id)) {
                                                hidden.remove(ayah.id);
                                              } else {
                                                hidden.add(ayah.id);
                                              }
                                              ref.read(quranHiddenArabicAyahIdsProvider.notifier).state = hidden;
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: Colors.white10,
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    isHidden ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                                    size: 13,
                                                    color: SukunColors.goldAccent,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    isHidden ? 'Aç' : 'Gizle',
                                                    style: const TextStyle(fontSize: 10, color: SukunColors.goldAccent),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          // Tekrar Sayacı (Örn: 33 tekrar)
                                          InkWell(
                                            onTap: () {
                                              final reps = Map<int, int>.from(ref.read(quranAyahRepetitionCountsProvider));
                                              reps[ayah.id] = (reps[ayah.id] ?? 0) + 1;
                                              ref.read(quranAyahRepetitionCountsProvider.notifier).state = reps;
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: Colors.purpleAccent.withValues(alpha: 0.25),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                'Tekrar: $repCount/10',
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.purpleAccent,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Consumer(
                            builder: (context, ref, _) {
                              final isHidden = ref.watch(quranHiddenArabicAyahIdsProvider).contains(ayah.id);
                              if (isHidden) {
                                return Container(
                                  height: 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.purpleAccent.withValues(alpha: 0.2)),
                                  ),
                                  child: const Text(
                                    '✦ Hafızadan Oku (Açmak için "Aç" butonuna dokun) ✦',
                                    style: TextStyle(fontSize: 12, color: Colors.purpleAccent, fontStyle: FontStyle.italic),
                                  ),
                                );
                              }
                              return ArabicScriptBlock(
                                arabicText: ayah.uthmaniText,
                                showTransliteration: false,
                                translation: ayah.translationTr,
                                arabicFontSize: arabicSize,
                              );
                            },
                          ),
                          if (ayah.shortTafsirTr != null) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.04),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Muhtasar Tefsir: ${ayah.shortTafsirTr!}',
                                style: TextStyle(
                                  fontSize: mealSize - 2,
                                  fontStyle: FontStyle.italic,
                                  color: SukunColors.carbonTextSecondary,
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(height: 8),
                          ContextualActionRow(
                            isSaved: bookmarkedIds.contains(ayah.id),
                            onLike: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${ayah.surahNumber}. Sure ${ayah.ayahNumber}. Âyet beğenildi.')),
                              );
                            },
                            onSave: () {
                              final current = ref.read(quranBookmarkedAyahIdsProvider);
                              final updated = Set<int>.from(current);
                              final wasSaved = updated.contains(ayah.id);
                              if (wasSaved) {
                                updated.remove(ayah.id);
                              } else {
                                updated.add(ayah.id);
                              }
                              ref.read(quranBookmarkedAyahIdsProvider.notifier).state = updated;

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    wasSaved
                                        ? '${ayah.surahNumber}. Sure ${ayah.ayahNumber}. Âyet yer imlerinden kaldırıldı.'
                                        : '${ayah.surahNumber}. Sure ${ayah.ayahNumber}. Âyet yer imlerine eklendi.',
                                  ),
                                ),
                              );
                            },
                            onAddNote: () {},
                            onShare: () {
                              ShareStudioSheet.show(
                                context,
                                title: '${ayah.surahNumber}. Sure ${ayah.ayahNumber}. Âyet',
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
          ),
        ],
      ),
    );
  }
}
