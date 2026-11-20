import 'package:flutter/material.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';
import 'esmaul_husna_screen.dart';
import 'prayer_guide_screen.dart';
import 'hatim_tracker_screen.dart';
import 'holy_days_checklist_screen.dart';
import 'smart_camii_silent_service.dart';

class IslamicToolsHubScreen extends StatefulWidget {
  const IslamicToolsHubScreen({super.key});

  @override
  State<IslamicToolsHubScreen> createState() => _IslamicToolsHubScreenState();
}

class _IslamicToolsHubScreenState extends State<IslamicToolsHubScreen> {
  // Kaza Namazı Sayacı
  int _fajrQada = 14;
  int _dhuhrQada = 22;
  int _asrQada = 18;
  int _maghribQada = 15;
  int _ishaQada = 20;
  int _fastQada = 7; // Kaza Orucu

  // Zekat Hesaplama Değerleri
  final TextEditingController _goldGramController = TextEditingController(text: '95');
  final TextEditingController _cashController = TextEditingController(text: '50000');
  double _calculatedZakat = 0.0;
  static const double goldGramPriceTL = 3100.0; // Güncel altın gram fiyatı
  static const double nisapGoldGram = 80.18;

  @override
  void initState() {
    super.initState();
    _recalculateZakat();
  }

  void _recalculateZakat() {
    final goldGram = double.tryParse(_goldGramController.text) ?? 0.0;
    final cash = double.tryParse(_cashController.text) ?? 0.0;

    final totalWealthTL = (goldGram * goldGramPriceTL) + cash;
    final nisapTL = nisapGoldGram * goldGramPriceTL;

    setState(() {
      if (totalWealthTL >= nisapTL) {
        _calculatedZakat = totalWealthTL * 0.025; // %2.5 (1/40)
      } else {
        _calculatedZakat = 0.0;
      }
    });
  }

