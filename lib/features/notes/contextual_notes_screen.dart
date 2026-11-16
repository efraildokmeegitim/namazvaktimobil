import 'package:flutter/material.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';

class ContextualNoteModel {
  final String id;
  final String title;
  final String body;
  final String sourceLink;
  final String date;
  final String categoryTag;

  ContextualNoteModel({
    required this.id,
    required this.title,
    required this.body,
    required this.sourceLink,
    required this.date,
    this.categoryTag = 'Tefekkür',
  });
}

class ContextualNotesScreen extends StatefulWidget {
  const ContextualNotesScreen({super.key});

  @override
  State<ContextualNotesScreen> createState() => _ContextualNotesScreenState();
}

class _ContextualNotesScreenState extends State<ContextualNotesScreen> {
  final List<ContextualNoteModel> _notes = [
    ContextualNoteModel(
      id: '1',
      title: 'İhlas ve Niyet Tefekkürü',
      body: 'Ameller ancak niyetlere göredir hadis-i şerifi üzerine: Günlük en sıradan işleri dahi kalpteki halis niyetle ebedi sevaba ve ibadete dönüştürmek mümkün.',
      sourceLink: 'Hadis Akış Kartı #001',
      date: '12 Kasım 2026',
      categoryTag: 'Hadis Notu',
    ),
    ContextualNoteModel(
      id: '2',
      title: 'Taif Duası ve Sabır Zirvesi',
      body: 'Zorluk ve haksızlık anında öfke ve beddua yerine hidayet duası etmek; nebevi ahlakın en büyük dersi.',
      sourceLink: 'Siyer Akış Kartı #001',
      date: '10 Kasım 2026',
      categoryTag: 'Siyer Notu',
    ),
    ContextualNoteModel(
      id: '3',
      title: 'Sabah İntibah Duası Virdi',
      body: 'Uyanır uyanmaz: "Elhamdü lillâhillezî ahyânâ ba\'de mâ emâtenâ..." duasını her sabah vird edinmeyi unutma.',
      sourceLink: 'Erkam Dualar ve Zikirler, Sayfa 1',
      date: '8 Kasım 2026',
      categoryTag: 'Dua Virdi',
    ),
  ];

  void _showAddNoteDialog() {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();
    String selectedTag = 'Tefekkür';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              decoration: const BoxDecoration(
                color: SukunColors.carbonCardSurface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                border: Border(top: BorderSide(color: SukunColors.emeraldPrimary, width: 1.5)),
              ),
              child: SingleChildScrollView(
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
                    const Row(
                      children: [
                        Icon(Icons.edit_note_rounded, color: SukunColors.emeraldPrimary, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Yeni Tefekkür Notu Ekle',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: titleController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Not Başlığı',
                        labelStyle: const TextStyle(color: Colors.white60),
                        filled: true,
                        fillColor: Colors.black.withValues(alpha: 0.3),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: bodyController,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Tefekkür ve İlim Notunuz...',
                        labelStyle: const TextStyle(color: Colors.white60),
                        filled: true,
                        fillColor: Colors.black.withValues(alpha: 0.3),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text('Kategori Etiketi', style: TextStyle(color: SukunColors.goldAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      children: ['Tefekkür', 'Âyet Notu', 'Hadis Notu', 'Siyer Notu', 'Dua Virdi', 'Fıkıh Meselesi'].map((tag) {
                        final isSel = tag == selectedTag;
                        return ChoiceChip(
                          label: Text(tag),
                          selected: isSel,
                          onSelected: (_) => setModalState(() => selectedTag = tag),
                          selectedColor: SukunColors.emeraldPrimary.withValues(alpha: 0.25),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SukunColors.emeraldPrimary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      icon: const Icon(Icons.check_rounded),
                      label: const Text('Notu Kaydet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      onPressed: () {
                        if (titleController.text.trim().isEmpty) return;
                        setState(() {
                          _notes.insert(
                            0,
                            ContextualNoteModel(
                              id: DateTime.now().millisecondsSinceEpoch.toString(),
                              title: titleController.text.trim(),
                              body: bodyController.text.trim(),
                              sourceLink: 'Serbest Tefekkür Notu',
                              date: '13 Kasım 2026',
                              categoryTag: selectedTag,
                            ),
                          );
                        });
                        Navigator.pop(ctx);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tefekkür Defterim', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.post_add_rounded, color: SukunColors.emeraldPrimary),
            tooltip: 'Yeni Not',
            onPressed: _showAddNoteDialog,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];
          return SukunSurfaceCard(
            enableGlass: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: SukunColors.emeraldPrimary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        note.categoryTag,
                        style: const TextStyle(color: SukunColors.emeraldPrimary, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(note.date, style: const TextStyle(fontSize: 11, color: Colors.white38)),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  note.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 6),
                Text(
                  note.body,
                  style: const TextStyle(fontSize: 14, height: 1.5, color: SukunColors.carbonTextPrimary),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.link_rounded, color: SukunColors.goldAccent, size: 14),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        note.sourceLink,
                        style: const TextStyle(color: SukunColors.goldAccent, fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline_rounded, color: Colors.white38, size: 18),
                      onPressed: () {
                        setState(() => _notes.removeAt(index));
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: SukunColors.emeraldPrimary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.edit_note_rounded),
        label: const Text('Yeni Not Yaz', style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: _showAddNoteDialog,
      ),
    );
  }
}
