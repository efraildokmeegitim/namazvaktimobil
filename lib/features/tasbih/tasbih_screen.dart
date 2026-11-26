import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/sukun_theme.dart';
import '../../core/ui_kit/ui_kit.dart';
import 'tasbih_provider.dart';

class TasbihScreen extends ConsumerStatefulWidget {
  const TasbihScreen({super.key});

  @override
  ConsumerState<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends ConsumerState<TasbihScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onTapDial() {
    _animController.forward().then((_) => _animController.reverse());
    ref.read(tasbihProvider.notifier).increment();
  }

  @override
  Widget build(BuildContext context) {
    final tasbih = ref.watch(tasbihProvider);
    final notifier = ref.read(tasbihProvider.notifier);

    // Gözü Kapalı OLED Gece Modu: Tam siyah zemin, ekrana her dokunuşta sayaç artar
    if (tasbih.isOledMode) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            ref.read(tasbihProvider.notifier).increment();
          },
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tasbih.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    if (tasbih.arabicText != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        tasbih.arabicText!,
                        textAlign: TextAlign.center,
                        style: SukunTheme.arabicQuranStyle(fontSize: 22, color: Colors.white54),
                      ),
                    ],
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
                      tasbih.targetCount == 0
                          ? 'Serbest Sayım • Toplam: ${tasbih.totalCount}'
                          : 'Hedef: ${tasbih.targetCount} • Devir: ${tasbih.round} • Toplam: ${tasbih.totalCount}',
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
            icon: Icon(
              tasbih.isVibrationEnabled ? Icons.vibration_rounded : Icons.smartphone_rounded,
              color: tasbih.isVibrationEnabled ? SukunColors.emeraldPrimary : Colors.white38,
            ),
            tooltip: tasbih.isVibrationEnabled ? 'Hedef Titreşimi Açık' : 'Titreşim Kapalı',
            onPressed: () => notifier.toggleVibration(),
          ),
          IconButton(
            icon: const Icon(Icons.nightlight_round, color: SukunColors.goldAccent),
            tooltip: 'Gözü Kapalı OLED Gece Modu',
            onPressed: () => notifier.toggleOledMode(),
          ),
          IconButton(
            icon: const Icon(Icons.bookmarks_rounded, color: SukunColors.emeraldPrimary),
            tooltip: 'Zikirlerim & Yeni Ekle',
            onPressed: () => _showDhikrListModal(context, tasbih, notifier),
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Sıfırla',
            onPressed: () => _confirmResetDialog(context, notifier),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              // 1. Zikir Bilgi Kartı & Hızlı Seçim Butonu
              SukunSurfaceCard(
                enableGlass: true,
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tasbih.title,
                                style: const TextStyle(
                                  color: SukunColors.goldAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (tasbih.meaningTr != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  tasbih.meaningTr!,
                                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                                ),
                              ],
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.playlist_add_check_rounded, color: SukunColors.goldAccent),
                          tooltip: 'Zikir Değiştir',
                          onPressed: () => _showDhikrListModal(context, tasbih, notifier),
                        ),
                      ],
                    ),
                    if (tasbih.arabicText != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        tasbih.arabicText!,
                        textAlign: TextAlign.center,
                        style: SukunTheme.arabicQuranStyle(
                          fontSize: 22,
                          color: Colors.white,
                          height: 1.8,
                        ),
                      ),
                    ],
                    const SizedBox(height: 12),
                    // Hedef Vurgusu & İlerleme Çubuğu
                    if (tasbih.targetCount > 0) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hedefe Kalan: ${tasbih.targetCount - tasbih.count}',
                            style: const TextStyle(color: Colors.white54, fontSize: 11),
                          ),
                          Text(
                            '%${((tasbih.count / tasbih.targetCount) * 100).toInt()}',
                            style: const TextStyle(color: SukunColors.emeraldPrimary, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: (tasbih.count / tasbih.targetCount).clamp(0.0, 1.0),
                          minHeight: 6,
                          backgroundColor: Colors.white10,
                          valueColor: const AlwaysStoppedAnimation<Color>(SukunColors.emeraldPrimary),
                        ),
                      ),
                    ] else ...[
                      const Text(
                        'Serbest Zikir Modu (Hedefsiz)',
                        style: TextStyle(color: Colors.white54, fontSize: 11),
                      ),
                    ],
                    const SizedBox(height: 14),
                    // Hızlı Hedef Seçici Çipler & Serbest Sayı Girişi
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      alignment: WrapAlignment.center,
                      children: [
                        ...[33, 99, 100, 500, 1000, 0].map((t) {
                          final isSelected = tasbih.targetCount == t;
                          final label = t == 0 ? 'Serbest (∞)' : '$t';
                          return ChoiceChip(
                            label: Text(
                              label,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.white70,
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: SukunColors.emeraldPrimary,
                            backgroundColor: Colors.white10,
                            side: BorderSide(
                              color: isSelected ? SukunColors.emeraldPrimary : Colors.transparent,
                            ),
                            onSelected: (_) {
                              notifier.setTargetCount(t);
                            },
                          );
                        }),
                        ActionChip(
                          avatar: const Icon(Icons.edit_outlined, size: 14, color: SukunColors.goldAccent),
                          label: Text(
                            ![33, 99, 100, 500, 1000, 0].contains(tasbih.targetCount)
                                ? 'Hedef: ${tasbih.targetCount}'
                                : 'Özel Sayı',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: ![33, 99, 100, 500, 1000, 0].contains(tasbih.targetCount)
                                  ? SukunColors.goldAccent
                                  : Colors.white70,
                            ),
                          ),
                          backgroundColor: ![33, 99, 100, 500, 1000, 0].contains(tasbih.targetCount)
                              ? SukunColors.goldAccent.withValues(alpha: 0.15)
                              : Colors.white10,
                          side: BorderSide(
                            color: ![33, 99, 100, 500, 1000, 0].contains(tasbih.targetCount)
                                ? SukunColors.goldAccent
                                : Colors.transparent,
                          ),
                          onPressed: () => _showCustomTargetDialog(context, tasbih.targetCount, notifier),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // 2. Büyük Etkileşimli Zikirmatik Kadranı
              ScaleTransition(
                scale: _scaleAnimation,
                child: GestureDetector(
                  onTap: _onTapDial,
                  child: Container(
                    width: 230,
                    height: 230,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        colors: [
                          Color(0xFF22362C),
                          Color(0xFF131F1A),
                          Color(0xFF090E0C),
                        ],
                        radius: 0.85,
                      ),
                      border: Border.all(
                        color: tasbih.targetCount > 0 && tasbih.count >= tasbih.targetCount
                            ? SukunColors.goldAccent
                            : SukunColors.emeraldPrimary,
                        width: 3.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: SukunColors.emeraldPrimary.withValues(alpha: 0.3),
                          blurRadius: 36,
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
                            fontWeight: FontWeight.w800,
                            fontFeatures: [FontFeature.tabularFigures()],
                          ),
                        ),
                        Text(
                          tasbih.targetCount == 0 ? '∞ Serbest' : '/ ${tasbih.targetCount}',
                          style: const TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'DOKUN',
                            style: TextStyle(
                              color: SukunColors.goldAccent,
                              fontSize: 10,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // 3. İstatistik Çubuğu (Devir & Toplam)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Text(
                      'Devir: ${tasbih.round}',
                      style: const TextStyle(color: SukunColors.goldAccent, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Text(
                      'Toplam Çekilen: ${tasbih.totalCount}',
                      style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // 4. Yeni Zikir Ekleme Hızlı Butonu
              OutlinedButton.icon(
                icon: const Icon(Icons.add_circle_outline_rounded, color: SukunColors.emeraldPrimary),
                label: const Text('Yeni Özel Zikir Ekle', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: SukunColors.emeraldPrimary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: () => _showAddDhikrDialog(context, notifier),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Zikir Listesi Modal Bottom Sheet
  void _showDhikrListModal(BuildContext context, TasbihState state, TasbihNotifier notifier) {
    showModalBottomSheet(
      context: context,
      backgroundColor: SukunColors.carbonBackground,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, scrollController) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Kayıtlı Zikirlerim',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.add, size: 18, color: SukunColors.emeraldPrimary),
                        label: const Text('Yeni Ekle', style: TextStyle(color: SukunColors.emeraldPrimary, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.pop(ctx);
                          _showAddDhikrDialog(context, notifier);
                        },
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white12),
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: state.savedDhikrs.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, index) {
                        final item = state.savedDhikrs[index];
                        final isSelected = state.activeDhikrId == item.id;

                        return Container(
                          decoration: BoxDecoration(
                            color: isSelected ? SukunColors.emeraldPrimary.withValues(alpha: 0.15) : SukunColors.carbonCardSurface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? SukunColors.emeraldPrimary : Colors.white10,
                              width: isSelected ? 1.5 : 1,
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            title: Text(
                              item.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isSelected ? SukunColors.goldAccent : Colors.white,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (item.arabicText != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    item.arabicText!,
                                    style: SukunTheme.arabicQuranStyle(fontSize: 16, color: Colors.white70),
                                  ),
                                ],
                                const SizedBox(height: 4),
                                Text(
                                  'Hedef: ${item.targetCount == 0 ? "Serbest" : item.targetCount} • Toplam Çekilen: ${item.totalLifetimeCount}',
                                  style: const TextStyle(fontSize: 11, color: Colors.white38),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isSelected)
                                  const Icon(Icons.check_circle_rounded, color: SukunColors.emeraldPrimary)
                                else
                                  IconButton(
                                    icon: const Icon(Icons.play_arrow_rounded, color: SukunColors.emeraldPrimary),
                                    onPressed: () {
                                      notifier.selectDhikr(item.id);
                                      Navigator.pop(ctx);
                                    },
                                  ),
                                if (!item.id.startsWith('namaz_')) ...[
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 20),
                                    onPressed: () {
                                      notifier.deleteDhikr(item.id);
                                    },
                                  ),
                                ],
                              ],
                            ),
                            onTap: () {
                              notifier.selectDhikr(item.id);
                              Navigator.pop(ctx);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Yeni Zikir Ekleme Diyaloğu
  void _showAddDhikrDialog(BuildContext context, TasbihNotifier notifier) {
    final titleController = TextEditingController();
    final arabicController = TextEditingController();
    final meaningController = TextEditingController();
    int target = 33;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: SukunColors.carbonBackground,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: const Text('Yeni Zikir Ekle', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Zikir Başlığı / Okunuşu *',
                        hintText: 'Örn: Yâ Şâfî, Lâ İlahe İllallah',
                        labelStyle: TextStyle(color: SukunColors.emeraldPrimary),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: arabicController,
                      style: const TextStyle(color: Colors.white),
                      textDirection: TextDirection.rtl,
                      decoration: const InputDecoration(
                        labelText: 'Arapça Metin (İsteğe Bağlı)',
                        hintText: 'سُبْحَانَ اللَّهِ',
                        labelStyle: TextStyle(color: SukunColors.emeraldPrimary),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: meaningController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Anlamı / Fazileti (İsteğe Bağlı)',
                        hintText: 'Örn: Şifa niyetiyle çekilir',
                        labelStyle: TextStyle(color: SukunColors.emeraldPrimary),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        labelText: 'Hedef Sayı (0 = Serbest Sayım) *',
                        hintText: 'Örn: 33, 99, 313, 1000, 4444',
                        labelStyle: TextStyle(color: SukunColors.emeraldPrimary),
                        suffixText: 'Adet',
                      ),
                      controller: TextEditingController(text: '$target'),
                      onChanged: (val) {
                        final parsed = int.tryParse(val.trim());
                        if (parsed != null && parsed >= 0) {
                          target = parsed;
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('İptal', style: TextStyle(color: Colors.white54)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SukunColors.emeraldPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    final title = titleController.text.trim();
                    if (title.isNotEmpty) {
                      notifier.addCustomDhikr(
                        title: title,
                        arabicText: arabicController.text.trim(),
                        meaningTr: meaningController.text.trim(),
                        targetCount: target,
                      );
                      Navigator.pop(ctx);
                    }
                  },
                  child: const Text('Kaydet ve Çek', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // İstediği Serbest Hedef Sayıyı Girme Diyaloğu
  void _showCustomTargetDialog(BuildContext context, int currentTarget, TasbihNotifier notifier) {
    final controller = TextEditingController(text: currentTarget > 0 ? '$currentTarget' : '33');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: SukunColors.carbonBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Özel Hedef Sayı Belirle', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hedefe ulaşıldığında telefonunuz titreşecek ve yeni devre geçecektir. Sınırsız çekmek için 0 yazın.',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              autofocus: true,
              style: const TextStyle(color: SukunColors.goldAccent, fontSize: 24, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                labelText: 'Hedef Sayı (Örn: 313, 500, 1000, 4444)',
                labelStyle: TextStyle(color: SukunColors.emeraldPrimary),
                suffixText: 'Hedef',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('İptal', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: SukunColors.emeraldPrimary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              final val = int.tryParse(controller.text.trim());
              if (val != null && val >= 0) {
                notifier.setTargetCount(val);
                Navigator.pop(ctx);
              }
            },
            child: const Text('Hedefi Uygula', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _confirmResetDialog(BuildContext context, TasbihNotifier notifier) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: SukunColors.carbonBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Zikri Sıfırla', style: TextStyle(color: Colors.white)),
        content: const Text('Mevcut tur sayacı sıfırlanacak. Devam edilsin mi?', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Vazgeç', style: TextStyle(color: Colors.white54))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: SukunColors.emeraldPrimary),
            onPressed: () {
              notifier.reset();
              Navigator.pop(ctx);
            },
            child: const Text('Sıfırla', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
