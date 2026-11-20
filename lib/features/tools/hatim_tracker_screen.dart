import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';

class HatimTrackerScreen extends StatefulWidget {
  const HatimTrackerScreen({super.key});

  @override
  State<HatimTrackerScreen> createState() => _HatimTrackerScreenState();
}

class _HatimTrackerScreenState extends State<HatimTrackerScreen> {
  int _lastReadPage = 1;
  int _dailyPageTarget = 4; // Günde 4 sayfa -> 150 günde hatim
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastReadPage = prefs.getInt('hatim_last_read_page') ?? 1;
      _dailyPageTarget = prefs.getInt('hatim_daily_page_target') ?? 4;
      _isLoading = false;
    });
  }

  Future<void> _savePage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('hatim_last_read_page', page);
    setState(() {
      _lastReadPage = page;
    });
  }

  Future<void> _saveTarget(int target) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('hatim_daily_page_target', target);
    setState(() {
      _dailyPageTarget = target;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: SukunColors.emeraldPrimary)),
      );
    }

    final totalPages = 604;
    final progress = (_lastReadPage / totalPages).clamp(0.0, 1.0);
    final remainingPages = totalPages - _lastReadPage;
    final daysToFinish = (remainingPages / (_dailyPageTarget > 0 ? _dailyPageTarget : 1)).ceil();
    final currentJuz = ((_lastReadPage - 1) ~/ 20) + 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kişisel Hatim ve Cüz Takipçisi', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // İlerleme Özeti Kartı
            SukunSurfaceCard(
              enableGlass: true,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Mevcut Sayfa', style: TextStyle(color: Colors.white54, fontSize: 12)),
                          const SizedBox(height: 4),
                          Text(
                            '$_lastReadPage / $totalPages',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: SukunColors.goldAccent,
                              fontFeatures: [FontFeature.tabularFigures()],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: SukunColors.emeraldPrimary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: SukunColors.emeraldPrimary.withValues(alpha: 0.4)),
                        ),
                        child: Text(
                          '$currentJuz. Cüz',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: SukunColors.emeraldPrimary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      backgroundColor: Colors.white12,
                      valueColor: const AlwaysStoppedAnimation<Color>(SukunColors.emeraldPrimary),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '%${(progress * 100).toStringAsFixed(1)} Tamamlandı',
                        style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Kalan: $daysToFinish gün',
                        style: const TextStyle(color: SukunColors.goldAccent, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Sayfa Hızlı Güncelleme Kartı
            SukunSurfaceCard(
              enableGlass: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Sayfa Güncelle', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton.filledTonal(
                        onPressed: _lastReadPage > 1 ? () => _savePage(_lastReadPage - 1) : null,
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        '$_lastReadPage. Sayfa',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      IconButton.filled(
                        style: IconButton.styleFrom(backgroundColor: SukunColors.emeraldPrimary),
                        onPressed: _lastReadPage < 604 ? () => _savePage(_lastReadPage + 1) : null,
                        icon: const Icon(Icons.add, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _savePage((_lastReadPage + 4).clamp(1, 604)),
                          child: const Text('+4 Sayfa Oku'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _savePage((_lastReadPage + 20).clamp(1, 604)),
                          child: const Text('+1 Cüz Bitir'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Günlük Hedef Seçimi
            SukunSurfaceCard(
              enableGlass: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Günlük Okuma Hedefiniz', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
                  const SizedBox(height: 8),
                  const Text('Günde kaç sayfa okuyarak hatminizi tamamlamak istersiniz?', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [2, 4, 10, 20].map((t) {
                      final isSelected = _dailyPageTarget == t;
                      final days = (604 / t).ceil();
                      return ChoiceChip(
                        label: Text('$t Sayfa (~$days gün)'),
                        selected: isSelected,
                        selectedColor: SukunColors.emeraldPrimary,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        onSelected: (_) => _saveTarget(t),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
