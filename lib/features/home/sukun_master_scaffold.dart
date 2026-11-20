import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';
import '../prayer_times/prayer_times_provider.dart';
import '../prayer_times/prayer_times_widgets.dart';
import '../prayer_times/celestial_prayer_arc.dart';
import '../ilmi_feed/ilmi_feed_screen.dart';
import '../quran/quran_screen.dart';
import '../dua_book_erkam/erkam_book_screen.dart';
import '../tools/islamic_tools_hub_screen.dart';
import '../../core/notifications/lock_screen_prayer_notification_service.dart';
import 'daily_wisdom_widget_card.dart';
import 'ramadan_imsakiye_widget_card.dart';
import 'daily_worship_tracker_widget_card.dart';

class SukunMasterScaffold extends ConsumerStatefulWidget {
  const SukunMasterScaffold({super.key});

  @override
  ConsumerState<SukunMasterScaffold> createState() => _SukunMasterScaffoldState();
}

class _SukunMasterScaffoldState extends ConsumerState<SukunMasterScaffold> {
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    LockScreenPrayerNotificationService.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: const SeljukPatternPainter(),
            ),
          ),
          IndexedStack(
            index: _currentTabIndex,
            children: const [
              SukunDashboardTab(),
              IlmiFeedScreen(),
              QuranScreen(),
              ErkamBookScreen(),
              IslamicToolsHubScreen(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: SukunColors.carbonCardSurface,
          border: const Border(
            top: BorderSide(color: SukunColors.carbonBorder, width: 1.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 20,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: NavigationBar(
            height: 64,
            backgroundColor: Colors.transparent,
            indicatorColor: SukunColors.emeraldPrimary.withValues(alpha: 0.18),
            indicatorShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: SukunColors.emeraldPrimary.withValues(alpha: 0.35),
                width: 1,
              ),
            ),
            selectedIndex: _currentTabIndex,
            onDestinationSelected: (idx) => setState(() => _currentTabIndex = idx),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded, color: SukunColors.emeraldPrimary),
                label: 'Vakitler',
              ),
              NavigationDestination(
                icon: Icon(Icons.auto_stories_outlined),
                selectedIcon: Icon(Icons.auto_stories_rounded, color: SukunColors.goldAccent),
                label: 'İlmi Akış',
              ),
              NavigationDestination(
                icon: Icon(Icons.menu_book_outlined),
                selectedIcon: Icon(Icons.menu_book_rounded, color: SukunColors.emeraldPrimary),
                label: 'Kur\'ân',
              ),
              NavigationDestination(
                icon: Icon(Icons.bookmark_outline_rounded),
                selectedIcon: Icon(Icons.bookmark_rounded, color: SukunColors.goldAccent),
                label: 'Dualar',
              ),
              NavigationDestination(
                icon: Icon(Icons.grid_view_rounded),
                selectedIcon: Icon(Icons.grid_view_rounded, color: SukunColors.emeraldPrimary),
                label: 'Araçlar',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SukunDashboardTab extends ConsumerWidget {
  const SukunDashboardTab({super.key});

  Widget _buildQuickGridItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        decoration: BoxDecoration(
          color: SukunColors.carbonCardSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: SukunColors.carbonBorder),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 6),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                maxLines: 1,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11.5, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timesAsync = ref.watch(activePrayerTimesProvider);
    final isSafir = ref.watch(isUserSafirProvider);

    return SafeArea(
      top: true,
      child: timesAsync.when(
        data: (times) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Celestial Prayer Arc with live sun path
                CelestialPrayerArc(prayerTimes: times),

                // Kerahat uyarısı rozeti
                if (times.isKerahatTime && times.kerahatMessage != null)
                  KerahatBadge(message: times.kerahatMessage!),

                // Seferi modu rozeti
                if (isSafir)
                  SeferiBadge(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => Container(
                          padding: const EdgeInsets.all(20),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Seferilik Rehberi',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              SizedBox(height: 8),
                              Text(
                                  'Ev konumunuzdan 90 km veya daha fazla uzaklaştığınız için 4 rekatlı farz namazları 2 rekat olarak kılabilirsiniz.'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                // 2. Hızlı Erişim İbadet Kısayolları (Grid)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildQuickGridItem(
                          icon: Icons.explore_rounded,
                          label: 'Kıble Pusulası',
                          color: SukunColors.goldAccent,
                          onTap: () => context.push('/qibla'),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: _buildQuickGridItem(
                          icon: Icons.fingerprint_rounded,
                          label: 'Tesbihmatik',
                          color: SukunColors.emeraldPrimary,
                          onTap: () => context.push('/tasbih'),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: _buildQuickGridItem(
                          icon: Icons.mosque_rounded,
                          label: 'Yakın Camiler',
                          color: SukunColors.goldAccent,
                          onTap: () => context.push('/mosques'),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: _buildQuickGridItem(
                          icon: Icons.alarm_rounded,
                          label: 'Akıllı Alarm',
                          color: SukunColors.emeraldPrimary,
                          onTap: () => context.push('/alarms'),
                        ),
                      ),
                    ],
                  ),
                ),

                // 3. İftar & Sahur Geri Sayım Kartı (Ramazan & Sünnet Oruçları)
                RamadanImsakiyeWidgetCard(
                  onOpenCalendar: () => context.push('/calendar'),
                ),

                // 4. Günlük İbadet ve Vird Kontrol Listesi
                const DailyWorshipTrackerWidgetCard(),

                // 5. Günün Hikmetli Sözü Kartı
                DailyWisdomWidgetCard(
                  onExploreFeed: () => context.push('/feed'),
                  onShare: () {
                    ShareStudioSheet.show(
                      context,
                      title: 'Günün Hikmetli Sözü',
                      bodyText: 'Vakit bir kılıç gibidir; eğer sen onu hayırla kesmezsen, o seni kesip tüketir. Nefsini hakla meşgul etmezsen batıl seni işgal eder.',
                      sourceReference: 'İmam Şâfiî (r.a.) • Medâricü\'s-Sâlikîn',
                    );
                  },
                ),

                // 6. Widget Tasarım Stüdyosu Vitrin Banner'ı
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => context.push('/widget-studio'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            SukunColors.emeraldPrimary.withValues(alpha: 0.2),
                            SukunColors.goldAccent.withValues(alpha: 0.12),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: SukunColors.goldAccent.withValues(alpha: 0.3)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.dashboard_customize_rounded, color: SukunColors.goldAccent, size: 24),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Widget Tasarım Stüdyosu',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Kilit ekranı ve ana ekran için 2x2, 4x2, 4x4 şık widget\'lar',
                                  style: TextStyle(color: Colors.white60, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded, color: SukunColors.goldAccent, size: 14),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // 4. Günün Hadis-i Şerifi & Tefekkürü
                SukunSurfaceCard(
                  enableGlass: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.format_quote_rounded, color: SukunColors.goldAccent, size: 18),
                          SizedBox(width: 6),
                          Text(
                            'GÜNÜN HADİS-İ ŞERİFİ & TEFEKKÜRÜ',
                            style: TextStyle(
                              color: SukunColors.goldAccent,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const ArabicScriptBlock(
                        arabicText: 'إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ',
                        transliteration: 'İnnemel a\'mâlü bin-niyyât.',
                        translation: 'Ameller ancak niyetlere göredir; herkese niyet ettiği şey vardır.',
                      ),
                      const SizedBox(height: 14),
                      ContextualActionRow(
                        onLike: () {},
                        onSave: () {},
                        onAddNote: () => context.push('/notes'),
                        onSendToTasbih: () => context.push('/tasbih'),
                        onShare: () {
                          ShareStudioSheet.show(
                            context,
                            title: 'Günün Hadis-i Şerifi',
                            arabicText: 'إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ',
                            bodyText: 'Ameller ancak niyetlere göredir; herkese niyet ettiği şey vardır.',
                            sourceReference: 'Buhârî, Bed\'ü\'l-Vahy, 1',
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Hata: $e')),
      ),
    );
  }
}