  Widget _buildQadaRow(String label, int count, VoidCallback onDec, VoidCallback onInc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 14),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, color: Colors.white54, size: 22),
                onPressed: count > 0 ? onDec : null,
              ),
              Container(
                width: 44,
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white12),
                ),
                child: Text(
                  '$count',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: SukunColors.goldAccent,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, color: SukunColors.emeraldPrimary, size: 22),
                onPressed: onInc,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalQada = _fajrQada + _dhuhrQada + _asrQada + _maghribQada + _ishaQada;

    return Scaffold(
      appBar: AppBar(
        title: const Text('İslami İbadet Araçları', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 28),
        child: Column(
          children: [
            // 1. Kaza Namazı ve Oruç Takipçisi
            SukunSurfaceCard(
              enableGlass: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.history_rounded, color: SukunColors.goldAccent, size: 20),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Kaza Namazı & Oruç Takipçisi',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: SukunColors.goldAccent),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: SukunColors.goldAccent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Toplam: $totalQada Vakit',
                          style: const TextStyle(color: SukunColors.goldAccent, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildQadaRow('Sabah Namazı', _fajrQada, () => setState(() => _fajrQada--), () => setState(() => _fajrQada++)),
                  _buildQadaRow('Öğle Namazı', _dhuhrQada, () => setState(() => _dhuhrQada--), () => setState(() => _dhuhrQada++)),
                  _buildQadaRow('İkindi Namazı', _asrQada, () => setState(() => _asrQada--), () => setState(() => _asrQada++)),
                  _buildQadaRow('Akşam Namazı', _maghribQada, () => setState(() => _maghribQada--), () => setState(() => _maghribQada++)),
                  _buildQadaRow('Yatsı Namazı', _ishaQada, () => setState(() => _ishaQada--), () => setState(() => _ishaQada++)),
                  const Divider(height: 16, color: Colors.white12),
                  _buildQadaRow('Kaza Orucu (Gün)', _fastQada, () => setState(() => _fastQada--), () => setState(() => _fastQada++)),
                ],
              ),
            ),

            // 2. Canlı Zekat Hesaplayıcı
            SukunSurfaceCard(
              enableGlass: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.calculate_rounded, color: SukunColors.emeraldPrimary, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'İnteraktif Zekât Hesaplayıcı',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: SukunColors.emeraldPrimary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Diyanet Nisap Eşiği: 80.18 gr Altın • Nisap üzerinde 1 yıl kalan malın 40\'ta biri (%2.5) zekat verilir.',
                    style: TextStyle(fontSize: 12, color: Colors.white70, height: 1.4),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _goldGramController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                            labelText: 'Altın Miktarı (Gram)',
                            labelStyle: const TextStyle(color: Colors.white60, fontSize: 12),
                            filled: true,
                            fillColor: Colors.black.withValues(alpha: 0.3),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onChanged: (_) => _recalculateZakat(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _cashController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                            labelText: 'Nakit & Birikim (TL)',
                            labelStyle: const TextStyle(color: Colors.white60, fontSize: 12),
                            filled: true,
                            fillColor: Colors.black.withValues(alpha: 0.3),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onChanged: (_) => _recalculateZakat(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: SukunColors.emeraldPrimary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: SukunColors.emeraldPrimary.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            'Verilmesi Gereken Zekât:',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${_calculatedZakat.toStringAsFixed(2)} TL',
                          style: const TextStyle(
                            color: SukunColors.goldAccent,
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            fontFeatures: [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 3. Esmâü'l-Hüsnâ (Allah'ın 99 İsmi ve Faziletleri)
            SukunSurfaceCard(
              enableGlass: true,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const EsmaulHusnaScreen()),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: SukunColors.goldAccent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: SukunColors.goldAccent.withValues(alpha: 0.35)),
                      ),
                      child: const Icon(Icons.stars_rounded, color: SukunColors.goldAccent, size: 24),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Esmâü\'l-Hüsnâ (99 İsim)',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Arapça hat, tecelli manaları ve zikir faziletleri',
                            style: TextStyle(fontSize: 12, color: Colors.white54),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, color: SukunColors.goldAccent, size: 14),
                  ],
                ),
              ),
            ),

            // 4. Detaylı Namaz İlmihali & Kılınış Rehberi
            SukunSurfaceCard(
              enableGlass: true,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PrayerGuideScreen()),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: SukunColors.emeraldPrimary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: SukunColors.emeraldPrimary.withValues(alpha: 0.35)),
                      ),
                      child: const Icon(Icons.menu_book_rounded, color: SukunColors.emeraldPrimary, size: 24),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Resimli & Detaylı Namaz İlmihali',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '5 vakit, cuma ve vitir namazı niyet, kıraat ve rekatları',
                            style: TextStyle(fontSize: 12, color: Colors.white54),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, color: SukunColors.goldAccent, size: 14),
                  ],
                ),
              ),
            ),

            // 5. Kişisel Hatim & Cüz Takipçisi
            SukunSurfaceCard(
              enableGlass: true,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const HatimTrackerScreen()),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: SukunColors.goldAccent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: SukunColors.goldAccent.withValues(alpha: 0.35)),
                      ),
                      child: const Icon(Icons.bookmark_added_rounded, color: SukunColors.goldAccent, size: 24),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kişisel Hatim & Cüz Takipçisi',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Kişisel günlük sayfa hedefi, cüz hesabı ve kalan gün takvimi',
                            style: TextStyle(fontSize: 12, color: Colors.white54),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, color: SukunColors.goldAccent, size: 14),
                  ],
                ),
              ),
            ),

            // 6. Mübarek Gün ve Gece İbadet Rehberi
            SukunSurfaceCard(
              enableGlass: true,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const HolyDaysChecklistScreen()),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: SukunColors.emeraldPrimary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: SukunColors.emeraldPrimary.withValues(alpha: 0.35)),
                      ),
                      child: const Icon(Icons.checklist_rounded, color: SukunColors.emeraldPrimary, size: 24),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cuma & Kandil İbadet Programları',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Cuma günü sünnetleri, kandil gecesi ibadet kontrol listesi',
                            style: TextStyle(fontSize: 12, color: Colors.white54),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, color: SukunColors.goldAccent, size: 14),
                  ],
                ),
              ),
            ),

            // 7. Akıllı Cami Sessiz Modu Hızlı Anahtarı
            SukunSurfaceCard(
              enableGlass: true,
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: const Icon(Icons.vibration_rounded, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cami / İbadet Sessiz Modu',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Tek tıkla telefonu titreşim / sessiz moda al',
                          style: TextStyle(fontSize: 12, color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SukunColors.emeraldPrimary,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    ),
                    onPressed: () async {
                      final success = await SmartCamiiSilentService.setSilentMode();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(success ? 'Telefon sessiz / titreşim moduna alındı.' : 'Zil sesi ayarlandı.'),
                            backgroundColor: SukunColors.emeraldPrimary,
                          ),
                        );
                      }
                    },
                    child: const Text('Sessize Al', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ],
              ),
            ),

            // 8. 5 Vakit Namaz Tesbihatı ve Aşr-ı Şerifler Rehberi
            SukunSurfaceCard(
              enableGlass: true,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.auto_stories_rounded, color: SukunColors.goldAccent, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '5 Vakit Namaz Sonrası Tesbihatı & Aşr-ı Şerifler',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: SukunColors.goldAccent),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    '• Sabah Namazı: Haşr Sûresi son 3 âyeti (Hüvallâhüllezî...)\n'
                    '• Öğle Namazı: Fetih Sûresi son 3 âyeti (Lekad sadakallâhü...)\n'
                    '• İkindi Namazı: Nebe (Amme) Sûresi\n'
                    '• Akşam Namazı: Haşr Sûresi son 3 âyeti\n'
                    '• Yatsı Namazı: Bakara Sûresi son 2 âyeti (Âmenerrasûlü...)',
                    style: TextStyle(fontSize: 13, color: Colors.white, height: 1.6),
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
