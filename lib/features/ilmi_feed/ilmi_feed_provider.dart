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

final ilmiFeedStreamProvider = StreamProvider<List<IlmiFeedItem>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final category = ref.watch(selectedFeedCategoryProvider);

  if (category == 'all') {
    return (db.select(db.ilmiFeedItems)
          ..orderBy([(t) => OrderingTerm.desc(t.publishedAt)]))
        .watch();
  } else {
    return (db.select(db.ilmiFeedItems)
          ..where((t) => t.category.equals(category))
          ..orderBy([(t) => OrderingTerm.desc(t.publishedAt)]))
        .watch();
  }
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
