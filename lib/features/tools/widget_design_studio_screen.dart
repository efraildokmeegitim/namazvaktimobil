import 'package:flutter/material.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/notifications/lock_screen_prayer_notification_service.dart';

enum WidgetSize {
  lockInline('Kilit Çubuğu (Inline)'),
  lockCircular('Kilit Dairesel (Circular)'),
  small('Small (2x2)'),
  medium('Medium (4x2)'),
  large('Large (4x4)');

  final String label;
  const WidgetSize(this.label);
}

enum WidgetThemeStyle {
  carbon('Karbon & Zümrüt'),
  nur('Nur & Fildişi'),
  glass('Buzlu Cam'),
  goldSeljuk('Selçuklu Altın & Gece'),
  crimsonSunset('Gün Batımı Şafak');

  final String label;
  const WidgetThemeStyle(this.label);
}

enum WidgetContentModel {
  prayerCountdown('Vakit & Canlı Sayaç'),
  celestialSunArc('Güneş Yayı & Kerahat'),
  wisdomAyah('Günün Âyeti & Hadisi'),
  ramadanIftar('İftar & Sahur Sayacı'),
  tasbihCounter('Hızlı Zikir & Vird'),
  quickIslamicTools('İslami Kısayollar');

  final String label;
  const WidgetContentModel(this.label);
}

class WidgetDesignStudioScreen extends StatefulWidget {
  const WidgetDesignStudioScreen({super.key});

  @override
  State<WidgetDesignStudioScreen> createState() => _WidgetDesignStudioScreenState();
}

class _WidgetDesignStudioScreenState extends State<WidgetDesignStudioScreen> {
  WidgetSize _selectedSize = WidgetSize.medium;
  WidgetThemeStyle _selectedTheme = WidgetThemeStyle.carbon;
  WidgetContentModel _selectedContent = WidgetContentModel.prayerCountdown;

