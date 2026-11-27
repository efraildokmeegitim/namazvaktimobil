import 'package:flutter/material.dart';
import '../prayer_times/prayer_times_model.dart';

enum SmartActionType {
  prayerGuide,
  tasbih,
  quran,
  dua,
  fasting,
  qibla,
  mosques,
}

class SmartRecommendation {
  final String title;
  final String subtitle;
  final String actionLabel;
  final IconData icon;
  final Color accentColor;
  final String route;
  final SmartActionType actionType;
  final String? badgeText;

  const SmartRecommendation({
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    required this.icon,
    required this.accentColor,
    required this.route,
    required this.actionType,
    this.badgeText,
  });
}

class SukunSmartEngine {
  /// Çevrimdışı, sıfır maliyetli ve kural tabanlı yapay zeka/akıllı asistan mantığı
  static SmartRecommendation getRecommendation({
    required PrayerDayTimes times,
    required bool isSafir,
    int? completedWorshipCount,
    int? totalWorshipCount,
  }) {
    final now = DateTime.now();
    final current = times.currentPrayer;
    final next = times.nextPrayer;
    final rem = times.timeRemainingToNext;
    final weekday = now.weekday; // 1: Pazartesi, 4: Perşembe, 5: Cuma

    // 1. Cuma Günü Akıllı İbadet & Kehf Suresi Tavsiyesi
    if (weekday == DateTime.friday && (current == PrayerType.fajr || current == PrayerType.sunrise || current == PrayerType.dhuhr)) {
      return const SmartRecommendation(
        title: 'Mübarek Cuma Saati',
        subtitle: 'Cuma gününde Kehf Sûresi okumak iki cuma arasını nurlandırır. Cuma namazı sünnet ve farzlarını inceleyin.',
        actionLabel: 'Cuma Rehberini Aç',
        icon: Icons.mosque_rounded,
        accentColor: Color(0xFFE5C170), // Gold
        route: '/tools',
        actionType: SmartActionType.prayerGuide,
        badgeText: 'Cuma Bereketi',
      );
    }

    // 2. Seferilik / Seyahat Akıllı Modu (90+ km)
    if (isSafir) {
      return const SmartRecommendation(
        title: 'Seferi Yolculuk Modu',
        subtitle: 'Ev konumunuzdan 90 km uzaktasınız. 4 rekatlı farzları 2 rekat (kasr) kılma ruhsatı geçerlidir.',
        actionLabel: 'Namaz Rehberi & Hükümler',
        icon: Icons.flight_takeoff_rounded,
        accentColor: Color(0xFF4EEDB0), // Mint emerald
        route: '/tools',
        actionType: SmartActionType.prayerGuide,
        badgeText: '90 km Seferi',
      );
    }

    // 3. Teheccüd / Seher Vakti Akıllı Algılama (İmsaktan önceki 2 saat)
    final imsakTime = times.fajr;
    final seherStart = imsakTime.subtract(const Duration(hours: 2, minutes: 15));
    if (now.isAfter(seherStart) && now.isBefore(imsakTime)) {
      return const SmartRecommendation(
        title: 'Feyizli Seher Vakti & Teheccüd',
        subtitle: 'Gecenin son üçte biri; duaların ve istiğfarın reddolunmadığı müstesna seher vaktindesiniz.',
        actionLabel: 'İstiğfar & Seyyidü\'l-İstiğfar',
        icon: Icons.bedtime_rounded,
        accentColor: Color(0xFF67B7D1), // Cyan/Night
        route: '/tasbih',
        actionType: SmartActionType.tasbih,
        badgeText: 'Seher Fırsatı',
      );
    }

    // 4. İmsak - Güneş arası (Sabah Namazı & Sabah Virdleri)
    if (current == PrayerType.fajr) {
      return const SmartRecommendation(
        title: 'Sabah Namazı & İşrak Vakti',
        subtitle: 'Sabah namazının sünneti ve farzı sonrası güneş doğana kadar zikir ve tefekkürle meşguliyet pek faziletlidir.',
        actionLabel: 'Sabah Zikirlerine Başla',
        icon: Icons.wb_twilight_rounded,
        accentColor: Color(0xFFE5C170),
        route: '/tasbih',
        actionType: SmartActionType.tasbih,
        badgeText: 'Sabah Virdi',
      );
    }

    // 5. Kuşluk / Duha Vakti (Güneş doğduktan 45 dk sonra başlayıp öğleye 45 dk kalana kadar)
    final dhuhaStart = times.sunrise.add(const Duration(minutes: 45));
    final dhuhaEnd = times.dhuhr.subtract(const Duration(minutes: 45));
    if (now.isAfter(dhuhaStart) && now.isBefore(dhuhaEnd)) {
      return const SmartRecommendation(
        title: 'Kuşluk (Duhâ) Namazı Vakti',
        subtitle: 'Güneş yükseldi, kerahat çıktı. Efendimiz\'in (s.a.v.) tavsiye ettiği 2 ila 8 rekatlık Kuşluk namazı vaktidir.',
        actionLabel: 'Kuşluk Namazını Kıl',
        icon: Icons.wb_sunny_rounded,
        accentColor: Color(0xFFF39C12),
        route: '/tools',
        actionType: SmartActionType.prayerGuide,
        badgeText: 'Müstehap Vakit',
      );
    }

    // 6. Kerahat Vakti Uyarısı (Güneş doğarken, öğle öncesi zevalde, akşam öncesi batışta)
    if (times.isKerahatTime) {
      return SmartRecommendation(
        title: 'Kerahat Vakti Uyarısı',
        subtitle: times.kerahatMessage ?? 'Güneşin doğuş, tepe noktası veya batış anı. Farz veya nafile namaz kılınması mekruhtur; Kur\'an ve zikir çekilebilir.',
        actionLabel: 'Kur\'ân-ı Kerîm Oku',
        icon: Icons.warning_amber_rounded,
        accentColor: const Color(0xFFE74C3C),
        route: '/quran',
        actionType: SmartActionType.quran,
        badgeText: 'Kerahat',
      );
    }

    // 7. Pazartesi veya Perşembe Sünnet Orucu Hatırlatıcısı (İkindi sonrası iftar hazırlığı)
    if ((weekday == DateTime.monday || weekday == DateTime.thursday) && current == PrayerType.asr) {
      return const SmartRecommendation(
        title: 'Sünnet Oruç & İftar Vakti Yaklaşıyor',
        subtitle: 'Pazartesi / Perşembe sünnet orucunun iftar saatine az kaldı. İftar anında yapılan dua geri çevrilmez.',
        actionLabel: 'İftar Duasını Oku',
        icon: Icons.restaurant_rounded,
        accentColor: Color(0xFF2ECC71),
        route: '/erkam',
        actionType: SmartActionType.dua,
        badgeText: 'Sünnet Oruç',
      );
    }

    // 8. Vaktin Çıkmasına Az Kaldı Uyarısı (< 35 dakika)
    if (rem.inMinutes <= 35 && rem.inMinutes > 0) {
      return SmartRecommendation(
        title: '${current.label} Namazı Vakti Çıkıyor',
        subtitle: '${next.label} vaktine sadece ${rem.inMinutes} dakika kaldı. Henüz kılmadıysanız ${current.label} namazınızı eda ediniz.',
        actionLabel: 'Kıbleyi & Namazı Gör',
        icon: Icons.timer_outlined,
        accentColor: const Color(0xFFE67E22),
        route: '/qibla',
        actionType: SmartActionType.prayerGuide,
        badgeText: 'Son ${rem.inMinutes} Dk',
      );
    }

    // 9. İkindi Vakti & Haşr Suresi Son Ayetleri (Hüvallahüllezi)
    if (current == PrayerType.asr) {
      return const SmartRecommendation(
        title: 'İkindi Namazı & Haşr Sûresi',
        subtitle: 'İkindi namazı farzından sonra Haşr Sûresi\'nin son üç ayetini (Hüvallahüllezi) okumak büyük mükâfattır.',
        actionLabel: 'Erkam Dualarını Aç',
        icon: Icons.auto_stories_rounded,
        accentColor: Color(0xFF1ABC9C),
        route: '/erkam',
        actionType: SmartActionType.dua,
        badgeText: 'İkindi Sünneti',
      );
    }

    // 10. Yatsı Sonrası / Gece (Âmene\'r-Rasûlü & Mülk Suresi)
    if (current == PrayerType.isha) {
      return const SmartRecommendation(
        title: 'Gece Virdi: Mülk & Âmene\'r-Rasûlü',
        subtitle: 'Yatsı namazı sonrasında Bakara son 2 ayeti ve kabir azabından koruyan Mülk (Tebâreke) Sûresi tavsiye edilir.',
        actionLabel: 'Mülk Sûresi\'ni Oku',
        icon: Icons.menu_book_rounded,
        accentColor: Color(0xFF9B59B6),
        route: '/quran',
        actionType: SmartActionType.quran,
        badgeText: 'Gece İstirahati',
      );
    }

    // Varsayılan / Genel Akıllı Tavsiye (Öğle vakti)
    return const SmartRecommendation(
      title: 'Vaktin Bereketi & Günlük Vird',
      subtitle: 'Kalpler ancak Allah\'ı anmakla sükûnet bulur. Günlük Kur\'an tilavetinizi ve istiğfarınızı tamamlayın.',
      actionLabel: 'Tesbihatı Başlat',
      icon: Icons.fingerprint_rounded,
      accentColor: Color(0xFF1FA87C),
      route: '/tasbih',
      actionType: SmartActionType.tasbih,
      badgeText: 'Ruhun Gıdası',
    );
  }
}
