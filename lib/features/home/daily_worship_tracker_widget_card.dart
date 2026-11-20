import 'package:flutter/material.dart';
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
}

class DailyWorshipTrackerWidgetCard extends StatefulWidget {
  const DailyWorshipTrackerWidgetCard({super.key});

  @override
  State<DailyWorshipTrackerWidgetCard> createState() => _DailyWorshipTrackerWidgetCardState();
}

class _DailyWorshipTrackerWidgetCardState extends State<DailyWorshipTrackerWidgetCard> {
  final List<DailyWorshipItem> _items = [
    DailyWorshipItem(id: '1', title: 'Sabah Namazı', isCompleted: true),
    DailyWorshipItem(id: '2', title: 'Öğle Namazı', isCompleted: true),
    DailyWorshipItem(id: '3', title: 'İkindi Namazı', isCompleted: false),
    DailyWorshipItem(id: '4', title: 'Akşam Namazı', isCompleted: false),
    DailyWorshipItem(id: '5', title: 'Yatsı Namazı', isCompleted: false),
    DailyWorshipItem(id: '6', title: 'Günlük Kur\'ân (1 Cüz / Sayfa)', isCompleted: true),
    DailyWorshipItem(id: '7', title: '100 İstiğfâr & 100 Salavât', isCompleted: false),
  ];

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
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
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
    final doneCount = _items.where((v) => v.isCompleted).length;

    return SukunSurfaceCard(
      enableGlass: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: SukunColors.emeraldPrimary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.fact_check_rounded, size: 14, color: SukunColors.emeraldPrimary),
                    ),
                    const SizedBox(width: 8),
                    const Flexible(
                      child: Text(
                        'GÜNLÜK İBÂDET VE VİRD TAKİBİ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: SukunColors.emeraldPrimary,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$doneCount / ${_items.length}',
                    style: const TextStyle(color: SukunColors.goldAccent, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 6),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => _showAddOrEditDialog(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: SukunColors.emeraldPrimary.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        border: Border.all(color: SukunColors.emeraldPrimary.withValues(alpha: 0.4)),
                      ),
                      child: const Icon(Icons.add_rounded, size: 14, color: SukunColors.emeraldPrimary),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              return Container(
                padding: const EdgeInsets.only(left: 10, right: 4, top: 4, bottom: 4),
                decoration: BoxDecoration(
                  color: item.isCompleted
                      ? SukunColors.emeraldPrimary.withValues(alpha: 0.22)
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: item.isCompleted ? SukunColors.emeraldPrimary : Colors.white12,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => setState(() => item.isCompleted = !item.isCompleted),
                      onLongPress: () => _showAddOrEditDialog(itemToEdit: item, index: index),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            item.isCompleted ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                            size: 15,
                            color: item.isCompleted ? SukunColors.emeraldPrimary : Colors.white54,
                          ),
                          const SizedBox(width: 6),
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
                    const SizedBox(width: 2),
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        setState(() {
                          _items.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.title} listeden silindi.'),
                            duration: const Duration(seconds: 2),
                            action: SnackBarAction(
                              label: 'Geri Al',
                              textColor: SukunColors.goldAccent,
                              onPressed: () {
                                setState(() {
                                  _items.insert(index, item);
                                });
                              },
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Icons.close_rounded,
                          size: 13,
                          color: Colors.white.withValues(alpha: 0.35),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 6),
          const Center(
            child: Text(
              'Tamamlamak için dokunun, düzenlemek için basılı tutun, silmek için × simgesine basın',
              style: TextStyle(fontSize: 10, color: Colors.white38, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}
