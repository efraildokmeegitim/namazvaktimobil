import 'package:flutter/material.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';

class HolyDaysChecklistScreen extends StatefulWidget {
  const HolyDaysChecklistScreen({super.key});

  @override
  State<HolyDaysChecklistScreen> createState() => _HolyDaysChecklistScreenState();
}

class _HolyDaysChecklistScreenState extends State<HolyDaysChecklistScreen> {
  final Map<String, bool> _fridayChecks = {
    'Cuma guslü almak ve temiz elbiseler giymek': true,
    'Kehf Sûresi\'ni tilavet etmek': false,
    'Peygamber Efendimiz\'e (s.a.v.) en az 100 Salavat-ı Şerife getirmek': true,
    'Cuma hutbesini dikkat ve sükûnetle dinlemek': false,
    'İcabet vaktinde (ikindi-akşam arası) hususi duâda bulunmak': false,
    'Sadaka vermek': false,
  };

  final Map<String, bool> _kandilChecks = {
    'Gündüzünü oruçlu geçirmek': false,
    'Kaza namazı kılmak (en az 1 günlük)': false,
    'Tevbe-i İstiğfar etmek (Seyyidü\'l İstiğfar)': true,
    'Yâsîn, Mülk ve Vâkıa sûrelerini okumak': false,
    'Tesbih Namazı kılmak (4 rekat)': false,
    'Anne-baba ve sıla-i rahim akrabalarını arayıp tebrikleşmek': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mübarek Gün ve Gece İbadet Rehberi', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: SukunColors.carbonCardSurface,
              child: const TabBar(
                indicatorColor: SukunColors.goldAccent,
                labelColor: SukunColors.goldAccent,
                unselectedLabelColor: Colors.white54,
                tabs: [
                  Tab(text: 'Cuma Günü İbadetleri', icon: Icon(Icons.wb_sunny_outlined)),
                  Tab(text: 'Kandil & Mübarek Geceler', icon: Icon(Icons.nightlight_round_outlined)),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Cuma Tab
                  ListView(
                    padding: const EdgeInsets.all(14),
                    children: _fridayChecks.entries.map((entry) {
                      return SukunSurfaceCard(
                        enableGlass: true,
                        child: CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          activeColor: SukunColors.emeraldPrimary,
                          checkColor: Colors.black,
                          title: Text(
                            entry.key,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: entry.value ? FontWeight.w600 : FontWeight.normal,
                              decoration: entry.value ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          value: entry.value,
                          onChanged: (val) {
                            setState(() {
                              _fridayChecks[entry.key] = val ?? false;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),

                  // Kandil Tab
                  ListView(
                    padding: const EdgeInsets.all(14),
                    children: _kandilChecks.entries.map((entry) {
                      return SukunSurfaceCard(
                        enableGlass: true,
                        child: CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          activeColor: SukunColors.goldAccent,
                          checkColor: Colors.black,
                          title: Text(
                            entry.key,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: entry.value ? FontWeight.w600 : FontWeight.normal,
                              decoration: entry.value ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          value: entry.value,
                          onChanged: (val) {
                            setState(() {
                              _kandilChecks[entry.key] = val ?? false;
                            });
                          },
                        ),
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
