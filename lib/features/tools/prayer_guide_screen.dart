import 'package:flutter/material.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';

class PrayerGuideItem {
  final String title;
  final String subTitle;
  final String description;
  final String arabicText;
  final String pronunciation;
  final String meal;

  const PrayerGuideItem({
    required this.title,
    required this.subTitle,
    required this.description,
    required this.arabicText,
    required this.pronunciation,
    required this.meal,
  });
}

class PrayerGuideScreen extends StatelessWidget {
  const PrayerGuideScreen({super.key});

  static const List<PrayerGuideItem> prayers = [
    PrayerGuideItem(
      title: 'Sabah Namazı',
      subTitle: '2 Rekat Sünnet + 2 Rekat Farz',
      description: 'Günün ilk bereketi. İmsak ile güneş doğuşu arasında eda edilir. Farzında kıraat sesli okunur.',
      arabicText: 'أُصَلِّي سُنَّةَ صَلَاةِ الْفَجْرِ رَكْعَتَيْنِ لِلّٰهِ تَعَالَى',
      pronunciation: 'Niyet: Niyet ettim Allah rızası için bugünkü sabah namazının sünnetini kılmaya.',
      meal: 'Sabah namazının iki rekat sünneti, dünyadan ve dünyadaki her şeyden daha hayırlıdır. (Müslim)',
    ),
    PrayerGuideItem(
      title: 'Öğle Namazı',
      subTitle: '4 İlk Sünnet + 4 Farz + 2 Son Sünnet (10 Rekat)',
      description: 'Güneşin zeval vaktinden (tepe noktasından batıya kaymasından) ikindi vaktine kadar kılınır.',
      arabicText: 'أُصَلِّي فَرْضَ صَلَاةِ الظُّهْرِ أَرْبَعَ رَكَعَاتٍ لِلّٰهِ تَعَالَى',
      pronunciation: 'Niyet: Niyet ettim Allah rızası için bugünkü öğle namazının farzını kılmaya.',
      meal: 'Öğle namazının farzından önce dört rekat kılmak, teheccüd namazına denktir. (Tirmizî)',
    ),
    PrayerGuideItem(
      title: 'İkindi Namazı',
      subTitle: '4 Gayr-i Müekked Sünnet + 4 Farz (8 Rekat)',
      description: 'Güneşin sararmasından ve kerahat vaktine girmeden önce eda edilen orta namaz (Salât-ı Vüstâ).',
      arabicText: 'حَافِظُوا عَلَى الصَّلَوَاتِ وَالصَّلَاةِ الْوُسْطَىٰ وَقُومُوا لِلَّهِ قَانِتِينَ',
      pronunciation: 'Namazlara ve orta namaza (ikindiye) devam edin; gönülden boyun eğerek Allah için namaza durun. (Bakara 238)',
      meal: 'İkindi namazını terk edenin ameli boşa gider. (Buhârî)',
    ),
    PrayerGuideItem(
      title: 'Akşam Namazı',
      subTitle: '3 Farz + 2 Sünnet (5 Rekat)',
      description: 'Güneşin tamamen batışından şafağın kaybolmasına kadar eda edilir. Farzı önce kılınır.',
      arabicText: 'أُصَلِّي فَرْضَ صَلَاةِ الْمَغْرِبِ ثَلَاثَ رَكَعَاتٍ لِلّٰهِ تَعَالَى',
      pronunciation: 'Niyet: Niyet ettim Allah rızası için bugünkü akşam namazının 3 rekat farzını kılmaya.',
      meal: 'Akşam namazının farzı 3 rekattır; birinci oturuşta yalnız Tahiyyat okunur, 3. rekatta yalnız Fâtiha okunur.',
    ),
    PrayerGuideItem(
      title: 'Yatsı ve Vitir Namazı',
      subTitle: '4 İlk Sünnet + 4 Farz + 2 Son Sünnet + 3 Vitir Vacip (13 Rekat)',
      description: 'Günün son namazıdır. Vitir namazının 3. rekatında Kunut duâları tekbir alınarak okunur.',
      arabicText: 'اَللّٰهُمَّ اِنَّا نَسْتَعِينُكَ وَنَسْتَغْفِرُكَ وَنَسْتَهْدِيكَ',
      pronunciation: 'Allâhümme innâ nesteînüke ve nestağfirüke ve nestehdîk...',
      meal: 'Allah tektir, teki sever. Ey Kur\'an ehli, vitir namazını kılınız! (Ebû Dâvûd)',
    ),
    PrayerGuideItem(
      title: 'Cuma Namazı',
      subTitle: '4 İlk Sünnet + 2 Farz + 4 Son Sünnet + 4 Zühri Ahir + 2 Vaktin Sünneti',
      description: 'Müslümanların haftalık bayramı ve cemaatle kılınması farz-ı ayn olan mukaddes namaz.',
      arabicText: 'يَا أَيُّهَا الَّذِينَ آمَنُوا إِذَا نُودِيَ لِلصَّلَاةِ مِن يَوْمِ الْجُمُعَةِ فَاسْعَوْا إِلَىٰ ذِكْرِ اللَّهِ',
      pronunciation: 'Ey iman edenler! Cuma günü namaza çağrıldığınız zaman hemen Allah\'ı anmaya koşun. (Cuma 9)',
      meal: 'Üzerine güneş doğan günlerin en hayırlısı cuma günüdür. (Müslim)',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resimli & Detaylı Namaz İlmihali', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        itemCount: prayers.length,
        itemBuilder: (context, index) {
          final p = prayers[index];
          return SukunSurfaceCard(
            enableGlass: true,
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              collapsedIconColor: SukunColors.goldAccent,
              iconColor: SukunColors.emeraldPrimary,
              leading: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: SukunColors.emeraldPrimary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: SukunColors.emeraldPrimary.withValues(alpha: 0.3)),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: SukunColors.emeraldPrimary),
                  ),
                ),
              ),
              title: Text(
                p.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
              ),
              subtitle: Text(
                p.subTitle,
                style: const TextStyle(fontSize: 12, color: SukunColors.goldAccent),
              ),
              children: [
                const Divider(color: Colors.white12, height: 20),
                Text(
                  p.description,
                  style: const TextStyle(fontSize: 13, color: Colors.white70, height: 1.5),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        p.arabicText,
                        style: SukunTheme.arabicQuranStyle(fontSize: 18, color: SukunColors.goldAccent),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        p.pronunciation,
                        style: const TextStyle(fontSize: 12, color: Colors.white, fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        p.meal,
                        style: const TextStyle(fontSize: 12, color: Colors.white54),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}