  // Tasarım Stili Renk Çözücüsü
  BoxDecoration _getWidgetDecoration(double radius) {
    switch (_selectedTheme) {
      case WidgetThemeStyle.carbon:
        return BoxDecoration(
          color: SukunColors.carbonCardSurface,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: SukunColors.emeraldPrimary.withValues(alpha: 0.35), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        );
      case WidgetThemeStyle.nur:
        return BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: SukunColors.nurBorder, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        );
      case WidgetThemeStyle.glass:
        return BoxDecoration(
          color: const Color(0x99111816),
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        );
      case WidgetThemeStyle.goldSeljuk:
        return BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1F170D), Color(0xFF0F0B06)],
          ),
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: SukunColors.goldAccent.withValues(alpha: 0.7), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: SukunColors.goldAccent.withValues(alpha: 0.15),
              blurRadius: 22,
              offset: const Offset(0, 8),
            ),
          ],
        );
      case WidgetThemeStyle.crimsonSunset:
        return BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2B141D), Color(0xFF140B10)],
          ),
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: const Color(0xFFE26D5C).withValues(alpha: 0.6), width: 1.3),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE26D5C).withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        );
    }
  }

  Color get _textColor {
    if (_selectedTheme == WidgetThemeStyle.nur) return SukunColors.nurTextPrimary;
    return Colors.white;
  }

  Color get _subTextColor {
    if (_selectedTheme == WidgetThemeStyle.nur) return SukunColors.nurTextSecondary;
    return Colors.white70;
  }

  Color get _accentColor {
    switch (_selectedTheme) {
      case WidgetThemeStyle.goldSeljuk:
        return SukunColors.goldAccent;
      case WidgetThemeStyle.crimsonSunset:
        return const Color(0xFFE26D5C);
      case WidgetThemeStyle.nur:
        return SukunColors.tileGreenPrimary;
      default:
        return SukunColors.emeraldPrimary;
    }
  }

  Widget _buildPreview() {
    switch (_selectedSize) {
      case WidgetSize.lockInline:
        return _buildLockInlinePreview();
      case WidgetSize.lockCircular:
        return _buildLockCircularPreview();
      case WidgetSize.small:
        return _buildSmallPreview();
      case WidgetSize.medium:
        return _buildMediumPreview();
      case WidgetSize.large:
        return _buildLargePreview();
    }
  }

  // 1. Kilit Ekranı Satır İçi Widget'ı (iOS LockScreen Inline / Android Status)
  Widget _buildLockInlinePreview() {
    return Container(
      width: 320,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: _getWidgetDecoration(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.access_time_filled_rounded, color: _accentColor, size: 18),
          const SizedBox(width: 8),
          Text(
            'İkindiye 02:44:18',
            style: TextStyle(
              color: _textColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          const Spacer(),
          Text('15:40', style: TextStyle(color: SukunColors.goldAccent, fontWeight: FontWeight.w700, fontSize: 13)),
        ],
      ),
    );
  }

  // 2. Kilit Ekranı Dairesel Saat Widget'ı (iOS LockScreen Circular / Wear)
  Widget _buildLockCircularPreview() {
    return Container(
      width: 140,
      height: 140,
      decoration: _getWidgetDecoration(70),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: CircularProgressIndicator(
              value: 0.65,
              strokeWidth: 4.5,
              color: _accentColor,
              backgroundColor: Colors.white12,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.wb_sunny_rounded, color: SukunColors.goldAccent, size: 18),
              const SizedBox(height: 2),
              Text(
                '02:44',
                style: TextStyle(
                  color: _textColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              Text('İKİNDİ', style: TextStyle(color: _accentColor, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1.1)),
            ],
          ),
        ],
      ),
    );
  }

  // 3. Small (2x2) Kare Widget
  Widget _buildSmallPreview() {
    return Container(
      width: 155,
      height: 155,
      padding: const EdgeInsets.all(14),
      decoration: _getWidgetDecoration(24),
      child: _buildSmallContent(),
    );
  }

  Widget _buildSmallContent() {
    switch (_selectedContent) {
      case WidgetContentModel.prayerCountdown:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: _accentColor.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
              child: Text('İkindi Vakti', style: TextStyle(color: _accentColor, fontWeight: FontWeight.bold, fontSize: 11)),
            ),
            const SizedBox(height: 6),
            Text(
              '02:44:18',
              style: TextStyle(
                color: _textColor,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            const SizedBox(height: 4),
            Text('15:40 • Fatih', style: TextStyle(color: _subTextColor, fontSize: 11)),
          ],
        );
      case WidgetContentModel.celestialSunArc:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wb_twilight_rounded, color: SukunColors.goldAccent, size: 30),
            const SizedBox(height: 6),
            Text('Güneş Yolu', style: TextStyle(color: _textColor, fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 2),
            Text('Kerahat Vaktine: Yok', style: TextStyle(color: _accentColor, fontSize: 10)),
            Text('Batış: 18:04', style: TextStyle(color: _subTextColor, fontSize: 10)),
          ],
        );
      case WidgetContentModel.ramadanIftar:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.nightlight_round, color: SukunColors.goldAccent, size: 26),
            const SizedBox(height: 4),
            Text('İFTARA', style: TextStyle(color: _accentColor, fontWeight: FontWeight.w800, fontSize: 11, letterSpacing: 1.1)),
            Text('05:08:12', style: TextStyle(color: _textColor, fontWeight: FontWeight.bold, fontSize: 20, fontFeatures: const [FontFeature.tabularFigures()])),
            Text('Akşam: 18:04', style: TextStyle(color: _subTextColor, fontSize: 10)),
          ],
        );
      case WidgetContentModel.tasbihCounter:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fingerprint_rounded, color: _accentColor, size: 28),
            const SizedBox(height: 4),
            Text('33 / 33', style: TextStyle(color: SukunColors.goldAccent, fontWeight: FontWeight.bold, fontSize: 18, fontFeatures: const [FontFeature.tabularFigures()])),
            Text('Sübhanallâh', style: TextStyle(color: _textColor, fontWeight: FontWeight.w600, fontSize: 11)),
          ],
        );
      default:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_stories_rounded, color: SukunColors.goldAccent, size: 24),
            const SizedBox(height: 4),
            Text('Günün Virdi', style: TextStyle(color: _accentColor, fontWeight: FontWeight.bold, fontSize: 11)),
            const SizedBox(height: 2),
            Text('100 İstiğfar', style: TextStyle(color: _textColor, fontWeight: FontWeight.w600, fontSize: 13)),
          ],
        );
    }
  }

  // 4. Medium (4x2) Dikdörtgen Widget
  Widget _buildMediumPreview() {
    return Container(
      width: 320,
      height: 155,
      padding: const EdgeInsets.all(15),
      decoration: _getWidgetDecoration(24),
      child: _buildMediumContent(),
    );
  }

  Widget _buildMediumContent() {
    switch (_selectedContent) {
      case WidgetContentModel.wisdomAyah:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.format_quote_rounded, color: SukunColors.goldAccent, size: 16),
                    const SizedBox(width: 4),
                    Text('Günün Âyet-i Kerîmesi', style: TextStyle(color: SukunColors.goldAccent, fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
                Text('Bakara • 152', style: TextStyle(color: _subTextColor, fontSize: 11)),
              ],
            ),
            Text(
              '«Beni anın ki ben de sizi anayım. Bana şükredin; nankörlük etmeyin.»',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: _textColor, fontSize: 12.5, height: 1.35, fontStyle: FontStyle.italic),
            ),
            Row(
              children: [
                Icon(Icons.favorite_rounded, color: _accentColor, size: 13),
                const SizedBox(width: 4),
                Text('Sükûn İlmi Akış', style: TextStyle(color: _subTextColor, fontSize: 10)),
              ],
            ),
          ],
        );
      case WidgetContentModel.ramadanIftar:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('İstanbul • Fatih', style: TextStyle(color: _textColor, fontWeight: FontWeight.bold, fontSize: 13)),
                Text('Ramazan / Sünnet Orucu', style: TextStyle(color: SukunColors.goldAccent, fontWeight: FontWeight.bold, fontSize: 11)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('İmsak (Sahur)', style: TextStyle(color: _subTextColor, fontSize: 11)),
                    Text('06:05', style: TextStyle(color: _textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                Container(height: 36, width: 1, color: Colors.white12),
                Column(
                  children: [
                    Text('İftar Vakti', style: TextStyle(color: _accentColor, fontWeight: FontWeight.bold, fontSize: 11)),
                    Text('18:04', style: TextStyle(color: SukunColors.goldAccent, fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ],
            ),
            Text('İftara Kalan Süre: 05:08:12', style: TextStyle(color: _accentColor, fontWeight: FontWeight.w800, fontSize: 12)),
          ],
        );
      default:
        // Standart 5 vakit ve kalan süre görünümü
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on_rounded, color: _accentColor, size: 14),
                    const SizedBox(width: 4),
                    Text('İstanbul, Fatih', style: TextStyle(color: _textColor, fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
                Text('24 Cemâziyelevvel', style: TextStyle(color: _subTextColor, fontSize: 11)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMiniPill('İmsak', '06:05', false),
                _buildMiniPill('Güneş', '07:35', false),
                _buildMiniPill('Öğle', '12:56', false),
                _buildMiniPill('İkindi', '15:40', true),
                _buildMiniPill('Akşam', '18:04', false),
                _buildMiniPill('Yatsı', '19:28', false),
              ],
            ),
            Text(
              'İkindi Vaktine 02:44:18 kaldı',
              style: TextStyle(color: _accentColor, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        );
    }
  }

  // 5. Large (4x4) Geniş İbadet & Yaşam Panosu
  Widget _buildLargePreview() {
    return Container(
      width: 320,
      height: 320,
      padding: const EdgeInsets.all(18),
      decoration: _getWidgetDecoration(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('İstanbul, Fatih', style: TextStyle(color: _textColor, fontWeight: FontWeight.bold, fontSize: 15)),
                  Text('24 Cemâziyelevvel 1448', style: TextStyle(color: _subTextColor, fontSize: 11)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: _accentColor.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)),
                child: Text('İkindi 15:40', style: TextStyle(color: _accentColor, fontWeight: FontWeight.bold, fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMiniPill('İmsak', '06:05', false),
              _buildMiniPill('Öğle', '12:56', false),
              _buildMiniPill('İkindi', '15:40', true),
              _buildMiniPill('Akşam', '18:04', false),
              _buildMiniPill('Yatsı', '19:28', false),
            ],
          ),
          const Divider(height: 20, color: Colors.white12),
          Row(
            children: [
              Icon(Icons.wb_sunny_rounded, color: SukunColors.goldAccent, size: 14),
              const SizedBox(width: 6),
              Text('Günün Hikmetli Sözü', style: TextStyle(color: SukunColors.goldAccent, fontWeight: FontWeight.bold, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '«Nefsini hakla meşgul etmezsen batıl seni işgal eder.»',
            style: TextStyle(color: _textColor, fontSize: 12, fontStyle: FontStyle.italic),
          ),
          Text('— İmam Şâfiî (r.a.)', style: TextStyle(color: _subTextColor, fontSize: 10)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLargeShortcut(Icons.explore_rounded, 'Kıble'),
              _buildLargeShortcut(Icons.fingerprint_rounded, 'Tesbih'),
              _buildLargeShortcut(Icons.menu_book_rounded, 'Kur\'an'),
              _buildLargeShortcut(Icons.bookmark_rounded, 'Dualar'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniPill(String name, String time, bool isCurrent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: isCurrent ? _accentColor.withValues(alpha: 0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isCurrent ? Border.all(color: _accentColor, width: 1.1) : null,
      ),
      child: Column(
        children: [
          Text(name, style: TextStyle(fontSize: 10, color: isCurrent ? _accentColor : _subTextColor)),
          Text(time, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isCurrent ? SukunColors.goldAccent : _textColor)),
        ],
      ),
    );
  }

  Widget _buildLargeShortcut(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _accentColor.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18, color: _accentColor),
        ),
        const SizedBox(height: 3),
        Text(label, style: TextStyle(fontSize: 10, color: _subTextColor)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Tasarım Stüdyosu', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Canlı Önizleme Sahnesi
            Center(
              child: Container(
                height: 340,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white10),
                ),
                child: _buildPreview(),
              ),
            ),
            const SizedBox(height: 20),

            // 1. Widget Biçimi / Boyutu
            const Text('Widget Boyutu & Konumu', style: TextStyle(fontWeight: FontWeight.bold, color: SukunColors.goldAccent)),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: WidgetSize.values.map((s) {
                  final isSel = s == _selectedSize;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(s.label),
                      selected: isSel,
                      onSelected: (_) => setState(() => _selectedSize = s),
                      selectedColor: SukunColors.emeraldPrimary.withValues(alpha: 0.25),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // 2. Widget İçerik Tipi
            const Text('İçerik Tipi & İşlev', style: TextStyle(fontWeight: FontWeight.bold, color: SukunColors.goldAccent)),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: WidgetContentModel.values.map((c) {
                  final isSel = c == _selectedContent;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(c.label),
                      selected: isSel,
                      onSelected: (_) => setState(() => _selectedContent = c),
                      selectedColor: SukunColors.goldAccent.withValues(alpha: 0.25),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // 3. Tema ve Görsel Atmosfer
            const Text('Tema ve Atmosfer', style: TextStyle(fontWeight: FontWeight.bold, color: SukunColors.goldAccent)),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: WidgetThemeStyle.values.map((t) {
                  final isSel = t == _selectedTheme;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(t.label),
                      selected: isSel,
                      onSelected: (_) => setState(() => _selectedTheme = t),
                      selectedColor: SukunColors.emeraldPrimary.withValues(alpha: 0.25),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // İşlem Butonları
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: SukunColors.emeraldPrimary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.add_to_home_screen_rounded),
              label: const Text('Ana Ekrana Ekle / Widget Tasarımını Kaydet', style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${_selectedSize.label} - ${_selectedContent.label} widget tasarımı kaydedildi.'),
                    backgroundColor: SukunColors.emeraldPrimary,
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: SukunColors.goldAccent,
                side: const BorderSide(color: SukunColors.goldAccent),
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.screen_lock_portrait_rounded),
              label: const Text('Kilit Ekranı Canlı Vakit Görünümünü Aç', style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                LockScreenPrayerNotificationService.setLockScreenEnabled(true);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Kilit ekranında canlı vakit bildirimi ve sayaç aktifleştirildi.'),
                    backgroundColor: SukunColors.tileGreenPrimary,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
