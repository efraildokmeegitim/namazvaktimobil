import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';
import 'ilmi_feed_card.dart';
import 'ilmi_feed_provider.dart';

class IlmiFeedScreen extends ConsumerWidget {
  const IlmiFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewMode = ref.watch(feedViewModeProvider);
    final selectedCategory = ref.watch(selectedFeedCategoryProvider);
    final searchQuery = ref.watch(ilmiFeedSearchQueryProvider);
    final favoritesOnly = ref.watch(ilmiFeedFavoritesOnlyProvider);
    final feedAsync = ref.watch(ilmiFeedStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('İlmi Akış', style: TextStyle(fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            icon: Icon(
              favoritesOnly ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              color: favoritesOnly ? SukunColors.goldAccent : Colors.white70,
            ),
            tooltip: favoritesOnly ? 'Tüm Kartları Göster' : 'Yalnızca Kaydedilenler',
            onPressed: () {
              ref.read(ilmiFeedFavoritesOnlyProvider.notifier).state = !favoritesOnly;
            },
          ),
          IconButton(
            icon: Icon(
              viewMode == FeedViewMode.list ? Icons.view_carousel_rounded : Icons.view_agenda_rounded,
              color: SukunColors.goldAccent,
            ),
            tooltip: viewMode == FeedViewMode.list ? 'Tam Ekran Dikey Kaydırma (Reels)' : 'Klasik Liste Görünümü',
            onPressed: () {
              ref.read(feedViewModeProvider.notifier).state =
                  viewMode == FeedViewMode.list ? FeedViewMode.reels : FeedViewMode.list;
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(104),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Canlı İlmi Arama Kutusu
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: TextField(
                  onChanged: (val) => ref.read(ilmiFeedSearchQueryProvider.notifier).state = val,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Ayet, hadis, fıkıh veya tefsirlerde ara...',
                    hintStyle: const TextStyle(fontSize: 12, color: Colors.white38),
                    prefixIcon: const Icon(Icons.search, size: 18, color: SukunColors.emeraldPrimary),
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 16, color: Colors.white70),
                            onPressed: () => ref.read(ilmiFeedSearchQueryProvider.notifier).state = '',
                          )
                        : null,
                    filled: true,
                    fillColor: SukunColors.carbonCardSurface,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white10),
                    ),
                  ),
                ),
              ),
              // Kategori Filtreleri
              CategoryFilterChips(
                categories: const [
                  'all',
                  'ayet',
                  'hadis',
                  'fikih',
                  'nefs_terbiyesi',
                  'ahlak_adab',
                  'tasavvuf',
                  'siyer',
                  'kelam',
                  'ozlu_soz',
                  'kitap_alintisi'
                ],
                selectedCategory: selectedCategory,
                displayLabels: const {
                  'all': 'Tümü',
                  'ayet': 'Âyet-i Kerîme',
                  'hadis': 'Hadis-i Şerif',
                  'fikih': 'Fıkıh & İlmihâl',
                  'nefs_terbiyesi': 'Nefs Terbiyesi',
                  'ahlak_adab': 'Ahlâk & Adâb',
                  'tasavvuf': 'Tasavvuf',
                  'siyer': 'Siyer & Sahâbe',
                  'kelam': 'Kelâm & Akaid',
                  'ozlu_soz': 'Hikmet',
                  'kitap_alintisi': 'Kitap Pasajı',
                },
                onSelected: (cat) {
                  ref.read(selectedFeedCategoryProvider.notifier).state = cat;
                },
              ),
            ],
          ),
        ),
      ),
      body: feedAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text(
                'Bu kategoride henüz ilmi kart bulunmuyor.',
                style: TextStyle(color: Colors.white54),
              ),
            );
          }

          if (viewMode == FeedViewMode.reels) {
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return IlmiFeedCard(
                  item: items[index],
                  isFullScreen: true,
                );
              },
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return IlmiFeedCard(
                item: items[index],
                isFullScreen: false,
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Hata: $e')),
      ),
    );
  }
}
