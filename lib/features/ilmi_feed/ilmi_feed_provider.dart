import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../core/database/app_database.dart';
import '../../main.dart';

enum FeedViewMode {
  reels,
  list;
}

final feedViewModeProvider = StateProvider<FeedViewMode>((ref) => FeedViewMode.list);
final selectedFeedCategoryProvider = StateProvider<String>((ref) => 'all');
final ilmiFeedSearchQueryProvider = StateProvider<String>((ref) => '');
final ilmiFeedFavoritesOnlyProvider = StateProvider<bool>((ref) => false);

final ilmiFeedStreamProvider = StreamProvider<List<IlmiFeedItem>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final category = ref.watch(selectedFeedCategoryProvider);
  final query = ref.watch(ilmiFeedSearchQueryProvider).trim().toLowerCase();
  final favoritesOnly = ref.watch(ilmiFeedFavoritesOnlyProvider);

  return (db.select(db.ilmiFeedItems)
        ..orderBy([(t) => OrderingTerm.desc(t.publishedAt)]))
      .watch()
      .map((items) {
    return items.where((item) {
      if (category != 'all' && item.category != category) {
        return false;
      }
      if (favoritesOnly && item.isLiked != 1) {
        return false;
      }
      if (query.isNotEmpty) {
        final title = (item.title ?? '').toLowerCase();
        final body = item.summaryBody.toLowerCase();
        final commentary = (item.detailedCommentary ?? '').toLowerCase();
        final source = item.sourceReference.toLowerCase();
        final cat = item.category.toLowerCase();
        return title.contains(query) ||
            body.contains(query) ||
            commentary.contains(query) ||
            source.contains(query) ||
            cat.contains(query);
      }
      return true;
    }).toList();
  });
});

class IlmiFeedActions {
  final AppDatabase db;
  IlmiFeedActions(this.db);

  Future<void> toggleLike(String id, bool currentlyLiked) async {
    await (db.update(db.ilmiFeedItems)..where((t) => t.id.equals(id))).write(
      IlmiFeedItemsCompanion(
        isLiked: Value(currentlyLiked ? 0 : 1),
      ),
    );
  }

  Future<void> markAsRead(String id) async {
    await (db.update(db.ilmiFeedItems)..where((t) => t.id.equals(id))).write(
      const IlmiFeedItemsCompanion(
        isRead: Value(1),
      ),
    );
  }

  Future<void> saveToCollection(String targetId, String? collectionId) async {
    await db.into(db.savedItems).insert(
          SavedItemsCompanion.insert(
            targetType: 'ilmi_card',
            targetId: targetId,
            collectionId: Value(collectionId),
            savedAt: DateTime.now().millisecondsSinceEpoch,
          ),
          mode: InsertMode.insertOrReplace,
        );
  }
}

final ilmiFeedActionsProvider = Provider<IlmiFeedActions>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return IlmiFeedActions(db);
});
