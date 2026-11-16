import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/database/app_database.dart';
import 'core/database/seed_loader_service.dart';
import 'core/theme/sukun_theme.dart';
import 'core/ui_kit/ui_kit.dart';
import 'features/prayer_times/prayer_times_model.dart';
import 'features/prayer_times/prayer_times_provider.dart';
import 'features/prayer_times/prayer_times_widgets.dart';
import 'features/ilmi_feed/ilmi_feed_screen.dart';
import 'features/dua_book_erkam/erkam_book_screen.dart';
import 'features/quran/quran_screen.dart';
import 'features/qibla_mosques/qibla_compass_screen.dart';
import 'features/qibla_mosques/nearby_mosques_screen.dart';
import 'features/tasbih/tasbih_screen.dart';
import 'features/islamic_calendar/islamic_calendar_screen.dart';
import 'features/smart_alarms/smart_alarms_screen.dart';
import 'features/notes/contextual_notes_screen.dart';
import 'features/tools/islamic_tools_hub_screen.dart';
import 'features/tools/widget_design_studio_screen.dart';
import 'features/home/sukun_master_scaffold.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final seedLoaderProvider = Provider<SeedLoaderService>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return SeedLoaderService(db);
});




final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SukunMasterScaffold(),
      ),
      GoRoute(
        path: '/feed',
        builder: (context, state) => const IlmiFeedScreen(),
      ),
      GoRoute(
        path: '/erkam',
        builder: (context, state) => const ErkamBookScreen(),
      ),
      GoRoute(
        path: '/quran',
        builder: (context, state) => const QuranScreen(),
      ),
      GoRoute(
        path: '/qibla',
        builder: (context, state) => const QiblaCompassScreen(),
      ),
      GoRoute(
        path: '/mosques',
        builder: (context, state) => const NearbyMosquesScreen(),
      ),
      GoRoute(
        path: '/tasbih',
        builder: (context, state) => const TasbihScreen(),
      ),
      GoRoute(
        path: '/calendar',
        builder: (context, state) => const IslamicCalendarScreen(),
      ),
      GoRoute(
        path: '/alarms',
        builder: (context, state) => const SmartAlarmsScreen(),
      ),
      GoRoute(
        path: '/notes',
        builder: (context, state) => const ContextualNotesScreen(),
      ),
      GoRoute(
        path: '/tools',
        builder: (context, state) => const IslamicToolsHubScreen(),
      ),
      GoRoute(
        path: '/widget-studio',
        builder: (context, state) => const WidgetDesignStudioScreen(),
      ),
    ],
  );
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: SukunApp()));
}

class SukunApp extends ConsumerWidget {
  const SukunApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    // Initialize & reload rich sample seed data
    ref.read(seedLoaderProvider).reloadIlmiFeed();
    ref.read(seedLoaderProvider).seedInitialDataIfEmpty();

    return MaterialApp.router(
      title: 'SÜKÛN • Namaz Vakti & İslami Yaşam',
      debugShowCheckedModeBanner: false,
      theme: SukunTheme.lightTheme,
      darkTheme: SukunTheme.darkTheme,
      themeMode: ThemeMode.dark, // Default OLED Karbon
      routerConfig: router,
    );
  }
}


class SukunHomeScreen extends ConsumerWidget {
  const SukunHomeScreen({super.key});

  List<Color> _getGradientForPrayer(PrayerType type) {
    switch (type) {
      case PrayerType.fajr:
        return SukunColors.gradientFajr;
      case PrayerType.sunrise:
      case PrayerType.dhuhr:
        return SukunColors.gradientDhuhr;
      case PrayerType.asr:
        return SukunColors.gradientAsr;
      case PrayerType.maghrib:
        return SukunColors.gradientMaghrib;
      case PrayerType.isha:
        return SukunColors.gradientIsha;
    }
  }

  String _formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayerTimesAsync = ref.watch(activePrayerTimesProvider);
    final isSafir = ref.watch(isUserSafirProvider);

