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
    final feedAsync = ref.watch(ilmiFeedStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('İlmi Akış', style: TextStyle(fontWeight: FontWeight.w700)),
        actions: [
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
          preferredSize: const Size.fromHeight(48),
          child: CategoryFilterChips(
            categories: const [
              'all',
              'fikih',
              'hadis',
              'ayet',
              'siyer',
              'kelam',
              'tasavvuf',
              'ozlu_soz',
              'kitap_alintisi'
            ],
            selectedCategory: selectedCategory,
            displayLabels: const {
              'all': 'Tümü',
              'fikih': 'Fıkıh',
              'hadis': 'Hadis',
              'ayet': 'Ayet',
              'siyer': 'Siyer',
              'kelam': 'Kelam',
              'tasavvuf': 'Tasavvuf',
              'ozlu_soz': 'Hikmet',
              'kitap_alintisi': 'Kitap',
            },
            onSelected: (cat) {
              ref.read(selectedFeedCategoryProvider.notifier).state = cat;
            },
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
