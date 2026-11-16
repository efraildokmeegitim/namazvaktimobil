import 'package:flutter/material.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';

class IslamicSpecialDay {
  final String title;
  final String hijriDate;
  final String gregorianDate;
  final int daysRemaining;
  final String description;
  final String recommendedWorship;

  const IslamicSpecialDay({
    required this.title,
    required this.hijriDate,
    required this.gregorianDate,
    required this.daysRemaining,
    required this.description,
    required this.recommendedWorship,
  });
}

class IslamicCalendarScreen extends StatelessWidget {
  const IslamicCalendarScreen({super.key});

  static const List<IslamicSpecialDay> specialDays = [
    IslamicSpecialDay(
      title: 'Regaib Kandili',
      hijriDate: 'Recep ayının ilk Cuma gecesi',
      gregorianDate: '2 Ocak',
      daysRemaining: 14,
      description: 'Üç ayların ilk mübarek kandil gecesi olup rağbetlerin Allah\'a yöneldiği gecedir.',
      recommendedWorship: 'Tevbe-i istiğfar, kaza namazları ve hacet namazı.',
    ),
    IslamicSpecialDay(
      title: 'Mirac Kandili',
      hijriDate: '27 Recep 1448',
      gregorianDate: '27 Ocak',
      daysRemaining: 39,
      description: 'Peygamber Efendimiz\'in (s.a.v.) semaya yükselip 5 vakit namaz hediyesiyle döndüğü gece.',
      recommendedWorship: 'Gündüz oruç, gece Kur\'an tilaveti ve tesbihat.',
    ),
    IslamicSpecialDay(
      title: 'Berat Kandili',
      hijriDate: '15 Şaban 1448',
      gregorianDate: '14 Şubat',
      daysRemaining: 57,
      description: 'Kulların günahlardan beraat ettiği, yıllık rızık ve ecellerin takdir edildiği gece.',
      recommendedWorship: 'Gündüz oruç, gece tesbih namazı ve istiğfar.',
    ),
    IslamicSpecialDay(
      title: 'Ramazan-ı Şerif Başlangıcı',
      hijriDate: '1 Ramazan 1448',
      gregorianDate: '1 Mart',
      daysRemaining: 72,
      description: 'On bir ayın sultanı, Kur\'an ve oruç ayı.',
      recommendedWorship: 'Farz oruç, teravih namazı ve mukabele.',
    ),
    IslamicSpecialDay(
      title: 'Kadir Gecesi',
      hijriDate: '27 Ramazan 1448',
      gregorianDate: '26 Mart',
      daysRemaining: 97,
      description: 'Bin aydan daha hayırlı olan, Kur\'ân-ı Kerîm\'in indirildiği kutlu gece.',
      recommendedWorship: 'Gece boyu dua: "Allahümme inneke afüvvün tühıbbü\'l-afve fa\'fü annî."',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dini Gün ve Geceler Takvimi', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: specialDays.length,
        itemBuilder: (context, index) {
          final day = specialDays[index];
          return SukunSurfaceCard(
            enableGlass: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      day.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: SukunColors.goldAccent,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: SukunColors.emeraldPrimary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: SukunColors.emeraldPrimary.withValues(alpha: 0.4)),
                      ),
                      child: Text(
                        '${day.daysRemaining} gün kaldı',
                        style: const TextStyle(
                          color: SukunColors.emeraldPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '${day.hijriDate} • ${day.gregorianDate}',
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(height: 10),
                Text(
                  day.description,
                  style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.4),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star_outline_rounded, color: SukunColors.goldAccent, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Tavsiye İbadet: ${day.recommendedWorship}',
                          style: const TextStyle(color: SukunColors.goldAccent, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
