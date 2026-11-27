import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';

class DailyWorshipItem {
  final String id;
  String title;
  bool isCompleted;

  DailyWorshipItem({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isCompleted': isCompleted,
      };

  factory DailyWorshipItem.fromJson(Map<String, dynamic> json) => DailyWorshipItem(
        id: json['id'] as String,
        title: json['title'] as String,
        isCompleted: json['isCompleted'] as bool? ?? false,
      );
}

class DailyWorshipTrackerWidgetCard extends StatefulWidget {
  const DailyWorshipTrackerWidgetCard({super.key});

  @override
  State<DailyWorshipTrackerWidgetCard> createState() => _DailyWorshipTrackerWidgetCardState();
}

class _DailyWorshipTrackerWidgetCardState extends State<DailyWorshipTrackerWidgetCard> {
  static const String _prefKeyItems = 'sukun_daily_worship_items';
  static const String _prefKeyDate = 'sukun_daily_worship_last_date';

  List<DailyWorshipItem> _items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final todayStr = DateTime.now().toIso8601String().substring(0, 10);
      final lastDate = prefs.getString(_prefKeyDate);

      final rawJson = prefs.getString(_prefKeyItems);

      if (rawJson != null && rawJson.isNotEmpty) {
        final decoded = jsonDecode(rawJson) as List<dynamic>;
        _items = decoded.map((e) => DailyWorshipItem.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        // Varsayılan vird listesi
        _items = [
          DailyWorshipItem(id: '1', title: 'Sabah Namazı', isCompleted: false),
          DailyWorshipItem(id: '2', title: 'Öğle Namazı', isCompleted: false),
          DailyWorshipItem(id: '3', title: 'İkindi Namazı', isCompleted: false),
          DailyWorshipItem(id: '4', title: 'Akşam Namazı', isCompleted: false),
          DailyWorshipItem(id: '5', title: 'Yatsı Namazı', isCompleted: false),
          DailyWorshipItem(id: '6', title: 'Günlük Kur\'ân (1 Cüz / Sayfa)', isCompleted: false),
          DailyWorshipItem(id: '7', title: '100 İstiğfâr & 100 Salavât', isCompleted: false),
        ];
      }

      // Yeni gün başladıysa tamamlananları otomatik sıfırla (Akıllı Gece Devri)
      if (lastDate != todayStr) {
        for (var item in _items) {
          item.isCompleted = false;
        }
        await prefs.setString(_prefKeyDate, todayStr);
        await _saveItems();
      }
    } catch (_) {}

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = jsonEncode(_items.map((e) => e.toJson()).toList());
      await prefs.setString(_prefKeyItems, encoded);
    } catch (_) {}
  }

  void _toggleItem(int index) {
    setState(() {
      _items[index].isCompleted = !_items[index].isCompleted;
    });
    _saveItems();
  }

  void _showAddOrEditDialog({DailyWorshipItem? itemToEdit, int? index}) {
    final textController = TextEditingController(text: itemToEdit?.title ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          decoration: const BoxDecoration(
            color: SukunColors.carbonCardSurface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            border: Border(top: BorderSide(color: SukunColors.emeraldPrimary, width: 1.5)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    itemToEdit == null ? 'Yeni Günlük Vird Ekle' : 'Virdi Düzenle',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  if (itemToEdit != null && index != null)
                    IconButton(
                      icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                      tooltip: 'Virdi Sil',
                      onPressed: () {
                        setState(() => _items.removeAt(index));
                        _saveItems();
                        Navigator.pop(ctx);
                      },
                    ),
                ],
              ),
              const SizedBox(height: 14),
              TextField(
                controller: textController,
                style: const TextStyle(color: Colors.white),
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Vird Adı (Ör: Kuşluk Namazı / 100 İhlas)',
                  labelStyle: const TextStyle(color: Colors.white60),
                  filled: true,
                  fillColor: Colors.black.withValues(alpha: 0.3),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: SukunColors.emeraldPrimary),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: SukunColors.emeraldPrimary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.check_rounded),
                label: Text(
                  itemToEdit == null ? 'Listeye Ekle' : 'Değişikliği Kaydet',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  final text = textController.text.trim();
                  if (text.isEmpty) return;

                  setState(() {
                    if (itemToEdit != null) {
                      itemToEdit.title = text;
                    } else {
                      _items.add(DailyWorshipItem(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: text,
                        isCompleted: false,
                      ));
                    }
                  });
                  _saveItems();
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox.shrink();
    }

    final completedCount = _items.where((i) => i.isCompleted).length;
    final progress = _items.isEmpty ? 0.0 : completedCount / _items.length;

    return SukunSurfaceCard(
      enableGlass: true,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: SukunColors.emeraldPrimary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.task_alt_rounded, size: 14, color: SukunColors.emeraldPrimary),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'GÜNLÜK İBÂDET & VİRD LİSTESİ',
                    style: TextStyle(
                      color: SukunColors.goldAccent,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '$completedCount / ${_items.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.add_circle_outline_rounded, color: SukunColors.emeraldPrimary, size: 18),
                    tooltip: 'Yeni Vird Ekle',
                    onPressed: () => _showAddOrEditDialog(),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Akıllı İlerleme Çubuğu
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: Colors.white10,
              valueColor: const AlwaysStoppedAnimation<Color>(SukunColors.emeraldPrimary),
            ),
          ),
          const SizedBox(height: 12),

          // Vird Maddeleri
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              return InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _toggleItem(index),
                onLongPress: () => _showAddOrEditDialog(itemToEdit: item, index: index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: item.isCompleted
                        ? SukunColors.emeraldPrimary.withValues(alpha: 0.22)
                        : Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: item.isCompleted
                          ? SukunColors.emeraldPrimary
                          : Colors.white.withValues(alpha: 0.12),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.isCompleted ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                        size: 13,
                        color: item.isCompleted ? SukunColors.emeraldPrimary : Colors.white38,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: item.isCompleted ? FontWeight.bold : FontWeight.w500,
                          color: item.isCompleted ? Colors.white : Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'Her gece otomatik sıfırlanır • Eklemek için + butonuna basın',
              style: TextStyle(fontSize: 10, color: Colors.white38, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}
