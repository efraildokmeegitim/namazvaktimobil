import 'package:flutter/material.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';

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
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 14)),
          Row(
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
                      const Row(
                        children: [
                          Icon(Icons.history_rounded, color: SukunColors.goldAccent, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Kaza Namazı & Oruç Takipçisi',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: SukunColors.goldAccent),
                          ),
                        ],
                      ),
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
                        const Text(
                          'Verilmesi Gereken Zekât:',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
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

            // 3. 5 Vakit Namaz Tesbihatı ve Aşr-ı Şerifler Rehberi
            SukunSurfaceCard(
              enableGlass: true,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.auto_stories_rounded, color: SukunColors.goldAccent, size: 20),
                      SizedBox(width: 8),
                      Text(
                        '5 Vakit Namaz Sonrası Tesbihatı & Aşr-ı Şerifler',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: SukunColors.goldAccent),
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