    return Scaffold(
      body: SafeArea(
        top: false,
        child: prayerTimesAsync.when(
          data: (times) {
            final nextPrayer = times.nextPrayer;
            final remaining = times.timeRemainingToNext;
            final gradient = _getGradientForPrayer(times.currentPrayer);

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SkyCountdownHeader(
                    nextPrayerName: nextPrayer.label,
                    remainingTimeFormatted: _formatDuration(remaining),
                    locationText: times.locationName,
                    hijriDateText: times.hijriDate,
                    sunProgress: times.sunProgress,
                    gradientColors: gradient,
                  ),
                  if (times.isKerahatTime && times.kerahatMessage != null)
                    KerahatBadge(message: times.kerahatMessage!),
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
                                    'Ev konumunuzdan 90 km veya daha fazla uzaklaştığınız için 4 rekatlı farz namazları 2 rekat olarak kısaltarak kılabilirsiniz.'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  PrayerTimesHorizontalGrid(prayerTimes: times),
                  const SizedBox(height: 12),
                  CategoryFilterChips(
                    categories: const ['all', 'fikih', 'hadis', 'ayet', 'tasavvuf'],
                    selectedCategory: 'all',
                    displayLabels: const {
                      'all': 'Tümü',
                      'fikih': 'Fıkıh',
                      'hadis': 'Hadis',
                      'ayet': 'Ayet',
                      'tasavvuf': 'Tasavvuf',
                    },
                    onSelected: (_) {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: SukunColors.goldAccent),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: const Icon(Icons.auto_stories_outlined, color: SukunColors.goldAccent),
                      label: const Text(
                        'İlmi Akışı Keşfet (8 Kategori & Reels)',
                        style: TextStyle(color: SukunColors.goldAccent, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => context.push('/feed'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: SukunColors.emeraldPrimary.withValues(alpha: 0.15),
                              foregroundColor: SukunColors.emeraldPrimary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(color: SukunColors.emeraldPrimary),
                              ),
                            ),
                            icon: const Icon(Icons.menu_book_rounded, size: 18),
                            label: const Text('Kur\'ân-ı Kerîm', style: TextStyle(fontWeight: FontWeight.bold)),
                            onPressed: () => context.push('/quran'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: SukunColors.goldAccent.withValues(alpha: 0.15),
                              foregroundColor: SukunColors.goldAccent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(color: SukunColors.goldAccent),
                              ),
                            ),
                            icon: const Icon(Icons.bookmark_added_rounded, size: 18),
                            label: const Text('Dualar Kitabı', style: TextStyle(fontWeight: FontWeight.bold)),
                            onPressed: () => context.push('/erkam'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white24),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            icon: const Icon(Icons.explore_outlined, size: 16, color: SukunColors.goldAccent),
                            label: const Text('Kıble', style: TextStyle(color: Colors.white, fontSize: 12)),
                            onPressed: () => context.push('/qibla'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white24),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            icon: const Icon(Icons.mosque_outlined, size: 16, color: SukunColors.emeraldPrimary),
                            label: const Text('Camiler', style: TextStyle(color: Colors.white, fontSize: 12)),
                            onPressed: () => context.push('/mosques'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white24),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            icon: const Icon(Icons.fingerprint_rounded, size: 16, color: SukunColors.goldAccent),
                            label: const Text('Tesbih', style: TextStyle(color: Colors.white, fontSize: 12)),
                            onPressed: () => context.push('/tasbih'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white24),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            icon: const Icon(Icons.calendar_month_outlined, size: 16, color: SukunColors.goldAccent),
                            label: const Text('Takvim', style: TextStyle(color: Colors.white, fontSize: 12)),
                            onPressed: () => context.push('/calendar'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white24),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            icon: const Icon(Icons.alarm_outlined, size: 16, color: SukunColors.emeraldPrimary),
                            label: const Text('Alarmlar', style: TextStyle(color: Colors.white, fontSize: 12)),
                            onPressed: () => context.push('/alarms'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white24),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            icon: const Icon(Icons.edit_note_rounded, size: 16, color: SukunColors.goldAccent),
                            label: const Text('Notlar', style: TextStyle(color: Colors.white, fontSize: 12)),
                            onPressed: () => context.push('/notes'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white24),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            icon: const Icon(Icons.apps_rounded, size: 16, color: SukunColors.emeraldPrimary),
                            label: const Text('Araçlar', style: TextStyle(color: Colors.white, fontSize: 12)),
                            onPressed: () => context.push('/tools'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => context.push('/widget-studio'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              SukunColors.emeraldPrimary.withValues(alpha: 0.2),
                              SukunColors.goldAccent.withValues(alpha: 0.15),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: SukunColors.goldAccent.withValues(alpha: 0.4)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.dashboard_customize_rounded, color: SukunColors.goldAccent, size: 20),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Widget Tasarım Stüdyosu (Small, Medium, Large)',
                                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios_rounded, color: SukunColors.goldAccent, size: 14),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SukunSurfaceCard(
                    enableGlass: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'GÜNÜN HADİS-İ ŞERİFİ',
                          style: TextStyle(
                            color: SukunColors.goldAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const ArabicScriptBlock(
                          arabicText: 'إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ',
                          transliteration: 'İnnemel a\'mâlü bin-niyyât.',
                          translation: 'Ameller ancak niyetlere göredir.',
                        ),
                        const SizedBox(height: 16),
                        ContextualActionRow(
                          onLike: () {},
                          onSave: () {},
                          onAddNote: () {},
                          onSendToTasbih: () {},
                          onSetAlarm: () {},
                          onShare: () {
                            ShareStudioSheet.show(
                              context,
                              title: 'Günün Hadis-i Şerifi',
                              arabicText: 'إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ',
                              bodyText: 'Ameller ancak niyetlere göredir.',
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
      ),
    );
  }
}
