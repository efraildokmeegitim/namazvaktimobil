import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';
import '../../main.dart';
import 'erkam_book_provider.dart';

class ErkamBookScreen extends ConsumerWidget {
  const ErkamBookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagesAsync = ref.watch(erkamDuaPagesStreamProvider);
    final viewStyle = ref.watch(erkamViewStyleProvider);
    final isSepia = ref.watch(erkamSepiaModeProvider);
    final showTranslit = ref.watch(showTransliterationProvider);
    final fontSize = ref.watch(erkamFontSizeProvider);
    final actions = ref.read(erkamBookActionsProvider);

    final bgColor = isSepia
        ? SukunColors.sepiaBackground
        : (Theme.of(context).brightness == Brightness.dark
            ? SukunColors.carbonBackground
            : SukunColors.nurBackground);

    return Scaffold(
      backgroundColor: bgColor,
      drawer: _ErkamDuaDrawer(isSepia: isSepia),
      appBar: AppBar(
        leading: Builder(
          builder: (scaffoldContext) => IconButton(
            icon: const Icon(Icons.menu_book_rounded),
            tooltip: 'Dua ve Fihrist Menüsü',
            onPressed: () => Scaffold.of(scaffoldContext).openDrawer(),
          ),
        ),
        title: const Text('Dualar ve Zikirler', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(
              isSepia ? Icons.menu_book : Icons.menu_book_outlined,
              color: isSepia ? SukunColors.leafAmberAccent : null,
            ),
            tooltip: 'Sepya Kitap Kağıdı Modu',
            onPressed: () {
              ref.read(erkamSepiaModeProvider.notifier).state = !isSepia;
            },
          ),
          IconButton(
            icon: Icon(
              showTranslit ? Icons.subtitles_rounded : Icons.subtitles_off_rounded,
            ),
            tooltip: 'Türkçe Okunuşu Aç/Kapat',
            onPressed: () {
              ref.read(showTransliterationProvider.notifier).state = !showTranslit;
            },
          ),
          IconButton(
            icon: const Icon(Icons.sync_rounded),
            tooltip: 'Tüm Duaları Yenile / Eşitle',
            onPressed: () async {
              final seedLoader = ref.read(seedLoaderProvider);
              await seedLoader.reloadErkamDualar();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Dualar ve Zikirler başarıyla yenilendi.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(
              viewStyle == ErkamViewStyle.continuous
                  ? Icons.view_stream_rounded
                  : (viewStyle == ErkamViewStyle.page ? Icons.auto_stories_rounded : Icons.view_headline_rounded),
              color: SukunColors.goldAccent,
            ),
            tooltip: viewStyle == ErkamViewStyle.continuous
                ? 'Tam Akış (Kesintisiz Oku)'
                : (viewStyle == ErkamViewStyle.page ? 'Sayfa (Yakınlaştırılabilir)' : 'Kart Görünümü'),
            onPressed: () {
              final next = viewStyle == ErkamViewStyle.continuous
                  ? ErkamViewStyle.page
                  : (viewStyle == ErkamViewStyle.page ? ErkamViewStyle.block : ErkamViewStyle.continuous);
              ref.read(erkamViewStyleProvider.notifier).state = next;
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Arama Çubuğu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: TextField(
              onChanged: (val) => ref.read(erkamSearchQueryProvider.notifier).state = val,
              style: TextStyle(
                fontSize: 14,
                color: isSepia ? SukunColors.sepiaInkText : Colors.white,
              ),
              decoration: InputDecoration(
                hintText: 'Dualarda, başlıklarda veya sayfalarda ara...',
                hintStyle: TextStyle(fontSize: 13, color: isSepia ? const Color(0xFF6E583B) : Colors.white60),
                prefixIcon: Icon(Icons.search, size: 20, color: isSepia ? const Color(0xFF5A4428) : SukunColors.goldAccent),
                suffixIcon: ref.watch(erkamSearchQueryProvider).isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, size: 18, color: isSepia ? SukunColors.sepiaInkText : Colors.white70),
                        onPressed: () => ref.read(erkamSearchQueryProvider.notifier).state = '',
                      )
                    : null,
                filled: true,
                fillColor: isSepia ? const Color(0xFFDECFA9) : SukunColors.carbonCardSurface,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: isSepia ? const BorderSide(color: Color(0xFFC7B38A), width: 1) : BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: isSepia ? const BorderSide(color: Color(0xFFC7B38A), width: 1) : const BorderSide(color: Colors.white12, width: 1),
                ),
              ),
            ),
          ),
          // Kategori Filtre Çipleri
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              children: ErkamCategoryFilter.values.map((cat) {
                final isSel = ref.watch(erkamActiveCategoryProvider) == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (cat == ErkamCategoryFilter.favorites) ...[
                          Icon(Icons.star_rounded, size: 14, color: isSel ? SukunColors.goldAccent : (isSepia ? const Color(0xFF8A6D3B) : SukunColors.goldAccent)),
                          const SizedBox(width: 4),
                        ],
                        if (cat == ErkamCategoryFilter.selamAyetleri || cat == ErkamCategoryFilter.hifzAyetleri) ...[
                          Icon(Icons.shield_outlined, size: 14, color: isSel ? SukunColors.emeraldPrimary : (isSepia ? const Color(0xFF1E6F50) : SukunColors.emeraldPrimary)),
                          const SizedBox(width: 4),
                        ],
                        Text(
                          cat.label,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isSel
                                ? (isSepia ? const Color(0xFF1A140E) : Colors.white)
                                : (isSepia ? const Color(0xFF53412B) : Colors.white70),
                          ),
                        ),
                      ],
                    ),
                    selected: isSel,
                    onSelected: (_) => ref.read(erkamActiveCategoryProvider.notifier).state = cat,
                    backgroundColor: isSepia ? const Color(0xFFE4D5B3) : Colors.white.withValues(alpha: 0.05),
                    selectedColor: isSepia
                        ? const Color(0xFFCABA94)
                        : (cat == ErkamCategoryFilter.favorites
                            ? SukunColors.goldAccent.withValues(alpha: 0.25)
                            : SukunColors.emeraldPrimary.withValues(alpha: 0.25)),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: pagesAsync.when(
              data: (pages) {
                if (pages.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.auto_stories_outlined, size: 48, color: isSepia ? const Color(0xFF6E583B) : Colors.white30),
                          const SizedBox(height: 12),
                          Text(
                            'Bu kategoride kayıtlı sayfa bulunamadı.',
                            style: TextStyle(color: isSepia ? const Color(0xFF53412B) : Colors.white60),
                          ),
                        ],
                      ),
                    ),
                  );
                }

          if (viewStyle == ErkamViewStyle.continuous) {
            // Kitaptaki Bütün Sayfaların Alt Alta Sıralandığı Orijinal Kitap Akışı
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...pages.map((page) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        color: isSepia ? const Color(0xFFF9F5EA) : SukunColors.carbonCardSurface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSepia ? const Color(0xFFD8C7A5) : Colors.white12,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Kitap Üst Başlık Şeridi (Running Header / Serlevha)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSepia ? const Color(0xFFEBE0C7) : Colors.white.withValues(alpha: 0.04),
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                              border: Border(
                                bottom: BorderSide(
                                  color: isSepia ? const Color(0xFFD8C7A5) : Colors.white10,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'SÂMÎ RAMAZANOĞLU • DUALAR VE ZİKİRLER',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 10,
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.bold,
                                      color: isSepia ? const Color(0xFF5A4428) : Colors.white60,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        page.isFavorite == 1 ? Icons.star_rounded : Icons.star_border_rounded,
                                        color: isSepia ? const Color(0xFF9E782F) : SukunColors.goldAccent,
                                        size: 20,
                                      ),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () => actions.toggleFavorite(page.pageNumber, page.isFavorite == 1),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'SAYFA ${page.pageNumber}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: isSepia ? const Color(0xFF3E2C1A) : SukunColors.goldAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Kitap Sayfa İçi İçeriği
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                 Center(
                                  child: Text(
                                    page.chapterTitle,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                      color: isSepia ? const Color(0xFF2B1D0E) : SukunColors.goldAccent,
                                    ),
                                  ),
                                ),
                                if (page.subTitle != null) ...[
                                  const SizedBox(height: 6),
                                  Center(
                                    child: Text(
                                      page.subTitle!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontStyle: FontStyle.italic,
                                        color: isSepia ? const Color(0xFF4A3722) : Colors.white70,
                                      ),
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 16),
                                if (page.arabicContent != null)
                                  ArabicScriptBlock(
                                    arabicText: page.arabicContent!,
                                    transliteration: page.transliterationTr,
                                    translation: page.meaningTr,
                                    arabicFontSize: fontSize + 4,
                                    showTransliteration: showTranslit,
                                    textColor: isSepia ? const Color(0xFF1A130B) : SukunColors.carbonTextPrimary,
                                    secondaryTextColor: isSepia ? const Color(0xFF4A3722) : SukunColors.carbonTextSecondary,
                                  ),
                                if (page.arabicContent == null)
                                  Text(
                                    page.meaningTr,
                                    style: TextStyle(
                                      fontSize: fontSize,
                                      height: 1.8,
                                      color: isSepia ? const Color(0xFF1A130B) : SukunColors.carbonTextPrimary,
                                    ),
                                  ),
                                if (page.virtueAndSource != null) ...[
                                  const SizedBox(height: 14),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: isSepia ? const Color(0xFFEADFC3) : Colors.white.withValues(alpha: 0.05),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: isSepia ? const Color(0xFFD6C5A0) : Colors.white12,
                                      ),
                                    ),
                                    child: Text(
                                      'Fazilet ve Kaynak: ${page.virtueAndSource!}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontStyle: FontStyle.italic,
                                        color: isSepia ? const Color(0xFF4A3722) : Colors.white70,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          // Sayfa Alt Bilgisi (Sayfa Numarası Folio)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: isSepia ? const Color(0xFFD8C7A5) : Colors.white10,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '- ${page.pageNumber} -',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isSepia ? const Color(0xFF5A4428) : Colors.white60,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            );
          }

          if (viewStyle == ErkamViewStyle.page) {
            return PageView.builder(
              itemCount: pages.length,
              onPageChanged: (idx) => actions.updateLastRead(pages[idx].pageNumber),
              itemBuilder: (context, index) {
                final page = pages[index];
                return InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 3.5,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SukunSurfaceCard(
                      enableGlass: !isSepia,
                      customBackground: isSepia ? const Color(0xFFF9F5EA) : null,
                      borderColor: isSepia ? const Color(0xFFD8C7A5) : null,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sayfa ${page.pageNumber}',
                                  style: TextStyle(
                                    color: isSepia ? const Color(0xFF3E2C1A) : SukunColors.goldAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    page.isFavorite == 1 ? Icons.star_rounded : Icons.star_border_rounded,
                                    color: isSepia ? const Color(0xFF9E782F) : SukunColors.goldAccent,
                                  ),
                                  onPressed: () => actions.toggleFavorite(page.pageNumber, page.isFavorite == 1),
                                ),
                              ],
                            ),
                            Divider(height: 16, color: isSepia ? const Color(0xFFD8C7A5) : Colors.white12),
                            Text(
                              page.chapterTitle,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isSepia ? const Color(0xFF2B1D0E) : Colors.white,
                              ),
                            ),
                            if (page.subTitle != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                page.subTitle!,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: isSepia ? const Color(0xFF4A3722) : Colors.white70,
                                ),
                              ),
                            ],
                            const SizedBox(height: 16),
                            if (page.arabicContent != null)
                              ArabicScriptBlock(
                                arabicText: page.arabicContent!,
                                transliteration: page.transliterationTr,
                                translation: page.meaningTr,
                                arabicFontSize: fontSize + 4,
                                showTransliteration: showTranslit,
                                textColor: isSepia ? const Color(0xFF1A130B) : SukunColors.carbonTextPrimary,
                                secondaryTextColor: isSepia ? const Color(0xFF4A3722) : SukunColors.carbonTextSecondary,
                              ),
                            if (page.arabicContent == null)
                              Text(
                                page.meaningTr,
                                style: TextStyle(
                                  fontSize: fontSize,
                                  height: 1.6,
                                  color: isSepia ? const Color(0xFF1A130B) : SukunColors.carbonTextPrimary,
                                ),
                              ),
                            if (page.virtueAndSource != null) ...[
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isSepia ? const Color(0xFFEADFC3) : Colors.white.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: isSepia ? const Color(0xFFD6C5A0) : Colors.white12,
                                  ),
                                ),
                                child: Text(
                                  'Fazilet & Kaynak: ${page.virtueAndSource!}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: isSepia ? const Color(0xFF4A3722) : Colors.white70,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          // Block view
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: pages.length,
            itemBuilder: (context, index) {
              final page = pages[index];
              return SukunSurfaceCard(
                enableGlass: !isSepia,
                customBackground: isSepia ? const Color(0xFFF9F5EA) : null,
                borderColor: isSepia ? const Color(0xFFD8C7A5) : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sayfa ${page.pageNumber} • ${page.chapterTitle}',
                          style: TextStyle(
                            color: isSepia ? const Color(0xFF3E2C1A) : SukunColors.goldAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            page.isFavorite == 1 ? Icons.star_rounded : Icons.star_border_rounded,
                            color: isSepia ? const Color(0xFF9E782F) : SukunColors.goldAccent,
                            size: 20,
                          ),
                          onPressed: () => actions.toggleFavorite(page.pageNumber, page.isFavorite == 1),
                        ),
                      ],
                    ),
                    if (page.subTitle != null) ...[
                      Text(
                        page.subTitle!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSepia ? const Color(0xFF2B1D0E) : Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (page.arabicContent != null)
                      ArabicScriptBlock(
                        arabicText: page.arabicContent!,
                        transliteration: page.transliterationTr,
                        translation: page.meaningTr,
                        arabicFontSize: fontSize + 2,
                        showTransliteration: showTranslit,
                        textColor: isSepia ? const Color(0xFF1A130B) : SukunColors.carbonTextPrimary,
                        secondaryTextColor: isSepia ? const Color(0xFF4A3722) : SukunColors.carbonTextSecondary,
                      ),
                    if (page.arabicContent == null)
                      Text(
                        page.meaningTr,
                        style: TextStyle(
                          fontSize: fontSize,
                          height: 1.5,
                          color: isSepia ? const Color(0xFF1A130B) : SukunColors.carbonTextPrimary,
                        ),
                      ),
                    if (page.virtueAndSource != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSepia ? const Color(0xFFEADFC3) : Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: isSepia ? const Color(0xFFD6C5A0) : Colors.white12,
                          ),
                        ),
                        child: Text(
                          page.virtueAndSource!,
                          style: TextStyle(
                            fontSize: 11,
                            color: isSepia ? const Color(0xFF4A3722) : Colors.white70,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    ContextualActionRow(
                      isSaved: page.isFavorite == 1,
                      onLike: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${page.chapterTitle} beğenildi.')),
                        );
                      },
                      onSave: () => actions.toggleFavorite(page.pageNumber, page.isFavorite == 1),
                      onAddNote: () {},
                      onSendToTasbih: page.recommendedCount != null ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${page.chapterTitle} (${page.recommendedCount} adet) Tesbihat çekimine eklendi.')),
                        );
                      } : null,
                      onShare: () {
                        ShareStudioSheet.show(
                          context,
                          title: page.chapterTitle,
                          arabicText: page.arabicContent,
                          bodyText: page.meaningTr,
                          sourceReference: page.virtueAndSource ?? 'Erkam Dualar ve Zikirler, s.${page.pageNumber}',
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

class _ErkamDuaDrawer extends ConsumerWidget {
  final bool isSepia;

  const _ErkamDuaDrawer({required this.isSepia});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allPagesAsync = ref.watch(erkamAllPagesStreamProvider);
    final drawerSearch = ref.watch(erkamDrawerSearchQueryProvider).trim().toLowerCase();
    final activeCat = ref.watch(erkamActiveCategoryProvider);

    final drawerBg = isSepia ? const Color(0xFFF7F1E1) : SukunColors.carbonCardSurface;
    final headerBg = isSepia ? const Color(0xFFE8DBC0) : const Color(0xFF16211E);
    final primaryTextColor = isSepia ? const Color(0xFF1A130B) : SukunColors.carbonTextPrimary;
    final subTextColor = isSepia ? const Color(0xFF4A3722) : Colors.white70;

    return Drawer(
      backgroundColor: drawerBg,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Çekmece Üst Başlığı (Fihrist & Arama)
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              color: headerBg,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.auto_stories_rounded, color: SukunColors.goldAccent, size: 22),
                          const SizedBox(width: 8),
                          Text(
                            'Dua Fihristi',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded, size: 20),
                        color: primaryTextColor,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Mahmud Sâmi Ramazanoğlu (k.s.)',
                    style: TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: subTextColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Fihrist İçi Hızlı Arama
                  TextField(
                    onChanged: (val) => ref.read(erkamDrawerSearchQueryProvider.notifier).state = val,
                    style: TextStyle(fontSize: 13, color: primaryTextColor),
                    decoration: InputDecoration(
                      hintText: 'Fihristte ara...',
                      hintStyle: TextStyle(fontSize: 12, color: subTextColor),
                      prefixIcon: Icon(Icons.search_rounded, size: 18, color: SukunColors.goldAccent),
                      suffixIcon: drawerSearch.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 16),
                              onPressed: () => ref.read(erkamDrawerSearchQueryProvider.notifier).state = '',
                            )
                          : null,
                      filled: true,
                      fillColor: isSepia ? const Color(0xFFE5D7B3) : Colors.white.withValues(alpha: 0.06),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Kategori Kısayolları (Selâm, Hıfz, Favoriler)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSepia ? const Color(0xFFD8C7A5) : Colors.white10,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _QuickFilterChip(
                      label: 'Selâm Âyetleri',
                      isSelected: activeCat == ErkamCategoryFilter.selamAyetleri,
                      isSepia: isSepia,
                      icon: Icons.shield_outlined,
                      onTap: () {
                        ref.read(erkamActiveCategoryProvider.notifier).state = ErkamCategoryFilter.selamAyetleri;
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 6),
                    _QuickFilterChip(
                      label: 'Hıfz Âyetleri',
                      isSelected: activeCat == ErkamCategoryFilter.hifzAyetleri,
                      isSepia: isSepia,
                      icon: Icons.security_rounded,
                      onTap: () {
                        ref.read(erkamActiveCategoryProvider.notifier).state = ErkamCategoryFilter.hifzAyetleri;
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 6),
                    _QuickFilterChip(
                      label: 'Favoriler',
                      isSelected: activeCat == ErkamCategoryFilter.favorites,
                      isSepia: isSepia,
                      icon: Icons.star_rounded,
                      onTap: () {
                        ref.read(erkamActiveCategoryProvider.notifier).state = ErkamCategoryFilter.favorites;
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 6),
                    _QuickFilterChip(
                      label: 'Tüm Kitap',
                      isSelected: activeCat == ErkamCategoryFilter.all,
                      isSepia: isSepia,
                      icon: Icons.all_inclusive_rounded,
                      onTap: () {
                        ref.read(erkamActiveCategoryProvider.notifier).state = ErkamCategoryFilter.all;
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Fihrist Dua Listesi (Tüm Dualar Sayfa Numaralı)
            Expanded(
              child: allPagesAsync.when(
                data: (allPages) {
                  final filtered = allPages.where((p) {
                    if (drawerSearch.isEmpty) return true;
                    return p.chapterTitle.toLowerCase().contains(drawerSearch) ||
                        (p.subTitle?.toLowerCase().contains(drawerSearch) ?? false) ||
                        p.meaningTr.toLowerCase().contains(drawerSearch) ||
                        p.pageNumber.toString() == drawerSearch;
                  }).toList();

                  if (filtered.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          'Aramanıza uygun dua bulunamadı.',
                          style: TextStyle(color: subTextColor, fontSize: 13),
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      color: isSepia ? const Color(0xFFE2D4B2) : Colors.white.withValues(alpha: 0.05),
                    ),
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      final isSelam = item.pageNumber >= 160 && item.pageNumber <= 163;
                      final isHifz = item.pageNumber >= 164 && item.pageNumber <= 174;

                      return ListTile(
                        dense: true,
                        leading: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: isSepia
                                ? const Color(0xFFDCCEA6)
                                : (isSelam || isHifz
                                    ? SukunColors.emeraldPrimary.withValues(alpha: 0.15)
                                    : Colors.white.withValues(alpha: 0.06)),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelam || isHifz
                                  ? SukunColors.goldAccent.withValues(alpha: 0.5)
                                  : Colors.transparent,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            's.${item.pageNumber}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isSelam || isHifz ? SukunColors.goldAccent : primaryTextColor,
                            ),
                          ),
                        ),
                        title: Text(
                          item.subTitle ?? item.chapterTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: primaryTextColor,
                          ),
                        ),
                        subtitle: Text(
                          item.chapterTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11, color: subTextColor),
                        ),
                        trailing: Icon(
                          item.isFavorite == 1 ? Icons.star_rounded : Icons.chevron_right_rounded,
                          size: 18,
                          color: item.isFavorite == 1 ? SukunColors.goldAccent : subTextColor,
                        ),
                        onTap: () {
                          // İlgili duaya git
                          if (isSelam) {
                            ref.read(erkamActiveCategoryProvider.notifier).state = ErkamCategoryFilter.selamAyetleri;
                          } else if (isHifz) {
                            ref.read(erkamActiveCategoryProvider.notifier).state = ErkamCategoryFilter.hifzAyetleri;
                          } else {
                            ref.read(erkamActiveCategoryProvider.notifier).state = ErkamCategoryFilter.all;
                            ref.read(erkamSearchQueryProvider.notifier).state = item.pageNumber.toString();
                          }
                          Navigator.of(context).pop();
                        },
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
      ),
    );
  }
}

class _QuickFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isSepia;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickFilterChip({
    required this.label,
    required this.isSelected,
    required this.isSepia,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? (isSepia ? const Color(0xFFCABA94) : SukunColors.emeraldPrimary.withValues(alpha: 0.25))
              : (isSepia ? const Color(0xFFE5D7B3) : Colors.white.withValues(alpha: 0.05)),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? SukunColors.goldAccent
                : (isSepia ? const Color(0xFFD8C7A5) : Colors.white10),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: isSelected ? SukunColors.goldAccent : null),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected && !isSepia ? Colors.white : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
