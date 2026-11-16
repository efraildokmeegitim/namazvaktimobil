import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';
import 'tasbih_provider.dart';

class TasbihScreen extends ConsumerWidget {
  const TasbihScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasbih = ref.watch(tasbihProvider);
    final notifier = ref.read(tasbihProvider.notifier);

    // Gözü Kapalı OLED Gece Modu: Tam siyah zemin, ekrana her dokunuşta sayaç artar
    if (tasbih.isOledMode) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            HapticFeedback.lightImpact();
            notifier.increment();
          },
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tasbih.title,
                      style: const TextStyle(color: Colors.white54, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '${tasbih.count}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 96,
                        fontWeight: FontWeight.w800,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Hedef: ${tasbih.targetCount} • Devir: ${tasbih.round}',
                      style: const TextStyle(color: Colors.white38, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.brightness_auto, color: Colors.white54),
                  tooltip: 'OLED Modundan Çık',
                  onPressed: () => notifier.toggleOledMode(),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gelişmiş Zikirmatik', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.nightlight_round, color: SukunColors.goldAccent),
            tooltip: 'Gözü Kapalı OLED Gece Modu',
            onPressed: () => notifier.toggleOledMode(),
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Sıfırla',
            onPressed: () => notifier.reset(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Zikir Kartı
            SukunSurfaceCard(
              enableGlass: true,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              child: Column(
                children: [
                  Text(
                    tasbih.title,
                    style: const TextStyle(
                      color: SukunColors.goldAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (tasbih.arabicText != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      tasbih.arabicText!,
                      style: SukunTheme.arabicQuranStyle(
                        fontSize: 24,
                        color: Colors.white,
                        height: 1.8,
                      ),
                    ),
                  ],
                  const SizedBox(height: 12),
                  Text(
                    'Zincirleme Namaz Tesbihatı (33 Sübhanallah -> 33 Elhamdülillah -> 33 Allahuekber)',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Büyük Tesbihmatik Butonu
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                notifier.increment();
              },
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: SukunColors.carbonCardSurface,
                  border: Border.all(color: SukunColors.emeraldPrimary, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: SukunColors.emeraldPrimary.withValues(alpha: 0.25),
                      blurRadius: 32,
                      spreadRadius: 6,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${tasbih.count}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                    Text(
                      '/ ${tasbih.targetCount}',
                      style: const TextStyle(color: Colors.white38, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Devir: ${tasbih.round}',
              style: const TextStyle(color: SukunColors.goldAccent, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
